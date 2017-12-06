//
//  EvaluateViewController.m
//  baozhifu
//
//  Created by mac on 13-12-17.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "EvaluateViewController.h"

#import "SVProgressHUD.h"

#import "CommonUtil.h"

#import "AppHttpClient.h"

#define HANZI_START 19968
#define HANZI_COUNT 20902

@interface EvaluateViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UITextView *m_conentTextView;

@property (weak, nonatomic) IBOutlet UILabel *m_PromptLabel;

@property (weak, nonatomic) IBOutlet UIView *m_saidView;

@property (weak, nonatomic) IBOutlet UIView *m_commentView;

@property (weak, nonatomic) IBOutlet UILabel *m_comPromptLabel;

@property (weak, nonatomic) IBOutlet UITextView *m_comConentTextView;


@property (weak, nonatomic) IBOutlet UIButton *m_btn1;

@property (weak, nonatomic) IBOutlet UIButton *m_btn2;

@property (weak, nonatomic) IBOutlet UIButton *m_btn3;

@property (weak, nonatomic) IBOutlet UIButton *m_btn4;

@property (weak, nonatomic) IBOutlet UIButton *m_btn5;

// 点击星星进行评价星级
- (IBAction)starClicked:(id)sender;


// 说两句时发表按钮触发的事件
- (IBAction)submitClicked:(id)sender;
// 评价时发表按钮触发的事件
- (IBAction)commentSubmit:(id)sender;

@end

@implementation EvaluateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
       
    self.m_starString = @"0";
    
    // 判断来自于哪个页面
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        self.m_saidView.hidden = NO;
        
        self.m_commentView.hidden = YES;
        
        [self setTitle:@"说两句"];
        
    }else{
        
        self.m_saidView.hidden = YES;
        
        self.m_commentView.hidden = NO;
        
        [self setTitle:@"评价"];
        
    }
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setM_tempView:nil];
    [self setM_conentTextView:nil];
    [self setM_PromptLabel:nil];
    [self setM_saidView:nil];
    [self setM_commentView:nil];
    [self setM_comPromptLabel:nil];
    [self setM_comConentTextView:nil];
    [self setM_btn1:nil];
    [self setM_btn2:nil];
    [self setM_btn3:nil];
    [self setM_btn4:nil];
    [self setM_btn5:nil];
    [super viewDidUnload];
}

- (void)leftClicked{
    
    [self goBack];
}

// 请求网络
- (void)requestComment{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *string;
    
    // 判断来自于哪个页面
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        string = [NSString stringWithFormat:@"%@",self.m_conentTextView.text];
        
    }else{
        
        string = [NSString stringWithFormat:@"%@",self.m_comConentTextView.text];
        
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [NSString stringWithFormat:@"%@",self.m_merchantId], @"merchantId",
                           [NSString stringWithFormat:@"%@",string],@"mess",
                           [NSString stringWithFormat:@"%@",self.m_typeString],@"option",
                           [NSString stringWithFormat:@"%@",self.m_starString],@"rank",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MerchantComment.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            //            NSString *msg = [json valueForKey:@"msg"];
            
            if ( [self.m_typeString isEqualToString:@"1"] ) {
                
                [SVProgressHUD showSuccessWithStatus:@"说两句提交成功"];
                
                [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(goLastView) userInfo:nil repeats:NO];
                
            }else{
                
                [SVProgressHUD showSuccessWithStatus:@"评价提交成功"];
                
                [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(goLastView) userInfo:nil repeats:NO];
                
            }
            
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

- (void)goLastView{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    if ( self.m_conentTextView.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入自己的想法"];
        
        return;
    }
    
    // 提交服务器
    [self requestComment];
    
}

- (IBAction)commentSubmit:(id)sender {
    
    [self.view endEditing:YES];
    
    if ( self.m_comConentTextView.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入自己的想法"];
        
        return;
    }
    
    // 提交服务器
    [self requestComment];
    
}

- (IBAction)starClicked:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 100 ) {
        
        self.m_btn1.selected = YES;
        self.m_btn2.selected = NO;
        self.m_btn3.selected = NO;
        self.m_btn4.selected = NO;
        self.m_btn5.selected = NO;
        
        self.m_starString = @"1";
        
    }else if ( btn.tag == 101 ){
        
        self.m_btn1.selected = YES;
        self.m_btn2.selected = YES;
        self.m_btn3.selected = NO;
        self.m_btn4.selected = NO;
        self.m_btn5.selected = NO;
        
        self.m_starString = @"2";
        
    }else if ( btn.tag == 102 ){
        
        self.m_btn1.selected = YES;
        self.m_btn2.selected = YES;
        self.m_btn3.selected = YES;
        self.m_btn4.selected = NO;
        self.m_btn5.selected = NO;
        
        self.m_starString = @"3";
        
    }else if ( btn.tag == 103 ){
        
        self.m_btn1.selected = YES;
        self.m_btn2.selected = YES;
        self.m_btn3.selected = YES;
        self.m_btn4.selected = YES;
        self.m_btn5.selected = NO;
        
        self.m_starString = @"4";
        
    }else {
        
        self.m_btn1.selected = YES;
        self.m_btn2.selected = YES;
        self.m_btn3.selected = YES;
        self.m_btn4.selected = YES;
        self.m_btn5.selected = YES;
        
        self.m_starString = @"5";
        
    }
    
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ( textView == self.m_conentTextView ) {
        
        self.m_PromptLabel.hidden = YES;
        
    }else{
        
        self.m_comPromptLabel.hidden = YES;
    }
    
    [self hiddenNumPadDone:nil];
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    [textView resignFirstResponder];
    
    if ( textView == self.m_conentTextView ) {
        
        if ( self.m_conentTextView.text.length == 0 ) {
            
            self.m_PromptLabel.hidden = NO;
        }
    }else{
        
        if ( self.m_comConentTextView.text.length == 0 ) {
            
            self.m_comPromptLabel.hidden = NO;
        }
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    
    int num = (int)([self textLength:textView.text] / 2);
    m_textCount = (int)([self textLength:textView.text] / 2);
    
    if ( num > 400 ) {
        
        [SVProgressHUD showErrorWithStatus:@"字符个数不能大于400"];
        
        textView.text = [textView.text substringToIndex:num * 2];
        
    }else{
        
        m_textCount = (int)([self textLength:textView.text] / 2);
        
    }
    
}

// 计算字数
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



@end
