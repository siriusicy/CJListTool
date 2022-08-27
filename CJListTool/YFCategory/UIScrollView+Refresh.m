//
//  UIScrollView+Refresh.m
//  CJListTool
//
//  Created by ChenJie on 2022/7/4.
//

#import "UIScrollView+Refresh.h"
#import "CJDemoCommonHeader.h"

@implementation UIScrollView (Refresh)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class tabClass = [UITableView class];
        yf_swizzled_instanceMethod(@selector(reloadData), @selector(yf_tableRefreshReloadData), tabClass);
        Class collectionClass = [UICollectionView class];
        yf_swizzled_instanceMethod(@selector(reloadData), @selector(yf_collectionRefreshReloadData), collectionClass);
    });
}

- (void)yf_tableRefreshReloadData {
    [self yf_tableRefreshReloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.mj_footer.hidden = ([self yf_totalDataCount] <= 0 && self.mj_header != nil);
    });

}

- (void)yf_collectionRefreshReloadData {
    [self yf_collectionRefreshReloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.mj_footer.hidden = ([self yf_totalDataCount] <= 0 && self.mj_header != nil);
    });
    
}

- (NSInteger)yf_totalDataCount {
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        for (NSInteger section = 0; section < tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
        /// 某些场景下会用section header/footer来展示数据,而cell数量为0
        if (tableView.numberOfSections > 1) {
            totalCount = MAX(tableView.numberOfSections, totalCount);
        }
        
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for (NSInteger section = 0; section<collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
        /// 某些场景下会用section header/footer来展示数据,而cell数量为0
        if (collectionView.numberOfSections > 1) {
            totalCount = MAX(collectionView.numberOfSections, totalCount);
        }
    }
    return totalCount;
}

#pragma mark -
- (void)triggerPullToRefresh {
    [self.mj_header beginRefreshing];
}

- (void)stopAnimating {
    [self stopAnimating:self.yf_noMoreData];
}

- (void)stopAnimating:(BOOL)noMoreData {
    
    self.yf_noMoreData = noMoreData;
    
    // header
    if (self.mj_header.state == MJRefreshStateRefreshing) {
        [self.mj_header endRefreshing];
    }
    // footer
    if (self.mj_footer.state == MJRefreshStateRefreshing) {
        if (noMoreData) {
            [self.mj_footer endRefreshingWithNoMoreData];
        }else {
            [self.mj_footer endRefreshing];
        }
    }else {
        if (noMoreData) {
            [self.mj_footer endRefreshingWithNoMoreData];
        }else {
            [self.mj_footer endRefreshing];
        }
    }
    // trailer
    if (self.mj_trailer.state == MJRefreshStateRefreshing) {
        [self.mj_trailer endRefreshing];
    }
}

- (void)addPullToRefreshWithActionHandler:(void (^)(void))actionHandler{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:actionHandler];
}

- (void)addInfiniteScrollingWithActionHandler:(void (^)(void))actionHandler {

    __weak typeof(self) wself = self;
    MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        __strong typeof(wself) sself = wself;
        if (!sself) {
            return;
        }
        
        BOOL showHandler = NO;
        
        if ([sself isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)sself;
            /// 某些场景下会用section header/footer来展示数据,而cell数量为0
            if ([tableView numberOfSections] > 1) {
                showHandler = YES;
            } else {
                for (NSInteger section = 0; section < [tableView numberOfSections]; section++) {
                    if ([tableView numberOfRowsInSection:section] > 0) {
                        showHandler = YES;
                        break;
                    }
                }
            }
        } else if ([sself isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView *)sself;
            /// 某些场景下会用section header/footer来展示数据,而cell数量为0
            if ([collectionView numberOfSections] > 1) {
                showHandler = YES;
            } else {
                for (NSInteger section = 0; section < [collectionView numberOfSections]; section++) {
                    if ([collectionView numberOfItemsInSection:section] > 0) {
                        showHandler = YES;
                        break;
                    }
                }
            }
        } else {
            showHandler = YES;
        }
        
        BOOL isNoMoreData = (sself.mj_footer.state == MJRefreshStateNoMoreData);
        if (showHandler && actionHandler && !isNoMoreData) {
            actionHandler();
        }
    }];

    self.mj_footer = footer;
}

#pragma mark -  set/get

- (BOOL)yf_noMoreData {
    return [objc_getAssociatedObject(self, @selector(yf_noMoreData)) boolValue];
}

- (void)setYf_noMoreData:(BOOL)yf_noMoreData {
    objc_setAssociatedObject(self, @selector(yf_noMoreData), @(yf_noMoreData), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
