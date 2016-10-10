//
//  FixedCollectionView.m
//  Pods
//
//  Created by wenyou on 15/8/30.
//
//

#import "WYCollectionView.h"

#import "WYCollectionUnitProtocol.h"
#import "WYReusableViewFactory.h"

//#import "ShopSearchResultEmptyView.h"


@interface WYCollectionView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>
@end


@implementation WYCollectionView {
    UICollectionView *_collectionView;
    WYReusableViewFactory *_viewFactory;
    WYCellControllerFactory *_controllerFactory;
    UICollectionViewScrollDirection _scrollDirection;
}

- (instancetype)initWithFrame:(CGRect)frame scrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    if (self = [super initWithFrame:frame]) {
        _scrollDirection = scrollDirection;
        [self initSubview];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _scrollDirection = UICollectionViewScrollDirectionVertical;
        [self initSubview];
    }
    return self;
}

- (void)initSubview {
    self.backgroundColor = [UIColor clearColor];
    
    _viewFactory = [[WYReusableViewFactory alloc] init];
    _controllerFactory = [[WYCellControllerFactory alloc] init];
    
    UICollectionViewFlowLayout *viewLayout = [[UICollectionViewFlowLayout alloc] init];
    viewLayout.scrollDirection = _scrollDirection;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:viewLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollIndicatorInsets = _collectionView.contentInset;
    
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [_collectionView addGestureRecognizer:tapRecognizer];
    tapRecognizer.delegate = self;
    [self addSubview:_collectionView];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded && [_delegate respondsToSelector:@selector(spaceDidClicked)]) {
        [_delegate spaceDidClicked];
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint initialPinchPoint = [gestureRecognizer locationInView:self.collectionView];
    NSIndexPath *tappedCellPath = [_collectionView indexPathForItemAtPoint:initialPinchPoint];
    if (tappedCellPath) {
        return NO;
    }
    return YES;
}

#pragma mark - implement
- (void)registCollectionReusableView:(Class)clazz { // 注册渲染对象
    [_viewFactory registCollectionReusableView:clazz view:_collectionView];
}

- (void)registCellController:(id<WYCellControllerProtocol>)controller {
    [controller setCollectionView:_collectionView];
    [_controllerFactory registerController:controller];
}

- (void)reloadData {
    [_collectionView reloadData];
}

- (void)setCollectionContentInset:(UIEdgeInsets)contentInset {
    _collectionView.contentInset = contentInset;
}

#pragma mark - UIScrollViewDelegate 代理桥接
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([_delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [_delegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([_delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [_delegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0) {
    if ([_delegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [_delegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([_delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [_delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([_delegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [_delegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([_delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [_delegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if ([_delegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [_delegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if ([_delegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [_delegate scrollViewDidScrollToTop:scrollView];
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id<WYReusableViewData> data = _datas.count ? _datas[indexPath.item] : nil;
    id<WYCellControllerProtocol> cellController = [_controllerFactory getControllerFromDataType:data.dataType];
    
    if ([cellController respondsToSelector:@selector(didSelectItemAtIndexPath:data:)]){
        [cellController didSelectItemAtIndexPath:indexPath data:data];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath { // cell大小
    id<WYReusableViewData> data = _datas.count ? _datas[indexPath.row] : 0;
    Class clazz = [_viewFactory getCollectionReusableViewClassWithPositionType:WYCollectionViewPositionTypeCenter dataType:data.dataType];
    CGSize size = [_viewFactory sizeForReusableViewClass:clazz data:data];
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section { // 行间距
    id<WYReusableViewData> data = _datas.count ? _datas[0] : nil;
    if (!data) {
        return 0;
    }
    Class clazz = [_viewFactory getCollectionReusableViewClassWithPositionType:WYCollectionViewPositionTypeCenter dataType:data.dataType];
    CGFloat size = [_viewFactory minimumInteritemSpacingForReusableViewClass:clazz];
    return size;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    id<WYReusableViewData> data = _datas.count ? _datas[0] : nil;
    if (!data) {
        return 0;
    }
    Class clazz = [_viewFactory getCollectionReusableViewClassWithPositionType:WYCollectionViewPositionTypeCenter dataType:data.dataType];
    CGFloat size = [_viewFactory minimumColumnSpacingForReusableViewClass:clazz];
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return  CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section { // section中cell数目
    return _datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath { // 构造cell
    id<WYReusableViewData> data = _datas.count ? _datas[indexPath.row] : nil;
    NSString *reuseIdentifier = [_viewFactory createReuseIdentifierWithPositionType:WYCollectionViewPositionTypeCenter dataType:data.dataType];
    UICollectionViewCell<WYCollectionUnitProtocol> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = [_controllerFactory getControllerFromDataType:data.dataType];
    [cell configWithData:data];
    
    if ([_delegate respondsToSelector:@selector(initCell)]) {
        [_delegate initCell];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView { // section数目
    return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath { // 构造header & footer
    return nil;
}
@end
