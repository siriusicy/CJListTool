//
//  YFDemoCollectionCell_1ViewModel.m
//  CJListTool
//
//  Created by ChenJie on 2022/8/20.
//

#import "YFDemoCollectionCell_1ViewModel.h"
#import "YFDemoCollectionCell_1.h"

@interface YFDemoCollectionCell_1ViewModel ()

@property (nonatomic, strong, readwrite) id model;

@property (nonatomic, assign) CGSize cellSizeValue;
@end

@implementation YFDemoCollectionCell_1ViewModel

- (instancetype)initWithModel:(id)model {
    if (self = [super init]) {
        self.model = model;
        
        // DoSomeThing
        self.cellSizeValue = CGSizeMake(100, 200);
        
    }
    return self;
}

#pragma mark -  YFCollectionCellVMProtocol
@synthesize bottomLineInfo;

- (CGSize)yf_cellSize {
    return self.cellSizeValue;
}

- (NSString *)yf_cellIdentity {
    return NSStringFromClass([self yf_cellClass]);
}

- (Class)yf_cellClass {
    return [YFDemoCollectionCell_1 class];
}


@end
