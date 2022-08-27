//
//  YFDemoTableCell_2.h
//  CJListTool
//
//  Created by ChenJie on 2022/8/4.
//

#import <UIKit/UIKit.h>
#import "YFTableCellProtocol.h"
#import "YFDemoTableCell_2ViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YFDemoTableCell_2 : UITableViewCell <YFTableCellProtocol>

@property (nonatomic, strong, readonly) YFDemoTableCell_2ViewModel *cellVM;


@end

NS_ASSUME_NONNULL_END
