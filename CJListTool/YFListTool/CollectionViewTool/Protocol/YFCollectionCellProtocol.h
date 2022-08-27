//
//  YFCollectionCellProtocol.h
//  YYMessageModule
//
//  Created by ChenJie on 2022/7/29.
//

#import <Foundation/Foundation.h>
#import "YFCollectionCellVMProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YFCollectionCellProtocol <NSObject>

@property (nonatomic, strong) id<YFCollectionCellVMProtocol> viewModel;

///cell 设置数据
- (void)updateCellWithViewModel:(id<YFCollectionCellVMProtocol>)cellViewModel;

@optional
- (void)updateCellDelegate:(id)cellDelegate;

@end


NS_ASSUME_NONNULL_END
