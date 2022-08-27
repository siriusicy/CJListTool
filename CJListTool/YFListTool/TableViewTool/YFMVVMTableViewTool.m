//
//  YFMVVMTableViewTool.m
//  CJListTool
//
//  Created by ChenJie on 2022/8/3.
//

#import "YFMVVMTableViewTool.h"
#import "CJDemoCommonHeader.h"
#import "YFTableSectionViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UIScrollView+Refresh.h"
#import "UITableViewCell+BottomLine.h"

@interface YFMVVMTableViewTool ()

@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) id<YFTableVCViewModelProtocol> viewModel;

@end

@implementation YFMVVMTableViewTool

- (instancetype)initWithViewModel:(id<YFTableVCViewModelProtocol>)viewModel {
    return [self initWithViewModel:viewModel tableViewStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithViewModel:(id<YFTableVCViewModelProtocol>)viewModel tableViewStyle:(UITableViewStyle)style {
    if (self = [super init]) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
        tableView.translatesAutoresizingMaskIntoConstraints = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor clearColor];
        //
        tableView.delegate = self;
        tableView.dataSource = self;
        //
        tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.01)];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.01)];
        tableView.sectionHeaderHeight = 0.01;
        tableView.sectionFooterHeight = 0.01;
        tableView.estimatedRowHeight = 0;
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        self.tableView = tableView;
        
        self.viewModel = viewModel;
    }
    return self;
}

#pragma mark - public methods
- (void)setViewModel:(id<YFTableVCViewModelProtocol>)viewModel {
    _viewModel = viewModel;
    self.viewModel.reloadSignal = [RACSubject subject];
    [self setupBindings];
}

- (void)setupBindings {
    @weakobj(self);
    [[self.viewModel.reloadSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongobj(self);
        [self.tableView stopAnimating];
        [self.tableView reloadData];
    }];
}

- (void)addPullToRefresh {
    @weakobj(self);
    [self.tableView addPullToRefreshWithActionHandler:^{
        @strongobj(self);
        [self.viewModel yf_loadDataWithRefresh:YES];
    }];
}

- (void)addFooterRefresh {
    @weakobj(self);
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        @strongobj(self);
        [self.viewModel yf_loadDataWithRefresh:NO];
    }];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.sectionDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YFTableSectionViewModel *model = self.viewModel.sectionDataSource[section];
    return model.listDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<YFTableCellVMProtocol> cellViewModel = self.viewModel.sectionDataSource[indexPath.section].listDataSource[indexPath.row];
    id<YFTableCellProtocol> cell = [tableView dequeueReusableCellWithIdentifier:[cellViewModel yf_cellIdentity]];
    if (cell == nil) {
        cell = [[[cellViewModel yf_cellClass] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[cellViewModel yf_cellIdentity]];
    }
    if ([cell respondsToSelector:@selector(updateCellDelegate:)]) {
        [cell updateCellDelegate:self.viewModel.cellDelegate];
    }
    if ([cell respondsToSelector:@selector(updateCellWithViewModel:)]) {
        [cell updateCellWithViewModel:cellViewModel];
    }

    return (UITableViewCell *)cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    YFTableSectionViewModel *model = (YFTableSectionViewModel*)self.viewModel.sectionDataSource[section];
    return model.sectionFootView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YFTableSectionViewModel *model = (YFTableSectionViewModel*)self.viewModel.sectionDataSource[section];
    return model.sectionHeadView;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    id<YFTableCellVMProtocol> cellViewModel = self.viewModel.sectionDataSource[indexPath.section].listDataSource[indexPath.row];
    
    if ([cellViewModel respondsToSelector:@selector(bottomLineInfo)]) {
        [cell yf_decorateWithBottomInfo:[cellViewModel bottomLineInfo]];
    } else {
        [cell yf_decorateWithBottomInfo:nil];
    }
    
    if ([self.delegate respondsToSelector:@selector(tableView:willDisplayCell:indexPath:)]) {
        [self.delegate tableView:tableView willDisplayCell:(UITableViewCell<YFTableCellProtocol>*)cell indexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(tableView:didEndDisplayingCell:indexPath:)]) {
        [self.delegate tableView:tableView didEndDisplayingCell:(UITableViewCell<YFTableCellProtocol>*)cell indexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YFTableSectionViewModel *model = self.viewModel.sectionDataSource[indexPath.section];
    id<YFTableCellVMProtocol> cellViewModel = model.listDataSource[indexPath.row];
    return [cellViewModel yf_cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    YFTableSectionViewModel *model = self.viewModel.sectionDataSource[section];
    switch (tableView.style) {
        case UITableViewStylePlain:
            return model.sectionHeadHeight;
            break;
        case UITableViewStyleGrouped:
        case UITableViewStyleInsetGrouped:
            return model.sectionHeadHeight > 0 ? model.sectionHeadHeight : 0.01;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    YFTableSectionViewModel *model = self.viewModel.sectionDataSource[section];
    switch (tableView.style) {
        case UITableViewStylePlain:
            return model.sectionFootHeight;
            break;
        case UITableViewStyleGrouped:
        case UITableViewStyleInsetGrouped:
            return model.sectionFootHeight > 0 ? model.sectionFootHeight : 0.01;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id<YFTableCellVMProtocol> cellViewModel = self.viewModel.sectionDataSource[indexPath.section].listDataSource[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectCellViewModel:indexPath:)]) {
        [self.delegate tableView:tableView didSelectCellViewModel:cellViewModel indexPath:indexPath];
    }
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

@end


