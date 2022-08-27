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

@interface YFDemoTableViewController () <YFMVVMTableViewToolDelegate, YFDemoTableCell_1Protocol>

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
        
    }];
    ///加载数据
    [self.viewModel yf_loadDataWithRefresh:YES];
}

#pragma mark -  YFDemoTableCell_1Protocol

- (void)demoTableCell_1:(YFDemoTableCell_1 *)cell testAction:(NSInteger)testNumber {
    NSLog(@"YFDemoTableCell_1 testNumber: %zd",testNumber);
}

#pragma mark -  YFMVVMTableViewToolDelegate

- (void)tableView:(UITableView *_Nullable)tableView willDisplayCell:(UITableViewCell<YFTableCellProtocol> *_Nullable)cell indexPath:(NSIndexPath *_Nullable)indexPath {
    
    if ([cell isKindOfClass:[YFDemoTableCell_1 class]]) {
        YFDemoTableCell_1 *realCell = (YFDemoTableCell_1 *)cell;

    } else if ([cell isKindOfClass:[YFDemoTableCell_2 class]]) {
        YFDemoTableCell_2 *realCell = (YFDemoTableCell_2 *)cell;
//        cell.block = ^ { };
        realCell.showBottomLine = YES;
        realCell.bottomLineHeight = 3;
        realCell.bottomLineLeft = 10;
        realCell.bottomLineRight = 20;
        realCell.bottomLineColor = [UIColor blackColor];
    }
    
}

- (void)tableView:(UITableView *_Nullable)tableView didSelectCellViewModel:(id<YFTableCellVMProtocol> _Nullable)cellViewModel indexPath:(NSIndexPath *_Nullable)indexPath {
    
    // DoSomeThing
    if ([cellViewModel isKindOfClass:[YFDemoTableCell_1ViewModel class]]) {
        YFDemoTableCell_1ViewModel *viewModel = (YFDemoTableCell_1ViewModel *)cellViewModel;
        UIViewController *vc = nil;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([cellViewModel isKindOfClass:[YFDemoTableCell_2ViewModel class]]) {
        YFDemoTableCell_2ViewModel *viewModel = (YFDemoTableCell_2ViewModel *)cellViewModel;
        UIViewController *vc = nil;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark -  set/get

- (YFMVVMTableViewTool *)tableViewTool {
    if (_tableViewTool == nil) {
        _tableViewTool = [[YFMVVMTableViewTool alloc] initWithViewModel:self.viewModel];
        _tableViewTool.delegate = self;
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
        _viewModel.cellDelegate = self;
    }
    return _viewModel;
}

@end
