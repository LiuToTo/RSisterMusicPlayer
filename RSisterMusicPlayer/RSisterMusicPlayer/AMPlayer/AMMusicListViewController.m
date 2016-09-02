//
//  AMMusicListViewController.m
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/20.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "AMMusicListViewController.h"
#import "NSString+FilePath.h"
#import "AMSession.h"
#import "AMMusic.h"

#import "AMStorageDataBase.h"

NSString * const kAMMusicListCellReuseID = @"kAMMusicListCellReuseID";
NSString * const kMusicSelectedNotifaction = @"kMusicSelectedNotifaction";

@interface AMMusicListViewController ()

@end

@implementation AMMusicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 64)];
    headView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headView;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self addNotification];
}

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView) name:kMusicListChangedNotification object:nil];
}

- (void)updateTableView
{
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[AMSession currentSession].musics count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMMusicListCell *cell = [tableView dequeueReusableCellWithIdentifier:kAMMusicListCellReuseID];
    
    NSArray *musicList = [AMSession currentSession].musics;
    AMMusic *music = [musicList objectAtIndex:indexPath.row];
    
    if (!cell) {
        cell = [[AMMusicListCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:kAMMusicListCellReuseID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor colorWithWhite:0.5 alpha:0.9];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.7 alpha:0.9];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = music.musicName;
    cell.detailTextLabel.text = music.musicPath;
    cell.deleteHandler = ^{
        NSLog(@"OC_delete");
        
        BOOL sucess = [[AMStorageDataBase defaultStorageDB] deleteMusicListTableWithMusic:music];
        if (sucess) {
            [[AMSession currentSession] deleteMusic:music];
        }
        
    };
    
    return (UITableViewCell *)cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kMusicSelectedNotifaction object:indexPath];
}

@end
