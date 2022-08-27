//
//  YFDemoCollectionCell_1.h
//  CJListTool
//
//  Created by ChenJie on 2022/8/20.
//

#import <UIKit/UIKit.h>
#import "YFCollectionCellProtocol.h"
#import "YFDemoCollectionCell_1ViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class YFDemoCollectionCell_1;
@protocol YFDemoCollectionCell_1Protocol <NSObject>

- (void)demoCollectionCell_1:(YFDemoCollectionCell_1 *)cell testAction:(NSInteger)testNumber;

@end

@interface YFDemoCollectionCell_1 : UICollectionViewCell <YFCollectionCellProtocol>

@property (nonatomic, strong, readonly) YFDemoCollectionCell_1ViewModel *cellVM;

@property (nonatomic, weak) id<YFDemoCollectionCell_1Protocol> delegate;
@end

NS_ASSUME_NONNULL_END
