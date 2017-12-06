//
//  ColourViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 14-2-13.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import "ColourViewController.h"
#import "UIColor-Expanded.h"
#import "SVProgressHUD.h"
#import "CommonUtil.h"


@interface ColourViewController ()

@end

@implementation ColourViewController
@synthesize delegate;
@synthesize selectedColor;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView
{
    
	UIView *container = [[UIView alloc] initWithFrame: IS_IPAD ? CGRectMake(0, 0, 320, 460) :[[UIScreen mainScreen] applicationFrame]];
	container.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	container.backgroundColor = [UIColor clearColor];
	self.view = container;
	
	KZColorPicker *picker = [[KZColorPicker alloc] initWithFrame:container.bounds];
    picker.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	picker.selectedColor = self.selectedColor;
    picker.oldColor = self.selectedColor;
	[picker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:picker];

    
}

- (void)leftClicked{
    
    [self goBack];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setTitle:self.CTitle];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"保存" action:@selector(Save)];
    
    [self hideTabBar:YES];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil  forKey:@"APP.red"];
    [defaults setObject:nil  forKey:@"APP.green"];
    [defaults setObject:nil  forKey:@"APP.blue"];
    [defaults setObject:nil  forKey:@"APP.alpha"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)Save
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[NSString stringWithFormat:@"%@",[defaults objectForKey:@"APP.alpha"]] isEqualToString:@"0.000000"]||[[NSString stringWithFormat:@"%@",[defaults objectForKey:@"APP.alpha"]] isEqualToString:@"(null)"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择透明度"];
        return;
    }else
    {
        if ([[NSString stringWithFormat:@"%@",[defaults objectForKey:@"APP.red"]] isEqualToString:@"0"]&&[[NSString stringWithFormat:@"%@",[defaults objectForKey:@"APP.reed"]] isEqualToString:@"0"]&&[[NSString stringWithFormat:@"%@",[defaults objectForKey:@"APP.reed"]] isEqualToString:@"0"]) {
            [SVProgressHUD showErrorWithStatus:@"请选择颜色"];
            return;
        }else
        {
            
            UIAlertView* alertView=[[UIAlertView alloc] initWithTitle:nil message:@"确定保存？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            [alertView show];
            
        }
    }
    
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
        if ( buttonIndex == 1 ) {
            
            [self SavetoServer];
        }
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}

- (void) pickerChanged:(KZColorPicker *)cp
{
    self.selectedColor = cp.selectedColor;

	[delegate defaultColorController:self didChangeColor:cp.selectedColor];
    
//    [self changeUIColorToRGB:cp.selectedColor];
    
}

-(void)SavetoServer
{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId; NSString *merchantId;NSString *key;
    NSString *rgb;
    memberId = [CommonUtil getValueByKey:MEMBER_ID];
    key = [CommonUtil getServerKey];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    rgb = [NSString stringWithFormat:@"%@,%@,%@",[defaults objectForKey:@"APP.red"],[defaults objectForKey:@"APP.green"],[defaults objectForKey:@"APP.blue"]];
    
    merchantId =self.MemberchantID;
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           merchantId,@"merchantId",
                           rgb,@"rgb",
                           key,@"key",
                           nil];
    [SVProgressHUD showWithStatus:@"数据提交中"];
    [httpClient request:@"WxSiteSetAppColor.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSString *msg=[json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(poptoview) userInfo:nil repeats:NO];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}


-(void)poptoview
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark  Popover support
- (CGSize) contentSizeForViewInPopover
{
	return CGSizeMake(320, 416);
}


@end
