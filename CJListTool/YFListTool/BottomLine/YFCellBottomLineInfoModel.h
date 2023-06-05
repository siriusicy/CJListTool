//
//  YFCellBottomLineInfoModel.h
//  CJListTool
//
//  Created by ChenJie on 2022/8/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFCellBottomLineInfoModel : NSObject

@property (nonatomic ,assign) BOOL showBottomLine;  ///< default YES
@property (nonatomic ,assign) CGFloat bottomLineLeft; ///< default 0
@property (nonatomic ,assign) CGFloat bottomLineRight; ///< default 0
@property (nonatomic ,copy) UIColor *bottomLineColor; ///< [UIColor grayColor]
@property (nonatomic ,assign) CGFloat bottomLineheight; ///< default 1px


+ (YFCellBottomLineInfoModel *)yf_defaultBottomLine;

+ (YFCellBottomLineInfoModel *)yf_cellBottomLineWithLeft:(CGFloat)bottomLineLeft
                                                   right:(CGFloat)bottomLineRight
                                                   color:(UIColor *)bottomLineColor;


@end

NS_ASSUME_NONNULL_END
