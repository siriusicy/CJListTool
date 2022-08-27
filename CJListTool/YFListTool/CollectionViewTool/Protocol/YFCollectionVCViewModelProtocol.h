//
//  YFCollectionVCViewModelProtocol.h
//  CJListTool
//
//  Created by ChenJie on 2022/8/3.
//

#import <Foundation/Foundation.h>
#import "YFCollectionSectionViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YFCollectionVCViewModelProtocol <NSObject>

@property (nonatomic, strong) NSMutableArray<YFCollectionSectionViewModel *> *sectionDataSource;

@property (nonatomic, strong) RACSubject *reloadSignal;

///组装数据
- (NSMutableArray <YFCollectionSectionViewModel *> *)yf_packageSectionDataSource ;

@optional

@property (nonatomic, weak) id cellDelegate;
///加载数据
- (void)yf_loadDataWithRefresh:(BOOL)isRefresh;

@end

NS_ASSUME_NONNULL_END
