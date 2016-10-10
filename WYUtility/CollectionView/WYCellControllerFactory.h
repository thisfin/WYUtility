//
//  SearchCellControllerFactory.h
//  Pods
//
//  Created by wenyou on 15/8/27.
//
//

#import <Foundation/Foundation.h>

#import "WYCollectionUnitProtocol.h"


@protocol WYCellControllerProtocol <NSObject>
@property (weak, nonatomic) UIViewController *contentController;    // 父容器controller
@property (weak, nonatomic) UICollectionView *collectionView;       // 列表
@property (weak, nonatomic) id model;                               // 父数据对象

@required
- (NSString *)supportDataType;
@optional
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath data:(id)data;
@end


@interface WYCellControllerFactory : NSObject
- (void)reset;
- (void)registerController:(id<WYCellControllerProtocol>)controller;                            // cell的controller注册
- (id<WYCellControllerProtocol>)getControllerFromDataType:(NSString *)supportDataType;
- (NSArray *)allControllers;
@end
