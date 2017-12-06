//
//  CheckCodeController.m
//  HuiHui
//
//  Created by mac on 16/10/18.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "CheckCodeController.h"
#import "AddSuccessViewController.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface CheckCodeController () {

    NSTimer *myTimer;
    
    int i;
    
}

@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, weak) UIButton *againBtn;

@property (nonatomic, weak) UIButton *nextBtn;

@end

@implementation CheckCodeController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavBarStyle];
    
    self.title = @"填写校验码";
    
    self.view.backgroundColor = [UIColor colorWithRed:245/255. green:245/255. blue:249/255. alpha:1.];
    
    [self setViewStyle];
    
    myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFunction:) userInfo:nil repeats:YES];
    
    i = 60;
    
    [myTimer setFireDate:[NSDate distantPast]];
    
}

- (void)timerFunction:(NSTimer *)timer {
    
    i--;
    
    if (i >= 0) {
        
        self.againBtn.userInteractionEnabled = NO;
        
        [self.againBtn setTitle:[NSString stringWithFormat:@"%d秒后重发",i] forState:0];
        
        self.againBtn.backgroundColor = [UIColor colorWithRed:221/255. green:221/255. blue:221/255. alpha:1.];
        
        [self.againBtn setTitleColor:[UIColor darkGrayColor] forState:0];
        
    }else {
    
        self.againBtn.userInteractionEnabled = YES;
        
        [self.againBtn setTitle:@"短信校验码" forState:0];
        
        self.againBtn.backgroundColor = [UIColor whiteColor];
        
        [self.againBtn setTitleColor:[UIColor blackColor] forState:0];
        
        [myTimer setFireDate:[NSDate distantFuture]];
        
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {

    [myTimer setFireDate:[NSDate distantFuture]];
    
}

- (void)setNavBarStyle {
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    UIColor *color = [UIColor whiteColor];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
}

- (void)setViewStyle {

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH * 0.05, 10, WIDTH * 0.9, 30)];
    
    NSString *str = [self replaceStringWithAsterisk:self.phoneNum startLocation:3 lenght:4];
    
    label.text = [NSString stringWithFormat:@"请输入手机%@收到的短信校验码。",str];
    
    label.textColor = [UIColor colorWithRed:157/255. green:157/255. blue:158/255. alpha:1.];
    
    label.font = [UIFont systemFontOfSize:16];
    
    [self.view addSubview:label];
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH * 0.05, CGRectGetMaxY(label.frame) + 10, WIDTH * 0.5, 50)];
    
    textfield.font = [UIFont systemFontOfSize:20];
    
    textfield.textAlignment = NSTextAlignmentCenter;
    
    textfield.placeholder = @"短信校验码";
    
    textfield.backgroundColor = [UIColor whiteColor];
    
    textfield.layer.borderWidth = 0.5;
    
    textfield.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    textfield.layer.cornerRadius = 5;
    
    textfield.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    [textfield addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventAllEditingEvents];
    
    self.textField = textfield;
    
    [self.view addSubview:textfield];
    
    UIButton *chongfa = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(textfield.frame) + 10, CGRectGetMaxY(label.frame) + 10, WIDTH * 0.4 - 10, 50)];
    
    chongfa.backgroundColor = [UIColor whiteColor];
    
    chongfa.layer.cornerRadius = 5;
    
    chongfa.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    chongfa.layer.borderWidth = 0.5;
    
    [chongfa setTitle:@"重发校验码" forState:0];
    
    [chongfa setTitleColor:[UIColor blackColor] forState:0];
    
    chongfa.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [chongfa addTarget:self action:@selector(chongfa) forControlEvents:UIControlEventTouchUpInside];
    
    self.againBtn = chongfa;
    
    [self.view addSubview:chongfa];
    
    UIButton *next = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH * 0.05, CGRectGetMaxY(textfield.frame) + 20, WIDTH * 0.9, 60)];
    
    self.nextBtn = next;
    
    [next setTitle:@"下一步" forState:0];
    
    next.userInteractionEnabled = NO;
    
    next.layer.cornerRadius = 5;
    
    next.backgroundColor = [UIColor colorWithRed:221/255. green:221/255. blue:221/255. alpha:1.];
    
    [next setTitleColor:[UIColor colorWithRed:187/255. green:187/255. blue:187/255. alpha:1.] forState:0];
    
    next.titleLabel.font = [UIFont systemFontOfSize:22];
    
    [next addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:next];
    
}

- (void)chongfa {
    
    i = 60;

    [myTimer setFireDate:[NSDate distantPast]];
    
    [self sendYanZhengMa];
    
}

- (void)sendYanZhengMa {
    
    //正则表达式 ^([0-9]{16}|[0-9]{19})$  /^(\d{16}|\d{19})$/
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.cardNum,@"cardNumber",
                           self.phoneNum,@"Account",
                           memberId,@"memberId",
                           nil];
    
    [httpClient request:@"BankCarAddMsg.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self resignFirst];
    
}

- (void)nextBtnClick {

    [self resignFirst];
    
    [self yanzhengCount];
    
}

- (void)yanzhengCount {

    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           self.dic[@"MemberBankCardId"],@"memberBankCardId",
                           self.textField.text, @"playMoney",
                           nil];
    [SVProgressHUD showWithStatus:@"信息提交中"];
    [httpClient request:@"BankCardVerification.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            AddSuccessViewController *vc = [[AddSuccessViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];

        }
    } failure:^(NSError *error) {

        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

}

- (void)resignFirst {

    if ([self.textField isFirstResponder]) {
        
        [self.textField resignFirstResponder];
        
    }
    
}

- (void)valueChanged:(UITextField *)textfield {
    
    if (![textfield.text isEqualToString:@""]) {
        
        self.nextBtn.userInteractionEnabled = YES;
        
        self.nextBtn.backgroundColor = [UIColor colorWithRed:53/255. green:158/255. blue:236/255. alpha:1.];
        
        [self.nextBtn setTitleColor:[UIColor whiteColor] forState:0];
        
    }else {
        
        self.nextBtn.userInteractionEnabled = NO;
        
        self.nextBtn.backgroundColor = [UIColor colorWithRed:221/255. green:221/255. blue:221/255. alpha:1.];
        
        [self.nextBtn setTitleColor:[UIColor colorWithRed:187/255. green:187/255. blue:187/255. alpha:1.] forState:0];
        
    }
    
}

-(NSString *)replaceStringWithAsterisk:(NSString *)originalStr startLocation:(NSInteger)startLocation lenght:(NSInteger)lenght
{
    NSString *newStr = originalStr;
    for (int i = 0; i < lenght; i++) {
        NSRange range = NSMakeRange(startLocation, 1);
        newStr = [newStr stringByReplacingCharactersInRange:range withString:@"*"];
        startLocation ++;
    }
    return newStr;
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
