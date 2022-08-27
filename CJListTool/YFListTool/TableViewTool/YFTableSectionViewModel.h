//
//  YFTableSectionViewModel.h
//  CJListTool
//
//  Created by ChenJie on 2022/7/29.
//

#import <Foundation/Foundation.h>
#import "YFTableCellVMProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YFTableSectionViewModel : NSObject <NSCopying>

@property (nonatomic, assign) CGFloat sectionHeadHeight;

@property (nonatomic, assign) CGFloat sectionFootHeight;

@property (nonatomic, strong) UIView *sectionHeadView;

@property (nonatomic, strong) UIView *sectionFootView;

@property (nonatomic, strong) NSMutableArray<id<YFTableCellVMProtocol>> *listDataSource;

@end

NS_ASSUME_NONNULL_END
