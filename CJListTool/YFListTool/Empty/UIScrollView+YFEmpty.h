//
//  UIScrollView+YFEmpty.h
//  CJListTool
//
//  Created by ChenJie on 2022/9/5.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (YFEmpty) <DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

#pragma mark -  页面出错
@property (nonatomic, assign) BOOL isError;
@property (nonatomic, strong) UIImage *errorImage UI_APPEARANCE_SELECTOR;
@property (nonatomic, copy, nullable) NSString *errorString UI_APPEARANCE_SELECTOR;
@property (nonatomic, copy, nullable) NSAttributedString *errorAttributedString;
@property (nonatomic, copy, nullable) NSString *errorDescriptionString UI_APPEARANCE_SELECTOR;
@property (nonatomic, copy, nullable) NSAttributedString *errorDescriptionAttributedString;

#pragma mark -  页面空白
@property (nonatomic, strong) UIImage *emptyImage UI_APPEARANCE_SELECTOR;
@property (nonatomic, copy) NSString *emptyString UI_APPEARANCE_SELECTOR;
@property (nonatomic, copy, nullable) NSAttributedString *emptyAttributedString;
@property (nonatomic, copy, nullable) NSString *emptyDescriptionString UI_APPEARANCE_SELECTOR;
@property (nonatomic, copy, nullable) NSAttributedString *emptyDescriptionAttributedString;

#pragma mark -  背景色
@property (nonatomic, strong) UIColor *emptyDataSetBackgroundColor;

@end

NS_ASSUME_NONNULL_END
