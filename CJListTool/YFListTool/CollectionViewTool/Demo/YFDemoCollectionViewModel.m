//
//  YFDemoCollectionViewModel.m
//  CJListTool
//
//  Created by ChenJie on 2022/8/20.
//

#import "YFDemoCollectionViewModel.h"

#import "YFCollectionSectionViewModel.h"
#import "YFDemoCollectionSectionFooterViewModel.h"
#import "YFDemoCollectionSectionHeaderViewModel.h"
#import "YFDemoCollectionCell_1ViewModel.h"
#import "YFDemoCollectionCell_2ViewModel.h"

@interface YFDemoCollectionViewModel ()

@property (nonatomic, strong) NSNumber *xxId;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation YFDemoCollectionViewModel

- (instancetype)initWithId:(NSNumber *)xxId {
    self = [self initWithId:xxId];
    if (self) {
        self.xxId = xxId;
    }
    return self;
}

#pragma mark -  YFTableVCViewModelProtocol
// 协议定义的存储属性
@synthesize sectionDataSource;
@synthesize reloadSignal;
@synthesize cellDelegate;

///组装数据
- (NSMutableArray <YFCollectionSectionViewModel *> *)yf_packageSectionDataSource {
    
    NSMutableArray *array = [NSMutableArray array];

#pragma mark -  section1
    YFCollectionSectionViewModel *section1 = [[YFCollectionSectionViewModel alloc] init];
    
    section1.sectionInsets = UIEdgeInsetsMake(10, 16, 40, 30);
    ///header
    section1.sectionHeaderViewModel = [[YFDemoCollectionSectionHeaderViewModel alloc] initWithModel:nil];
    ///footer
    section1.sectionFooterViewModel = [[YFDemoCollectionSectionFooterViewModel alloc] initWithModel:nil];

    section1.minimumLineSpacing = 20;
    section1.minimumInteritemSpacing = 10;
    
    for (int i=0; i<4; ++i) {
        
        YFDemoCollectionCell_1ViewModel *cellVM = [[YFDemoCollectionCell_1ViewModel alloc] initWithModel:nil];
        ///自定义cell bottomLine 如果有需要的话
        YFCellBottomLineInfoModel *bottomLine = [YFCellBottomLineInfoModel yf_defaultBottomLine];
        bottomLine.bottomLineheight = 3;
        cellVM.bottomLineInfo = bottomLine;
        [section1.listDataSource addObject:cellVM];
    }
    
    [array addObject:section1];
#pragma mark -  section2

    YFCollectionSectionViewModel *section2 = [[YFCollectionSectionViewModel alloc] init];
    
    section2.sectionInsets = UIEdgeInsetsMake(30, 16, 20, 30);
    ///header
    section2.sectionHeaderViewModel = [[YFDemoCollectionSectionHeaderViewModel alloc] initWithModel:nil];
    ///footer
    section2.sectionFooterViewModel = [[YFDemoCollectionSectionFooterViewModel alloc] initWithModel:nil];

    section2.minimumLineSpacing = 30;
    section2.minimumInteritemSpacing = 10;
    
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
        
        YFDemoCollectionCell_2ViewModel *cellVM = [[YFDemoCollectionCell_2ViewModel alloc] initWithModel:nil];
        cellVM.bottomLineInfo = [YFCellBottomLineInfoModel yf_defaultBottomLine];
        [self.dataArray addObject:cellVM];
        self.sectionDataSource = [self yf_packageSectionDataSource];
//        self.noMoreData = YES;
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

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
