#import <UIKit/UIKit.h>


@interface UIColor (Ex)
+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue;

+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(NSUInteger)alpha;

// param string "aarrggbb" or "#aarrggbb" or "rrggbb" or "#rrggbb"
+ (UIColor *)colorWithString:(NSString *)string;
@end
