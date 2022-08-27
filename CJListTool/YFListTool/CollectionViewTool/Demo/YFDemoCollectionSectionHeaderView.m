//
//  YFDemoCollectionSectionHeaderView.m
//  CJListTool
//
//  Created by ChenJie on 2022/8/20.
//

#import "YFDemoCollectionSectionHeaderView.h"
#import <Masonry/Masonry.h>

@interface YFDemoCollectionSectionHeaderView ()

@property (nonatomic, strong, readwrite) YFDemoCollectionSectionHeaderViewModel *headerVM;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YFDemoCollectionSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor greenColor];
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.centerY.mas_equalTo(0);
        }];
        
    }
    return self;
}

#pragma mark -  YFCollectionHeaderFooterProtocol
@synthesize viewModel;
///设置数据
- (void)updateViewWithViewModel:(id<YFCollectionHeaderFooterVMProtocol>) itemViewModel {
    self.viewModel = itemViewModel;
    self.headerVM = (YFDemoCollectionSectionHeaderViewModel *)itemViewModel;
    
    /// TODO -

}

#pragma mark -  set/get

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont boldSystemFontOfSize:14.0];
        lab.textColor = [UIColor blackColor];
        lab.text = @"Header";
        
        _titleLabel = lab;
    }
    return _titleLabel;
}


@end
