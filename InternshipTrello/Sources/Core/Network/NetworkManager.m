//
//  NetworkManager.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 21.10.2021.
//

#import "NetworkManager.h"
#import "NetworkRequest.h"

NS_ASSUME_NONNULL_BEGIN

/** Network manager errors.*/
typedef NS_ENUM(NSInteger, NetworkManagerErrorCode) {
    NetworkManagerErrorCodeSerialization = 1
};

/** Function for casting HTTPMethod to NSString.*/
NSString *httpMethodToString(HTTPMethod method) {
    switch (method) {
        case GET:
            return @"GET";
        case PUT:
            return @"PUT";
        case DELETE:
            return @"DELETE";
        case POST:
            return @"POST";
    }
}

@implementation NetworkManager

+ (instancetype)shared {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)sendRequest:(id<NetworkRequest>)request
     withCompletion:(RequestCompletion)completion {
    NSURLComponents *components = [[NSURLComponents alloc] initWithString:request.url];
    components.path = request.path;
    NSMutableArray<NSURLQueryItem *> *items = [[NSMutableArray alloc] init];
    for (NSString *key in request.query.allKeys) {
        [items addObject:[NSURLQueryItem queryItemWithName:key value:request.query[key]]];
    }
    components.queryItems = items;

    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:components.URL];
    urlRequest.HTTPBody = request.body;
    urlRequest.HTTPMethod = httpMethodToString(request.requestMethod);
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithRequest:urlRequest
                                  completionHandler:^(NSData * _Nullable data,
                                                      NSURLResponse * _Nullable response,
                                                      NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        Class responseType = request.responseType;
        if ([responseType conformsToProtocol:@protocol(SerializableModel)]) {
            id<SerializableModel> object = [[responseType alloc] initWithJSONObject:json];
            completion(object, nil);
        } else {
            NSString *desc = [NSString stringWithFormat:@"Could not parse response. %@ model does not conform to Serializable protocol.", NSStringFromClass(responseType)];
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
            NSError *parsingError = [NSError errorWithDomain:@"NetworkManagerErrorDomain"
                                                        code:NetworkManagerErrorCodeSerialization
                                                    userInfo:userInfo];
            completion(nil, parsingError);
        }
    }];
    [task resume];
}

@end

NS_ASSUME_NONNULL_END
