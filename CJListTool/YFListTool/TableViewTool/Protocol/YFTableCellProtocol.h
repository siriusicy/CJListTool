//
//  YFTableCellProtocol.h
//  YYMessageModule
//
//  Created by ChenJie on 2022/7/29.
//

#import <Foundation/Foundation.h>
#import "YFTableCellVMProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YFTableCellProtocol <NSObject>

@property (nonatomic, strong) id<YFTableCellVMProtocol> viewModel;

///cell 设置数据
- (void)updateCellWithViewModel:(id<YFTableCellVMProtocol>)cellViewModel;

@optional
- (void)updateCellDelegate:(id)cellDelegate;

@end


NS_ASSUME_NONNULL_END
