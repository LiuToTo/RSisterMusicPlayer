//
//  AMSearchResultViewController.h
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/18.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AMKeyWordModel.h"
#import "AMSongModel.h"
#import "AMSingerModel.h"


typedef void(^AMSelectedRowHandler)(AMModel *item,NSIndexPath *indexPath);
@interface AMSearchResultViewController : UITableViewController
{
    NSArray *_items;
    AMSelectedRowHandler _selectedHandler;
}

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) AMSelectedRowHandler selectedHandler;

@end
