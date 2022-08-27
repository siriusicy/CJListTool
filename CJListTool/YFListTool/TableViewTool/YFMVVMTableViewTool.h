//
//  YFMVVMTableViewTool.h
//  CJListTool
//
//  Created by ChenJie on 2022/8/3.
//

#import <Foundation/Foundation.h>
#import "YFTableCellVMProtocol.h"
#import "YFTableCellProtocol.h"
#import "YFTableVCViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YFMVVMTableViewToolDelegate <NSObject, UIScrollViewDelegate>

@optional
- (void)tableView:(UITableView *_Nullable)tableView didSelectCellViewModel:(id<YFTableCellVMProtocol> _Nullable)cellViewModel indexPath:(NSIndexPath *_Nullable)indexPath ;
- (void)tableView:(UITableView *_Nullable)tableView willDisplayCell:(UITableViewCell<YFTableCellProtocol> *_Nullable)cell indexPath:(NSIndexPath *_Nullable)indexPath;
- (void)tableView:(UITableView *_Nullable)tableView didEndDisplayingCell:(UITableViewCell<YFTableCellProtocol> *_Nullable)cell indexPath:(NSIndexPath *_Nullable)indexPath;

@end

#pragma mark -
@interface YFMVVMTableViewTool : NSObject <UITableViewDelegate,UITableViewDataSource>
 
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithViewModel:(id<YFTableVCViewModelProtocol>)viewModel;
- (instancetype)initWithViewModel:(id<YFTableVCViewModelProtocol>)viewModel tableViewStyle:(UITableViewStyle)style;

@property (nonatomic, weak) id<YFMVVMTableViewToolDelegate> delegate;
@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, strong, readonly) id<YFTableVCViewModelProtocol> viewModel;

- (void)addPullToRefresh;
- (void)addFooterRefresh;

@end

NS_ASSUME_NONNULL_END
