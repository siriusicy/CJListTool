//
//  YFDemoCollectionSectionFooterViewModel.h
//  CJListTool
//
//  Created by ChenJie on 2022/8/20.
//

#import <Foundation/Foundation.h>
#import "YFCollectionHeaderFooterVMProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YFDemoCollectionSectionFooterViewModel : NSObject <YFCollectionHeaderFooterVMProtocol>

@property (nonatomic, strong, readonly) id model;

- (instancetype)initWithModel:(id)model;

@end

NS_ASSUME_NONNULL_END
