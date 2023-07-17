//
//  YFDemoCollectionViewController.m
//  CJListTool
//
//  Created by ChenJie on 2022/8/20.
//

#import "YFDemoCollectionViewController.h"
#import "CJDemoCommonHeader.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CHTCollectionViewWaterfallLayout.h"
#import "YFMVVMCollectionViewTool.h"
#import "YFDemoCollectionViewModel.h"
#import "YFDemoCollectionCell_1.h"
#import "YFDemoCollectionCell_2.h"
#import "UICollectionViewCell+BottomLine.h"
///空白页
#import "UIScrollView+YFEmpty.h"


@interface YFDemoCollectionViewController () <
YFMVVMCollectionViewToolDelegate , YFDemoCollectionCell_1Protocol,
DZNEmptyDataSetDelegate, DZNEmptyDataSetSource ///< 如果需要空白页的话遵守协议
>

@property (nonatomic, strong) YFMVVMCollectionViewTool *collectionViewTool;
@property (nonatomic, strong) YFDemoCollectionViewModel *viewModel;

@end

@implementation YFDemoCollectionViewController

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"CollectionToolTest";
    
    [self.view addSubview:self.collectionViewTool.collectionView];
    [self.collectionViewTool.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    ///绑定
    @weakobj(self);
    [[self.viewModel.requestCompleteSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongobj(self);
        //DoSomeThing
        
        ///如果需要空白页的话
        if ([x isKindOfClass:[NSNumber class]]) {
            self.collectionViewTool.collectionView.isError = [(NSNumber *)x boolValue];
        }
        
    }];
    ///加载数据
    [self.viewModel yf_loadDataWithRefresh:YES];
}

#pragma mark -  YFDemoCollectionCell_1Protocol
///cell的代理方法
- (void)demoCollectionCell_1:(YFDemoCollectionCell_1 *)cell testAction:(NSInteger)testNumber {
    NSLog(@"YFDemoCollectionCell_1 testNumber: %zd",testNumber);
}

#pragma mark -  YFMVVMCollectionViewToolDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell isKindOfClass:[YFDemoCollectionCell_1 class]]) {
        YFDemoCollectionCell_1 *realCell = (YFDemoCollectionCell_1 *)cell;

    } else if ([cell isKindOfClass:[YFDemoCollectionCell_2 class]]) {
        YFDemoCollectionCell_2 *realCell = (YFDemoCollectionCell_2 *)cell;
//        cell.block = ^ { };

    }
    
}

- (void)collectionView:(UICollectionView *)tableView didSelectCellViewModel:(id<YFCollectionCellVMProtocol> _Nullable)cellViewModel indexPath:(NSIndexPath *)indexPath {
    
    // DoSomeThing
    if ([cellViewModel isKindOfClass:[YFDemoCollectionCell_1ViewModel class]]) {
        YFDemoCollectionCell_1ViewModel *viewModel = (YFDemoCollectionCell_1ViewModel *)cellViewModel;
//        UIViewController *vc = nil;
//        [self.navigationController pushViewController:vc animated:YES];
    } else if ([cellViewModel isKindOfClass:[YFDemoCollectionCell_2ViewModel class]]) {
        YFDemoCollectionCell_2ViewModel *viewModel = (YFDemoCollectionCell_2ViewModel *)cellViewModel;
//        UIViewController *vc = nil;
//        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark -  DZNEmptyDataSetDelegate
///如果该页面的空白页需要自定义,在这里实现对应的代理方法,默认不需要实现,会有一个全局的样式

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    NSLog(@"空白页点击");
    [self.viewModel yf_loadDataWithRefresh:YES];
}

#pragma mark -  set/get

- (YFMVVMCollectionViewTool *)collectionViewTool {
    if (_collectionViewTool == nil) {
        
        #pragma mark -  正常demo
//        _collectionViewTool = [[YFMVVMCollectionViewTool alloc] initWithViewModel:self.viewModel];
        #pragma mark -  瀑布流demo
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.minimumColumnSpacing = 16 ;//同一行item之间的间距
        layout.minimumInteritemSpacing = 16; //
        _collectionViewTool = [[YFMVVMCollectionViewTool alloc] initWithViewModel:self.viewModel layout:layout];
        
        
        
        _collectionViewTool.delegate = self;
        ///< 如果需要空白页的话遵守协议
        _collectionViewTool.collectionView.emptyDataSetDelegate = self;
        _collectionViewTool.collectionView.emptyDataSetSource = self;
        _collectionViewTool.collectionView.backgroundColor = [UIColor whiteColor];
        
        ///绑定上下拉刷新
        [_collectionViewTool addPullToRefresh];
        [_collectionViewTool addFooterRefresh];
        RAC(_collectionViewTool.collectionView, yf_noMoreData) = RACObserve(self.viewModel, noMoreData);
    }
    return _collectionViewTool;
}

- (YFDemoCollectionViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = [[YFDemoCollectionViewModel alloc] init];
        ///设置cell的代理
        _viewModel.cellDelegate = self;
    }
    return _viewModel;
}

@end

