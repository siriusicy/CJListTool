//
//  YFTableSectionViewModel.m
//  CJListTool
//
//  Created by ChenJie on 2022/7/29.
//

#import "YFTableSectionViewModel.h"
#import <YYModel/YYModel.h>

@implementation YFTableSectionViewModel

- (NSMutableArray<NSObject<YFTableCellVMProtocol> *> *)listDataSource {
    if (_listDataSource == nil) {
        _listDataSource = [NSMutableArray array];
    }
    return _listDataSource;
}

- (id)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}

@end
