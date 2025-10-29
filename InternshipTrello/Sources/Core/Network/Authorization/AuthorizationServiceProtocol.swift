//
//  AuthorizationServiceProtocol.swift
//  InternshipTrello
//
//  Created by Ivan Suntsov on 19.10.2021.
//

import Foundation

@objc protocol AuthorizationServiceProtocol : NSObjectProtocol {
    /// Redirects user to browser for authorizing.
    ///
    /// - Parameter completion: callback after authorization results handling.
    func authorize(completion: @escaping (_ isSuccessful: Bool, _ error: NSError?) -> Void)
    
    /// Performs logout actions.
    func logout()
    
    /// Shows if authorized or not.
    static func isAuthorized() -> Bool 
}
