//
//  AMPlayerBar.m
//  RSisterMusicPlayer
//
//  Created by 刘旭 on 16/4/3.
//  Copyright © 2016年 RunningSister. All rights reserved.
//

#import "AMPlayerBar.h"
#import <Masonry/Masonry.h>

@interface AMPlayerBar ()

@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation AMPlayerBar
#pragma mark - initialization
+ (instancetype)playerBar
{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"AMPlayerBar" owner:nil options:nil];
    AMPlayerBar  *playerBar = [views lastObject];
    playerBar.playerModel = AMPlayerModelSequency;
    return playerBar;
}

+ (instancetype)playerBarWithFrame:(CGRect)frame
{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"AMPlayerBar" owner:nil options:nil];
    AMPlayerBar  *playerBar = [views lastObject];
    playerBar.playerModel = AMPlayerModelSequency;
    playerBar.frame = frame;
    return playerBar;
}

- (void)setFrame:(CGRect)frame
{
    CGRect rect =  frame;
    rect.size.height = rect.size.height > 55 ? rect.size.height :55;
    [super setFrame:rect];
}

- (void)play
{
    self.playBtn.selected = NO;
    [self.playBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
}
- (void)next
{
    [self.nextBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - action

- (IBAction)playModel:(UIButton *)button
{
    switch (self.playerModel)
    {
        case AMPlayerModelSequency:
        {
            self.playerModel = AMPlayerModelRandom;
            [button setImage:[UIImage imageNamed:@"player_mode_random"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"player_mode_random_hl"] forState:UIControlStateHighlighted];
            if (self.ChooseModelHandle) {
                self.ChooseModelHandle(AMPlayerModelRandom);
            }
            break;
        }
        case AMPlayerModelRandom:
        {
            self.playerModel = AMPlayerModelSequencyCircle;
            [button setImage:[UIImage imageNamed:@"player_mode_sequency"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"player_mode_sequency_hl"] forState:UIControlStateHighlighted];
            if (self.ChooseModelHandle) {
                self.ChooseModelHandle(AMPlayerModelSequencyCircle);
            }
            break;
        }
        case AMPlayerModelSequencyCircle:
        {
            self.playerModel = AMPlayerModelSingleCircle;
            [button setImage:[UIImage imageNamed:@"player_mode_single"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"player_mode_single_hl"] forState:UIControlStateHighlighted];
            if (self.ChooseModelHandle) {
                self.ChooseModelHandle(AMPlayerModelSingleCircle);
            }
            break;
        }
        case AMPlayerModelSingleCircle:
        {
            self.playerModel = AMPlayerModelSequency;
            [button setImage:[UIImage imageNamed:@"player_mode_nocircle_sequency"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"player_mode_nocircle_sequency_hl"] forState:UIControlStateHighlighted];
            if (self.ChooseModelHandle) {
                self.ChooseModelHandle(AMPlayerModelSequency);
            }
            break;
        }
    }
}
- (IBAction)playLast:(UIButton *)button
{
    if (self.changeHandle) {
        self.changeHandle(AMPlayerChangeTypeForward,self.playerModel);
         self.playBtn.selected = NO;
        [self.playBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}
- (IBAction)play:(UIButton *)button
{
    if (self.playHandle) {
        self.playHandle(button.selected);
    }
    button.selected = !button.selected;
}
- (IBAction)playNext:(UIButton *)button
{
    if (self.changeHandle) {
        self.changeHandle(AMPlayerChangeTypeNext,self.playerModel);
        self.playBtn.selected = NO;
        [self.playBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}
- (IBAction)prefer:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
         [button setImage:[UIImage imageNamed:@"player_new_favorited"] forState:UIControlStateSelected];
    }else{
        [button setImage:[UIImage imageNamed:@"player_new_favorite"] forState:UIControlStateNormal];
    }
     [button setImage:[UIImage imageNamed:@"player_new_favorited_hl"] forState:UIControlStateHighlighted];
    if (self.preferHandle) {
        self.preferHandle(button.selected);
    }
}

@end
