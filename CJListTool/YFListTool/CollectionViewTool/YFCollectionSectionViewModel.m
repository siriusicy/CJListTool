//
//  YFCollectionSectionViewModel.m
//  AFNetworking
//
//  Created by ChenJie on 2022/8/15.
//

#import "YFCollectionSectionViewModel.h"

@implementation YFCollectionSectionViewModel

- (instancetype)init {
    if (self = [super init]) {
        _minimumInteritemSpacing = -1;
        _minimumLineSpacing = -1;
        _minimumColumnSpacing = -1;
        _columnCount = 2;
    }
    return self;
}

- (NSMutableArray<NSObject<YFCollectionCellVMProtocol> *> *)listDataSource {
    if (!_listDataSource) {
        _listDataSource = [NSMutableArray array];
    }
    return _listDataSource;
}

@end
