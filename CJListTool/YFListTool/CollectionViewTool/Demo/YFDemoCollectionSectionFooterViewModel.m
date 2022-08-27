//
//  YFDemoCollectionSectionFooterViewModel.m
//  CJListTool
//
//  Created by ChenJie on 2022/8/20.
//

#import "YFDemoCollectionSectionFooterViewModel.h"
#import "CJDemoCommonHeader.h"

#import "YFDemoCollectionSectionFooterView.h"

@interface YFDemoCollectionSectionFooterViewModel ()

@property (nonatomic, strong, readwrite) id model;
@property (nonatomic, assign) CGSize viewSizeValue;

@end

@implementation YFDemoCollectionSectionFooterViewModel

- (instancetype)initWithModel:(id)model {
    if (self = [super init]) {
        self.model = model;
        
        // DoSomeThing
        self.viewSizeValue = CGSizeMake(kScreenWidth, 40);
        
    }
    return self;
}

#pragma mark -  YFCollectionHeaderFooterVMProtocol

- (CGSize)yf_reusableViewSize {
    return self.viewSizeValue;
}

- (NSString *)yf_reusableViewIdentity {
    return NSStringFromClass([self yf_reusableViewClass]);
}

- (Class)yf_reusableViewClass {
    return [YFDemoCollectionSectionFooterView class];
}

@end
