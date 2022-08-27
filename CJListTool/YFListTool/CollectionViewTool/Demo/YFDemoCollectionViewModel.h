//
//  YFDemoCollectionViewModel.h
//  CJListTool
//
//  Created by ChenJie on 2022/8/20.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "YFCollectionVCViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YFDemoCollectionViewModel : NSObject <YFCollectionVCViewModelProtocol>

@property (nonatomic, assign) BOOL noMoreData;
///请求结束的信号(做一些自定义的操作)
@property (nonatomic, strong) RACSubject *requestCompleteSignal;


- (instancetype)initWithId:(NSNumber *)xxId;

@end

NS_ASSUME_NONNULL_END
