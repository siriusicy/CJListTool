//
//  YFDemoCollectionCell_2.h
//  CJListTool
//
//  Created by ChenJie on 2022/8/20.
//

#import <UIKit/UIKit.h>
#import "YFCollectionCellProtocol.h"
#import "YFDemoCollectionCell_2ViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YFDemoCollectionCell_2 : UICollectionViewCell <YFCollectionCellProtocol>

@property (nonatomic, strong, readonly) YFDemoCollectionCell_2ViewModel *cellVM;

@end

NS_ASSUME_NONNULL_END
