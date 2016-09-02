//
//  AMPlayerContainerViewController.m
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/13.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "AMPlayerContainerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "NSString+FilePath.h"

#import "AMLRCViewController.h"
#import "AMPlayerBar.h"

#import "AMStorageDataBase.h"
#import "AMSession.h"
#import "AMNetEngine.h"
#import "AMPlayerManager.h"

#import "AMSearchContainerViewController.h"

#import "AMMusicListViewController.h"
#import "AppDelegate.h"



@interface AMPlayerContainerViewController ()<AVAudioPlayerDelegate>

@property (nonatomic, strong) UIBarButtonItem *detailBarItem;
@property (nonatomic, strong) UIBarButtonItem *searchBarItem;
@property (weak, nonatomic) IBOutlet UIImageView *singerImageView;

@property (nonatomic, strong) AMLRCViewController  *lrcViewController;
@property (nonatomic, strong) AMPlayerBar *playerBar;

@property (nonatomic, strong) AMPlayerManager *playerManager;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation AMPlayerContainerViewController
#pragma mark - initialization
+ (instancetype)playerContainerViewController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AMPlayerContainerViewController" bundle:nil];
    
    return [storyboard instantiateInitialViewController];
}

#pragma mark - layout
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"AMPLAYER";
    
    [self loadPlayerManager];
    [self setSingerImageWithPicUrl:nil];
    [self loadDetailBarItem];
    [self loadSearchBarItem];
    [self loadPlayBar];
    [self loadLrcViewController];
    [self loadDisplayLink];
    
    [self addNotifation];
}

- (void)setSingerImageWithPicUrl:(NSString *)picUrl
{
    if (picUrl.length >0) {
        [self.singerImageView sd_setImageWithURL:[NSURL URLWithString:picUrl]];
    }else{
        self.singerImageView.image = [UIImage imageNamed:@"background"];
        self.singerImageView.animationImages = @[[UIImage imageNamed:@"background"],[UIImage imageNamed:@"lyric-sharing-background-1"],[UIImage imageNamed:@"lyric-sharing-background-2"],[UIImage imageNamed:@"lyric-sharing-background-3"],[UIImage imageNamed:@"lyric-sharing-background-4"],[UIImage imageNamed:@"lyric-sharing-background-5"],[UIImage imageNamed:@"lyric-sharing-background-6"]];
        self.singerImageView.animationDuration = 5;
        self.singerImageView.animationRepeatCount = 0;
    }
}
- (void)addNotifation
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifacation:) name:kMusicSelectedNotifaction object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)notifacation:(NSNotification *)notification
{
    NSIndexPath *index = notification.object;
    self.currentIndex = index.row;
    
    [_playerBar play];
}

#pragma mark - action method
- (void)detailOpen
{
    NSLog(@"详情");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

- (void)searchOpen
{
    NSLog(@"搜索");
    AMSearchContainerViewController *searchVc = [[AMSearchContainerViewController alloc] init];
    
    [self.navigationController pushViewController:searchVc animated:YES];
    
}

#pragma mark - lazy load

- (void)loadPlayerManager
{
    if (!_playerManager) {
        _playerManager = [AMPlayerManager shareManager];
        __weak typeof(self) weakSelf = self;
        _playerManager.playFinishedHandler = ^{
             [weakSelf.playerBar next];
        };
        _currentIndex = 0;
    }
}

- (void)loadDetailBarItem
{
    if (!_detailBarItem) {
        _detailBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_menu"] style:UIBarButtonItemStylePlain target:self action:@selector(detailOpen)];
        self.navigationItem.leftBarButtonItem = _detailBarItem;
    }
}
- (void)loadSearchBarItem
{
    if (!_searchBarItem) {
        _searchBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchOpen)];
        self.navigationItem.rightBarButtonItem = _searchBarItem;
    }
}

- (void)loadPlayBar
{
    if (!_playerBar) {
        _playerBar = [AMPlayerBar playerBar];
        [self.view addSubview:_playerBar];
        _playerBar.backgroundColor = [UIColor blackColor];
        _playerBar.alpha = 0.5;
        [_playerBar mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.leading.equalTo(self.view);
            make.bottom.equalTo(self.view);
            make.trailing.equalTo(self.view);
            make.height.equalTo(@(70));
        }];
        [self playerSetting];
    }
}

- (void)loadLrcViewController
{
    if (!_lrcViewController) {
        _lrcViewController = [AMLRCViewController lrcViewController];
        [self.view addSubview:_lrcViewController.view];
        [self addChildViewController:_lrcViewController];
        [_lrcViewController.view mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.equalTo(self.view).offset(64);
             make.leading.equalTo(self.view);
             make.trailing.equalTo(self.view);
             make.bottom.equalTo(self.playerBar.mas_top);
         }];
    }
}

- (void)loadDisplayLink
{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updatePlayProcess)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
}
#pragma mark - custorm method
- (void)playerSetting
{
    __weak typeof(self) weakSelf = self;
    _playerBar.progressView.trackTintColor = [UIColor clearColor];
    _playerBar.playHandle = ^(BOOL isPlaying)
    {
        if (!isPlaying)
        {
            AMMusic *music = [AMSession currentSession].musics[weakSelf.currentIndex];
            weakSelf.title = music.musicName;
            
            NSString *path = [music.musicPath documentFilePath];
            [weakSelf.playerManager loadMusiceWithFile:path];
            [weakSelf.playerManager play];
            [weakSelf setSingerImageWithPicUrl:music.picURl];
            if (music.picURl.length <=0) {
                [weakSelf.singerImageView startAnimating];
            }
        }else{
            [weakSelf.playerManager pause];
            if (weakSelf.singerImageView.isAnimating) {
                [weakSelf.singerImageView stopAnimating];
            }
        }
    };
    _playerBar.changeHandle = ^(AMPlayerChangeType type, AMPlayerModel playerModel)
    {
        switch (playerModel) {
            case AMPlayerModelSequency: // 顺序播放
            {
                if (type == AMPlayerChangeTypeForward) {
                    if (weakSelf.currentIndex == 0) {
                        weakSelf.currentIndex = 0;
                    }else{
                        weakSelf.currentIndex--;
                    }
                }else{
                    if (weakSelf.currentIndex == [AMSession currentSession].musics.count-1) {
                        weakSelf.currentIndex = [AMSession currentSession].musics.count-1;
                    }else{
                        weakSelf.currentIndex++;
                    }
                }
                break;
            }
            case AMPlayerModelRandom: // 随机
            {
                weakSelf.currentIndex = arc4random() % [AMSession currentSession].musics.count;
                break;
            }
            case AMPlayerModelSingleCircle: // 单曲循环
            {
                break;
            }
            default: // 列表循环
            {
                if (type == AMPlayerChangeTypeForward) {
                    if (weakSelf.currentIndex == 0) {
                        weakSelf.currentIndex =[AMSession currentSession].musics.count-1;
                    }else{
                        weakSelf.currentIndex--;
                    }
                }else{
                    if (weakSelf.currentIndex == [AMSession currentSession].musics.count-1) {
                        weakSelf.currentIndex = 0;
                    }else{
                        weakSelf.currentIndex++;
                    }
                }
                break;
            }
        }
    };
}

- (void)updatePlayProcess
{
    _playerBar.progressView.progress =  self.playerManager.progress;
    
    _lrcViewController.currentTime = _playerManager.getCurrentTime;
}

@end
