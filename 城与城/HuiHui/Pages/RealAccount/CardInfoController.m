//
//  CardInfoController.m
//  HuiHui
//
//  Created by mac on 16/10/14.
//  Copyright © 2016年 MaxLinksTec. All rights reserved.
//

#import "CardInfoController.h"
#import "CheckCodeController.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface CardInfoController ()<UITextFieldDelegate>

@property (nonatomic, weak) UITextField *textfield;

@property (nonatomic, weak) UIButton *nextBtn;

@end

@implementation CardInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"填写银行卡信息";
    
    self.view.backgroundColor = [UIColor colorWithRed:245/255. green:245/255. blue:249/255. alpha:1.];
    
    [self setNavBarStyle];
    
    [self setViewStyle];
    
    // Do any additional setup after loading the view.
}

- (void)setNavBarStyle {
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backItem;
    
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

    UILabel *tishi = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH * 0.05, 10, WIDTH * 0.9, 20)];
    
    tishi.text = @"信息加密处理，仅用于银行验证";
    
    tishi.textColor = [UIColor colorWithRed:157/255. green:157/255. blue:158/255. alpha:1.];
    
    tishi.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:tishi];
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tishi.frame) + 10, WIDTH, 0.5)];
    
    line1.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:line1];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line1.frame), WIDTH, 50)];
    
    view1.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view1];
    
    UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH * 0.05, CGRectGetMaxY(line1.frame) + 15, WIDTH * 0.2, 20)];
    
    title1.text = @"卡类型";
    
    title1.font = [UIFont systemFontOfSize:18];
    
    [self.view addSubview:title1];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame), WIDTH, 0.5)];
    
    line2.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:line2];
    
    UILabel *cardtype = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH * 0.3, CGRectGetMaxY(line1.frame) + 15, WIDTH * 0.65, 20)];
    
    if ([self.bankInfo[@"OrgCode"] isEqualToString:@"0100"]) {
        
        cardtype.text = @"中国邮政储蓄银行";
        
    }else if ([self.bankInfo[@"OrgCode"] isEqualToString:@"0102"]) {
        
        cardtype.text = @"中国工商银行";
        
    }else if ([self.bankInfo[@"OrgCode"] isEqualToString:@"0103"]) {
        
        cardtype.text = @"中国农业银行";
        
    }else if ([self.bankInfo[@"OrgCode"] isEqualToString:@"0104"]) {
        
        cardtype.text = @"中国银行";
        
    }else if ([self.bankInfo[@"OrgCode"] isEqualToString:@"0105"]) {
        
        cardtype.text = @"中国建设银行";
        
    }else if ([self.bankInfo[@"OrgCode"] isEqualToString:@"0302"]) {
        
        cardtype.text = @"中信银行";
        
    }else if ([self.bankInfo[@"OrgCode"] isEqualToString:@"0303"]) {
        
        cardtype.text = @"中国光大银行";
        
    }else if ([self.bankInfo[@"OrgCode"] isEqualToString:@"0305"]) {
        
        cardtype.text = @"中国民生银行";
        
    }else if ([self.bankInfo[@"OrgCode"] isEqualToString:@"0306"]) {
        
        cardtype.text = @"广发银行";
        
    }else if ([self.bankInfo[@"OrgCode"] isEqualToString:@"0308"]) {
        
        cardtype.text = @"招商银行";
        
    }else if ([self.bankInfo[@"OrgCode"] isEqualToString:@"0309"]) {
        
        cardtype.text = @"兴业银行";
        
    }
    
    cardtype.font = [UIFont systemFontOfSize:19];
    
    [self.view addSubview:cardtype];
    
    UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line2.frame) + 30, WIDTH, 0.5)];
    
    line3.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:line3];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line3.frame), WIDTH, 50)];
    
    view2.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view2];
    
    UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view2.frame), WIDTH, 0.5)];
    
    line4.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:line4];
    
    UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH * 0.05, CGRectGetMaxY(line3.frame) + 15, WIDTH * 0.2, 20)];
    
    title2.text = @"手机号";
    
    title2.font = [UIFont systemFontOfSize:18];
    
    [self.view addSubview:title2];
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH * 0.3, 15 + CGRectGetMaxY(line3.frame), WIDTH * 0.65, 20)];
    
    self.textfield = textfield;
    
    textfield.delegate = self;
    
    textfield.placeholder = @"银行预留手机号码";
    
    textfield.font = [UIFont systemFontOfSize:19];
    
    textfield.keyboardType = UIKeyboardTypePhonePad;
    
    [textfield addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventAllEditingEvents];
    
    [self.view addSubview:textfield];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH * 0.05, CGRectGetMaxY(line4.frame) + 25, 40, 20)];
    
    lab.text = @"同意";
    
    lab.font = [UIFont systemFontOfSize:15];
    
    lab.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:lab];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame), CGRectGetMaxY(line4.frame) + 25, 100, 20)];
    
    [btn setTitle:@"《服务协议》" forState:0];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [btn setTitleColor:[UIColor colorWithRed:53/255. green:158/255. blue:236/255. alpha:1.] forState:0];
    
    [self.view addSubview:btn];
    
    UIButton *next = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH * 0.05, CGRectGetMaxY(btn.frame) + 25, WIDTH * 0.9, 60)];
    
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

- (void)nextBtnClick {
    
    if ([self isValidateMobile:self.textfield.text]) {
        
        [self resignFirst];
        
        [self sendYanZhengMa];
        
    }else {
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"大陆手机为11位数字，非大陆手机为“国家代码-手机号码”形式" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
    
}

- (void)sendYanZhengMa {
    
    //正则表达式 ^([0-9]{16}|[0-9]{19})$  /^(\d{16}|\d{19})$/

    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.bankInfo[@"Membercardnumber"],@"cardNumber",
                           self.textfield.text,@"Account",
                           memberId,@"memberId",
                           nil];
    
    [httpClient request:@"BankCarAddMsg.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            CheckCodeController *vc = [[CheckCodeController alloc] init];
            
            vc.phoneNum = self.textfield.text;
            
            vc.cardNum = self.bankInfo[@"Membercardnumber"];
            
            vc.dic = self.bankInfo;
            
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

    if ([self.textfield isFirstResponder]) {
        
        [self.textfield resignFirstResponder];
        
    }
}

-(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|17[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
    
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    if ([self.textfield isFirstResponder]) {
        
        [self.textfield resignFirstResponder];
        
    }
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
