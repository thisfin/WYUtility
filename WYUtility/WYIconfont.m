//
//  WYIconfont.m
//  Pods
//
//  Created by fin on 2016/10/9.
//
//

#import "WYIconfont.h"

#import <CoreText/CTFontManager.h>


static NSString *fontName = @"FontAwesome";
static NSString *fontPath = @"fontawesome-webfont_4.6.3";


@implementation WYIconfont
+ (UIFont *)fontOfSize:(CGFloat)fontSize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [WYIconfont registerIconfont];
    });
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    NSAssert(font != nil, @"%@ couldn't be loaded", fontName);
    return font;
}

+ (void)setFontWithFontPath:(NSString *)path fontName:(NSString *)name {
    fontPath = path;
    fontName = name;
}

+ (void)registerIconfont {
    NSString *path = [[NSBundle mainBundle] pathForResource:fontPath ofType:@"ttf"];
    NSData *dynamicFontData = [NSData dataWithContentsOfFile:path];
    if (!dynamicFontData) {
        return;
    }
    CFErrorRef error;
    CGDataProviderRef providerRef = CGDataProviderCreateWithCFData((__bridge CFDataRef)dynamicFontData);
    CGFontRef font = CGFontCreateWithDataProvider(providerRef);
    if (!CTFontManagerRegisterGraphicsFont(font, &error)) {
        //注册失败
        CFStringRef errorDescription = CFErrorCopyDescription(error);
        NSLog(@"Failed to load font: %@", errorDescription);
        CFRelease(errorDescription);
    }
    CFRelease(font);
    CFRelease(providerRef);
}

+ (UIImage *)imageWithIcon:(NSString *)content backgroundColor:(UIColor *)bgColor iconColor:(UIColor *)iconColor andSize:(CGSize)size {
    if (!bgColor) {
        bgColor = [UIColor clearColor];
    }
    if (!iconColor) {
        iconColor = [UIColor whiteColor];
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGRect textRect = CGRectZero;
    textRect.size = size;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:textRect];
    [bgColor setFill];
    [path fill];
    
    CGFloat fontSize = size.width;
    UIFont *font = [WYIconfont fontOfSize:fontSize];
    @autoreleasepool {
        UILabel *label = [UILabel new];
        label.font = font;
        label.text = content;
        fontSize = [WYIconfont constraintLabelToSize:label size:size maxFontSize:500 minFontSize:5];
        font = label.font;
    }
    [iconColor setFill];
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    [content drawInRect:textRect withAttributes:@{NSFontAttributeName : font,
                                                  NSForegroundColorAttributeName : iconColor,
                                                  NSBackgroundColorAttributeName : bgColor,
                                                  NSParagraphStyleAttributeName: style}];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (CGFloat)constraintLabelToSize:(UILabel *)label size:(CGSize)size maxFontSize:(CGFloat)maxFontSize minFontSize:(CGFloat)minFontSize {
    // Set the frame of the label to the targeted rectangle
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    label.frame = rect;
    
    // Try all font sizes from largest to smallest font size
    CGFloat fontSize = maxFontSize;
    
    // Fit label width wize
    CGSize constraintSize = CGSizeMake(label.frame.size.width, MAXFLOAT);
    
    do {
        // Set current font size
        label.font = [WYIconfont fontOfSize:fontSize];
        
        // Find label size for current font size
        CGRect textRect = [[label text] boundingRectWithSize:constraintSize
                                                     options:NSStringDrawingUsesFontLeading
                                                  attributes:@{NSFontAttributeName:label.font}
                                                     context:nil];
        // Done, if created label is within target size
        if (textRect.size.height <= label.frame.size.height) {
            break;
        }
        
        // Decrease the font size and try again
        fontSize -= 2;
    } while (fontSize > minFontSize);
    
    return fontSize;
}

+ (UIImage *)imageWithIcon:(NSString *)content backgroundColor:(UIColor *)bgColor iconColor:(UIColor *)iconColor fontSize:(CGFloat)fontSize {
    if (!bgColor) {
        bgColor = [UIColor clearColor];
    }
    if (!iconColor) {
        iconColor = [UIColor whiteColor];
    }
    
    UIFont *font = [WYIconfont fontOfSize:fontSize];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSFontAttributeName : font,
                                 NSForegroundColorAttributeName : iconColor,
                                 NSBackgroundColorAttributeName : bgColor,
                                 NSParagraphStyleAttributeName: style};
    
    CGSize size = [content sizeWithAttributes:attributes];
    size = CGSizeMake(size.width * 1.1, size.height * 1.05);
    
    CGRect textRect = CGRectZero;
    textRect.size = size;
    
    CGPoint origin = CGPointMake(size.width * 0.05, size.height * 0.025);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:textRect];
    [bgColor setFill];
    [path fill];
    
    [content drawAtPoint:origin withAttributes:attributes];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
