//
//  YFCollectionHeaderFooterVMProtocol.h
//  CJListTool
//
//  Created by ChenJie on 2022/8/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YFCollectionHeaderFooterVMProtocol <NSObject>

- (CGSize)yf_reusableViewSize;
- (NSString *)yf_reusableViewIdentity;
- (Class)yf_reusableViewClass;

@end

NS_ASSUME_NONNULL_END
