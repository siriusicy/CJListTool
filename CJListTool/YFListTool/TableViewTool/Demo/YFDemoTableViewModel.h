//
//  YFDemoTableViewModel.h
//  CJListTool
//
//  Created by ChenJie on 2022/8/4.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "YFTableVCViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YFDemoTableViewModel : NSObject <YFTableVCViewModelProtocol>


@property (nonatomic, assign) BOOL noMoreData;
///请求结束的信号(做一些自定义的操作)
@property (nonatomic, strong) RACSubject *requestCompleteSignal;


- (instancetype)initWithId:(NSNumber *)xxId;


@end

NS_ASSUME_NONNULL_END
