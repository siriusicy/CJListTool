//
//  YFDemoCollectionSectionHeaderView.h
//  CJListTool
//
//  Created by ChenJie on 2022/8/20.
//

#import <UIKit/UIKit.h>
#import "YFCollectionHeaderFooterProtocol.h"
#import "YFDemoCollectionSectionHeaderViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YFDemoCollectionSectionHeaderView : UICollectionReusableView <YFCollectionHeaderFooterProtocol>

@property (nonatomic, strong, readonly) YFDemoCollectionSectionHeaderViewModel *headerVM;


@end

NS_ASSUME_NONNULL_END
