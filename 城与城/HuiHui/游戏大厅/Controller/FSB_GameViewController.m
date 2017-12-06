//
//  FSB_GameViewController.m
//  HuiHui
//
//  Created by mac on 2017/5/17.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_GameViewController.h"
#import "LJConst.h"
#import "FSB_GameHeadView.h"

#import "FSB_GameCenterViewController.h"
#import "TiXingView.h"
#import "XieYiViewController.h"

@interface FSB_GameViewController ()

@property (nonatomic, strong) FSB_GameCenterViewController *gamecenterVC;

@end

@implementation FSB_GameViewController

-(FSB_GameCenterViewController *)gamecenterVC {

    if (_gamecenterVC == nil) {
        
        _gamecenterVC = [[FSB_GameCenterViewController alloc] init];
        
        _gamecenterVC.view.frame = CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight);
        
        GoodsInfoNavBlock goodsInfoNavBlock = ^(FSB_GameCenterViewController *infoVC, CGFloat alpha) {
        
            [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:alpha]] forBarMetrics:UIBarMetricsDefault];
            
        };
        
        _gamecenterVC.goodsInfoNavBlock = goodsInfoNavBlock;
        
    }
    
    return _gamecenterVC;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.gamecenterVC.view];
   
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"Game_Back.png" andaction:@selector(viewDismiss)];
    
    if (![[CommonUtil getValueByKey:MEMBER_ID] isEqualToString:@"19404"]) {
        
        self.navigationItem.rightBarButtonItem = [self SetNavigationRightBartitle:@"帮助" andaction:@selector(wenhaoClick)];
        
    }
    
    [self requestForZuiJinClick];
    
}

- (void)requestForZuiJinClick {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                         @"5",@"Type",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [http request:@"ClickIconRecord.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)wenhaoClick {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *fensibaoExtension = [defaults objectForKey:@"game_extension"];
    
    fensibaoExtension = [fensibaoExtension stringByReplacingOccurrencesOfString:@"/n" withString:@"\n"];
    
    XieYiViewController *vc = [[XieYiViewController alloc] init];
    
    vc.xieyiString = fensibaoExtension;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:0.]] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:FSB_StyleCOLOR] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewDismiss {

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (UIBarButtonItem *)SetNavigationRightBartitle:(NSString *)aImageName andaction:(SEL)Saction{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setFrame:CGRectMake(0, 0, 40, 33)];
    addButton.backgroundColor = [UIColor clearColor];
    [addButton setTitle:aImageName forState:0];
    [addButton setTitleColor:[UIColor whiteColor] forState:0];
    [addButton addTarget:self action:Saction forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    return _addFriendItem;
}

- (UIBarButtonItem *)SetNavigationBarImage:(NSString *)aImageName andaction:(SEL)Saction{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setFrame:CGRectMake(-5, 0, 30, 30)];
    addButton.backgroundColor = [UIColor clearColor];
    [addButton setImage:[UIImage imageNamed:aImageName] forState:UIControlStateNormal];
    [addButton addTarget:self action:Saction forControlEvents:UIControlEventTouchUpInside];
    
    addButton.layer.masksToBounds = YES;
    
    addButton.layer.cornerRadius = addButton.frame.size.width * 0.5;
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    return _addFriendItem;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
