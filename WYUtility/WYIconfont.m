//
//  WYIconfont.m
//  Pods
//
//  Created by fin on 2016/10/9.
//
//

#import "WYIconfont.h"

static NSString *fontPath;

@implementation WYIconfont
+ (UIFont *)fontOfSize:(CGFloat)fontSize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [WYIconfont registerIconfont];
    });
}

+ (void)fontPath:(NSString *)path {
    fontPath = path;
}

+ (void)registerIconfont {
    
}
@end
