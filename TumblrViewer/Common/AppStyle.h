//
//  AppStyle.h
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppStyle : NSObject
+ (UIFont *)primaryFont;
+ (UIFont *)primaryFontWithSize:(CGFloat)size;
+ (UIColor *)primaryTextColor;
+ (UILabel *)standardLabel;
+ (UILabel *)standardLabelWithSize:(CGFloat)size;
@end
