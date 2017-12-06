//
//  DPbuyViewController.m
//  HuiHui
//
//  Created by 冯海强 on 14-7-25.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "DPbuyViewController.h"
#import "CommonUtil.h"

@interface DPbuyViewController ()
{
 int iiii;
}

@end

@implementation DPbuyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dp_dic = [[NSDictionary alloc]init];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [self hideTabBar:YES];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    if ([self.dp_Type isEqualToString:@"1"]) {
        self.title = @"评价";
        self.dp_remindbuyview.hidden = YES;

    }else if ([self.dp_Type isEqualToString:@"2"]) {
            self.title = @"我的团购单";
        self.dp_remindbuyview.hidden = YES;
        }
    else{
        self.title =[self.dp_dic objectForKey:@"title"];
        self.dp_remindbuyview.hidden = NO;
        self.dp_buyview.frame = CGRectMake(0, 20, self.dp_buyview.frame.size.width, self.dp_buyview.frame.size.height - 20);
    }

    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    //弹出输入法通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center  addObserver:self selector:@selector(keyboardDidShow)  name:UIKeyboardDidShowNotification  object:nil];
    
    self.dp_buyview.delegate = self;
    
    // 设置文字显示在整个webView里面，自动适应
    [self.dp_buyview setScalesPageToFit:YES];
    
    self.dp_buyview.detectsPhoneNumbers = YES;//自动检测网页上的电话号码，单击可以拨打
        
    self.dp_buyview.scrollView.showsHorizontalScrollIndicator = NO;
    
    NSLog(@"self.dp_buystring  = %@",self.dp_buystring);
    
    [self loadWebPageWithString:[NSString stringWithFormat:@"%@",self.dp_buystring]];
    
//    [self RequestSendMessageDP:@"您成功购买了大众点评网睿咖啡：代金券 剩余161天验证KEY :2118 9074 81"];

    
}

- (void)loadWebPageWithString:(NSString*)urlString
{
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.dp_buyview loadRequest:request];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardDidShow
{
    [self hiddenNumPadDone:nil];
}

-(void)rightClicked
{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    self.navigationItem.rightBarButtonItem = nil;
    [self loadWebPageWithString:[NSString stringWithFormat:@"%@",self.dp_buystring]];

}

- (void)leftClicked{

    if ([self.dp_Type isEqualToString:@"0"]) {
        UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:@"您正在进行购买" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确认返回", nil];
        sheet.tag = 100001;
        [sheet showInView:self.view];
        return;
    }

    
    [self goBack];

    
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 100001)
    {
        if (buttonIndex==0)
        {
            
            [self goBack];
            
        }
        
    }
}

#pragma mark - UIwebViewDelegate
-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*) reuqest navigationType:(UIWebViewNavigationType)navigationType;{

//        if ([self.dp_Type isEqualToString:@"1"]) {
//            if (navigationType == UIWebViewNavigationTypeFormSubmitted) {
//                return NO;
//            }
//        }
    NSString *RUL = [NSString stringWithFormat:@"%@",[[reuqest URL] absoluteString]];
    NSRange range1 = [RUL rangeOfString:@"dianping://shopinfo?"];
    NSRange range2 = [RUL rangeOfString:@"itms-apps://itunes.apple.com/cn/app"];
    
    if ((range1.location == !NSNotFound)||(range2.location == !NSNotFound))
    {
        return NO;
    }

    return YES;
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [SVProgressHUD showWithStatus:@"正在加载中…"];
    
    //导航栏表示网络正在进行
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{

    self.navigationItem.rightBarButtonItem.enabled = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [SVProgressHUD dismiss];
    
    if (![self.dp_Type isEqualToString:@"0"]) {
        return;
    }
    
    NSLog(@"URLURL = %@",[NSString stringWithFormat:@"%@",[self.dp_buyview stringByEvaluatingJavaScriptFromString:@"document.URL"]]);
    
    
    NSString *keyWord = [NSString stringWithFormat:@"%@",[self.dp_buyview stringByEvaluatingJavaScriptFromString:@"document.body.innerText"] ];
    
    
    NSLog(@"innerText = %@",[NSString stringWithFormat:@"%@",[self.dp_buyview stringByEvaluatingJavaScriptFromString:@"document.body.innerText"]]);
    
    
    //    获取所有html:
//    NSString *ljs = [self.dp_buyview stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerHTML"];
//    
//    NSLog(@"jslddd11111 = %@",ljs);
    
    // 隐藏掉下面下载大众点评的显示
    NSString *js = @"document.getElementsByClassName('.footer_banner').style.display='none'";
    NSString *pageSource = [webView stringByEvaluatingJavaScriptFromString:js];

    
    
    if (([[self.dp_buyview stringByEvaluatingJavaScriptFromString:@"document.body.innerText"] rangeOfString:@"您绑定的手机号"].location != NSNotFound)&&([[self.dp_buyview stringByEvaluatingJavaScriptFromString:@"document.URL"] rangeOfString:@"hasheader=0&direct=true&uid="].location!= NSNotFound))
    {
        if (![self.dp_Type isEqualToString:@"1"]&&![self.dp_Type isEqualToString:@"2"]) {
            [self setRightButtonWithTitle:@"清除" action:@selector(rightClicked)];
        }
    }
    else if (([keyWord rangeOfString:@"购买成功！\n若团购券稍有延迟，请耐心等待: )\n查看团购券"].location != NSNotFound)) {
        
        NSLog(@"成功URL = %@",[self.dp_buyview stringByEvaluatingJavaScriptFromString:@"document.URL"]);
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"恭喜您购买成功"
                                                message:@"查看一下我的点评团购券" 
                                                delegate:self
                                                cancelButtonTitle:@"确定"
                                                otherButtonTitles:nil,
                                  nil];
        alertView.tag = 100;
        [alertView show];
        
    }
    else{
        
        NSString *URL = [self.dp_buyview stringByEvaluatingJavaScriptFromString:@"document.URL"];
        if ([URL isEqualToString:@"http://lite.m.dianping.com/my/group/receiptlist?st=1"]) {
        
            NSString * TEXT = [self.dp_buyview stringByEvaluatingJavaScriptFromString:@"document.body.innerText"];
            
            NSArray *b = [TEXT componentsSeparatedByString:@"\n"];

            if (b.count!=0) {
                
                if ([[NSString stringWithFormat:@"%@",[b objectAtIndex:2]] isEqualToString:@"序列号"]) {
                    
                    NSString *title = [NSString stringWithFormat:@"%@",[b objectAtIndex:1]];
//                    NSString *dtie =[NSString stringWithFormat:@"%@",[b objectAtIndex:2]];
                    NSString *num = [NSString stringWithFormat:@"%@",[b objectAtIndex:3]];
                    NSString *message = [NSString stringWithFormat:@"您成功购买了大众点评网%@%@:%@",title,@" 验证KEY",num];
       
                    [self RequestSendMessageDP:[message stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
                    
                }
                
            }
        }
    }
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [SVProgressHUD dismiss];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        
        [self loadWebPageWithString:@"http://lite.m.dianping.com/my/group/receiptlist?st=1"];

    }
}


- (void)RequestSendMessageDP:(NSString *)Message {
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"8119",         @"formMemberID",
                           memberId,    @"toMemberID",
                           Message,     @"content",
                           key,   @"key",
                           nil];
    [httpClient request:@"HXSendMessage.ashx" parameters:param success:^(NSJSONSerialization* json){
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        if (success) {
            NSLog(@"%@",msg);

        }else {
            NSLog(@"%@",msg);
        }
    } failure:^(NSError *error) {
        NSLog(@"错误");
    }];
    
}


@end
