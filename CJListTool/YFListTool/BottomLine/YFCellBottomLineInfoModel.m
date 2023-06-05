//
//  YFCellBottomLineInfoModel.m
//  CJListTool
//
//  Created by ChenJie on 2022/8/3.
//

#import "YFCellBottomLineInfoModel.h"

@implementation YFCellBottomLineInfoModel

- (instancetype)init {
    if (self = [super init]) {
        _showBottomLine = YES;
        _bottomLineLeft = 0;
        _bottomLineRight = 0;
        _bottomLineheight = 1;
        _bottomLineColor = [UIColor grayColor];
    }
    return self;
}


+ (YFCellBottomLineInfoModel *)yf_defaultBottomLine {
    return [[YFCellBottomLineInfoModel alloc] init];
}

+ (YFCellBottomLineInfoModel *)yf_cellBottomLineWithLeft:(CGFloat)bottomLineLeft
                                                   right:(CGFloat)bottomLineRight
                                                   color:(UIColor *)bottomLineColor {
    YFCellBottomLineInfoModel *model = [self yf_defaultBottomLine];
    model.bottomLineLeft = bottomLineLeft;
    model.bottomLineRight = bottomLineRight;
    model.bottomLineColor = bottomLineColor;
    return model;
}

@end
