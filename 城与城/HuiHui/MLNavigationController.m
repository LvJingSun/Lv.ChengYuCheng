//
//  MLNavigationController.m
//  MultiLayerNavigation
//
//  Created by Feather Chan on 13-4-12.
//  Copyright (c) 2013年 Feather Chan. All rights reserved.
//

#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]

#import "MLNavigationController.h"
#import <QuartzCore/QuartzCore.h>
#import "MapViewController.h"
#import "BBMapViewController.h"
#import "CtripHBMapViewController.h"
#import "ChatListViewController.h"

#import "DPbuyViewController.h"
#import "ChatViewController.h"
#import "SceneryMapViewController.h"

#import "SceneryOrderformViewController.h"
#import "SceneryOrderListViewController.h"

#import "TrainwebViewController.h"

#import "Fl_webViewController.h"

#import "Sec_webViewController.h"

#import "Hotel_webViewController.h"

#import "QuanquanListViewController.h"

#import "HHQuanDetailViewController.h"

#import "MyquanquanViewController.h"

#import "HH_menuToHomeViewController.h"

#import "HL_PromoterViewController.h"
@interface MLNavigationController ()
{
    CGPoint startTouch;
    
    UIImageView *lastScreenShotView;
    UIView *blackMask;
}

@property (nonatomic,retain) UIView *backgroundView;
@property (nonatomic,retain) NSMutableArray *screenShotsList;

@property (nonatomic,assign) BOOL isMoving;

@property (strong, nonatomic) EMConversation *Baseconversation;//会话管理者

@end

@implementation MLNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.screenShotsList = [[NSMutableArray alloc]initWithCapacity:2];
        self.canDragBack = YES;
        
    }
    return self;
}

- (void)dealloc
{
    self.screenShotsList = nil;
    
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    
    
//    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // draw a shadow for navigation view to differ the layers obviously.
    // using this way to draw shadow will lead to the low performace
    // the best alternative way is making a shadow image.
    //
    //self.view.layer.shadowColor = [[UIColor blackColor]CGColor];
    //self.view.layer.shadowOffset = CGSizeMake(5, 5);
    //self.view.layer.shadowRadius = 5;
    //self.view.layer.shadowOpacity = 1;
    
    self.isMoveGesture = NO;
    
    UIImageView *shadowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"leftside_shadow_bg"]];
    shadowImageView.frame = CGRectMake(-10, 0, 10, self.view.frame.size.height);
    [self.view addSubview:shadowImageView];
    
    self.recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                                   action:@selector(paningGestureReceive:)];
    [self.recognizer delaysTouchesBegan];
//    [self.view addGestureRecognizer:self.recognizer];
    if (self.viewControllers.count < 1 )
    {
        [self.view removeGestureRecognizer:self.recognizer];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// override the push method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.screenShotsList addObject:[self capture]];
    
    if ([viewController isKindOfClass:[ChatViewController class]]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addObserverremoveObserver:) name:@"addObserverremoveObserver" object:nil];
    }
    
    if ([viewController isKindOfClass:[ABPersonViewController class]]) {
        self.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],
                                                                        UITextAttributeFont : [UIFont boldSystemFontOfSize:20]};
        
    }
    
    // 隐藏tabBar
    viewController.hidesBottomBarWhenPushed = YES;
    
    // 判断如果是地图页面的话删除手势
    if ([viewController isKindOfClass:[MapViewController class]] || [viewController isKindOfClass:[BBMapViewController class]]|| [viewController isKindOfClass:[CtripHBMapViewController class]] || [viewController isKindOfClass:[DPbuyViewController class]] || [viewController isKindOfClass:[SceneryMapViewController class]] || [viewController isKindOfClass:[SceneryOrderformViewController class]] || [viewController isKindOfClass:[TrainwebViewController class]] || [viewController isKindOfClass:[Fl_webViewController class]] || [viewController isKindOfClass:[Sec_webViewController class]] || [viewController isKindOfClass:[Hotel_webViewController class]] || [viewController isKindOfClass:[HH_menuToHomeViewController class]] || [viewController isKindOfClass:[HL_PromoterViewController class]]) {
        
        self.isMoveGesture = NO;
        
        [self.view removeGestureRecognizer:self.recognizer];

    }else{
        
        if ( !self.isMoveGesture ) {
        
            self.isMoveGesture = YES;
            
            [self.view addGestureRecognizer:self.recognizer];
        }
    
    }
    
    [super pushViewController:viewController animated:animated];
}


- (void)addObserverremoveObserver:(NSNotification *)notification
{
    BOOL RD = [notification.object boolValue];
    if (RD) {
        
        self.isMoveGesture = NO;
        [self.view removeGestureRecognizer:self.recognizer];
        
    }else
    {
        self.isMoveGesture = YES;
        [self.view addGestureRecognizer:self.recognizer];
    }
    
    
    
}




// override the pop method
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"RemoveNullMessageConversation" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUntreatedApplyCount" object:nil];
    
    [self.screenShotsList removeLastObject];
    
    [self.backgroundView removeFromSuperview];
    
    self.backgroundView = nil;
    
    if (self.viewControllers.count == 2) {
        self.isMoveGesture = NO;
        [self.view removeGestureRecognizer: self.recognizer];
        return [super popViewControllerAnimated:animated];
    }
    
    if ( !self.isMoveGesture ) {
        self.isMoveGesture = YES;
        [self.view addGestureRecognizer:self.recognizer];
    }

    return [super popViewControllerAnimated:animated];
}


#pragma mark - Utility Methods -

// get the current view screen shot
- (UIImage *)capture
{
    
    UIGraphicsBeginImageContextWithOptions([[UIApplication sharedApplication]keyWindow].bounds.size, [[UIApplication sharedApplication]keyWindow].opaque, 0.0);
    [[[UIApplication sharedApplication]keyWindow].layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

// set lastScreenShotView 's position and alpha when paning
- (void)moveViewWithX:(float)x
{
    
    x = x>320?320:x;
    x = x<0?0:x;
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    // 设置图片的翻转的角度
//    float scale = (x/6400)+0.95;
    float alpha = 0.4 - (x/800);

//    lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
    blackMask.alpha = alpha;
    
}

#pragma mark - Gesture Recognizer -

- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer 
{
    // If the viewControllers has only one vc or disable the interaction, then return.
    if (self.viewControllers.count <= 1 || !self.canDragBack) return;
    
    // we get the touch position by the window's coordinate
    CGPoint touchPoint = [recoginzer locationInView:KEY_WINDOW];
    
    // begin paning, show the backgroundView(last screenshot),if not exist, create it.
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        
        _isMoving = YES;
        startTouch = touchPoint;
        
        if (!self.backgroundView)
        {
            CGRect frame = self.view.frame;
            
            self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            [self.view.superview insertSubview:self.backgroundView belowSubview:self.view];
            
            blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            blackMask.backgroundColor = [UIColor clearColor];
            [self.backgroundView addSubview:blackMask];
        }
        
        self.backgroundView.hidden = NO;
        
        if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
        
        UIImage *lastScreenShot = [self.screenShotsList lastObject];
        lastScreenShotView = [[UIImageView alloc]initWithImage:lastScreenShot];
        [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
        
        //End paning, always check that if it should move right or move left automatically
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        
        if (touchPoint.x - startTouch.x > 50)
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:320];
            } completion:^(BOOL finished) {
                
                [self popViewControllerAnimated:NO];
                CGRect frame = self.view.frame;
                frame.origin.x = 0;
                self.view.frame = frame;
                
                _isMoving = NO;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                self.backgroundView.hidden = YES;
            }];
            
        }
        return;
        
        // cancal panning, alway move to left side automatically
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
            self.backgroundView.hidden = YES;
        }];
        
        return;
    }
    
    // it keeps move with touch
    if (_isMoving) {
        [self moveViewWithX:touchPoint.x - startTouch.x];
    }
}

@end
