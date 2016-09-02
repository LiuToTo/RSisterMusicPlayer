//
//  AMSearchContainerViewController.m
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/18.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "AMSearchContainerViewController.h"
#import "AMSearchResultViewController.h"
#import "AMMusicResultListViewController.h"

#import "AMNetEngine.h"

#import "AMKeyWordModel.h"
#import "AMSongModel.h"
#import "AMSingerModel.h"

#import "AMResultSongModel.h"


@interface AMSearchContainerViewController () <UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchViewController;

@end
@implementation AMSearchContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"音乐搜索";
    self.tableView.tableFooterView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    self.tableView.scrollEnabled = NO;
    
    [self loadSearchViewController];
}

#pragma mark - 

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [AMNetEngine searchKeyWordWithQueryKey:searchController.searchBar.text finished:^(BOOL successed, id resultObj, NSError *error)
    {
        if (successed) {
            NSMutableArray *arrM = [NSMutableArray array];
            NSArray *keywords = [resultObj objectForKey:@"keywords"];
            for (NSDictionary *dict in keywords) {
                [arrM addObject:[AMKeyWordModel modelWithDict:dict]];
            }
            
            NSArray *singers = [resultObj objectForKey:@"singer"];
            for (NSDictionary *dict in singers) {
                [arrM addObject:[AMSingerModel modelWithDict:dict]];
            }
            
            NSArray *songs = [resultObj objectForKey:@"song"];
            for (NSDictionary *dict in songs) {
                [arrM addObject:[AMSongModel modelWithDict:dict]];
            }
           
            AMSearchResultViewController *resultVC = (AMSearchResultViewController *)searchController.searchResultsController;
            
            resultVC.items = arrM.copy;
            [resultVC.tableView reloadData];
        }
    }];
}

#pragma mark - loader

- (void)loadSearchViewController
{
    if (!_searchViewController) {
        AMSearchResultViewController *resultVC = [[AMSearchResultViewController alloc] init];
        
        __weak typeof(self) weakSelf = self;
        resultVC.selectedHandler = ^(AMModel *item,NSIndexPath *indexPath)
        {
            NSString *key;
            if ([item isKindOfClass:[AMSongModel class]]) {
                key = ((AMSongModel *)item).name;
            }else if ([item isKindOfClass:[AMSingerModel class]]) {
                AMSingerModel *singer = (AMSingerModel *)item;
                key = singer.singer_name;
            }else if ([item isKindOfClass:[AMKeyWordModel class]]) {
                AMKeyWordModel *keyword = (AMKeyWordModel *)item;
                key = keyword.val;
            }

            [AMNetEngine searchMusicListWithKeyWord:key page:1 finished:^(BOOL successed, id resultObj, NSError *error)
            {
                if (successed) {
                    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:[resultObj count]];
                    for (NSDictionary *dict in resultObj) {
                        AMResultSongModel *model = [AMResultSongModel modelWithDict:dict];
                        [arrM addObject:model];
                    }
                    
                    AMMusicResultListViewController *resultVC = [[AMMusicResultListViewController alloc] init];
                    resultVC.items = arrM.copy;
                    
                    [weakSelf.navigationController pushViewController:resultVC animated:YES];
                    
                    self.searchViewController.active = NO;
                }
            }];
        };
        
        _searchViewController = [[UISearchController alloc] initWithSearchResultsController:resultVC];
        
        _searchViewController.searchResultsUpdater = self;
        _searchViewController.searchBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
        
        self.tableView.tableHeaderView = _searchViewController.searchBar;
        self.definesPresentationContext = YES;
    }
}

@end
