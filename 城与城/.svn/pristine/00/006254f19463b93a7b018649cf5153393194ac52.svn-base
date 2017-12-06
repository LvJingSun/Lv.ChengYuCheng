//
//  SendMessageViewController.m
//  HuiHui
//
//  Created by mac on 14-3-28.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "SendMessageViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "MessageObject.h"

#import "MessageAndUserObject.h"

#import "MessageListCell.h"

#import "Configuration.h"

#import "NSObject+SBJson.h"

#import "XMPPManager.h"

#import "NSData+Base64.h"

#import "LookImageViewController.h"

#import "NSDate+BBExtensions.h"

#import "GTMBase64.h"

#import "UserInformationViewController.h"

#import "FriendsListViewController.h"

#import "Appdelegate.h"

#import "MarkupParser.h"

#import "SCGIFImageView.h"

#import "WebViewController.h"

#import "XMPP_service.h"

#import "ChatDetailViewController.h"


@interface SendMessageViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UIView *m_inputBar;

@property (weak, nonatomic) IBOutlet UITextField *m_message;

@property (weak, nonatomic) IBOutlet UIButton *m_voiceBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_voiceTapBtn;

@property (weak, nonatomic) IBOutlet UIView *m_voiceView;

@property (weak, nonatomic) IBOutlet UIImageView *m_tipImagV;


// 发送按钮触发的事件
- (IBAction)sendClicked:(id)sender;
// 发送图片按钮触发的事件
- (IBAction)choosePicture:(id)sender;

- (IBAction)voiceBtnClicked:(id)sender;

- (IBAction)voiceStop:(id)sender;

// 按下按钮选择录音的模式
- (IBAction)voiceChooseClicked:(id)sender;
// 选择表情
- (IBAction)chooseEmotionClicked:(id)sender;

@end

@implementation SendMessageViewController

@synthesize m_recordList;

@synthesize m_chatPerson;

@synthesize isSelectedPicture;

@synthesize m_moreView;

@synthesize m_recorder;

@synthesize m_recorderFilePath;

@synthesize m_dataFile;

@synthesize m_prepareToRecord;

@synthesize isVoiceMode;

@synthesize m_index;

@synthesize m_Second;

@synthesize m_longIndex;

@synthesize m_emotionView;

@synthesize m_typeFrom;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_recordList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_chatPerson = [[Userobject alloc]init];
        
        isSelectedPicture = NO;
        
        m_prepareToRecord = NO;
        
        isVoiceMode = NO;
        
        m_index = 0;
        
        m_Second = 0;
        
        m_longIndex = 0;
        

    }
    return self;
}

// 保证只初始化一次
//+ (SendMessageViewController *)shareobject
//{
//    static SendMessageViewController *VC = nil;
//    
//    if ( VC == nil ){
//        
//        VC = [[SendMessageViewController alloc]init];
//        
//    }
//    return VC;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    recordAudio = [[RecordAudio alloc]init];
    recordAudio.delegate = self;
    
    // 判断是否是群聊
    if ( self.group ) {
        
//        self.title = [NSString stringWithFormat:@"%@",[self.group getName]];
        
        // 保存群的名称
        [CommonUtil addValue:[self.group getName] andKey:@"GroupName"];

    }else{
        
//        self.title = self.m_chatPerson.userNickName;

    }
    
    
    // 记录是否是第一次进入页面-从本地加载数据
    self.isFirstInPage = YES;
  
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
    // tableView添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
  
    [self.m_tableView addGestureRecognizer:tap];
   
    
    
    [self.m_tableView setBackgroundView:nil];
    [self.m_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // 保存聊天的对象的memberId
    [CommonUtil addValue:self.m_chatPerson.userId andKey:OTHERMEMBERID];
    
    
    // 拍照、图片按钮所在的view
    m_moreView = [[MoreView alloc]init];
    [m_moreView setFrame:CGRectMake(0, 0, 320, 170)];
    m_moreView.m_delegate = self;
    
    // 表情所在的view
    m_emotionView = [EmotionView instance];
    [m_emotionView setFrame:CGRectMake(0, 0, 320, 170)];
//    m_emotionView.delegate = self;
    
    [EmotionView setEmotionDelegate:self];

    // 默认隐藏录音的按钮
    [self.m_voiceTapBtn setHidden:YES];
    
    [self.m_message setHidden:NO];
    
    //// ====初始化录音
    
    if ( !self.m_prepareToRecord ) {
        
        [self setupRecordDevice];

    }
  
    
    self.m_voiceView.hidden = YES;
    
    self.m_voiceTapBtn.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0];
    self.m_voiceTapBtn.layer.cornerRadius = 5.0f;
    self.m_voiceTapBtn.layer.borderWidth = 0.5f;
    self.m_voiceTapBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    self.m_voiceTapBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
 
    
    
    NSLog(@"self.group = %@",self.group.groupIdMain);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload{
    [super viewDidUnload];
    
    self.m_recorder = nil;
    self.m_prepareToRecord = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear: animated];
    
    // 第一次进入页面后刷新数据
    if ( self.isFirstInPage ) {
        
        // 加载数据
        [self refresh];
    }
    
    self.isFirstInPage = NO;
   
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    
    // 设置导航栏的标题
    if ( self.group ) {
        
        self.title = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"GroupName"]];
    
    }else{
        
        self.title = self.m_chatPerson.userNickName;
        
    }
    
    if ( self.isFirstInPage ) {
        
        [SVProgressHUD showWithStatus:@"数据加载中"];
        
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SendnewMsgCome:) name:kXMPPSendNewMsgNotifaction object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeKeyBoard:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openURLString:) name:@"OpenUrl" object:nil];
    
 
    
    

    
    if ( !self.isSelectedPicture ) {
        
        [self hideTabBar:YES];
        
    }else{
        
        // =========
        if ( isIOS7 ) {
            
            for(UIView *view in self.tabBarController.view.subviews)
            {
                
                if([view isKindOfClass:[UITabBar class]])
                {
                    
                    if (self.tabBarController.tabBar.hidden) {
                        [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width, 0)];
                    }
                }
            }

        }
        //========
    }
    
    self.isSelectedPicture = NO;
    
    // 判断转发
    if ( Appdelegate.isForward ) {
        
        // 这里是操作和对方聊天的这条内容被转发给对方的
        [self forwardClicked];
        
        Appdelegate.isForward = NO;
    }
    
    
    // 从添加群聊页面过来-刚添加群后发起一个聊天用于创建是谁新建的群，保存群主
    if ( [self.m_typeFrom isEqualToString:@"GroupChat"] && Appdelegate.isHello ) {

        Appdelegate.isHello = NO;
        
        NSString *base64utf8 = [GTMBase64 base64StringBystring:@"Hello"];
        
        NSDate *date = [NSDate date];
        
        // 将日期转换成字符
        NSString *dateString = [self stringFromDate:date];
       
        NSDictionary *messageDic = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"file",[NSNumber numberWithInt:kWCMessageTypePlain],@"messageType", base64utf8,@"text", dateString,@"dateKey", nil];
        
        NSString *msgJson = [messageDic JSONRepresentation];
        
        self.m_message.text = @"";
        //生成消息对象
        XMPPMessage *mes1 = [XMPPMessage messageWithType:@"groupchat" to:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@",self.group.groupId]]];
        
        [mes1 addChild:[DDXMLNode elementWithName:@"body" stringValue:msgJson]];
        
        //发送消息
        [[XMPPManager sharedInstance] sendGroupMessage:mes1 withGroup:self.group];
        
        [self.m_tableView reloadData];
        
    }else{
        
    }

        
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kXMPPSendNewMsgNotifaction object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"OpenUrl" object:nil];
//
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"groups_change" object:nil];

    // 判断是否隐藏tabBar
    if ( !self.isSelectedPicture ) {
        
        if ( isIOS7 ) {
            
            // 修改选择了图片后产生的bug =======
            for(UIView *view in self.tabBarController.view.subviews)
            {
                
                if([view isKindOfClass:[UITabBar class]])
                {
                    
                    if (self.tabBarController.tabBar.hidden) {
                        [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width, 49)];
                        
                    }
                }
                
            }
        }
        //=========
        
        [self hideTabBar:NO];

    }else{
        
    }
    
}

#pragma mark - 聊天页面里点击网址后进行跳转的通知
- (void)openURLString:(NSNotification *)notification{
    
    NSString *string = [NSString stringWithFormat:@"%@",[notification.userInfo objectForKey:@"urlString"]];
    
    // 进入网页页面
    WebViewController *VC = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
    VC.m_scanString = string;
    VC.m_typeString = @"2";
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)leftClicked{
    
    // 从添加群聊页面过来
    if ( [self.m_typeFrom isEqualToString:@"GroupChat"] ) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else{
       
         [self goBack];
    }
    
    
   
   
}

- (void)forwardClicked{
    
    // 保存聊天的对象的memberId
    [CommonUtil addValue:self.m_chatPerson.userId andKey:OTHERMEMBERID];
    
    [CommonUtil addValue:self.m_chatPerson.userNickName andKey:OTHERUSERNAME];
    
    [CommonUtil addValue:self.m_chatPerson.userHead andKey:OTHERHEADERIMAGE];
    
    [CommonUtil addValue:@"0" andKey:kFromMessage];
    [CommonUtil addValue:@"" andKey:kFriendFlag];

    
    // 判断是转发文本还是转发图片
    if ( [Appdelegate.isImageOrText isEqualToString:@"1"] ) {
        // 转发的是文本
        NSString *base64utf8 = [GTMBase64 base64StringBystring:[CommonUtil getValueByKey:FORWARDCONTENT]];
        
        NSDictionary *messageDic = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"file",[NSNumber numberWithInt:kWCMessageTypePlain],@"messageType", base64utf8,@"text", nil];
        
        NSString *msgJson = [messageDic JSONRepresentation];
        
        self.m_message.text = @"";
        
        //生成消息对象
        XMPPMessage *mes1 = [XMPPMessage messageWithType:@"chat" to:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@home.cityandcity.com",self.m_chatPerson.userId]]];
        
        [mes1 addChild:[DDXMLNode elementWithName:@"body" stringValue:msgJson]];
        
        //发送消息
        [[XMPPManager sharedInstance] sendMessage:mes1];
        
        [self.m_tableView reloadData];

    }else if ( [Appdelegate.isImageOrText isEqualToString:@"2"] ){
        
//        NSString *base64utf8 = [GTMBase64 base64StringBystring:[CommonUtil getValueByKey:FORWARDCONTENT]];
 
        // 转发的是图片
        long long timeMills = [NSDate currentTimeMillis];
        
        NSDictionary *messageDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",timeMills],@"file",[NSNumber numberWithInt:kWCMessageTypeImage],@"messageType", [CommonUtil getValueByKey:FORWARDCONTENT],@"text", nil];
        
        NSString *msgJson = [messageDic JSONRepresentation];
        
        self.m_message.text = @"";
        
        //生成消息对象
        XMPPMessage *mes1 = [XMPPMessage messageWithType:@"chat" to:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@home.cityandcity.com",self.m_chatPerson.userId]]];
        
        [mes1 addChild:[DDXMLNode elementWithName:@"body" stringValue:msgJson]];
        
        //发送消息
        [[XMPPManager sharedInstance] sendMessage:mes1];
        
        [self.m_tableView reloadData];

    }else{
        
        
        
    }
   
}

- (void)CleanChattingMessage{
    // 清空聊天记录
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"确定清空该联系人的聊天记录？"
                                                      delegate:self cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    alertView.tag = 10930;
    [alertView show];
    
}

- (IBAction)sendClicked:(id)sender {
    
    [CommonUtil addValue:@"0" andKey:kFromMessage];
    [CommonUtil addValue:@"" andKey:kFriendFlag];

    
    NSString *message = self.m_message.text;
    
    if ( message.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"内容不能为空"];
        
        return;
    }
    
    if ([message rangeOfString:@"/"].location != NSNotFound) {
       
        for (NSString *each in Appdelegate.emotionJsonsKeyIsText) {
          
            NSString *fullKey = [[NSString alloc] initWithFormat:@"/%@:",each];
            
            if ([message rangeOfString:fullKey].location != NSNotFound) {
                NSString *fullCode = [[NSString alloc] initWithFormat:@"/:HH%@:",[Appdelegate.emotionJsonsKeyIsText objectForKey:each]];
               
                message = [message stringByReplacingOccurrencesOfString:fullKey withString:fullCode];

            }

        }
    }
    
    
    
    NSString *base64utf8 = [GTMBase64 base64StringBystring:message];
    
    NSDate *date = [NSDate date];
    
    // 将日期转换成字符
    NSString *dateString = [self stringFromDate:date];
    
    NSLog(@"date = %@,dateString = %@",date,dateString);
    
    NSDictionary *messageDic = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"file",[NSNumber numberWithInt:kWCMessageTypePlain],@"messageType", base64utf8,@"text",dateString,@"dateKey", nil];
    
    NSString *msgJson = [messageDic JSONRepresentation];
    
    self.m_message.text = @"";
    
   
    if ( self.group ) {
        
        //生成消息对象
        XMPPMessage *mes1 = [XMPPMessage messageWithType:@"groupchat" to:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@",self.group.groupId]]];
        
        [mes1 addChild:[DDXMLNode elementWithName:@"body" stringValue:msgJson]];
        
        //发送消息
        [[XMPPManager sharedInstance] sendGroupMessage:mes1 withGroup:self.group];
        
        [self.m_tableView reloadData];
        
        
    }else{
        
        //生成消息对象
        XMPPMessage *mes1 = [XMPPMessage messageWithType:@"chat" to:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@home.cityandcity.com",self.m_chatPerson.userId]]];
        
        [mes1 addChild:[DDXMLNode elementWithName:@"body" stringValue:msgJson]];
        
        //发送消息
        [[XMPPManager sharedInstance] sendMessage:mes1];
        
        [self.m_tableView reloadData];
    }
    
    

}

// 选择图片
- (IBAction)choosePicture:(id)sender {
    
    // 如果是录音模式下的话，则恢复成非录音的模式
    if ( self.isVoiceMode ) {
        
        self.isVoiceMode = NO;
        
        [self.m_voiceBtn setImage:[UIImage imageNamed:@"voice_normal.png"] forState:UIControlStateNormal];
        
        [self.m_voiceBtn setImage:[UIImage imageNamed:@"voice_selected.png"] forState:UIControlStateSelected];
        
        [self.m_voiceTapBtn setHidden:YES];
        
        [self.m_message setHidden:NO];
    }
    
    [self.m_message setInputView:self.m_message.inputView ? nil: m_moreView];
    
    [self.m_message reloadInputViews];
    [self.m_message becomeFirstResponder];
    
        
}
// 开始录音
- (IBAction)voiceBtnClicked:(id)sender {
    
    self.m_voiceView.hidden = NO;
    
    [self.m_voiceTapBtn setTitle:@"松开结束" forState:UIControlStateNormal];
    
    BOOL recording = [self startRecording];
    
    if( recording ){
        // 录音的动画
        NSMutableArray *imgArr = [[NSMutableArray alloc]initWithCapacity:0];
        
        for ( int i = 0; i<= 3; i++) {
            NSString *imgName;
            
            imgName = [NSString stringWithFormat:@"mai%i.png",i + 1];
            
            [imgArr addObject:[UIImage imageNamed:imgName]];
        }
 
        self.m_tipImagV.animationImages = imgArr;
        self.m_tipImagV.animationDuration = 1.0;
        [self.m_tipImagV startAnimating];
        
    }

}

// 停止录音
- (IBAction)voiceStop:(id)sender {
    
    [CommonUtil addValue:@"0" andKey:kFromMessage];
    [CommonUtil addValue:@"" andKey:kFriendFlag];

    self.m_voiceView.hidden = YES;
    
    [self.m_tipImagV stopAnimating];

    
    [self.m_voiceTapBtn setTitle:@"按住说话" forState:UIControlStateNormal];
    
    NSData *data = [self stopRecording];
   
    if(data == nil){
        return ;
    }

    if (data.length == 4096) {
        [SVProgressHUD showErrorWithStatus:@"录音失败,时间太短"];
        
        if ( isIOS7 ) {
            
            for(UIView *view in self.tabBarController.view.subviews)
            {
                
                if([view isKindOfClass:[UITabBar class]])
                {
                    
                    if (self.tabBarController.tabBar.hidden) {
                        [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width, 0)];
                    }
                }
            }

        }
        return;
    }
    
    

    self.m_dataFile = data;
    
    
    if ( self.group ) {
    
        // 将data转换成string发送
        NSString *text = [NSString stringWithFormat:@"%@",[data base64EncodedString]];
        
        long long timeMills = [NSDate currentTimeMillis];
        
        
        NSDate *date = [NSDate date];
        
        // 将日期转换成字符
        NSString *dateString = [self stringFromDate:date];
        
        NSDictionary *messageDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",timeMills],@"file",[NSNumber numberWithInt:kWCMessageTypeVoice],@"messageType", text,@"text",dateString,@"dateKey", nil];
        
        NSString *msgJson = [messageDic JSONRepresentation];
        
        
        // 群聊
        
        //生成消息对象
        XMPPMessage *mes1 = [XMPPMessage messageWithType:@"groupchat" to:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@",self.group.groupId]]];
        
        [mes1 addChild:[DDXMLNode elementWithName:@"body" stringValue:msgJson]];
        
        //发送消息
        [[XMPPManager sharedInstance] sendGroupMessage:mes1 withGroup:self.group];
        
        
    }else{
       
        
        // 将data转换成string发送
        NSString *text = [NSString stringWithFormat:@"%@",[data base64EncodedString]];
        
        long long timeMills = [NSDate currentTimeMillis];
        
        NSDictionary *messageDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",timeMills],@"file",[NSNumber numberWithInt:kWCMessageTypeVoice],@"messageType", text,@"text", nil];
        
        NSString *msgJson = [messageDic JSONRepresentation];
        
        //生成消息对象
        XMPPMessage *mes1 = [XMPPMessage messageWithType:@"chat" to:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@home.cityandcity.com",self.m_chatPerson.userId]]];
        
        [mes1 addChild:[DDXMLNode elementWithName:@"body" stringValue:msgJson]];
        
        //发送消息
        [[XMPPManager sharedInstance] sendMessage:mes1];

    }
    
    [self refresh];
    
    //发送出去提示声音 (包含这值说明有新的消息发送过来)
    NSBundle *mainBundle = [NSBundle mainBundle];
    self.soundToPlay = [NSURL fileURLWithPath:[mainBundle pathForResource:@"3885" ofType:@"mp3"] isDirectory:YES];
    if ( [self soundToPlay] != nil) {
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[self soundToPlay], &beepSound);
        if (error != kAudioServicesNoError) {
            NSLog(@"Problem loading nearSound.caf");
        }
    }
    if (beepSound != (SystemSoundID)-1) {
        AudioServicesPlaySystemSound(beepSound);
    }
    

}

// 录音还是键盘的模式选择
- (IBAction)voiceChooseClicked:(id)sender {
    
    self.isVoiceMode = !self.isVoiceMode;
    
    if ( self.isVoiceMode ) {
        
        [self.m_voiceBtn setImage:[UIImage imageNamed:@"jianpan_normal.png"] forState:UIControlStateNormal];

        [self.m_voiceBtn setImage:[UIImage imageNamed:@"jianpan_selected.png"] forState:UIControlStateSelected];
        
        [self.m_voiceTapBtn setHidden:NO];
        
        [self.m_message setHidden:YES];
        
        if ( [self.m_message isFirstResponder]  ) {
            
            [self.m_message resignFirstResponder];
        }
       

    }else{
        
        [self.m_voiceBtn setImage:[UIImage imageNamed:@"voice_normal.png"] forState:UIControlStateNormal];
        
        [self.m_voiceBtn setImage:[UIImage imageNamed:@"voice_selected.png"] forState:UIControlStateSelected];
       
        [self.m_voiceTapBtn setHidden:YES];
        
        [self.m_message setHidden:NO];

    }
    
}

- (IBAction)chooseEmotionClicked:(id)sender {
    
    
    // 如果是录音模式下的话，则恢复成非录音的模式
    if ( self.isVoiceMode ) {
        
        self.isVoiceMode = NO;
        
        [self.m_voiceBtn setImage:[UIImage imageNamed:@"voice_normal.png"] forState:UIControlStateNormal];
        
        [self.m_voiceBtn setImage:[UIImage imageNamed:@"voice_selected.png"] forState:UIControlStateSelected];
        
        [self.m_voiceTapBtn setHidden:YES];
        
        [self.m_message setHidden:NO];
    }

    
    [self.m_message setInputView:self.m_message.inputView ? nil: m_emotionView];

//    [self.m_message setInputView:m_emotionView];
    
    [self.m_message reloadInputViews];
    [self.m_message becomeFirstResponder];
}

//==录音方法-测试==
- (BOOL) startRecording{
    
    if ( self.m_recorder.recording ) {
        return NO;
    }
    
    [self.m_recorder prepareToRecord];
    [self.m_recorder record];
    
    return YES;
}



- (NSData *) stopRecording{
    
    [self.m_recorder stop];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
    NSURL *url = [NSURL fileURLWithPath:m_recorderFilePath];
    NSError *err = nil;
    NSData *audioData = [NSData dataWithContentsOfFile:[url path] options: 0 error:&err];
    if(!audioData){
        NSLog(@"audio data err: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
    }
    self.m_recorder.delegate = nil;

    self.m_recorder = nil;
    m_prepareToRecord = NO;
    [self setupRecordDevice];
    
    return audioData;
}

- (void) setupRecordDevice{
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    // 添加这句用于5.0.1以上的录音
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    [audioSession setActive:NO error:nil];
    static NSMutableDictionary *recordSetting = nil;
    if(nil == recordSetting){
        recordSetting = [[NSMutableDictionary alloc] init];
        //        [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatAppleIMA4] forKey:AVFormatIDKey];
        [recordSetting setValue:[NSNumber numberWithFloat:4410.0] forKey:AVSampleRateKey];
        [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
        [recordSetting setValue :[NSNumber numberWithInt:16] forKey:AVEncoderBitRateKey];
        [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
        [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    }
    
    // Create a new dated file
    
    NSArray *_cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *_cacheDirectory = [_cachePaths objectAtIndex:0];

    m_recorderFilePath = [_cacheDirectory stringByAppendingPathComponent:@"/temp.wav"];
    
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:m_recorderFilePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:m_recorderFilePath error:nil];
    }
    NSURL *url = [NSURL fileURLWithPath:m_recorderFilePath];
    
    m_recorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:nil];
    if (nil) {
        NSLog(@"error when init recorder");
    }
    if( !m_recorder ){
        return;
    }
    //prepare to record
    [m_recorder setDelegate:self];
    m_prepareToRecord = YES;
}


- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *) aRecorder
                           successfully:(BOOL)flag{
    
    NSLog (@"audioRecorderDidFinishRecording:successfully: %@", flag ? @"yes" : @"no");
    // your actions here
    
}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *) somePlayer successfully:(BOOL)flag{
    
    NSLog(@"player finish %@",flag ? @"yes" : @"no");

    // 播放结束后停止播放语音======
    MessageListCell *cell = (MessageListCell *)[self.m_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.m_index inSection:0]];
    
    if ( [cell._animationImagV isAnimating] ) {
        
        [cell._animationImagV stopAnimating];
        
        cell._animationImagV.hidden = YES;
        
        cell._voiceImage.hidden = NO;
    }

}

//======
#pragma-mark 拍照选择照片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    // 页面退出后进行一些操作
    [self dismissViewControllerAnimated:YES completion:^{
        
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        
        if ([mediaType isEqualToString:@"public.image"]){
            
            //        UIImage *originImage = [info objectForKey:UIImagePickerControllerEditedImage];
            
            // 判断当前设备的分辨率
            //        UIScreen *MainScreen = [UIScreen mainScreen];
            //        CGSize Size = [MainScreen bounds].size;
            //        CGFloat scale = [MainScreen scale];
            //        CGFloat screenWidth = Size.width * scale;
            //        CGFloat screenHeight = Size.height * scale;
            
            //        UIImage *scaleImage = [self scaleImage:originImage toScale:0.3];
            
            
            [CommonUtil addValue:@"0" andKey:kFromMessage];
            [CommonUtil addValue:@"" andKey:kFriendFlag];

            
            UIImage *originImage1 = [info objectForKey:UIImagePickerControllerOriginalImage];
            
            
            UIImageView *imgV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 330, originImage1.size.height / originImage1.size.width * 330)];
            
            imgV1.image = [CommonUtil scaleImage:originImage1 toSize:CGSizeMake(330, originImage1.size.height / originImage1.size.width * 330)];
            
            NSData *data = [self getImageData:imgV1];
            
            NSString *text = [[NSString alloc] initWithFormat:@"%@",[data base64EncodedString]];
            
            long long timeMills = [NSDate currentTimeMillis];
            
            NSDate *date = [NSDate date];
            
            // 将日期转换成字符
            NSString *dateString = [self stringFromDate:date];
           
            NSDictionary *messageDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%lld",timeMills],@"file",[NSNumber numberWithInt:kWCMessageTypeImage],@"messageType", text,@"text", dateString,@"dateKey", nil];
            
            NSString *msgJson = [messageDic JSONRepresentation];
            
            if ( self.group ) {
                
                // 群聊
                //生成消息对象
                XMPPMessage *mes1 = [XMPPMessage messageWithType:@"groupchat" to:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@",self.group.groupId]]];
                
                [mes1 addChild:[DDXMLNode elementWithName:@"body" stringValue:msgJson]];
                
                //发送消息
                [[XMPPManager sharedInstance] sendGroupMessage:mes1 withGroup:self.group];
                
                [self refresh];
           
            }else{
                
                //生成消息对象
                XMPPMessage *mes1 = [XMPPMessage messageWithType:@"chat" to:[XMPPJID jidWithString:[NSString stringWithFormat:@"%@@home.cityandcity.com",self.m_chatPerson.userId]]];
                
                [mes1 addChild:[DDXMLNode elementWithName:@"body" stringValue:msgJson]];
                
                //发送消息
                [[XMPPManager sharedInstance] sendMessage:mes1];
                
                [self refresh];
             
            }
          
        }
        
    }];
    
    
    if ( isIOS7 ) {
        
        
    }else{
        
        [self.view endEditing:YES];
        
        [self.m_tableView setContentOffset:CGPointMake(0, 0)];
        
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    if ( isIOS7 ) {
        
        
    }else{
        
        [self.view endEditing:YES];
        
        [self.m_tableView setContentOffset:CGPointMake(0, 0)];
    
    }
    
}


- (NSData *)getImageData:(UIImageView *)imageView {
    UIImage *iamge = imageView.image;
    return UIImageJPEGRepresentation(iamge, 1);
}

#pragma mark- 缩放图片
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    
    // 计算图片显示的大小
    float height = image.size.width / 50.0f;
    
    UIGraphicsBeginImageContext(CGSizeMake(50,image.size.height / height));
    [image drawInRect:CGRectMake(0, 0, 50, image.size.height / height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return scaledImage;
}

// 点击某行图片触发的事件
- (void)imageClicked:(id)sender{
    
    if ( [self.m_message isFirstResponder] ) {
        
        [self.m_message resignFirstResponder];
    }
    
    self.isSelectedPicture = YES;

    UIButton *btn = (UIButton *)sender;
    
    MessageObject *msg = [self.m_recordList objectAtIndex:btn.tag];
    
    // 进入查看图片的页面
    
    LookImageViewController *VC = [[LookImageViewController alloc]initWithNibName:@"LookImageViewController" bundle:nil];
    VC.m_imageString =  msg.messageContent;
    
    [self presentViewController:VC animated:NO completion:nil];
}

// 点击某行播放语音
- (void)voiceClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    //== 先将开始的上一个录音暂停播放，在播放下一个
    MessageListCell *cell = (MessageListCell *)[self.m_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.m_index inSection:0]];
    
    
    if ( [cell._animationImagV isAnimating] ) {
        
        [cell._animationImagV stopAnimating];
        
        cell._animationImagV.hidden = YES;
        
        cell._voiceImage.hidden = NO;
    }

    // =====
    
    self.m_index = btn.tag;
    
    MessageObject *msg = [self.m_recordList objectAtIndex:btn.tag];

    NSArray *strs = [[[NSUserDefaults standardUserDefaults]stringForKey:kXMPPmyJID] componentsSeparatedByString:@"@"];
    
    enum kWCMessageCellStyle style = [msg.messageFrom isEqualToString:strs[0]]?kWCMessageCellStyleMeWithVoice:kWCMessageCellStyleOtherWithVoice;
    
    ///==========
    MessageListCell *cell1 = (MessageListCell *)[self.m_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:btn.tag inSection:0]];
    
    cell1._animationImagV.hidden = NO;
    cell1._voiceImage.hidden = YES;

    cell1._animationImagV.backgroundColor =[UIColor clearColor];
    
    
    NSMutableArray *imgArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    // 判断是我发的还是对方发来的
    if ( style == kWCMessageCellStyleMeWithVoice ) {
        
        for ( int i = 0; i<= 3; i++) {
            NSString *imgName;
            
            imgName = [NSString stringWithFormat:@"SenderVoicePlay0%i.png",i];
            
            [imgArr addObject:[UIImage imageNamed:imgName]];
        }
        
    }else{
        
        for ( int i = 0; i<= 3; i++) {
            NSString *imgName;
            
            imgName = [NSString stringWithFormat:@"ReceiverVoicePlay0%i.png",i];
            
            [imgArr addObject:[UIImage imageNamed:imgName]];
            
        }
    }
    
    cell1._animationImagV.animationImages = imgArr;
    cell1._animationImagV.animationDuration = 1.0;
    [cell1._animationImagV startAnimating];
    
    //=========
    
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:msg.messageContent]){

        return;
    }

    NSURL *fileUrl = [NSURL fileURLWithPath:msg.messageContent isDirectory:NO];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory :AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
    NSError *err = nil;
    

    if ( style == kWCMessageCellStyleMeWithVoice ) {
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:&err];
        
    }else{
     
        NSMutableData * data = [[NSMutableData alloc]initWithContentsOfURL:fileUrl];

        player = [[AVAudioPlayer alloc]initWithData:DecodeAMRToWAVE(data) error:&err];

        if (player == nil||err) {
                
            player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:&err];
  
            }

    }

    
    if (err) {
        NSLog(@"err %@",err);
    }
    player.delegate=self;
    if (player == nil) {
        
        return;
   
    }

    
    [player prepareToPlay];
    
    {
        //    UInt32 audioRouteOverride = slientMode ?
        //    kAudioSessionOverrideAudioRoute_None:kAudioSessionOverrideAudioRoute_Speaker;
        
        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
        
        AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute, sizeof(audioRouteOverride), &audioRouteOverride);
    }
    BOOL start = [player play];
    
    if (start) {
        
        
    }
    
}



#pragma mark ---触摸关闭键盘----
- (void)handleTap:(UIGestureRecognizer *)gesture
{
    
    [self.view endEditing:YES];
}

#pragma mark ----键盘高度变化------
-(void)changeKeyBoard:(NSNotification *)aNotifacation
{
    
    //获取到键盘frame 变化之前的frame
    NSValue *keyboardBeginBounds = [[aNotifacation userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect = [keyboardBeginBounds CGRectValue];
    
    //获取到键盘frame变化之后的frame
    NSValue *keyboardEndBounds = [[aNotifacation userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect endRect = [keyboardEndBounds CGRectValue];
    
    CGFloat deltaY = endRect.origin.y-beginRect.origin.y;
    //拿frame变化之后的origin.y-变化之前的origin.y，其差值(带正负号)就是我们self.view的y方向上的增量
    
    [CATransaction begin];
    [UIView animateWithDuration:0.4f animations:^{
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+deltaY, self.view.frame.size.width, self.view.frame.size.height)];
        [self.m_tableView setContentInset:UIEdgeInsetsMake(self.m_tableView.contentInset.top - deltaY, 0, 0, 0)];
        
    } completion:^(BOOL finished) {
        
    }];
    [CATransaction commit];
    
}

//send
#pragma mark  接受新消息广播
- (void)SendnewMsgCome:(NSNotification *)notifacation
{
    [self.tabBarController.tabBarItem setBadgeValue:@"1"];
    
    //[WCMessageObject save:notifacation.object];
    
    [self refresh];
    
}
//send
- (void)refresh
{
    
    if ( !self.group ) {
        
        // 在聊天的页面后将未读消息的状态转换成已读的状态
        [MessageObject updateMessage:self.m_chatPerson.userId];
        
        self.m_recordList = [MessageObject fetchMessageListWithUser:self.m_chatPerson.userId byPage:1];

        
        
    }else{
        
        // 在聊天的页面后将未读消息的状态转换成已读的状态
        [GroupChatObject updateMessage:self.group.groupIdMain];
        
        self.m_recordList = [GroupChatObject fetchGroupList:self.group.groupIdMain byPage:1];
        
    }
    
    
    if ( self.m_recordList.count != 0 ) {
        
        [self.m_tableView reloadData];
        
        [self.m_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.m_recordList.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        
        // 判断是群聊还是个人聊天
        if ( self.group ) {
            
//             [self setRightButtonWithNormalImage:@"xxqd.png" withTitle:@"退出" action:@selector(exitClicked)];
            
            
            [self setRightButtonWithNormalImage:@"group_user.png" action:@selector(exitClicked)];

            
            
            
            
        }else{
            
            // 数组不为空时就设置导航栏的右按钮-清空
            [self setRightButtonWithNormalImage:@"xxqd.png" withTitle:@"清空" action:@selector(CleanChattingMessage)];
        }
        
    }else{
        
        // 判断是群聊还是个人聊天
        if ( self.group ) {
            
            [self setRightButtonWithNormalImage:@"xxqd.png" withTitle:@"退出" action:@selector(exitClicked)];
            
        }else{
          
            // 数组为空时设置导航栏右按钮为空
            self.navigationController.navigationItem.rightBarButtonItem = nil;

        
        }
    }

    
    
    [SVProgressHUD dismiss];
    
}

- (void)exitClicked{
    
    // 进入群的详细信息类
    ChatDetailViewController *VC = [[ChatDetailViewController alloc]initWithNibName:@"ChatDetailViewController" bundle:nil];
    
    NSLog(@"self.group.members = %@",self.group.members);
    
    VC.group = self.group;
    VC.m_typeString = self.m_typeFrom;
    [self.navigationController pushViewController:VC animated:YES];

}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_recordList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"friendCell";
   
    MessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if ( !cell ) {
        
        cell = [[MessageListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
   
    }
    
    cell.tag = indexPath.row;
    
    if ( !self.group ) {
        
        MessageObject *msg = [self.m_recordList objectAtIndex:indexPath.row];
        
        //    [cell setMessageObject:msg];
        
        NSArray *strs = [[[NSUserDefaults standardUserDefaults]stringForKey:kXMPPmyJID] componentsSeparatedByString:@"@"];
        
        
        enum kWCMessageCellStyle style = [msg.messageFrom isEqualToString:strs[0]] ? kWCMessageCellStyleMe : kWCMessageCellStyleOther;
        
        switch (style) {
            case kWCMessageCellStyleMe:
                [cell setHeadImageWithPath:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_Head] tag:indexPath.row];
                
                break;
            case kWCMessageCellStyleOther:
                [cell setHeadImageWithPath:self.m_chatPerson.userHead tag:indexPath.row];
                break;
            case kWCMessageCellStyleMeWithImage:
            {
                [cell setHeadImageWithPath:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_Head] tag:indexPath.row];
                
            }
                break;
            case kWCMessageCellStyleOtherWithImage:{
                [cell setHeadImageWithPath:self.m_chatPerson.userHead tag:indexPath.row];
            }
                break;
                
            case kWCMessageCellStyleMeWithVoice:
            {
                [cell setHeadImageWithPath:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_Head] tag:indexPath.row];
                
            }
                break;
            case kWCMessageCellStyleOtherWithVoice:{
                [cell setHeadImageWithPath:self.m_chatPerson.userHead tag:indexPath.row];
            }
                break;
                
            default:
                break;
        }
        
        if ( [msg.messageType intValue] == kWCMessageTypeImage ) {
            
            cell.delegate = nil;
            
            // 图片
            style = style == kWCMessageCellStyleMe ? kWCMessageCellStyleMeWithImage:kWCMessageCellStyleOtherWithImage;
            
            
            [cell setChatImage:msg.messageContent tag:indexPath.row];
            
            cell._imageBtn.tag = indexPath.row;
            [cell._imageBtn addTarget:self action:@selector(imageClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            
            // 添加长按的手势
            UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandle:)];
            [recognizer setMinimumPressDuration:0.4f];
            [cell._imageBtn addGestureRecognizer:recognizer];
            
            
        }else if ( [msg.messageType intValue] == kWCMessageTypeVoice ){
            
            cell.delegate = nil;
            
            // 语音
            
            style = style == kWCMessageCellStyleMe ? kWCMessageCellStyleMeWithVoice:kWCMessageCellStyleOtherWithVoice;
            
            cell._voiceBtn.tag = indexPath.row;
            [cell._voiceBtn addTarget:self action:@selector(voiceClicked:) forControlEvents:UIControlEventTouchUpInside];
            
        }else if ( [msg.messageType intValue] == kWCMessageTypePlain ) {
            
            cell.delegate = self;
            
            cell._messageConent.tag = indexPath.row;
            
            NSString *coreText = [self toCoreText:msg.messageContent];
            
            [cell setContent:coreText withRow:indexPath.row];
            
        }
        
        cell._timeLabel.text = [self stringFromDate:msg.messageDate];
        
        [cell setMsgStyle:style];
        
        
        
        

    }else{
        
        
        // 群聊赋值
        
        GroupChatObject *msg = [self.m_recordList objectAtIndex:indexPath.row];
        
        //    [cell setMessageObject:msg];
        
        NSArray *strs = [[[NSUserDefaults standardUserDefaults]stringForKey:kXMPPmyJID] componentsSeparatedByString:@"@"];
        
        
        enum kWCMessageCellStyle style = [msg.messageFrom isEqualToString:strs[0]] ? kWCMessageCellStyleMe : kWCMessageCellStyleOther;
        
        switch (style) {
            case kWCMessageCellStyleMe:
                [cell setHeadImageWithPath:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_Head] tag:indexPath.row];
                
                break;
            case kWCMessageCellStyleOther:
                                
                [cell setHeadImageWithPath:msg.messageImageV tag:indexPath.row];
                break;
            case kWCMessageCellStyleMeWithImage:
            {
                [cell setHeadImageWithPath:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_Head] tag:indexPath.row];
                
            }
                break;
            case kWCMessageCellStyleOtherWithImage:{
                [cell setHeadImageWithPath:msg.messageImageV tag:indexPath.row];
            }
                break;
                
            case kWCMessageCellStyleMeWithVoice:
            {
                [cell setHeadImageWithPath:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_Head] tag:indexPath.row];
                
            }
                break;
            case kWCMessageCellStyleOtherWithVoice:{
                [cell setHeadImageWithPath:msg.messageImageV tag:indexPath.row];
            }
                break;
                
            default:
                break;
        }
        
        if ( [msg.messageType intValue] == kWCMessageTypeImage ) {
            
            cell.delegate = nil;
            
            // 图片
            style = style == kWCMessageCellStyleMe ? kWCMessageCellStyleMeWithImage:kWCMessageCellStyleOtherWithImage;
            
            
            [cell setChatImage:msg.messageContent tag:indexPath.row];
            
            cell._imageBtn.tag = indexPath.row;
            [cell._imageBtn addTarget:self action:@selector(imageClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            
            // 添加长按的手势
            UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandle:)];
            [recognizer setMinimumPressDuration:0.4f];
            [cell._imageBtn addGestureRecognizer:recognizer];
            
            
        }else if ( [msg.messageType intValue] == kWCMessageTypeVoice ){
            
            cell.delegate = nil;
            
            // 语音
            
            style = style == kWCMessageCellStyleMe ? kWCMessageCellStyleMeWithVoice:kWCMessageCellStyleOtherWithVoice;
            
            cell._voiceBtn.tag = indexPath.row;
            [cell._voiceBtn addTarget:self action:@selector(voiceClicked:) forControlEvents:UIControlEventTouchUpInside];
            
        }else if ( [msg.messageType intValue] == kWCMessageTypePlain ) {
            
            cell.delegate = self;
            
            cell._messageConent.tag = indexPath.row;
            
            NSString *coreText = [self toCoreText:msg.messageContent];
            
            [cell setContent:coreText withRow:indexPath.row];
            
            
        }
        
        
        cell._timeLabel.text = [self stringFromDate:msg.messageDate];
        
        [cell setMsgStyle:style];
        
        
        NSLog(@"from = %@,to = %@,date = %@",msg.messageFrom,msg.messageTo,msg.messageDate);


        
    }
    // 头像点击触发的事件
    cell._headBtn.tag = indexPath.row;
    
    [cell._headBtn addTarget:self action:@selector(clickedHead:) forControlEvents:UIControlEventTouchUpInside];
    
    
    

    
    return cell;
}


- (void)longPressHandle:(UITapGestureRecognizer *)longPressGestureRecognizer
{
    
    if (longPressGestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
 
    // 判断出是哪一行的长按手势
    CGPoint point = [longPressGestureRecognizer locationInView:self.m_tableView];
    NSIndexPath *indexPath = [self.m_tableView indexPathForRowAtPoint:point];
   
    // 实现转发、删除图片的功能
    [self showImageForwarding:[NSString stringWithFormat:@"%i",indexPath.row]];
    
}

// 将表情字符转换成可以识别到的字符
- (NSString *) toCoreText:(NSString *)text{
   
    NSString *result = text;
    
    while (true) {
        
        NSRange range = [result rangeOfString:@"/:HH"];
        
        if (range.location == NSNotFound ) {

            break;
        }
        
        //====
        // 判断字符的长度用于删除字符时做的处理
        if ( result.length < range.location + 8 ) {
           
            break;
        }
        //====
        
        NSString *endString = [result substringWithRange:NSMakeRange(range.location+7, 1)];
        
        if(nil == endString || NO == [@":" isEqualToString:endString]){

            break;
        }
        
        NSString *tag = [result substringWithRange:NSMakeRange(range.location + 4, 3)];
       
        NSString *imageName = [[NSString alloc] initWithFormat:@"f%@.png",tag];
        
        if (nil == [UIImage imageNamed:imageName]) {

            break;
        }
        
        NSString *rawTag = [[NSString alloc] initWithFormat:@"/:HH%@:",tag];
        NSString *coreTag = [[NSString alloc] initWithFormat:@"<img src='%@'/ width='24' height='24'>",imageName];
        result = [result stringByReplacingOccurrencesOfString:rawTag withString:coreTag];
    }
    
    
    return result;
}

- (void)showImageForwarding:(NSString *)aIndex{
    
//    UIMenuController *menu = [UIMenuController sharedMenuController];
//    
//    if ( menu.menuItems.count != 0 ) {
//        
//        menu.menuItems = nil;
//        
//    }

    
    
    [self.view endEditing:YES];
   
    self.m_longIndex = [aIndex integerValue];
//

     // 设置点击某行所在的坐标
    CGRect rectInTableView = [self.m_tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:[aIndex integerValue] inSection:0]];
    CGRect rectInSuperview = [self.m_tableView convertRect:rectInTableView toView:[self.m_tableView superview]];
    
    UIMenuItem *forwarding = [[UIMenuItem alloc] initWithTitle:NSLocalizedStringFromTable(@"转发", @"Message", @"转发") action:@selector(forwardingImageClicked:)];
    UIMenuItem *delete = [[UIMenuItem alloc] initWithTitle:NSLocalizedStringFromTable(@"删除", @"Message", @"删除") action:@selector(deleteClicked:)];
    
    [UIMenuController sharedMenuController].menuItems = [NSArray arrayWithObjects:delete, forwarding, nil];
    
    // 显示在计算好的位置
    [[UIMenuController sharedMenuController] setTargetRect:CGRectMake(rectInSuperview.origin.x, rectInSuperview.origin.y + 20, rectInSuperview.size.width, rectInSuperview.size.height)  inView:self.view];
    
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    
}

#pragma mark - LongPressDelegate
- (void)showCopyAndForwarding:(NSString *)aIndex{
    
    [self.view endEditing:YES];
    
    self.m_longIndex = [aIndex integerValue];
    
    // 设置点击某行所在的坐标
    CGRect rectInTableView = [self.m_tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:[aIndex integerValue] inSection:0]];
    CGRect rectInSuperview = [self.m_tableView convertRect:rectInTableView toView:[self.m_tableView superview]];
    
    UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:NSLocalizedStringFromTable(@"复制", @"Message", @"复制文本") action:@selector(copyClicked:)];
    UIMenuItem *forwarding = [[UIMenuItem alloc] initWithTitle:NSLocalizedStringFromTable(@"转发", @"Message", @"转发") action:@selector(forwardingClicked:)];
    UIMenuItem *delete = [[UIMenuItem alloc] initWithTitle:NSLocalizedStringFromTable(@"删除", @"Message", @"删除") action:@selector(deleteClicked:)];
//     UIMenuItem *favorite = [[UIMenuItem alloc] initWithTitle:NSLocalizedStringFromTable(@"收藏", @"Message", @"收藏") action:@selector(favoriteClicked:)];
    [UIMenuController sharedMenuController].menuItems = [NSArray arrayWithObjects:copy,delete, forwarding, nil];

    
    // 显示在计算好的位置
    [[UIMenuController sharedMenuController] setTargetRect:CGRectMake(rectInSuperview.origin.x, rectInSuperview.origin.y + 20, rectInSuperview.size.width, rectInSuperview.size.height)  inView:self.view];
    
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    
}

#pragma mark -
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action
              withSender:(id)sender
{
    if (action == @selector(copyClicked:) ||
        action == @selector(forwardingClicked:) ||
        action == @selector(deleteClicked:))
        return YES;
    
    return [super canPerformAction:action withSender:sender];
}


- (void)copyClicked:(id)sender{
    
    MessageObject *msg = [self.m_recordList objectAtIndex:self.m_longIndex];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = msg.messageContent;
    
    [SVProgressHUD showSuccessWithStatus:@"消息已经复制到粘贴板"];

}

- (void)forwardingImageClicked:(id)sender{
    
    // 图片转发
    Appdelegate.isImageOrText = @"2";
    
    MessageObject *msg = [self.m_recordList objectAtIndex:self.m_longIndex];
    
    // 保存转发的内容
    [CommonUtil addValue:msg.messageContent andKey:FORWARDCONTENT];
    
    // 转发给某个好友
    FriendsListViewController *VC = [[FriendsListViewController alloc]initWithNibName:@"FriendsListViewController" bundle:nil];
    VC.m_typeString = @"2";
    VC.m_userId = self.m_chatPerson.userId;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)forwardingClicked:(id)sender{
    
    // 文本转发
    Appdelegate.isImageOrText = @"1";
    
    MessageObject *msg = [self.m_recordList objectAtIndex:self.m_longIndex];

    // 保存转发的内容
    [CommonUtil addValue:msg.messageContent andKey:FORWARDCONTENT];
    
    // 转发给某个好友
    FriendsListViewController *VC = [[FriendsListViewController alloc]initWithNibName:@"FriendsListViewController" bundle:nil];
    VC.m_typeString = @"2";
    VC.m_userId = self.m_chatPerson.userId;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)deleteClicked:(id)sender{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"确定删除"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    alertView.tag = 11000;
    [alertView show];
    
}

/*- (void)favoriteClicked:(id)sender{
    
    [SVProgressHUD showErrorWithStatus:@"收藏"];
    
    
}*/

- (void)clickedHead:(id)sender{
    
    [self.view endEditing:YES];
    
    UIButton *btn = (UIButton *)sender;
    
    // 点击头像进入用户的详情页面
    MessageObject *msg = [self.m_recordList objectAtIndex:btn.tag];
    
    // 进入详细资料
    UserInformationViewController *VC = [[UserInformationViewController alloc]initWithNibName:@"UserInformationViewController" bundle:nil];
    VC.m_typeString = @"0";
    VC.m_chatString = @"1";
    ///// 好友Id================
    VC.m_friendId = [NSString stringWithFormat:@"%@",msg.messageFrom];
    [self.navigationController pushViewController:VC animated:YES];

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( [[self.m_recordList[indexPath.row] messageType]intValue] == kWCMessageTypeImage){
        
        return 155.0f;
    
    }else if( [[self.m_recordList[indexPath.row] messageType]intValue] == kWCMessageTypePlain ) {
    
        NSString *orgin = [self.m_recordList[indexPath.row]messageContent];
        
        CGSize textSize = [orgin sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake((320 - HEAD_SIZE - 3 * INSETS - 40), TEXT_MAX_HEIGHT) lineBreakMode:NSLineBreakByWordWrapping];
        
        return 55 + textSize.height;
   
    } else if( [[self.m_recordList[indexPath.row] messageType]intValue] == kWCMessageTypeVoice ) {
       
        return 75.0f;
        
    }else{
        
        return 0.0f;
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    // 修改bug-复制显示的黑色view多了自己定义的几个
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    if ( menu.menuItems.count != 0 ) {
        
        menu.menuItems = nil;
       
    }
  
    
    [self hiddenNumPadDone:nil];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    [self.m_message setInputView:nil];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
//    [textField resignFirstResponder];
    
    [self.m_message setInputView:nil];

    
    // 触发发送消息的方法
    [self sendClicked:nil];
    
    return YES;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 10930 ) {
        
        if ( buttonIndex == 1 ) {
            
            // 清空数据的时候将语音也清空
            for (int i = 0; i < self.m_recordList.count; i++) {
                MessageObject *messageObject = [self.m_recordList objectAtIndex:i];
                
                // 判断字符以wav结尾
                if ( [messageObject.messageContent hasSuffix:@".wav"] ) {
                    // 如果是wav语音的话，则删除保存的文件
                    if ([[NSFileManager defaultManager] fileExistsAtPath:messageObject.messageContent]) {
                        
                        [[NSFileManager defaultManager] removeItemAtPath:messageObject.messageContent error:nil];
                    }

                }
                
            }
            
            
            // 清空
            if ( [MessageObject deleteMessageFromUserId:self.m_chatPerson.userId] ) {
                
                if ( [MessageObject delereUserId:self.m_chatPerson.userId] ) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                    
                }
            }
          
        }
    }else if ( alertView.tag == 11000 ){
        
        if ( buttonIndex == 1 ) {
            
            if ( !self.group ) {
                
                // 删除
                MessageObject *msg = [self.m_recordList objectAtIndex:self.m_longIndex];
                
                // 删除某一条具体的聊天记录
                [MessageObject deleteMessageFromUserId:msg.messageFrom toUserId:msg.messageTo withDate:msg.messageDate];
                
                // 重新刷新聊天列表
                [self refresh];
                
                // 如果数组为空的话，则返回上一级页面
                if ( self.m_recordList.count == 0 ) {
                    
                    [self goBack];
                    
                }

            }else{
                
                
                // 群聊删除
                GroupChatObject *msg = [self.m_recordList objectAtIndex:self.m_longIndex];
                
                // 删除某一条具体的聊天记录
                [GroupChatObject deleteMessageFromUserId:msg.messageFrom toUserId:self.group.groupIdMain withDate:msg.messageDate];
                
                // 重新刷新聊天列表
                [self refresh];
                
                // 如果数组为空的话，则返回上一级页面
                if ( self.m_recordList.count == 0 ) {
                    
                    [self goBack];
                    
                }

            }
        }else{
            
            
        }
        
    }else{
        
        
        
    }
}

#pragma mark - MoreViewDelegate
- (void)pickPhotoWithTag:(NSString *)aTag{
    
    if ( [aTag isEqualToString:@"100"] ) {
        // 拍照
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        
        // 判断设备是否支持拍照
        if([[[UIDevice currentDevice] model] rangeOfString:@"iPhone Simulator"].location != NSNotFound) {
            
            self.isSelectedPicture = NO;
            
            // 取消第一响应
            if ( [self.m_message isFirstResponder] ) {
                
                [self.m_message resignFirstResponder];
            }
            
            [self alertWithMessage:@"本设备暂不支持拍照功能"];
            
        }else{
            
            self.isSelectedPicture = YES;

            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.allowsEditing = YES;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }

    }else if ( [aTag isEqualToString:@"101"] ){
        // 选取相册
        self.isSelectedPicture = YES;
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.allowsEditing = YES;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
        
    }else{
        
        
    }
    
    
    if ( [self.m_message isFirstResponder] ) {
        
        [self.m_message resignFirstResponder];
    }

    
    
}

- (void)RecordStatus:(int)status{
    
    
}

#pragma mark - Emotion
- (void)deleteEmotion{
    
    if (self.m_message.text.length>0) {
        if (self.m_message.text.length >= 3) {
            NSString *last = [self.m_message.text substringFromIndex:self.m_message.text.length-1];
            if ([last isEqualToString:@":"]) {
                NSString *last = [self.m_message.text substringFromIndex:self.m_message.text.length-3];
                int length =3;
                if ([last rangeOfString:@"/"].location != 0  && self.m_message.text.length >= 4) {
                    last = [self.m_message.text substringFromIndex:self.m_message.text.length-4];
                    length = 4;
                }
                if ([last rangeOfString:@"/"].location != 0 && self.m_message.text.length >= 5) {
                    last = [self.m_message.text substringFromIndex:self.m_message.text.length-5];
                    length = 5;
                }
                if ([last rangeOfString:@"/"].location != 0 && self.m_message.text.length >= 6) {
                    last = [self.m_message.text substringFromIndex:self.m_message.text.length-6];
                    length = 6;
                }
                if ([last rangeOfString:@"/"].location == 0) {
                    self.m_message.text = [self.m_message.text substringToIndex:self.m_message.text.length-length];
                    
//                    [self textViewDidChange:self.m_message];
                    
                    return;
                }
            }
        }
        
        self.m_message.text = [self.m_message.text substringToIndex:self.m_message.text.length-1];
        
//        [self textViewDidChange:self.m_message];
        
    }

    
}

- (void)sendEmotion{
    
    [self sendClicked:nil];

}

- (void)clickedEmotion:(NSString *)text{
    
    NSRange part = NSMakeRange(4, 3);
    NSString *partString = [text substringWithRange:part];
    
    NSString *partText = [Appdelegate.emotionJsonsKeyIsCode objectForKey:partString];
    
    if ( partText ) {
        
        text = [text stringByReplacingCharactersInRange:NSMakeRange(1, 6) withString:partText];
    }
    
    self.m_message.text = [self.m_message.text stringByAppendingString:text];

}


@end
