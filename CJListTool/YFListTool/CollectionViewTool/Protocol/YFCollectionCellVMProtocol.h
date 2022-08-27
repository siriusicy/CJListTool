//
//  YFCollectionCellVMProtocol.h
//  YYMessageModule
//
//  Created by ChenJie on 2022/7/29.
//

#import <Foundation/Foundation.h>
#import "YFCellBottomLineInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YFCollectionCellVMProtocol <NSObject>

- (CGSize)yf_cellSize;
- (NSString *)yf_cellIdentity;
- (Class)yf_cellClass;
@optional
///
@property (nonatomic, strong, nullable) YFCellBottomLineInfoModel *bottomLineInfo;

@end

NS_ASSUME_NONNULL_END
