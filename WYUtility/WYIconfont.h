//
//  WYIconfont.h
//  Pods
//
//  Created by fin on 2016/10/9.
//
//

#import <Foundation/Foundation.h>


@interface WYIconfont : NSObject
+ (void)setFontWithFontPath:(NSString *)path fontName:(NSString *)name;
+ (UIFont *)fontOfSize:(CGFloat)fontSize;
+ (UIImage *)imageWithIcon:(NSString *)content backgroundColor:(UIColor *)bgColor iconColor:(UIColor *)iconColor andSize:(CGSize)size;
+ (UIImage *)imageWithIcon:(NSString *)content backgroundColor:(UIColor *)bgColor iconColor:(UIColor *)iconColor fontSize:(CGFloat)fontSize;
@end
