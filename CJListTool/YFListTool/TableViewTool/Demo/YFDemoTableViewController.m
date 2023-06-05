//
//  YFDemoTableViewController.m
//  CJListTool
//
//  Created by ChenJie on 2022/8/4.
//

#import "YFDemoTableViewController.h"
#import "CJDemoCommonHeader.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "YFMVVMTableViewTool.h"
#import "UITableViewCell+BottomLine.h"
#import "YFDemoTableViewModel.h"
#import "YFDemoTableCell_1.h"
#import "YFDemoTableCell_2.h"

///空白页
#import "UIScrollView+YFEmpty.h"


@interface YFDemoTableViewController () <
YFMVVMTableViewToolDelegate, YFDemoTableCell_1Protocol,
DZNEmptyDataSetDelegate, DZNEmptyDataSetSource ///< 如果需要空白页的话遵守协议
>

@property (nonatomic, strong) YFMVVMTableViewTool *tableViewTool;
@property (nonatomic, strong) YFDemoTableViewModel *viewModel;

@end

@implementation YFDemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"tableToolTest";
    
    [self.view addSubview:self.tableViewTool.tableView];
    [self.tableViewTool.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
            self.tableViewTool.tableView.isError = [(NSNumber *)x boolValue];
        }
        
    }];
    ///加载数据
    [self.viewModel yf_loadDataWithRefresh:YES];
}

#pragma mark -  YFDemoTableCell_1Protocol
///cell的代理方法
- (void)demoTableCell_1:(YFDemoTableCell_1 *)cell testAction:(NSInteger)testNumber {
    NSLog(@"YFDemoTableCell_1 testNumber: %zd",testNumber);
}

#pragma mark -  YFMVVMTableViewToolDelegate

- (void)tableView:(UITableView *_Nullable)tableView willDisplayCell:(UITableViewCell<YFTableCellProtocol> *_Nullable)cell indexPath:(NSIndexPath *_Nullable)indexPath {
    
    // DoSomeThing if need
    if ([cell isKindOfClass:[YFDemoTableCell_1 class]]) {
        YFDemoTableCell_1 *realCell = (YFDemoTableCell_1 *)cell;

    } else if ([cell isKindOfClass:[YFDemoTableCell_2 class]]) {
        YFDemoTableCell_2 *realCell = (YFDemoTableCell_2 *)cell;
//        cell.block = ^ { };
    }
    
}

- (void)tableView:(UITableView *_Nullable)tableView didSelectCellViewModel:(id<YFTableCellVMProtocol> _Nullable)cellViewModel indexPath:(NSIndexPath *_Nullable)indexPath {
    
    // DoSomeThing if need
    if ([cellViewModel isKindOfClass:[YFDemoTableCell_1ViewModel class]]) {
        YFDemoTableCell_1ViewModel *viewModel = (YFDemoTableCell_1ViewModel *)cellViewModel;
//        UIViewController *vc = nil;
//        [self.navigationController pushViewController:vc animated:YES];
    } else if ([cellViewModel isKindOfClass:[YFDemoTableCell_2ViewModel class]]) {
        YFDemoTableCell_2ViewModel *viewModel = (YFDemoTableCell_2ViewModel *)cellViewModel;
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

- (YFMVVMTableViewTool *)tableViewTool {
    if (_tableViewTool == nil) {
        _tableViewTool = [[YFMVVMTableViewTool alloc] initWithViewModel:self.viewModel];
        _tableViewTool.delegate = self;
        ///< 如果需要空白页的话遵守协议
        _tableViewTool.tableView.emptyDataSetDelegate = self;
        _tableViewTool.tableView.emptyDataSetSource = self;
        
        _tableViewTool.tableView.backgroundColor = [UIColor whiteColor];
        
        ///绑定上下拉刷新
        [_tableViewTool addPullToRefresh];
        [_tableViewTool addFooterRefresh];
        RAC(_tableViewTool.tableView, yf_noMoreData) = RACObserve(self.viewModel, noMoreData);
    }
    return _tableViewTool;
}

- (YFDemoTableViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = [[YFDemoTableViewModel alloc] init];
        ///设置cell的代理
        _viewModel.cellDelegate = self;
    }
    return _viewModel;
}

@end
