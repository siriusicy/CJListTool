//
//  YFDemoTableCell_1ViewModel.m
//  CJListTool
//
//  Created by ChenJie on 2022/8/4.
//

#import "YFDemoTableCell_1ViewModel.h"
#import "YFDemoTableCell_1.h"

@interface YFDemoTableCell_1ViewModel ()

@property (nonatomic, strong, readwrite) id model;

@property (nonatomic, assign) CGFloat cellHeightValue;

@end

@implementation YFDemoTableCell_1ViewModel

- (instancetype)initWithModel:(id)model {
    if (self = [super init]) {
        self.model = model;
        
        // DoSomeThing
        self.cellHeightValue = 150;
        
    }
    return self;
}

#pragma mark -  YFTableCellVMProtocol
@synthesize bottomLineInfo; // 协议定义的存储属性

- (CGFloat)yf_cellHeight {
    return self.cellHeightValue;
}

- (nonnull Class)yf_cellClass {
    return [YFDemoTableCell_1 class];
}

- (nonnull NSString *)yf_cellIdentity {
    return NSStringFromClass([YFDemoTableCell_1 class]);
}

@end
