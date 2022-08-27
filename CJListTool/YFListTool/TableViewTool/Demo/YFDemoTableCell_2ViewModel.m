//
//  YFDemoTableCell_2ViewModel.m
//  CJListTool
//
//  Created by ChenJie on 2022/8/4.
//

#import "YFDemoTableCell_2ViewModel.h"
#import "YFDemoTableCell_2.h"

@interface YFDemoTableCell_2ViewModel ()

@property (nonatomic, strong, readwrite) id model;

@property (nonatomic, assign) CGFloat cellHeightValue;

@end

@implementation YFDemoTableCell_2ViewModel

- (instancetype)initWithModel:(id)model {
    if (self = [super init]) {
        self.model = model;
        
        //DoSomeThing
        self.cellHeightValue = 100;
        
    }
    return self;
}

#pragma mark -  YFTableCellVMProtocol
@synthesize bottomLineInfo; // 协议定义的存储属性

- (CGFloat)yf_cellHeight {
    return self.cellHeightValue;
}

- (nonnull Class)yf_cellClass {
    return [YFDemoTableCell_2 class];
}

- (nonnull NSString *)yf_cellIdentity {
    return NSStringFromClass([YFDemoTableCell_2 class]);
}

@end
