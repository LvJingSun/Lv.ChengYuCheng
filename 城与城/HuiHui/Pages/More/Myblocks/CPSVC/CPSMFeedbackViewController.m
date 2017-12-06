//
//  CPSMFeedbackViewController.m
//  HuiHui
//
//  Created by mac on 15-10-18.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "CPSMFeedbackViewController.h"

@interface CPSMFeedbackViewController ()<UITextViewDelegate>
@property (nonatomic,weak) IBOutlet UITextView *EvaluationView;


@end

@implementation CPSMFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.EvaluationView.delegate = self;
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    [self setTitle:@"意见反馈"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self hiddenNumPadDone:nil];
    if ([textView.text isEqualToString:@"请说说你的想法"]) {
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = @"请说说你的想法";
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (IBAction)AddCloudMenuAdvice:(id)sender{
    if ([self.EvaluationView.text isEqualToString:@"请说说你的想法"]) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的意见"];
        return;
    }
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"MemberID",
                           key,@"Key",
                           self.m_shopId,@"MerchantShopID",
                           self.EvaluationView.text,@"Description",
                           
                           nil];
    
    [httpClient request:@"AddCloudMenuAdvice.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(leftClicked) userInfo:nil repeats:NO];
            
        }else{
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

@end
