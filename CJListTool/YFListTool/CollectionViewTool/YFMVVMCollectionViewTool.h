//
//  YFMVVMCollectionViewTool.h
//  CJListTool
//
//  Created by ChenJie on 2022/8/20.
//

#import <Foundation/Foundation.h>
#import <CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.h>
#import "YFCollectionVCViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class YFCollectionCellVMProtocol;

@protocol YFMVVMCollectionViewToolDelegate <NSObject, UIScrollViewDelegate>

@optional

- (void)collectionView:(UICollectionView *)tableView didSelectCellViewModel:(id<YFCollectionCellVMProtocol> _Nullable)cellViewModel indexPath:(NSIndexPath *)indexPath ;
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath ;
- (void)collectionView:(UICollectionView *)collectionView willDisplaySectionHeader:(UICollectionReusableView *)view atSection:(NSInteger)section ;
- (void)collectionView:(UICollectionView *)collectionView willDisplaySectionFooter:(UICollectionReusableView *)view atSection:(NSInteger)section ;

@end


@interface YFMVVMCollectionViewTool : NSObject
<UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout, CHTCollectionViewDelegateWaterfallLayout>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithViewModel:(id<YFCollectionVCViewModelProtocol>)viewModel;
- (instancetype)initWithViewModel:(id<YFCollectionVCViewModelProtocol>)viewModel layout:(UICollectionViewLayout *)layout;

@property (nonatomic, weak) id<YFMVVMCollectionViewToolDelegate> delegate;
@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, strong, readonly) id<YFCollectionVCViewModelProtocol> viewModel;

- (void)addPullToRefresh;
- (void)addFooterRefresh;

@end

NS_ASSUME_NONNULL_END
