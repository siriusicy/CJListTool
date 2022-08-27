//
//  YFCollectionHeaderFooterProtocol.h
//  CJListTool
//
//  Created by ChenJie on 2022/8/15.
//

#import <Foundation/Foundation.h>
#import "YFCollectionHeaderFooterVMProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YFCollectionHeaderFooterProtocol <NSObject>

@property (nonatomic, strong) id<YFCollectionHeaderFooterVMProtocol> viewModel;

///设置数据
- (void)updateViewWithViewModel:(id<YFCollectionHeaderFooterVMProtocol>) itemViewModel;

@end

NS_ASSUME_NONNULL_END
