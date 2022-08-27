//
//  YFDemoTableCell_1.h
//  CJListTool
//
//  Created by ChenJie on 2022/8/4.
//

#import <UIKit/UIKit.h>
#import "YFTableCellProtocol.h"
#import "YFDemoTableCell_1ViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@class YFDemoTableCell_1;

@protocol YFDemoTableCell_1Protocol <NSObject>

- (void)demoTableCell_1:(YFDemoTableCell_1 *)cell testAction:(NSInteger)testNumber;

@end

@interface YFDemoTableCell_1 : UITableViewCell <YFTableCellProtocol>

@property (nonatomic, strong, readonly) YFDemoTableCell_1ViewModel *cellVM;

@property (nonatomic, weak) id<YFDemoTableCell_1Protocol> delegate;

@end

NS_ASSUME_NONNULL_END
