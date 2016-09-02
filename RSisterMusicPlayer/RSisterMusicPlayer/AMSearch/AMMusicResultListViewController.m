//
//  AMMusicResultListViewController.m
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/22.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "AMMusicResultListViewController.h"
#import "AMResultSongModel.h"
#import "AMMoviePlayerManager.h"

@interface AMMusicResultListViewController ()

@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) AMDownloadView *downloadView;

@end

@implementation AMMusicResultListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor colorWithWhite:0.5 alpha:0.9];
    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.backgroundColor = [UIColor blackColor];
}

#pragma mark - action click
- (void)didSelected:(UIButton *)btn
{
    [_downloadView removeFromSuperview];
    _downloadView = nil;
    AMResultSongModel *item = _items[btn.tag];
    
    _downloadView = [AMDownloadView downloadView:item.auditionList info:item];
    __weak typeof(self) weakSelf = self;
    _downloadView.closeHandler = ^()
    {
        [weakSelf tapHidden];
    };
    
    [self loadCoverView];
    [self.navigationController.view addSubview:_downloadView];
    
    [_downloadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.navigationController.view);
        make.trailing.equalTo(self.navigationController.view);
        make.bottom.equalTo(self.navigationController.view);
        make.height.equalTo(@(200));
    }];
}

- (void)tapHidden
{
    [_coverView removeFromSuperview];
    _coverView = nil;
    
    [_downloadView removeFromSuperview];
    _downloadView = nil;
}

#pragma mark - tableView datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AMSearchResult"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AMSearchResult"];
        cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.5 alpha:0.9];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
        cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
        
        cell.textLabel.textColor = [UIColor colorWithWhite:0.7 alpha:0.9];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    
    UIButton *downloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 60)];
    [downloadBtn setImage:[UIImage imageNamed:@"list_menu_download"] forState:UIControlStateNormal];
    [downloadBtn sizeToFit];
    [downloadBtn addTarget:self action:@selector(didSelected:) forControlEvents:UIControlEventTouchUpInside];
    downloadBtn.tag = indexPath.row;
    cell.accessoryView = downloadBtn;
    cell.accessoryView.bounds = CGRectMake(0, 0, 40, 60);
    
    AMResultSongModel *item = _items[indexPath.row];
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.singerName;
    
    return cell;
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    AMResultSongModel *item = _items[indexPath.row];
    AMAuditionListModel *model =  [item.auditionList firstObject];
    model.name = item.name;
    [[AMMoviePlayerManager manager] loadMusiceWithURL:model.url];
    if (_selectedHandler) {
        AMModel *item = _items[indexPath.row];
        _selectedHandler(item,indexPath);
    }
    
    [vc.view addSubview:[AMMoviePlayerManager manager].playView];
    
    [AMMoviePlayerManager manager].playView.frame = vc.view.bounds;
    
//    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - loader
- (void)loadCoverView
{
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:self.navigationController.view.bounds];
        
        _coverView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        _coverView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHidden)];
        [_coverView addGestureRecognizer:tap];
        
        [self.navigationController.view addSubview:_coverView];
    }
}

@end
