//
//  MenuEvaluationViewController.m
//  HuiHui
//
//  Created by mac on 15-10-18.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "MenuEvaluationViewController.h"
#import "HCSStarRatingView.h"

@interface MenuEvaluationViewController ()<UITextViewDelegate>

@property (nonatomic,weak) IBOutlet UIView *productstartView;
@property (nonatomic,weak) IBOutlet UIView *wuliustartView;

@property (nonatomic,weak) IBOutlet UILabel *productLabel;
@property (nonatomic,weak) IBOutlet UILabel *wuliuLabel;

@property (nonatomic,weak) IBOutlet UITextView *EvaluationView;


@end

@implementation MenuEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    [self setTitle:@"评价"];
    self.EvaluationView.delegate = self;
    
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    starRatingView.maximumValue = 5;
    starRatingView.minimumValue = 1;
    starRatingView.value = 0.f;
    starRatingView.tintColor = RGBACKTAB;
    [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.productstartView addSubview:starRatingView];
    
    HCSStarRatingView *starRatingView1 = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    starRatingView1.maximumValue = 5;
    starRatingView1.minimumValue = 1;
    starRatingView1.value = 0.f;
    starRatingView1.tintColor = RGBACKTAB;
    [starRatingView1 addTarget:self action:@selector(didChangeValue1:) forControlEvents:UIControlEventValueChanged];
    [self.wuliustartView addSubview:starRatingView1];


}

- (void)leftClicked{
    
    [self goBack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didChangeValue:(HCSStarRatingView *)sender {
    self.productLabel.text = [NSString stringWithFormat:@"%.0f分",sender.value];

}

- (IBAction)didChangeValue1:(HCSStarRatingView *)sender {
    self.wuliuLabel.text = [NSString stringWithFormat:@"%.0f分",sender.value];

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

- (IBAction)AddCloudMenuScore:(id)sender{
    if ([self.productLabel.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请对产品打分!"];
        return;
    }
    if ([self.wuliuLabel.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请对物流打分!"];
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
                           self.CloudMenuOrderID,@"CloudMenuOrderID",
                           [self.EvaluationView.text isEqualToString:@"请说说你的想法"]?@"":self.EvaluationView.text,@"RefundReason",
                           self.productLabel.text.length!=0?[self.productLabel.text substringWithRange:NSMakeRange(0,1)]:@"1",@"Score",
                           self.wuliuLabel.text.length!=0?[self.wuliuLabel.text substringWithRange:NSMakeRange(0,1)]:@"1",@"WLScore",

                           nil];
        
    [httpClient request:@"AddCloudMenuScore.ashx" parameters:param success:^(NSJSONSerialization* json) {
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
