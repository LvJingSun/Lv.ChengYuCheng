//
//  CheckAHPhoneViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-1-26.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "CheckAHPhoneViewController.h"
#import "CommonUtil.h"

@interface CheckAHPhoneViewController ()
{
    IBOutlet UITextField *CheckPhone;
    
    IBOutlet UITextField *provincetextfield;
    IBOutlet UITextField *citytextfield;
    IBOutlet UITextField *countytextfield;
    IBOutlet UITextField *adresstextfield;

    IBOutlet UIView *C_AdressView;//地址视图
    
    IBOutlet UIImageView *round0;
    IBOutlet UIImageView *round1;
    IBOutlet UIImageView *round2;

    IBOutlet UIImageView *line0;
    IBOutlet UIImageView *line1;
    
    IBOutlet UILabel *Label0;
    IBOutlet UILabel *Label1;
    IBOutlet UILabel *Label2;
    
    IBOutlet UILabel *instructions;//说明

    NSMutableArray *AllList;
    
    NSInteger AHprovincerow;
    NSInteger AHcityrow;
    NSInteger AHcountyrow;
    
    IBOutlet UIButton *DevelopmentBtn;
    
    NSString *toMemberId;//被开发的ID；
    NSString *centerId;//服务中心ID；

}

@end

@implementation CheckAHPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AllList = [[NSMutableArray alloc]init];
    
    [self ChosePAdress];
    
    round0.layer.masksToBounds = round1.layer.masksToBounds = round2.layer.masksToBounds = YES;
    round0.layer.cornerRadius = round1.layer.cornerRadius = round2.layer.cornerRadius =7.0;
    CheckPhone.delegate =self;
    [self setRightButtonWithTitle:@"检测" action:@selector(Detection)];
    
    [self setTitle:@"开发代理商"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [DevelopmentBtn addTarget:self action:@selector(SubmitKaiFa) forControlEvents:UIControlEventTouchUpInside];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}


-(void)leftClicked
{
    [self goBack];
}


-(void)Detection
{
    if ([CheckPhone.text isEqualToString:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:ACCOUNT]]]) {
        [SVProgressHUD showErrorWithStatus:@"不能开发自己"];
        return;
    }
    [self CheckSeverService];
    [self.view endEditing:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@""]) {
        if (textField.text.length ==12) {
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }else
            self.navigationItem.rightBarButtonItem.enabled = NO;
    }else{
        if (textField.text.length == 10)
            {
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }else
                self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    [self hiddenNumPadDone:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [self.view endEditing:YES];
    return YES;
}

//调服务器-开发代理
-(void)CheckSeverService{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           CheckPhone.text,     @"Account",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"CheckMember.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            BOOL developed = [[json valueForKey:@"CanDeveloped"] boolValue];
            [SVProgressHUD dismiss];
            //可被开发
            if (developed) {
                
                toMemberId = [NSString stringWithFormat:@"%@",[json valueForKey:@"ToMemberId"]];
                
                self.navigationItem.rightBarButtonItem = nil;
                CheckPhone.enabled = NO;
                instructions.text = @"检测成功，此用户可以被开发√";
                instructions.textColor = RGBACOLOR(0, 136, 206, 1);
                C_AdressView.hidden = NO;
                round0.backgroundColor = line0.backgroundColor = RGBACOLOR(71, 162, 245, 1);
                
            }else
            {
                NSString *msg = [json valueForKey:@"msg"];
                [SVProgressHUD showErrorWithStatus:msg];
                instructions.text = msg;
                instructions.textColor = [UIColor redColor];
            }
        }else{
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"检测失败"];
    }];
}



//选择服务中心
-(void)ChosePAdress
{
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           nil];
    [httpClient request:@"ServiceCenter.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            AllList = [json valueForKey:@"provinceList"];//省份
        }
    } failure:^(NSError *error) {
    }];

}

-(IBAction)ChoseAdress:(id)sender
{
    UIButton * BTN = (UIButton *)sender;
    AHchoseadressViewController *VC = [[AHchoseadressViewController alloc]initWithNibName:@"AHchoseadressViewController" bundle:nil];
    VC.AHarray = [[NSMutableArray alloc]initWithCapacity:0];
    VC.delegate = self;
    switch (BTN.tag) {
        case 100:
            VC.AHType = @"province";
            break;
        case 101:
            if ([provincetextfield.text isEqualToString:@""]) {
                [SVProgressHUD showErrorWithStatus:@"请先选择省份"];
                return;
            }
            VC.AHType = @"city";
            VC.AHprovincerow = [NSString stringWithFormat:@"%ld",(long)AHprovincerow];
            NSLog(@"%@",VC.AHprovincerow);

            break;
        case 102:
            if ([citytextfield.text isEqualToString:@""]) {
                [SVProgressHUD showErrorWithStatus:@"请先选择城市"];
                return;
            }
            VC.AHType = @"county";
            VC.AHprovincerow = [NSString stringWithFormat:@"%ld",(long)AHprovincerow];
            VC.AHcityrow = [NSString stringWithFormat:@"%ld",(long)AHcityrow];

            break;
        case 103:
            if ([countytextfield.text isEqualToString:@""]) {
                [SVProgressHUD showErrorWithStatus:@"请先选择县、区、街"];
                return;
            }
            VC.AHType = @"address";
            VC.AHprovincerow = [NSString stringWithFormat:@"%ld",(long)AHprovincerow];
            VC.AHcityrow = [NSString stringWithFormat:@"%ld",(long)AHcityrow];
            VC.AHcountyrow =[NSString stringWithFormat:@"%ld",(long)AHcountyrow];
            break;
            
        default:
            break;
    }
    VC.AHarray = AllList;
    [self.navigationController pushViewController:VC animated:YES];
    
}



- (void)getAHCityName:(NSMutableDictionary *)namedic andType:(NSString *)Type androw:(NSIndexPath *)Row;
{
    if ([Type isEqualToString:@"province"]) {
        if ([[NSString stringWithFormat:@"%@",[namedic objectForKey:@"provinceName"]] isEqualToString:provincetextfield.text]) {
            return;
        }else
        {
           citytextfield.text = countytextfield.text = adresstextfield.text = @"";
        }
        AHprovincerow = Row.row;
        provincetextfield.text = [NSString stringWithFormat:@"%@",[namedic objectForKey:@"provinceName"]];


    }else if ([Type isEqualToString:@"city"]){
        if ([[NSString stringWithFormat:@"%@",[namedic objectForKey:@"cityName"]] isEqualToString:citytextfield.text]) {
            return;
        }else{
            countytextfield.text = adresstextfield.text = @"";
        }
        AHcityrow = Row.row;
        citytextfield.text = [NSString stringWithFormat:@"%@",[namedic objectForKey:@"cityName"]];


    }else if ([Type isEqualToString:@"county"]){
        if ([[NSString stringWithFormat:@"%@",[namedic objectForKey:@"countyName"]] isEqualToString:countytextfield.text]) {
            return;
        }else
        {
            adresstextfield.text = @"";
        }
        AHcountyrow = Row.row;
        countytextfield.text = [NSString stringWithFormat:@"%@",[namedic objectForKey:@"countyName"]];


    }else if ([Type isEqualToString:@"address"]){
        if ([[NSString stringWithFormat:@"%@",[namedic objectForKey:@"address"]] isEqualToString:adresstextfield.text]) {
            return;
        }
        adresstextfield.text = [NSString stringWithFormat:@"%@",[namedic objectForKey:@"address"]];
        centerId = [NSString stringWithFormat:@"%@",[namedic objectForKey:@"centerId"]];
        DevelopmentBtn.enabled = YES;
        round1.backgroundColor = line1.backgroundColor = RGBACOLOR(71, 162, 245, 1);
        instructions.text = @"服务中心地址选择完毕，请立即开发";
        return;

    }
    
    DevelopmentBtn.enabled = NO;
    round1.backgroundColor = line1.backgroundColor = [UIColor lightGrayColor];
    instructions.text = @"检测成功，此用户可以被开发√";

}

-(void)SubmitKaiFa
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *serviceAddress = [NSString stringWithFormat:@"%@ %@ %@ %@",provincetextfield.text,citytextfield.text,countytextfield.text,adresstextfield.text];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"fromMemberId",
                           serviceAddress,     @"serviceAddress",
                           toMemberId,     @"toMemberId",
                           centerId,@"centerId",
                           nil];
    NSLog(@"%@",param);
    
    [httpClient request:@"SubmitKaiFa.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            round2.backgroundColor = RGBACOLOR(71, 162, 245, 1);

            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            [self.delegate SubmitKaiFasuccess];

            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(leftClicked) userInfo:nil repeats:NO];
            
            
        }else
        {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"开发失败，请稍后再试"];
    }];
}


@end
