//
//  YFCollectionSectionViewModel.h
//  AFNetworking
//
//  Created by ChenJie on 2022/8/15.
//

#import <Foundation/Foundation.h>
#import "YFCollectionCellVMProtocol.h"
#import "YFCollectionHeaderFooterVMProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YFCollectionSectionViewModel : NSObject

@property (nonatomic, assign) UIEdgeInsets sectionInsets; ///< default UIEdgeInsetsZero
@property (nonatomic, strong) id<YFCollectionHeaderFooterVMProtocol> sectionHeaderViewModel;
@property (nonatomic, strong) id<YFCollectionHeaderFooterVMProtocol> sectionFooterViewModel;
@property (nonatomic, strong) NSMutableArray<NSObject<YFCollectionCellVMProtocol> *> *listDataSource;

@property (nonatomic, assign) CGFloat minimumLineSpacing; ///< 行间距
// 以下为瀑布流属性
@property (nonatomic, assign) CGFloat minimumInteritemSpacing; ///< 同一行item之间的间距
@property (nonatomic, assign) CGFloat minimumColumnSpacing; ///
@property (nonatomic, assign) NSInteger columnCount;
@property (nonatomic, strong) UIView *sectionBackgroundView; ///< section背景

@end

NS_ASSUME_NONNULL_END
