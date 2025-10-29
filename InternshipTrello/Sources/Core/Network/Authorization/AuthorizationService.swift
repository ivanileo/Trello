//
//  AuthorizationService.swift
//  InternshipTrello
//
//  Created by Ivan Suntsov on 08.10.2021.
//

import Foundation
import OAuthSwift

@objc final class AuthorizationService: NSObject, AuthorizationServiceProtocol {
    /// Constants for authorization actions.
    private enum Constants {
        /// URL constants.
        static let authCallbackURL = "gdinternship://auth"
        static let baseURL = "https://trello.com"
        static let getRequestTokenPath = "/1/OAuthGetRequestToken"
        static let authorizeTokenPath = "/1/OAuthAuthorizeToken"
        static let getAccessTokenPath = "/1/OAuthGetAccessToken"

        /// Keychain constants.
        static let kTokenKeychainKey = "DefaultUserOAuthToken"
        static let kTokenSecretKeychainKey = "DefaultUserOAuthTokenSecret"
    }
    
    private var oauthSwift: OAuth1Swift?
    
    @objc func authorize(completion: @escaping (_ isSuccessful: Bool, _ error: NSError?) -> Void) {
        createOauthSwift()
        let success: OAuth1Swift.TokenSuccessHandler = { credential, response, params in
            print("tokens have been received.")
            KeychainService.savePair(withStringValue: credential.oauthToken,
                                          andKey: Constants.kTokenKeychainKey)
            KeychainService.savePair(withStringValue: credential.oauthTokenSecret,
                                          andKey: Constants.kTokenSecretKeychainKey)
            completion(true, nil)
        }
        let failure: OAuth1Swift.FailureHandler = { error in
            print("error while authentication occured: " + error.localizedDescription)
            completion(false, error as NSError)
        }
        if let _ = oauthSwift?.authorize(withCallbackURL: Constants.authCallbackURL,
                                            success: success,
                                            failure: failure) {
            return
        }
        completion(false, nil)
    }

    @objc func logout() {
        KeychainService.deleteStringValue(byKey: Constants.kTokenKeychainKey)
        KeychainService.deleteStringValue(byKey: Constants.kTokenSecretKeychainKey)
    }
    
    /// Callback oauth url should be handled by this method.
    ///
    /// - Parameter url: url that will be handled.
    @objc static func handleOAuthURL(_ url: URL) {
        OAuthSwift.handle(url: url)
    }

    @objc static func isAuthorized() -> Bool {
        if let _ = KeychainService.stringValue(byKey: Constants.kTokenKeychainKey),
           let _ = KeychainService.stringValue(byKey: Constants.kTokenSecretKeychainKey) {
            return true
        }
        return false
    }

    private func createOauthSwift() {
        if let webConfig = PlistManager.dictionaryFromPList(withName: "WebConfig") as? [String: String],
           let consumerKey = webConfig["DevAPIKey"],
           let consumerSecret = webConfig["OAuth1Secret"] {
            oauthSwift = OAuth1Swift(
                consumerKey:    consumerKey,
                consumerSecret: consumerSecret,
                requestTokenUrl: Constants.baseURL + Constants.getRequestTokenPath,
                authorizeUrl:    Constants.baseURL + Constants.authorizeTokenPath,
                accessTokenUrl:  Constants.baseURL + Constants.getAccessTokenPath
            )
        } else {
            oauthSwift = nil
            print("error: can't read plist with client keys.")
        }
    }
}
