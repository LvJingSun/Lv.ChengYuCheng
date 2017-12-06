//
//  ShakeViewController.h
//  HuiHui
//
//  Created by mac on 13-10-14.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  摇一摇控制器

#import "BaseViewController.h"

#import <AudioToolbox/AudioToolbox.h>

@interface ShakeViewController : BaseViewController{
    
    SystemSoundID soundID;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (strong, nonatomic) IBOutlet UIView *m_showView;

@property (weak, nonatomic) IBOutlet UIView *m_contentView;

@property (weak, nonatomic) IBOutlet UIView *m_nothingView;

@property (weak, nonatomic) IBOutlet UIButton *m_btnTitle;

@property (nonatomic, strong) NSArray *m_values;

@property (nonatomic, strong) NSArray *m_keyTimes;

@property (nonatomic, strong) NSArray *m_Funtions;

@property (nonatomic, retain) NSURL *soundToPlay;

- (IBAction)shaking:(id)sender;


// 摇一摇触发的事件
- (void)shake;

// 显示请求结束后的提示
- (void)show;
// 有果实的关闭
- (IBAction)close:(id)sender;
// 打开查看
- (IBAction)openToSee:(id)sender;
// 没果实的close
- (IBAction)nothingClose:(id)sender;
// 继续摇一摇
- (IBAction)continueShake:(id)sender;

// btn点击事件
- (IBAction)btnClicked:(id)sender;


@end
