//
//  AMLRCViewController.m
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/13.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "AMLRCViewController.h"
#import "AMLRCItem.h"

@interface AMLRCViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *lrcTableView;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) NSUInteger nextCurrent;

@end

@implementation AMLRCViewController

+ (instancetype)lrcViewController
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"AMLRCViewController" bundle:[NSBundle mainBundle]];
    return [sb instantiateInitialViewController];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"大王叫我来巡山.plist" ofType:nil];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:array.count];
    
    for (NSDictionary *dict in array) {
        AMLRCItem *item = [AMLRCItem modelWithDict:dict];
        [arrM addObject:item];
    }
    
    _items = arrM.copy;
    
    _nextCurrent = 0;
    
    self.lrcTableView.dataSource = self;
    self.lrcTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lrcList"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lrcList"];
    }
    
    AMLRCItem *item = _items[indexPath.row];
    cell.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.7];
    cell.textLabel.text = item.content;
    
     NSIndexPath *nextCurrentPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    if (_nextCurrent >0) {
       nextCurrentPath = [NSIndexPath indexPathForRow:_nextCurrent-1 inSection:0];
    }
    
    if (indexPath == nextCurrentPath) {
        cell.textLabel.textColor = [UIColor redColor];
    }else{
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}

- (void)setCurrentTime:(NSString *)currentTime
{
    // 刷新
    if ([currentTime isEqualToString:@"00:00"]) {
        _nextCurrent = 0;
        [_lrcTableView reloadData];
        [_lrcTableView scrollsToTop];
    }
    _currentTime = currentTime;
    
    if (!_items) {
        return;
    }
    
    AMLRCItem *item =  _items[_nextCurrent];

    
    if ([currentTime isEqualToString:item.time]) {
        
        [_lrcTableView reloadData];
        
        // 滚动到下一句(保持在中间)
        if (_nextCurrent >7 && _nextCurrent <_items.count-7) {
             NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_nextCurrent+7 inSection:0];
            [_lrcTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
        }
        
        
        
        if (_nextCurrent < _items.count-1) {
            _nextCurrent++;
        }
    }
    
}

@end
