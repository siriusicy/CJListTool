//
//  YFDemoTableViewModel.m
//  CJListTool
//
//  Created by ChenJie on 2022/8/4.
//

#import "YFDemoTableViewModel.h"
#import "CJDemoCommonHeader.h"
#import "YFDemoTableCell_1ViewModel.h"
#import "YFDemoTableCell_2ViewModel.h"

@interface YFDemoTableViewModel ()

@property (nonatomic, strong) NSNumber *xxId;
@property (nonatomic, strong) NSMutableArray<NSObject<YFTableCellVMProtocol> *> *dataArray;

@end

@implementation YFDemoTableViewModel

- (instancetype)initWithId:(NSNumber *)xxId {
    self = [self initWithId:xxId];
    if (self) {
        self.xxId = xxId;
    }
    return self;
}


/// Table Section Footer / Header
- (UIView *)headHeaderFooterView:(BOOL)isHeader {
    
    UIView *view = [UIView.alloc initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    view.backgroundColor = isHeader ? [UIColor greenColor] : [UIColor redColor];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = [UIColor blackColor];
    lab.text = isHeader ? @"Header" : @"Footer";
    [view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.centerY.mas_equalTo(0);
    }];
    return view;
}

#pragma mark -  YFTableVCViewModelProtocol
// 协议定义的存储属性
@synthesize sectionDataSource;
@synthesize reloadSignal;
@synthesize cellDelegate;

///组装数据
- (NSMutableArray <YFTableSectionViewModel *> *)yf_packageSectionDataSource {
    
    NSMutableArray *array = [NSMutableArray array];
    
#pragma mark -  section1
    YFTableSectionViewModel *section1 = [[YFTableSectionViewModel alloc] init];
    section1.sectionHeadHeight = 50;
    section1.sectionHeadView = [self headHeaderFooterView:YES];
    section1.sectionFootHeight = 60;
    section1.sectionFootView = [self headHeaderFooterView:NO];
    
    for (int i=0; i<4; ++i) {
        YFDemoTableCell_1ViewModel *cellVM = [[YFDemoTableCell_1ViewModel alloc] initWithModel:nil];
        ///自定义cell bottomLine 如果有需要的话
        cellVM.bottomLineInfo = [YFCellBottomLineInfoModel yf_cellBottomLineWithLeft:10 right:20 color:[UIColor blackColor]];
        [section1.listDataSource addObject:cellVM];
    }
    
    [array addObject:section1];

#pragma mark -  section2

    YFTableSectionViewModel *section2 = [[YFTableSectionViewModel alloc] init];
    section2.sectionHeadHeight = 50;
    section2.sectionHeadView = [self headHeaderFooterView:YES];
    section2.sectionFootHeight = 60;
    section2.sectionFootView = [self headHeaderFooterView:NO];
    
    section2.listDataSource = self.dataArray;
    
    [array addObject:section2];

    return array;
}

///加载数据
- (void)yf_loadDataWithRefresh:(BOOL)isRefresh {
    
    // TODO:- 数据请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (isRefresh) {
            [self.dataArray removeAllObjects];
        }
        
        
        YFDemoTableCell_2ViewModel *cellVM = [[YFDemoTableCell_2ViewModel alloc] initWithModel:nil];
        ///自定义cell bottomLine 如果有需要的话
        cellVM.bottomLineInfo = [YFCellBottomLineInfoModel yf_cellBottomLineWithLeft:10 right:20 color:[UIColor redColor]];
        [self.dataArray addObject:cellVM];

        ///
        self.sectionDataSource = [self yf_packageSectionDataSource];
//        self.noMoreData = YES;
        ///
        BOOL isError = YES;
        [self.requestCompleteSignal sendNext:@(isError)];
        
        ///这个信号会reloadData
        [self.reloadSignal sendNext:nil];

    });
}

#pragma mark -  set/get

- (RACSubject *)requestCompleteSignal {
    if (_requestCompleteSignal == nil) {
        _requestCompleteSignal = [RACSubject subject];
    }
    return _requestCompleteSignal;
}

- (NSMutableArray<NSObject<YFTableCellVMProtocol> *> *)dataArray  {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
