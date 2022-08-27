//
//  YFDemoCollectionCell_2ViewModel.h
//  CJListTool
//
//  Created by ChenJie on 2022/8/20.
//

#import <Foundation/Foundation.h>
#import "YFCollectionCellVMProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YFDemoCollectionCell_2ViewModel : NSObject <YFCollectionCellVMProtocol>

@property (nonatomic, strong, readonly) id model;

- (instancetype)initWithModel:(id)model;

@end

NS_ASSUME_NONNULL_END
