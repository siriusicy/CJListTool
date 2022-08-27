//
//  YFDemoCollectionSectionFooterView.h
//  CJListTool
//
//  Created by ChenJie on 2022/8/20.
//

#import <UIKit/UIKit.h>
#import "YFCollectionHeaderFooterProtocol.h"
#import "YFDemoCollectionSectionFooterViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YFDemoCollectionSectionFooterView : UICollectionReusableView <YFCollectionHeaderFooterProtocol>

@property (nonatomic, strong, readonly) YFDemoCollectionSectionFooterViewModel *footerVM;


@end

NS_ASSUME_NONNULL_END
