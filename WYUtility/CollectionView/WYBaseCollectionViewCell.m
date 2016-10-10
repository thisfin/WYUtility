//
//  SingleCollectionViewBaseCell.m
//  Pods
//
//  Created by wenyou on 15/8/31.
//
//

#import "WYBaseCollectionViewCell.h"


@implementation WYBaseCollectionViewCell
@synthesize delegate;

#pragma mark - TMSearchListUnitProtocol
- (void)configWithData:(id)data {
    NSAssert(NO, @"subclass must implement this method!");
}

+ (CGSize)sizeForData:(id)data {
    NSAssert(NO, @"subclass must implement this method!");
    return CGSizeZero;
}

+ (CGFloat)minimumColumnSpacing {
    return 0;
}

+ (CGFloat)minimumInteritemSpacing {
    return 0;
}

+ (WYCollectionViewPositionType)positionType {
    NSAssert(NO, @"subclass must implement this method!");
    return 0;
}

+ (NSString *)dataType {
    NSAssert(NO, @"subclass must implement this method!");
    return 0;
}
@end
