//
//  AuthorizeButton.m
//  InternshipTrello
//
//  Created by Ivan Suntsov on 13.10.2021.
//

#import "AuthorizeButton.h"

NS_ASSUME_NONNULL_BEGIN

@implementation AuthorizeButton

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    self.backgroundColor = highlighted ? UIColor.whiteColor : UIColor.grayColor;
}

@end

NS_ASSUME_NONNULL_END
