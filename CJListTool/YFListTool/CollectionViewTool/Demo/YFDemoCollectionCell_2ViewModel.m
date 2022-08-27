//
//  YFDemoCollectionCell_2ViewModel.m
//  CJListTool
//
//  Created by ChenJie on 2022/8/20.
//

#import "YFDemoCollectionCell_2ViewModel.h"
#import "YFDemoCollectionCell_2.h"

@interface YFDemoCollectionCell_2ViewModel ()

@property (nonatomic, strong, readwrite) id model;

@property (nonatomic, assign) CGSize cellSizeValue;
@end

@implementation YFDemoCollectionCell_2ViewModel

- (instancetype)initWithModel:(id)model {
    if (self = [super init]) {
        self.model = model;
        
        // DoSomeThing
        self.cellSizeValue = CGSizeMake(156, 208);
        
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
    return [YFDemoCollectionCell_2 class];
}


@end
