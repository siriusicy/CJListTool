//
//  YFMVVMCollectionViewTool.m
//  CJListTool
//
//  Created by ChenJie on 2022/8/20.
//

#import "YFMVVMCollectionViewTool.h"
#import "CJDemoCommonHeader.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UIScrollView+Refresh.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "UICollectionViewCell+BottomLine.h"
#import "YFCollectionSectionViewModel.h"
#import "YFCollectionCellVMProtocol.h"
#import "YFCollectionCellProtocol.h"
#import "YFCollectionHeaderFooterProtocol.h"
#import "YFCollectionHeaderFooterVMProtocol.h"

@interface YFMVVMCollectionViewTool ()

@property (nonatomic, strong, readwrite) UICollectionView *collectionView;
@property (nonatomic, strong, readwrite) id<YFCollectionVCViewModelProtocol> viewModel;

@property (nonatomic, strong) NSMutableArray<NSString *> *registeredCellIdentifiers;
@property (nonatomic, strong) NSMutableArray<NSString *> *registeredHeaderFooterIdentifiers;

@end

@implementation YFMVVMCollectionViewTool

- (instancetype)initWithViewModel:(id<YFCollectionVCViewModelProtocol>)viewModel {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    return [self initWithViewModel:viewModel layout:layout];
}
- (instancetype)initWithViewModel:(id<YFCollectionVCViewModelProtocol>)viewModel layout:(UICollectionViewLayout *)layout {
    if (self = [super init]) {

        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        
        collectionView.delegate = self;
        collectionView.dataSource = self;

        self.collectionView = collectionView;
        self.viewModel = viewModel;
    }
    return self;
    
}

#pragma mark -  CollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(collectionView:didSelectCellViewModel:indexPath:)]) {
        id<YFCollectionCellVMProtocol> cellVM = self.viewModel.sectionDataSource[indexPath.section].listDataSource[indexPath.row];
        [self.delegate collectionView:collectionView didSelectCellViewModel:cellVM indexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

    id<YFCollectionCellVMProtocol> cellVM = self.viewModel.sectionDataSource[indexPath.section].listDataSource[indexPath.row];
    if ([cellVM respondsToSelector:@selector(bottomLineInfo)]) {
        [cell yf_decorateWithBottomInfo:[cellVM bottomLineInfo]];
    } else {
        [cell yf_decorateWithBottomInfo:nil];
    }
    
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(collectionView:willDisplayCell:atIndexPath:)]) {
        [self.delegate collectionView:collectionView willDisplayCell:cell atIndexPath:indexPath];
    }
}
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {

    if ([elementKind isEqualToString:CHTCollectionElementKindSectionHeader] ||
        [elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (self.delegate &&
            [self.delegate respondsToSelector:@selector(collectionView:willDisplaySectionHeader:atSection:)]) {
            [self.delegate collectionView:collectionView willDisplaySectionHeader:view atSection:indexPath.section];
        }
    } else if ([elementKind isEqualToString:CHTCollectionElementKindSectionFooter] ||
               [elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        if (self.delegate &&
            [self.delegate respondsToSelector:@selector(collectionView:willDisplaySectionFooter:atSection:)]) {
            [self.delegate collectionView:collectionView willDisplaySectionFooter:view atSection:indexPath.section];
        }
    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO:
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    // TODO:
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.viewModel.sectionDataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.sectionDataSource[section].listDataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id<YFCollectionCellVMProtocol> cellVM = self.viewModel.sectionDataSource[indexPath.section].listDataSource[indexPath.row];

    ///
    NSString *finalCellId = [NSString stringWithFormat:@"%p_%@", collectionView , [cellVM yf_cellIdentity]];
    if ([self.registeredCellIdentifiers containsObject:finalCellId] == NO) {
        [self.registeredCellIdentifiers addObject:finalCellId];
        [collectionView registerClass:[cellVM yf_cellClass] forCellWithReuseIdentifier:finalCellId];
    }
    //
    id<YFCollectionCellProtocol> cell = [collectionView dequeueReusableCellWithReuseIdentifier:finalCellId forIndexPath:indexPath];
    
    if ([cell respondsToSelector:@selector(updateCellDelegate:)]) {
        [cell updateCellDelegate:self.viewModel.cellDelegate];
    }
    
    if ([cell respondsToSelector:@selector(updateCellWithViewModel:)]) {
        [cell updateCellWithViewModel:cellVM];
    }

    return (UICollectionViewCell *)cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    id<YFCollectionHeaderFooterVMProtocol> headerFooterVM = nil;
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader] ||
        [kind isEqualToString:UICollectionElementKindSectionHeader]) {
        headerFooterVM = self.viewModel.sectionDataSource[indexPath.section].sectionHeaderViewModel;
    } else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter] ||
               [kind isEqualToString:UICollectionElementKindSectionFooter]) {
        headerFooterVM = self.viewModel.sectionDataSource[indexPath.section].sectionFooterViewModel;
    }
    
    if (headerFooterVM == nil) {
        return nil;
    }
    
    NSString *finalViewId = [NSString stringWithFormat:@"%p_%@_%@", collectionView, kind, [headerFooterVM yf_reusableViewIdentity]];
    if ([self.registeredHeaderFooterIdentifiers containsObject:finalViewId] == NO) {
        [self.registeredHeaderFooterIdentifiers addObject:finalViewId];
        [collectionView registerClass:[headerFooterVM yf_reusableViewClass] forSupplementaryViewOfKind:kind withReuseIdentifier:finalViewId];
    }
    
    id<YFCollectionHeaderFooterProtocol> headerFooterView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:finalViewId forIndexPath:indexPath];
    [headerFooterView updateViewWithViewModel:headerFooterVM];
    
    return (UICollectionReusableView *)headerFooterView;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    id<YFCollectionCellVMProtocol> cellVM = self.viewModel.sectionDataSource[indexPath.section].listDataSource[indexPath.row];
    return [cellVM yf_cellSize];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    YFCollectionSectionViewModel *sectionVM = self.viewModel.sectionDataSource[section];
    return sectionVM.sectionInsets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    YFCollectionSectionViewModel *sectionVM = self.viewModel.sectionDataSource[section];
    if (sectionVM.minimumLineSpacing < 0) {
        ///sectionVM中没有赋值minimumLineSpacing,就用layout中的值
        if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
            UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
            return flowLayout.minimumLineSpacing;
        }
        return 0;
    } else {
        return sectionVM.minimumLineSpacing;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    YFCollectionSectionViewModel *sectionVM = self.viewModel.sectionDataSource[section];
    if (sectionVM.minimumInteritemSpacing < 0) {
        ///sectionVM中没有赋值minimumInteritemSpacing,就用layout中的值
        if ([collectionViewLayout isKindOfClass:[CHTCollectionViewWaterfallLayout class]]) {
            CHTCollectionViewWaterfallLayout *layout = (CHTCollectionViewWaterfallLayout *)collectionViewLayout;
            return layout.minimumInteritemSpacing;
        } else if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
            UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
            return flowLayout.minimumInteritemSpacing;
        }
        return 0;
    } else {
        return sectionVM.minimumInteritemSpacing;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    YFCollectionSectionViewModel *sectionVM = self.viewModel.sectionDataSource[section];
    return [sectionVM.sectionHeaderViewModel yf_reusableViewSize];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    YFCollectionSectionViewModel *sectionVM = self.viewModel.sectionDataSource[section];
    return [sectionVM.sectionFooterViewModel yf_reusableViewSize];
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout columnCountForSection:(NSInteger)section {
    YFCollectionSectionViewModel *sectionVM = self.viewModel.sectionDataSource[section];
    return sectionVM.columnCount;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section {
    YFCollectionSectionViewModel *sectionVM = self.viewModel.sectionDataSource[section];
    return [sectionVM.sectionHeaderViewModel yf_reusableViewSize].height;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section {
    YFCollectionSectionViewModel *sectionVM = self.viewModel.sectionDataSource[section];
    return [sectionVM.sectionFooterViewModel yf_reusableViewSize].height;
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForHeaderInSection:(NSInteger)section {
//
//}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForFooterInSection:(NSInteger)section {
//
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumColumnSpacingForSectionAtIndex:(NSInteger)section {
    YFCollectionSectionViewModel *sectionVM = self.viewModel.sectionDataSource[section];
    if (sectionVM.minimumColumnSpacing < 0) {
        ///sectionVM中没有赋值minimumColumnSpacing,就用layout中的值
        if ([collectionViewLayout isKindOfClass:[CHTCollectionViewWaterfallLayout class]]) {
            CHTCollectionViewWaterfallLayout *layout = (CHTCollectionViewWaterfallLayout *)collectionViewLayout;
            return layout.minimumColumnSpacing;
        }
        return 0;
    } else {
        return sectionVM.minimumColumnSpacing;
    }
}

///section背景view
- (UIView *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout backgroundViewForSectionAt:(NSInteger)section {
    
    YFCollectionSectionViewModel *sectionVM = self.viewModel.sectionDataSource[section];
    return sectionVM.sectionBackgroundView;
}

#pragma mark - public methods
- (void)setViewModel:(id<YFCollectionVCViewModelProtocol>)viewModel {
    _viewModel = viewModel;
    self.viewModel.reloadSignal = [RACSubject subject];
    [self setupBindings];
}

- (void)setupBindings {
    @weakobj(self);
    [[self.viewModel.reloadSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongobj(self);
        [self.collectionView stopAnimating];
        [self.collectionView reloadData];
    }];
}

- (void)addPullToRefresh {
    @weakobj(self);
    [self.collectionView addPullToRefreshWithActionHandler:^{
        @strongobj(self);
        [self.viewModel yf_loadDataWithRefresh:YES];
    }];
}

- (void)addFooterRefresh {
    @weakobj(self);
    [self.collectionView addInfiniteScrollingWithActionHandler:^{
        @strongobj(self);
        [self.viewModel yf_loadDataWithRefresh:NO];
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [self.delegate scrollViewDidZoom:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.delegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ([self.delegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.delegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.delegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.delegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.delegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return [self.delegate scrollViewShouldScrollToTop:scrollView];
    }
    return YES;
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.delegate scrollViewDidScrollToTop:scrollView];
    }
}

/* Also see -[UIScrollView adjustedContentInsetDidChange]
 */
- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView API_AVAILABLE(ios(11.0), tvos(11.0)) {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidChangeAdjustedContentInset:)]) {
        [self.delegate scrollViewDidChangeAdjustedContentInset:scrollView];
    }
}

#pragma mark -  set/get

- (NSMutableArray<NSString *> *)registeredCellIdentifiers {
    if (_registeredCellIdentifiers == nil) {
        _registeredCellIdentifiers = [NSMutableArray array];
    }
    return _registeredCellIdentifiers;
}

- (NSMutableArray<NSString *> *)registeredHeaderFooterIdentifiers {
    if (_registeredHeaderFooterIdentifiers == nil) {
        _registeredHeaderFooterIdentifiers = [NSMutableArray array];
    }
    return _registeredHeaderFooterIdentifiers;
}
    
@end
