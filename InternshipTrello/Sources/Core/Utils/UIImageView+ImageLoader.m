//
//  UIImageView+ImageLoader.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 27.10.2021.
//

#import "UIImageView+ImageLoader.h"

@implementation UIImageView (ImageLoader)

- (void)setImageWithUrl:(NSURL *)url andPlaceholder:(nullable UIImage *)placeholder {
    self.image = placeholder;
    __weak __typeof__(self) weakSelf = self;
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:url
                                                           completionHandler:^(NSData * _Nullable data,
                                                                               NSURLResponse * _Nullable response,
                                                                               NSError * _Nullable error) {
        if (error) {
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            __typeof__(self) strongSelf = weakSelf;
            if (!strongSelf) {
                return;
            }
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                strongSelf.image = image;
            }
        });
    }];
    [task resume];
}

@end
