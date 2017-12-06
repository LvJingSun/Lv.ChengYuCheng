//
//  BaseViewController.m
//  HuiHui
//
//  Created by mac on 13-10-8.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

#import "Reachability.h"

#import "SVProgressHUD.h"

#import "CommonUtil.h"

#import "sys/xattr.h"

static UIColor *ColorRGB(float R, float G, float B, float alph){
    UIColor *colorNew = [UIColor colorWithRed:R/255. green:G/255. blue:B/255. alpha:alph];
    
    return colorNew;
}

@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize m_keyTimes;

@synthesize m_Funtions;

@synthesize m_values;

@synthesize HHBase_emptyLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_values = [[NSArray alloc]init];
        m_Funtions = [[NSArray alloc]init];
        m_keyTimes = [[NSArray alloc]init];
        

      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.HHBase_emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, WindowSize.size.height/2, WindowSizeWidth, 24)];
    self.HHBase_emptyLabel.text = @"暂无数据";
    self.HHBase_emptyLabel.textAlignment = NSTextAlignmentCenter;
    self.HHBase_emptyLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.HHBase_emptyLabel];
    self.HHBase_emptyLabel.hidden = YES;
    
   self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    
    // 去掉导航栏的阴影的方法
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    
    // =====
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, WindowSizeWidth, [UIScreen mainScreen].bounds.size.height);

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // 保存最后所在的view的类名
    [CommonUtil addValue:NSStringFromClass([self class]) andKey:@"ClassName"];
    
    if ( isIOS7 ) {
        
        self.navigationController.navigationBar.translucent = NO;

    }
    
        // 设置导航栏的背景和tabBar的背景颜色 区分低版本和高版本
        if ( isIOS7 ) {

            [self.navigationController.navigationBar setBarTintColor:RGBACKTAB];

           [self.tabBarController.tabBar setBarTintColor:RGBACKTAB];


        }else{
            
            [self.navigationController.navigationBar setTintColor:RGBACKTAB];
            
           [self.tabBarController.tabBar setTintColor:RGBACKTAB];

        }
}


- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
}

- (void)setUpForDismissKeyboard {
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    [self hidenKeyboard];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    
    // 添加往左滑返回的属性
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    

    // 键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
 
}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置title
- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    [self setNavigationTitleViewTitleText:title titleColor:nil];
}

- (void)setNavigationTitleViewTitleText:(NSString *)titleText titleColor:(UIColor *)titleColor
{
    UILabel * labelTitle = [self getNavigationTitleViewTitleText:titleText titleColor:titleColor];
    self.navigationItem.titleView = labelTitle;

}

-(UILabel*)getNavigationTitleViewTitleText:(NSString *)titleText titleColor:(UIColor *)titleColor
{
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 6, 200, 30)];
    titleLabel.font = [UIFont systemFontOfSize:20.0f];//[UIFont fontWithName:@"Helvetica-Bold" size:20.0f];//fontWithName:@"Helvetica-Bold" size:22.0f];
    if (titleColor == nil){
        titleLabel.textColor = [UIColor whiteColor];
    }else{
        titleLabel.textColor = titleColor;
    }
    [titleLabel setShadowOffset:CGSizeMake(0, 0)];
    [titleLabel setShadowColor:[UIColor colorWithRed:0x41/255.0f green:0x41/255.0f blue:0x41/255.0f alpha:1.0f]]; //[UIColor whiteColor]];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = titleText;
    [titleLabel sizeToFit];
    
	return titleLabel;
}

// 设置导航栏的左右按钮
- (void)setLeftButtonWithNormalImage:(NSString *)aImageName action:(SEL)action{
//    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_button setFrame:CGRectMake(0, 0, 10, 16)];
//    _button.backgroundColor = [UIColor clearColor];
//    [_button setImage:[UIImage imageNamed:aImageName] forState:UIControlStateNormal];
//    [_button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
//    [self.navigationItem setLeftBarButtonItem:_barButton];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [backButton setImage:[UIImage imageNamed:aImageName] forState:UIControlStateNormal];
    [backButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    
//    UIImage *backButtonImage = [UIImage imageNamed:aImageName];
//    UIBarButtonItem *customItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:action];
//    [self.navigationItem setLeftBarButtonItem: customItem];
    
}

- (void)setLeftButtonWithTitle:(NSString *)aTitle action:(SEL)action {
    
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(0, 0, 60, 29)];
    _button.backgroundColor = [UIColor clearColor];
    _button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [_button setTitle:aTitle forState:UIControlStateNormal];
    [_button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
    [self.navigationItem setLeftBarButtonItem:_barButton];
    
}

- (void)setRightButtonWithTitle:(NSString *)aTitle action:(SEL)action{
    
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(0, 0, 60, 29)];
    _button.backgroundColor = [UIColor clearColor];
    _button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [_button setTitle:aTitle forState:UIControlStateNormal];
//    _button.layer.borderWidth = 1.0;
//    _button.layer.borderColor = [UIColor whiteColor].CGColor;
    [_button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
    [self.navigationItem setRightBarButtonItem:_barButton];
}

- (UIBarButtonItem *)SetNavigationBarRightImage:(NSString *)aImageName andaction:(SEL)Saction{
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [addButton setFrame:CGRectMake(0, 0, 18, 20)];
    
    addButton.backgroundColor = [UIColor clearColor];
    
    [addButton setImage:[UIImage imageNamed:aImageName] forState:UIControlStateNormal];
    
    [addButton addTarget:self action:Saction forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    return _addFriendItem;
    
}

- (void)setRightButtonWithNormalImage:(NSString *)aImageName action:(SEL)action{
    
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(0, 0, 50, 29)];
    _button.backgroundColor = [UIColor clearColor];
    [_button setImage:[UIImage imageNamed:aImageName] forState:UIControlStateNormal];
    [_button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
    [self.navigationItem setRightBarButtonItem:_barButton];
}

- (void)setLeftButtonWithNormalImage:(NSString *)aImageName withTitle:(NSString *)aTitle action:(SEL)action{
    
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(0, 0, 50, 29)];
    _button.backgroundColor = [UIColor clearColor];
    [_button setTitle:aTitle forState:UIControlStateNormal];
    [_button.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [_button setBackgroundImage:[UIImage imageNamed:aImageName] forState:UIControlStateNormal];
    [_button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
    [self.navigationItem setLeftBarButtonItem:_barButton];
}

- (void)setRightButtonWithNormalImage:(NSString *)aImageName withTitle:(NSString *)aTitle action:(SEL)action{
    
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(0, 0, 50, 29)];
    _button.backgroundColor = [UIColor clearColor];
    [_button setTitle:aTitle forState:UIControlStateNormal];
    [_button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_button setBackgroundImage:[UIImage imageNamed:aImageName] forState:UIControlStateNormal];
    [_button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
    [self.navigationItem setRightBarButtonItem:_barButton];
}

- (void)goBack{
    
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) hideTabBar:(BOOL) hidden{
   /*
    if ( isIOS7 ) {
        
        [self.tabBarController.tabBar setHidden:hidden];
        
        //    CGRect rect = self.tabBarController.view.frame;
        //    rect.size.height += 49;
        //   self.tabBarController.view.frame = rect;
        
        for(UIView *view in self.tabBarController.view.subviews)
        {
            
            CGSize m_size = self.tabBarController.view.frame.size;
            
            if([view isKindOfClass:[UITabBar class]])
            {
                if (self.tabBarController.tabBar.hidden) {
                    
                    [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width, view.frame.size.height)];
                    
                    self.navigationController.view.frame = CGRectMake(0, 0, m_size.width,m_size.height + 49);
                    
                } else {
                    
                    [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height-49, view.frame.size.width, view.frame.size.height)];
                    
                    
                    self.navigationController.view.frame = CGRectMake(0, 0, m_size.width, m_size.height+ 49);
                    
                }
                
            }
            else
            {
                if (self.tabBarController.tabBar.hidden) {
                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [UIScreen mainScreen].bounds.size.height)];
                    
                    self.navigationController.view.frame = CGRectMake(0, 0, m_size.width, m_size.height + 49);
                    
                } else {
                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [UIScreen mainScreen].bounds.size.height-98)];
                    
                    self.navigationController.view.frame = CGRectMake(0, 0, m_size.width, m_size.height + 49);
                    
                    
                }
            }
        }
        
    }else{
        
        if ( [self.tabBarController.view.subviews count] < 2 )
        {
            return;
        }
        UIView *contentView;
        
        if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        {
            
            contentView = [self.tabBarController.view.subviews objectAtIndex:1];
        }
        else
        {
            

            contentView = [self.tabBarController.view.subviews objectAtIndex:0];
        }
        //    [UIView beginAnimations:@"TabbarHide" context:nil];
        if ( hidden )
        {
            
            contentView.frame = self.tabBarController.view.bounds;
        }
        else
        {

            contentView.frame = CGRectMake(self.tabBarController.view.bounds.origin.x,
                                           self.tabBarController.view.bounds.origin.y,
                                           self.tabBarController.view.bounds.size.width,
                                           self.tabBarController.view.bounds.size.height - self.tabBarController.tabBar.frame.size.height + 49);
        }
        
        self.tabBarController.tabBar.hidden = hidden;

    }*/

}

// 设置自定义显示的提示框
- (void)alertWithMessage:(NSString *)message
{
    [self alertWithMessage:message tag:0 delegate:nil];
}

- (UIAlertView *)alertWithMessage:(NSString *)message tag:(NSUInteger)tag delegate:(id)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:message
                                                        delegate:delegate
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil, nil];
    alertView.delegate = delegate;
    alertView.tag = tag;
    [alertView show];
    return alertView;
}

- (UIAlertView *)alertWithTitle:(NSString *)Title Message:(NSString *)message cancelBtn:(NSString*)cancelBtn otherBtn:(NSString*)otherBtn tag:(NSUInteger)tag delegate:(id)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:Title
                                                        message:message
                                                       delegate:delegate
                                              cancelButtonTitle:cancelBtn
                                              otherButtonTitles:otherBtn, nil];
    alertView.delegate = delegate;
    alertView.tag = tag;
    [alertView show];
    return alertView;
}

- (void) hideGradientBackground:(UIView*)theView
{
    for (UIView * subview in theView.subviews)
    {
        if ([subview isKindOfClass:[UIImageView class]])
            subview.hidden = YES;
        
        [self hideGradientBackground:subview];
    }
}

//隐藏键盘的方法
-(void)hidenKeyboard {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];//关闭键盘
}

- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    return YES;
}

- (void)handleKeyboardWillHide:(NSNotification *)notification
{
    if (self.doneInKeyboardButton.superview)
    {
        [self.doneInKeyboardButton removeFromSuperview];
    }
    if (!keyboardShow) {
        return;
    }
    if (self.rootScrollView != nil) {
        NSDictionary *info = [notification userInfo];
        NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
        CGSize keybroundSize = [value CGRectValue].size;
        CGRect viewFrame = [self.rootScrollView frame];
        viewFrame.size.height += keybroundSize.height;
        self.rootScrollView.frame = viewFrame;
    }
    keyboardShow = NO;
}

- (void)handleKeyboardDidShow:(NSNotification *)notification
{
    // create custom button
    if (self.doneInKeyboardButton == nil)
    {
        self.doneInKeyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
//        if (screenHeight==568.0f) {//爱疯5
//            self.doneInKeyboardButton.frame = CGRectMake(0, 568 - 53, 106, 53);
//        } else {//3.5寸
//            self.doneInKeyboardButton.frame = CGRectMake(0, 480 - 53, 106, 53);
//        }
        
//        NSLog(@"height = %f",screenHeight);
        
        // 6p的情况
        if ( screenHeight == 736.0f ) {
            
            self.doneInKeyboardButton.frame = CGRectMake(self.view.frame.origin.x, screenHeight - 57, WindowSizeWidth/3 - 2, 57);

        }else{
            
            self.doneInKeyboardButton.frame = CGRectMake(self.view.frame.origin.x, screenHeight - 53, WindowSizeWidth/3 - 2, 53);

        }
        
        
        self.doneInKeyboardButton.adjustsImageWhenHighlighted = NO;
        self.doneInKeyboardButton.hidden=self.needHiddenDone;
        [self.doneInKeyboardButton setBackgroundImage:[UIImage imageNamed:@"btn_done_up.png"] forState:UIControlStateNormal];
        [self.doneInKeyboardButton setBackgroundImage:[UIImage imageNamed:@"btn_done_down.png"] forState:UIControlStateHighlighted];
        [self.doneInKeyboardButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // locate keyboard view
//    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
//    if (self.doneInKeyboardButton.superview == nil)
//    {
//        [tempWindow addSubview:self.doneInKeyboardButton];    // 注意这里直接加到window上
//    }
    self.doneInKeyboardButton.hidden=self.needHiddenDone;
    if (keyboardShow) {
        return;
    }
    if (self.rootScrollView != nil) {
        NSDictionary *info = [notification userInfo];
        NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
        CGSize keybroundSize = [value CGRectValue].size;
        CGRect viewFrame = [self.rootScrollView frame];
        viewFrame.size.height -= keybroundSize.height;
        self.rootScrollView.frame = viewFrame;
        //[self performSelector:@selector(moveToActiveView) withObject:nil afterDelay:0.5];
        [self moveToActiveView];
    }
    keyboardShow = YES;
}

- (void)moveToActiveView {
    if (self.activeField != nil) {
        //CGRect textFieldRect = [self.activeField frame];
        CGRect textFieldRect = [self.activeField.superview frame];

        [self.rootScrollView scrollRectToVisible:textFieldRect animated:YES];
    }
}

- (void)finishAction {
    [self hidenKeyboard];
}

- (IBAction)showNumPadDone:(id)sender {
    self.needHiddenDone = NO;
    self.doneInKeyboardButton.hidden=self.needHiddenDone;
}

- (IBAction)hiddenNumPadDone:(id)sender {
    self.needHiddenDone = YES;
    self.doneInKeyboardButton.hidden=self.needHiddenDone;
}


// 判断网络不好
- (BOOL)isConnectionAvailable{
    BOOL  isExistenceNetWork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    switch ( [reach currentReachabilityStatus] ) {
        case NotReachable:
            isExistenceNetWork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetWork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetWork = YES;
            break;
        default:
            break;
    }
    if ( !isExistenceNetWork ) {
        [SVProgressHUD showErrorWithStatus:@"目前无网络可用"];
    }
    return isExistenceNetWork;
}


// 判断手机号码是否正确的格式
- (BOOL)isMobileNumber:(NSString *)mobileNum {
    
    NSString  *MOBILE = @"^1(3[0-9]|5[0-9]|8[0-9])\\d{8}$";
    
    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString *CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    
    NSString  *MOBILENWE = @"^1(4[0-9]|5[0-9]|8[0-9])\\d{8}$";
    //    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CM];
    
    
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CU];
    
    
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CT];
    
    //添加电信 新的手机号码格式字段
    NSPredicate *regextestmobilenew = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILENWE];
    
    if (([regextestmobile  evaluateWithObject:mobileNum] == YES) ||
        ([regextestcm evaluateWithObject:mobileNum] == YES) ||
        ([regextestmobilenew evaluateWithObject:mobileNum] == YES)|| ([regextestct
                                                                       evaluateWithObject:mobileNum] == YES) || ([regextestcu
                                                                                                                  evaluateWithObject:mobileNum] == YES )){
        
        return  YES;
        
    } else{
        
        return  NO;
        
    }
    
}

- (BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

// 日期字符转换成日期类型
- (NSDate *)dateFromString:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:dateStr];
    return date;
}

- (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    //    NSDate *date = [formatter dateFromString:dateStr];
    NSString *dateStr = [formatter stringFromDate:date];
    
    return dateStr;
}

// 计算字数的多少 - 如果为汉字则加2，否则加1
- (float)textLength:(NSString *)text{
    float number = 0.0;
    for (int index = 0; index < [text length]; index++)
    {
        if ( [self isHaveChineseCharacters:[text substringWithRange:NSMakeRange(index, 1)]] ) {
            number = number + 2;
        }else{
            number = number + 1;
        }
    }
    return number;
}

- (BOOL)isHaveChineseCharacters:(NSString *)_text
{
    for(int i = 0; i < [(NSString *)_text length]; ++i) {
        int a = [(NSString *)_text characterAtIndex:i];
        
        if ([self isChineseCharacters_utf8:a]) {
            return YES;
        } else {
            continue;
        }
    }
    return NO;
}

- (BOOL)isChineseCharacters_utf8:(NSInteger)characterAtIndex {
    if(characterAtIndex >= HANZI_START && characterAtIndex <= HANZI_COUNT+HANZI_START) {
        return YES;
    } else {
        return NO;
    }
    //acoutnt++;
    //acount*2+bcount;
}

- (int)sumOfSixValueWithDic:(NSDictionary *)aDic{
    
    int sum = 0;
        
    // 判断是否是商户的情况，如果是商户的话则显示我的分享，如果是普通用户则不显示我的分享
    if ([[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:IsDaiLiAndMct]] isEqualToString:@"1"]) {
        
        sum = /*[[aDic objectForKey:@"IntegralRecordList"] intValue] + */[[aDic objectForKey:@"KeyList"] intValue] + [[aDic objectForKey:@"MemberOrder"] intValue] +
        [[aDic objectForKey:@"MemberPublicInviteList"] intValue] + [[aDic objectForKey:@"MemberToken"] intValue] + [[aDic objectForKey:@"TransactionRecords"] intValue];
        
    }else{
        
        sum = /*[[aDic objectForKey:@"IntegralRecordList"] intValue] +*/ [[aDic objectForKey:@"KeyList"] intValue] + [[aDic objectForKey:@"MemberOrder"] intValue] + [[aDic objectForKey:@"MemberToken"] intValue] + [[aDic objectForKey:@"TransactionRecords"] intValue];
    }
    
    return sum;
}

#pragma mark - 共享定位功能

//- (void)qqLogin{

    // 调用qq登录的方法，登录成功后则会执行 tencentDidLogin 的代理方法
//    [_tencentOAuth authorize:_permissions inSafari:NO];

//}

// 将NSDate日期转换成字符
- (NSString *)stringWithDateFromScenery:(NSDate *)aDate{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:aDate];
    
    return dateString;
}

// 将字符转换成NSDate日期
- (NSDate *)dateWithstringFromScenery:(NSString *)aString{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:aString];
    
    return date;
}

// 根据日期获得是星期几
- (NSString *)getDate:(NSString *)aDate{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [formatter dateFromString:aDate];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps= [calendar components:(NSYearCalendarUnit |
                                                   NSMonthCalendarUnit |
                                                   NSDayCalendarUnit |
                                                   NSWeekdayCalendarUnit) fromDate:date];
    
    NSString *weekString = [self getWeekStringFromInteger:[comps weekday]];
    
    NSString *string;
    
    string = [NSString stringWithFormat:@"%@ %@",aDate,weekString];
        
    return string;

}

- (NSString *)getCurrentDate{
    
    NSString *dateString;
    
    // 赋值出发日期-显示当前的日期
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateStr = [formatter stringFromDate:date];
    
    // 获取日历上当前的日期
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps= [calendar components:(NSYearCalendarUnit |
                                                   NSMonthCalendarUnit |
                                                   NSDayCalendarUnit |
                                                   NSWeekdayCalendarUnit) fromDate:date];

    
    NSString *weekString = [self getWeekStringFromInteger:[comps weekday]];
    
    dateString = [NSString stringWithFormat:@"%@ %@",dateStr,weekString];
    
    
    return dateString;
    
}
// 根据日期获取星期几
- (NSString *)getWeekday:(NSDate*)date
{
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSWeekdayCalendarUnit fromDate:date];
    NSString *weekday = [self getWeekStringFromInteger:[componets weekday]];
    return weekday;
}


//通过数字返回星期几
- (NSString *)getWeekStringFromInteger:(int)week
{
    NSString *str_week;
    
    switch (week) {
        case 1:
            str_week = @"周日";
            break;
        case 2:
            str_week = @"周一";
            break;
        case 3:
            str_week = @"周二";
            break;
        case 4:
            str_week = @"周三";
            break;
        case 5:
            str_week = @"周四";
            break;
        case 6:
            str_week = @"周五";
            break;
        case 7:
            str_week = @"周六";
            break;
    }
    return str_week;
}

- (int)getNumberOfDaysOneYear{
    
    int count = 0;
 
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    NSDate *date = [NSDate date];
    
    NSDateComponents *comps = [calendar components:(NSYearCalendarUnit |
                                                   NSMonthCalendarUnit |
                                                   NSDayCalendarUnit |
                                                   NSWeekdayCalendarUnit) fromDate:date];
    
    // 循环计算每个月的天数，然后相加
    for (int i = 1; i <= 12; i++) {
        
        [comps setMonth:i];
        
        NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit
                                       inUnit: NSMonthCalendarUnit
                                      forDate: [calendar dateFromComponents:comps]];
        
        count += range.length;
        
    }
 
    
    return count;
}

- (int)getNumberOfDaysCurrentMonth{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDate *date = [NSDate date];
    
    NSDateComponents *comps = [calendar components:(NSYearCalendarUnit |
                                                    NSMonthCalendarUnit |
                                                    NSDayCalendarUnit |
                                                    NSWeekdayCalendarUnit) fromDate:date];
    
    
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit
                                   inUnit: NSMonthCalendarUnit
                                  forDate: [calendar dateFromComponents:comps]];
    
    
    return range.length;
}


//隐藏多余分栏线
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

// 引导页数据
// 获取图片本地路径
- (NSString *)getLocalImagePath{
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return [documentsDirectory stringByAppendingPathComponent:kCoverImageName];
}

// 保存图片到本地
- (void)saveImage:(UIImage *)image{
    
    BOOL success = YES;
    NSString *filePath = [self getLocalImagePath];
    NSError *error = nil;
    [UIImagePNGRepresentation(image) writeToFile:filePath options:NSDataWritingAtomic error:&error];
    if ( error != nil ) {
        success = NO;
    }
    
}





@end
