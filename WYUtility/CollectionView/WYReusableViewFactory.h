//
//  SingleCellViewFactory.h
//  Pods
//
//  Created by wenyou on 15/8/31.
//
//

#import <UIKit/UIKit.h>

#import "WYCollectionUnitProtocol.h"


@interface WYReusableViewFactory : NSObject
- (void)registCollectionReusableView:(Class)clazz view:(UICollectionView *)view;

- (Class)getCollectionReusableViewClassWithPositionType:(WYCollectionViewPositionType)positionType
                                               dataType:(NSString *)dataType;

- (CGSize)sizeForReusableViewClass:(Class)clazz data:(id)data;

- (CGFloat)minimumColumnSpacingForReusableViewClass:(Class)clazz;

- (CGFloat)minimumInteritemSpacingForReusableViewClass:(Class)clazz;

- (NSString *)createReuseIdentifierWithPositionType:(WYCollectionViewPositionType)positionType
                                           dataType:(NSString *)dataType;
@end
