//
//  YFDemoCollectionCell_2.m
//  CJListTool
//
//  Created by ChenJie on 2022/8/20.
//

#import "YFDemoCollectionCell_2.h"
#import <Masonry/Masonry.h>

@interface YFDemoCollectionCell_2 ()

@property (nonatomic, strong, readwrite) YFDemoCollectionCell_2ViewModel *cellVM;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YFDemoCollectionCell_2

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor greenColor];
        
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.centerY.mas_equalTo(0);
        }];
    }
    return self;
}

#pragma mark -  YFCollectionCellProtocol
@synthesize viewModel;

- (void)updateCellWithViewModel:(id<YFCollectionCellVMProtocol>)cellViewModel {
    self.viewModel = cellViewModel;
    self.cellVM = (YFDemoCollectionCell_2ViewModel *)cellViewModel;
    
    //DoSomeThing
    
}

#pragma mark -  set/get

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont boldSystemFontOfSize:14.0];
        lab.textColor = [UIColor blackColor];
        lab.text = @"YFDemoCollectionCell_2";
        
        _titleLabel = lab;
    }
    return _titleLabel;
}


@end
