//
//  UIImageView+ImageLoader.h
//  InternshipTrello
//
//  Created by Ivan Suntsov on 27.10.2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A category that extends UIImageView for image downloading.
 */
@interface UIImageView (ImageLoader)

/**
 * Sets image to self from custom url with placeholder.
 *
 * @param url url with image.
 * @param placeholder uiview that will be set before will be image downloaded.
 */
- (void)setImageWithUrl:(NSURL *)url andPlaceholder:(nullable UIImage *)placeholder;

@end

NS_ASSUME_NONNULL_END
