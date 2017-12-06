//
//  ShakeViewController.m
//  HuiHui
//
//  Created by mac on 13-10-14.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "ShakeViewController.h"

#import <QuartzCore/QuartzCore.h>

#import <AudioToolbox/AudioToolbox.h>

#import "IntegralViewController.h"

#import "ShouhuoViewController.h"

#import "SponsorViewController.h"

#import <AVFoundation/AVFoundation.h>


@interface ShakeViewController (){
    
    BOOL    fristTimeShake;

}

@end

@implementation ShakeViewController

@synthesize m_values;

@synthesize m_Funtions;

@synthesize m_keyTimes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"摇一摇"];
    
    [self setLeftButtonWithNormalImage:@"back.png" action:@selector(LeftClicked)];
    
    fristTimeShake = YES;

    // 隐藏没有摇到果实的view
    self.m_nothingView.hidden = YES;
    
    self.m_contentView.hidden = NO;
    
    self.m_showView.center = self.view.center;
    
    // 初始化三个用于动画的数组
    NSArray *array = [[NSArray alloc]initWithObjects:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DIdentity], nil];
    
    NSArray *keyTimes = [[NSArray alloc]initWithObjects:@"0.2f",@"0.5f", @"0.75f", @"1.0f", nil];
    
    NSArray *funtions = [[NSArray alloc]initWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], nil];

    self.m_values = array;
    
    self.m_keyTimes = keyTimes;
    
    self.m_Funtions = funtions;
    
}

- (void)LeftClicked{
    
    [self goBack];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // 隐藏tabBar
    [self hideTabBar:YES];

    if ([self soundToPlay] != nil) {
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[self soundToPlay], &soundID);
        if (error != kAudioServicesNoError) {
            NSLog(@"Problem loading nearSound.caf");
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.m_showView removeFromSuperview];
    
    
    [self hideTabBar:NO];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - motion
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    [self shake];
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    
}

- (void)shake{
    
    if (fristTimeShake) {
        //换算锚点
        CGRect rect = self.m_imageView.frame;
        self.m_imageView.frame = CGRectMake(rect.origin.x, rect.origin.y+rect.size.height/2, rect.size.width, rect.size.height);
        
    }
        
    fristTimeShake = NO;
    
    int repeat_count = 8;
    
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //mark 0.02是极限的角度
    //设置抖动幅度
    shakeAnimation.fromValue = [NSNumber numberWithFloat:-0.02];
    shakeAnimation.toValue = [NSNumber numberWithFloat:0.02];
    shakeAnimation.duration = 0.1;
    shakeAnimation.autoreverses = YES; //是否重复
    shakeAnimation.repeatCount = repeat_count;
    self.m_imageView.layer.anchorPoint = CGPointMake(0.5, 1);
    [self.m_imageView.layer addAnimation:shakeAnimation forKey:@"imageView"];
    
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    // 播放声音 ==========
    
//    SystemSoundID sameViewSoundID;
//    
//    NSURL *filePath   = [[NSBundle mainBundle] URLForResource:@"beep-beep" withExtension: @"caf"];
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &sameViewSoundID);
//    //变量SoundID与URL对应
//    AudioServicesPlaySystemSound(sameViewSoundID); //播放SoundID声音
//    if(soundID){
//        AudioServicesDisposeSystemSoundID(soundID), soundID = 0;
//    }
//    NSBundle *mainBundle = [NSBundle mainBundle];
//    self.soundToPlay = [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"caf"] isDirectory:YES];


    [self performSelector:@selector(removeAnimation) withObject:nil afterDelay:0.2 * repeat_count];
    
}

//开始处理特效放大
- (void)removeAnimation
{
    [self.m_imageView.layer removeAnimationForKey:@"imageView"];
    
    // 显示提示的view
    [self show];
}

- (IBAction)shaking:(id)sender {
    
    [self shake];
}

// 显示请求结束后的提示
- (void)show{
    
    [self.view addSubview:self.m_showView];
    
    // 动画
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = self.m_values;
    popAnimation.keyTimes = self.m_keyTimes;
    popAnimation.timingFunctions = self.m_Funtions;
    
    [self.m_showView.layer addAnimation:popAnimation forKey:nil];
    
}

- (IBAction)close:(id)sender {
    
    [self.m_showView removeFromSuperview];
}

- (IBAction)openToSee:(id)sender {
    
    // 进入积分的页面
    IntegralViewController *viewController = [[IntegralViewController alloc]initWithNibName:@"IntegralViewController" bundle:nil];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (IBAction)nothingClose:(id)sender {
    
    [self.m_showView removeFromSuperview];
    
}

- (IBAction)continueShake:(id)sender {
    
    [self.m_showView removeFromSuperview];
    
}

- (IBAction)btnClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    switch ( btn.tag ) {
        case 100:
            
        {
            // 赞助一个
            SponsorViewController *VC = [[SponsorViewController alloc]initWithNibName:@"SponsorViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
            
        case 101:
            
        {
            // 我的收获
            ShouhuoViewController *VC = [[ShouhuoViewController alloc]initWithNibName:@"ShouhuoViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
        }
            break;
       
            
        default:
            break;
    }
    
}

@end
