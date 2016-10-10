//
//  SingleCellViewFactory.m
//  Pods
//
//  Created by wenyou on 15/8/31.
//
//

#import "WYReusableViewFactory.h"


@interface WYReusableViewFactory () {
    NSMutableDictionary *_dictionary;
}
@end


@implementation WYReusableViewFactory
#pragma mark - Override
- (id)init {
    if (self = [super init]) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - Implement
- (void)registCollectionReusableView:(Class)clazz view:(UICollectionView *)view {
    WYCollectionViewPositionType positionType = [self positionTypeForReusableViewClass:clazz];
    NSString *dataType = [self dataTypeForReusableViewClass:clazz];
    NSString *key = [self createKeyWithPositionType:positionType dataType:dataType];
    switch (positionType) {
        case WYCollectionViewPositionTypeCenter:
            [view registerClass:clazz forCellWithReuseIdentifier:key];
            break;
        case WYCollectionViewPositionTypeHeader:
            [view registerClass:clazz forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:key];
            break;
        case WYCollectionViewPositionTypeFooter:
            [view registerClass:clazz forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:key];
            break;
        default:
            return;
    }
    [_dictionary setObject:clazz forKey:key];
}

- (Class)getCollectionReusableViewClassWithPositionType:(WYCollectionViewPositionType)positionType dataType:(NSString *)dataType {
    return [_dictionary valueForKey:[self createKeyWithPositionType:positionType dataType:dataType]];
}

- (CGSize)sizeForReusableViewClass:(Class)clazz data:(id)data {
    CGSize result;
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[clazz methodSignatureForSelector:@selector(sizeForData:)]];
    [invocation setTarget:clazz];
    [invocation setSelector:@selector(sizeForData:)];
    [invocation setArgument:&data atIndex:2];
    [invocation invoke];
    [invocation getReturnValue:&result];
    return result;
}

- (CGFloat)minimumColumnSpacingForReusableViewClass:(Class)clazz {
    CGFloat result;
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[clazz methodSignatureForSelector:@selector(minimumColumnSpacing)]];
    [invocation setTarget:clazz];
    [invocation setSelector:@selector(minimumColumnSpacing)];
    [invocation invoke];
    [invocation getReturnValue:&result];
    return result;
}

- (CGFloat)minimumInteritemSpacingForReusableViewClass:(Class)clazz {
    CGFloat result;
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[clazz methodSignatureForSelector:@selector(minimumInteritemSpacing)]];
    [invocation setTarget:clazz];
    [invocation setSelector:@selector(minimumInteritemSpacing)];
    [invocation invoke];
    [invocation getReturnValue:&result];
    return result;
}

- (NSString *)createReuseIdentifierWithPositionType:(WYCollectionViewPositionType)positionType dataType:(NSString *)dataType {
    return [self createKeyWithPositionType:positionType dataType:dataType];
}

//- (void)didSelectForReusableViewClass:(Class)clazz indexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView model:(id)model param:(NSDictionary *)paramDict {
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[clazz methodSignatureForSelector:@selector(didSelectAtIndexPath:collectionView:model:param:)]];
//    [invocation setTarget:clazz];
//    [invocation setSelector:@selector(didSelectAtIndexPath:collectionView:model:param:)];
//    [invocation setArgument:&indexPath atIndex:2];
//    [invocation setArgument:&collectionView atIndex:3];
//    [invocation setArgument:&model atIndex:4];
//    [invocation setArgument:&paramDict atIndex:5];
//    [invocation invoke];
//}

#pragma mark - Private
- (NSString *)createKeyWithPositionType:(WYCollectionViewPositionType)positionType dataType:(NSString *)dataType {
    return [NSString stringWithFormat:@"%lu-%@", positionType, dataType];
}

- (WYCollectionViewPositionType)positionTypeForReusableViewClass:(Class)clazz {
    WYCollectionViewPositionType result;
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[clazz methodSignatureForSelector:@selector(positionType)]];
    [invocation setTarget:clazz];
    [invocation setSelector:@selector(positionType)];
    [invocation invoke];
    [invocation getReturnValue:&result];
    return result;
}

- (NSString *)dataTypeForReusableViewClass:(Class)clazz {
    NSString *result;
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[clazz methodSignatureForSelector:@selector(dataType)]];
    [invocation setTarget:clazz];
    [invocation setSelector:@selector(dataType)];
    [invocation invoke];
    [invocation getReturnValue:&result];
    return result;
}
@end
