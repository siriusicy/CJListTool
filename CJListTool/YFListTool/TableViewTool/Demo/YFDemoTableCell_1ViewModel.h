//
//  YFDemoTableCell_1ViewModel.h
//  CJListTool
//
//  Created by ChenJie on 2022/8/4.
//

#import <Foundation/Foundation.h>
#import "YFTableCellVMProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YFDemoTableCell_1ViewModel : NSObject <YFTableCellVMProtocol>

@property (nonatomic, strong, readonly) id model;

- (instancetype)initWithModel:(id)model;

@end

NS_ASSUME_NONNULL_END
