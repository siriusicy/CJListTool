//
//  YFDemoCollectionCell_1.m
//  CJListTool
//
//  Created by ChenJie on 2022/8/20.
//

#import "YFDemoCollectionCell_1.h"
#import <Masonry/Masonry.h>

@interface YFDemoCollectionCell_1 ()

@property (nonatomic, strong, readwrite) YFDemoCollectionCell_1ViewModel *cellVM;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YFDemoCollectionCell_1

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor greenColor];
        
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.centerY.mas_equalTo(0);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self.contentView addGestureRecognizer:tap];

    }
    return self;
}

#pragma mark -  action
- (void)tapAction:(UITapGestureRecognizer *)tap{
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(demoCollectionCell_1:testAction:)]) {
        [self.delegate demoCollectionCell_1:self testAction:1];
    }
}

#pragma mark -  YFCollectionCellProtocol
@synthesize viewModel;

- (void)updateCellWithViewModel:(id<YFCollectionCellVMProtocol>)cellViewModel {
    self.viewModel = cellViewModel;
    self.cellVM = (YFDemoCollectionCell_1ViewModel *)cellViewModel;
    
    //DoSomeThing
    
}

- (void)updateCellDelegate:(id)cellDelegate {
    self.delegate = cellDelegate;
}

#pragma mark -  set/get

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont boldSystemFontOfSize:14.0];
        lab.textColor = [UIColor blackColor];
        lab.text = @"YFDemoCollectionCell_1";
        
        _titleLabel = lab;
    }
    return _titleLabel;
}


@end
