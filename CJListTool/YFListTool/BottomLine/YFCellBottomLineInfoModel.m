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
        self.showBottomLine = YES;
        self.bottomLineLeft = 0;
        self.bottomLineRight = 0;
        self.bottomLineheight = 1;
        self.bottomLineColor = [UIColor grayColor];
    }
    return self;
}

@end
