//
//  RH_RedRecordsViewController.m
//  HuiHui
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_RedRecordsViewController.h"
#import "ZJScrollPageView.h"
#import "RH_Get_RecordsViewController.h"
#import "RH_Send_RecordsViewController.h"
#import "RedHorseHeader.h"
#import "RH_AllRedViewController.h"

@interface RH_RedRecordsViewController ()<ZJScrollPageViewDelegate>

@property(strong, nonatomic)NSArray<NSString *> *titles;

@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;

@end

@implementation RH_RedRecordsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self setRootStyle];
    
    self.title = @"记录";
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"RH_HomeBack.png" andaction:@selector(dismissRH_Homeview)];
    
    self.navigationItem.rightBarButtonItem = [self SetNavigationBarRightTitle:@"总红包" andaction:@selector(allCountClick)];
    
}

- (void)allCountClick {

    RH_AllRedViewController *vc = [[RH_AllRedViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)dismissRH_Homeview {

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)setRootStyle {
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    
    style.showLine = YES;
    
    style.gradualChangeTitleColor = YES;
    
    style.scrollTitle = NO;
    
    style.normalTitleColor = [UIColor colorWithRed:57/255. green:57/255. blue:57/255. alpha:1.];
    
    style.selectedTitleColor = RH_ThemeColor;
    
    style.scrollLineColor = RH_ThemeColor;
    
    style.segmentHeight = 40;
    
    style.titleFont = [UIFont systemFontOfSize:17];
    
    self.titles = @[@"每日红包",@"补贴金额"];
    
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64.0) segmentStyle:style titles:self.titles parentViewController:[self getCurrentViewController] delegate:self];
    
    [self.view addSubview:scrollPageView];
    
}

- (NSInteger)numberOfChildViewControllers {
    
    return self.titles.count;
    
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (index == 0) {
        
        childVc = [[RH_Get_RecordsViewController alloc] init];
        
        childVc.view.backgroundColor = RH_ViewBGColor;
        
    }else if (index == 1) {
        
        childVc = [[RH_Send_RecordsViewController alloc] init];
        
        childVc.view.backgroundColor = RH_ViewBGColor;
        
    }
    
    return childVc;
    
}

/** 获取当前View的控制器对象 */
-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
