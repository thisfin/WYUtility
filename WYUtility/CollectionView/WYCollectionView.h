//
//  FixedCollectionView.h
//  Pods
//
//  Created by wenyou on 15/8/30.
//
//

#import <UIKit/UIKit.h>

#import "WYCollectionUnitProtocol.h"
#import "WYCellControllerFactory.h"


@protocol WYCollectionViewDelegate <UIScrollViewDelegate>
@optional
- (void)spaceDidClicked;
- (void)initCell;
@end

@interface WYCollectionView : UIView
@property (nonatomic, weak) id<WYCollectionViewDelegate> delegate;
@property (nonatomic, strong) NSArray *datas;                               // 列表数据
@property (nonatomic, strong, readonly) UICollectionView *collectionView;   // 列表

- (instancetype)initWithFrame:(CGRect)frame scrollDirection:(UICollectionViewScrollDirection)scrollDirection;

- (void)registCollectionReusableView:(Class)clazz;                          // 注册cell
- (void)registCellController:(id<WYCellControllerProtocol>)controller;  // 注册cell的controller
- (void)reloadData;                                                         // cell数据重加载
- (void)setCollectionContentInset:(UIEdgeInsets)contentInset;               // 内缩样式
@end
