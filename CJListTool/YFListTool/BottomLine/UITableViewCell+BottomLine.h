//
//  UITableViewCell+BottomLine.h
//  CJListTool
//
//  Created by ChenJie on 2022/8/3.
//

#import <UIKit/UIKit.h>
#import "YFCellBottomLineInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (BottomLine)

@property (nonatomic ,assign) BOOL showBottomLine;

@property (nonatomic ,assign) CGFloat bottomLineLeft;

@property (nonatomic ,assign) CGFloat bottomLineRight;

@property (nonatomic ,assign) CGFloat bottomLineHeight;

@property (nonatomic, copy) UIColor *bottomLineColor;

@property (nonatomic ,strong ,readonly) UIView *yf_bottomLineView;

/// 传空会重置信息
- (void)yf_decorateWithBottomInfo:(nullable YFCellBottomLineInfoModel *)info;

@end

NS_ASSUME_NONNULL_END
