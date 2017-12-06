//
//  SharetoHuiHuiViewController.m
//  HuiHui
//
//  Created by 冯海强 on 14-7-8.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "SharetoHuiHuiViewController.h"

#import "CommonUtil.h"

@interface SharetoHuiHuiViewController ()

@property (weak, nonatomic) IBOutlet UITextField *ShareText;

@property (weak, nonatomic) IBOutlet UILabel *titlel;
@property (weak, nonatomic) IBOutlet UILabel *subtitlel;
@property (weak, nonatomic) IBOutlet UIImageView *imagev;

@end

@implementation SharetoHuiHuiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.ImageDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        self.ImageArray = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    self.ShareText.delegate = self;
    
    self.title = @"城与城朋友圈分享";
    
    [self didload];

}


- (NSData *)getImageData:(UIImageView *)imageView {
    UIImage *iamge = imageView.image;
    return UIImageJPEGRepresentation(iamge, 1);
}

//赋值，主要请求图片
-(void)didload
{
    [SVProgressHUD showWithStatus:@"正在请求……"];
    
    if ([self.dynamicType isEqualToString:KEY_DYNAMIC_WebViewShare]) {

        NSLog(@"%@",self.ImageArray);
    if (self.ImageArray.count!=0) {
        
            self.imagev.image = [self.ImageArray lastObject];
        }
        
    }else{
        
        NSString *imagePath = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"productImage"]];
        
        self.imagev.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imagePath]]];
        
    }
//图片填充不越界
//    self.imagev.contentMode = UIViewContentModeCenter;
//    self.imagev.clipsToBounds = YES;
    [self.ImageDic setValue:[self getImageData:self.imagev] forKey:[NSString stringWithFormat:@"picUrl0"]];
    
    self.titlel.text =self.STitle;
    self.subtitlel.text = self.subTitle;
    
    [SVProgressHUD dismiss];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
}


- (void)leftClicked{
    
    [self goBack];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
{
    [self hiddenNumPadDone:textField];
    
    if (!iPhone5) {
        if (isIOS7) {
                    self.view.frame =  CGRectMake(0, -35, WindowSize.size.width, WindowSize.size.height);
        }else{
            
                    self.view.frame =  CGRectMake(0, -40, WindowSize.size.width, WindowSize.size.height);
        }

    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField; {
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
{
    if (!iPhone5) {
        if (isIOS7) {
                    self.view.frame =  CGRectMake(0, 65, WindowSize.size.width, WindowSize.size.height);
        }else{
            
                      self.view.frame =  CGRectMake(0, 0, WindowSize.size.width, WindowSize.size.height);
        }


    }
}


//分享
-(IBAction)ShareBtn:(id)sender
{
    [self.view endEditing:YES];
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString * memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    NSString * key = [CommonUtil getServerKey];
    
    UIDevice *dev = [UIDevice currentDevice];
    NSString *devname =  [NSString stringWithFormat:@"%@",dev.model];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedSpace];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           devname,@"source",
                           [NSString stringWithFormat:@"%@",self.ShareText.text],@"contents",
                           @"1",@"picCount",
                           self.serviceID,@"serviceID",
                           self.activityID,@"activityID",
                           self.dynamicType,@"dynamicType",
                           self.STitle,@"title",
                           self.subTitle,@"subTitle",
                           self.webUrl,@"webUrl",
                           self.m_merchantShopId,@"merchantShopID",
                           self.dealId,@"dealId",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据提交中"];
    [httpClient multiRequestSpace:@"DynamicShareAdd.ashx" parameters:param files:self.ImageDic success:^(NSJSONSerialization* json){
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            NSString *msg=[json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            //保存本地更新时间
            NSString *time = [NSString stringWithFormat:@"%f", (double)[[NSDate date] timeIntervalSince1970]];
            [CommonUtil addValue:[NSString stringWithFormat:@"%.16f",[time doubleValue]-500] andKey:Spaceuploadtime];
            
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(leftClicked) userInfo:nil repeats:NO];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
    
}



@end
