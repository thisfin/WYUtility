//
//  ListUnitProtocol.h
//  Pods
//
//  Created by wenyou on 15/3/24.
//
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, WYCollectionViewPositionType) {
    WYCollectionViewPositionTypeCenter = 0,
    WYCollectionViewPositionTypeHeader = 1,
    WYCollectionViewPositionTypeFooter = 2
};


// 子元素
@protocol WYReusableViewData <NSObject>
@property (nonatomic, strong) NSString* dataType;
@end


// 块元素
@protocol WYSectionViewData <NSObject>
@property (nonatomic, strong) id<WYReusableViewData> headerData;
@property (nonatomic, strong) id<WYReusableViewData> footerData;
@property (nonatomic, strong) NSArray *cellDatas;
@end


// 整体数据
@protocol WYCollectionViewData <NSObject>
@property (nonatomic, strong) NSArray *sectionDatas;
@end


@protocol WYCollectionUnitProtocol <NSObject>
@property (nonatomic, weak) id delegate;
// 注入数据
- (void)configWithData:(id)data;
// 根据展示数据拿到cell的size
+ (CGSize)sizeForData:(id)data;
// 位置类型
+ (WYCollectionViewPositionType)positionType;
// 数据类型
+ (NSString *)dataType;
// 最小纵向间隔
+ (CGFloat)minimumColumnSpacing;
// 最小横向间隔
+ (CGFloat)minimumInteritemSpacing;
@optional
// 点击
+ (void)didSelectAtIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView model:(id)model param:(NSDictionary *)paramDict;
@end
