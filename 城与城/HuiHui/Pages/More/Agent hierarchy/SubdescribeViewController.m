//
//  SubdescribeViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-1-27.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SubdescribeViewController.h"

@interface SubdescribeViewController ()
{
    IBOutlet UITextView *submitTextview;
    
    IBOutlet UILabel *proLabel;//提示语句
}

@end

@implementation SubdescribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    submitTextview.layer.masksToBounds = YES; //没这句话它圆不起来
    submitTextview.layer.cornerRadius = 8.0; //设置图片圆角的尺度
    [submitTextview setFrame:CGRectMake(submitTextview.frame.origin.x, submitTextview.frame.origin.y, submitTextview.frame.size.width, 150)];
    submitTextview.delegate = self;
    
    [self setTitle:@"增加服务描述"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    [self setRightButtonWithTitle:@"提交" action:@selector(Submit)];
    
    proLabel.text = [NSString stringWithFormat:@"本次服务包括以下几点：\n1、\n2、\n3、"];
    
}

-(void)leftClicked
{
    [self goBack];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}


-(void)Submit
{
    if (submitTextview.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入服务描述"];
        return;
    }
    [submitTextview resignFirstResponder];
    [self Submit_loadData];
}


- (void)textViewDidBeginEditing:(UITextView *)textView;
{
    [self hiddenNumPadDone:nil];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
    if (textView.text.length + text.length >0) {
        if (text.length ==0 && textView.text.length ==1) {
            proLabel.hidden = NO;
            return YES;
        }
        proLabel.hidden = YES;
    }else
    {
        proLabel.hidden = NO;
    }
    
    return YES;
}

#pragma mark 发送自定义消息（高级会话）一般是图片+正副标题（类型是（代理商服务打评）等等）
-(void)sendU_definedDALIMessage:(NSString *)title andcontent:(NSString *)content andopinion:(NSString *)opinion andtype:(NSString *)type andtoid:(NSString *)username andserviceId:(NSString *)serviceId andgroup:(BOOL)Isgroup
{
    //@"自定义消息_HuiHui_012345"
    EMChatText *userObject = [[EMChatText alloc] initWithText:title];
    EMTextMessageBody *body = [[EMTextMessageBody alloc]
                               initWithChatObject:userObject];
    EMMessage *msg = [[EMMessage alloc] initWithReceiver:username
                                                  bodies:@[body]];
    msg.requireEncryption = NO;
    msg.isGroup = Isgroup;
    NSMutableDictionary *vcardProperty = [NSMutableDictionary dictionary];
    [vcardProperty setObject:title forKey:@"Dalititle"];//服务标题
    [vcardProperty setObject:content forKey:@"Dalicontent"];//服务内容
   	[vcardProperty setObject:opinion forKey:@"Daliopinion"];//评论
    [vcardProperty setObject:serviceId forKey:@"DaliserviceId"];//服务ID；
    [vcardProperty setObject:type forKey:@"type"];//自定义类型

    msg.ext = vcardProperty;
    [[EaseMob sharedInstance].chatManager asyncSendMessage:msg progress:nil prepare:^(EMMessage *message, EMError *error) {
    } onQueue:nil completion:^(EMMessage *message, EMError *error) {
        [self hideHud];
        if (!error) {
            [self showHint:@"发送成功"];
            [self.delegate Submitsuccess];
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(leftClicked) userInfo:nil repeats:NO];
        }else{
            [self showHint:@"发送失败"];
        }
    } onQueue:nil];
    
}


//增加服务内容
- (void)Submit_loadData {
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"fromMemberId",
                           self.toMemberId,   @"toMemberId",
                           submitTextview.text,@"serviceDesc",
                           nil];
    [self showHudInView:self.view hint:@"正在发送..."];
    [httpClient request:@"AddService.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *serviceId = [NSString stringWithFormat:@"%@",[json valueForKey:@"serviceId"]];
            [self sendU_definedDALIMessage:@"服务打评" andcontent:submitTextview.text andopinion:@"" andtype:@"DALI" andtoid:self.toMemberId andserviceId:serviceId andgroup:NO];

        } else {
            [self hideHud];
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [self hideHud];
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
    }];
}



@end
