//
//  YFDemoTableCell_1.m
//  CJListTool
//
//  Created by ChenJie on 2022/8/4.
//

#import "YFDemoTableCell_1.h"
#import <Masonry/Masonry.h>

@interface YFDemoTableCell_1 ()

@property (nonatomic, strong, readwrite) YFDemoTableCell_1ViewModel *cellVM;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YFDemoTableCell_1
// 协议定义的存储属性
@synthesize viewModel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        ///
        self.contentView.backgroundColor = [UIColor redColor];
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
        [self.delegate respondsToSelector:@selector(demoTableCell_1:testAction:)]) {
        [self.delegate demoTableCell_1:self testAction:1];
    }
}

#pragma mark -  YFTableCellProtocol
///cell 设置数据
- (void)updateCellWithViewModel:(id<YFTableCellVMProtocol>)cellViewModel {
    self.viewModel = cellViewModel;
    self.cellVM = (YFDemoTableCell_1ViewModel *)cellViewModel;
    
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
        lab.text = @"YFDemoTableCell_1";
        
        _titleLabel = lab;
    }
    return _titleLabel;
}

@end
