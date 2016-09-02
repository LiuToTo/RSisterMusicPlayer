//
//  AMSearchResultViewController.m
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/18.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "AMSearchResultViewController.h"

#import "AMKeyWordModel.h"
#import "AMSongModel.h"
#import "AMSingerModel.h"

@implementation AMSearchResultViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor colorWithWhite:0.5 alpha:0.9];
    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
}

#pragma mark - datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AMSearchResult"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"AMSearchResult"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor colorWithWhite:0.5 alpha:0.9];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.7 alpha:0.9];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    AMModel *item = _items[indexPath.row];
    if ([item isKindOfClass:[AMKeyWordModel class]]) {
        AMKeyWordModel *keyWord = (AMKeyWordModel *)item;
        cell.textLabel.text = keyWord.typeName;
        cell.detailTextLabel.text = keyWord.val;
    }else if ([item isKindOfClass:[AMSingerModel class]]) {
        AMSingerModel *singer = (AMSingerModel *)item;
        cell.textLabel.text = singer.typeName;
        cell.detailTextLabel.text = singer.singer_name;
    }else if ([item isKindOfClass:[AMSongModel class]]) {
        AMSongModel *song = (AMSongModel *)item;
        cell.textLabel.text = song.typeName;
        cell.detailTextLabel.text = song.name;
    }

    return cell;
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectedHandler) {
        AMModel *item = _items[indexPath.row];
        _selectedHandler(item,indexPath);
    }
}

@end
