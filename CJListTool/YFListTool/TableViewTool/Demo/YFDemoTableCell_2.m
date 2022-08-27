//
//  YFDemoTableCell_2.m
//  CJListTool
//
//  Created by ChenJie on 2022/8/4.
//

#import "YFDemoTableCell_2.h"
#import <Masonry/Masonry.h>

@interface YFDemoTableCell_2 ()

@property (nonatomic, strong, readwrite) YFDemoTableCell_2ViewModel *cellVM;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation YFDemoTableCell_2
// 协议定义的存储属性
@synthesize viewModel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        ///
        self.contentView.backgroundColor = [UIColor greenColor];

        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.centerY.mas_equalTo(0);
        }];
        
    }
    return self;
}

#pragma mark -  YFTableCellProtocol
///cell 设置数据
- (void)updateCellWithViewModel:(id<YFTableCellVMProtocol>)cellViewModel {
    self.viewModel = cellViewModel;
    self.cellVM = (YFDemoTableCell_2ViewModel *)cellViewModel;
    
    //DoSomeThing
    
    
}

#pragma mark -  set/get

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = [UIFont boldSystemFontOfSize:14.0];
        lab.textColor = [UIColor blackColor];
        lab.text = @"YFDemoTableCell_2";
        
        _titleLabel = lab;
    }
    return _titleLabel;
}

@end
