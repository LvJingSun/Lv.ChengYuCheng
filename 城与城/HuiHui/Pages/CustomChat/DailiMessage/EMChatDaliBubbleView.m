//
//  EMChatDaliBubbleView.m
//  HuiHui
//
//  Created by 冯海强 on 15-1-28.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "EMChatDaliBubbleView.h"

#import "Reachability.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
NSString *const kRouterEventDaliBubbleTapEventName = @"kRouterEventDaliBubbleTapEventName";

@implementation EMChatDaliBubbleView


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        _DaliView = [[UIView alloc]init];
        [_DaliView setFrame: CGRectMake(0, 0, DALI_VIEW_SIZE_WIDTH, DALI_VIEW_SIZE_HEIGHT)];
        _DaliView.backgroundColor = [UIColor whiteColor];
        _DaliView.layer.masksToBounds = YES; //没这句话它圆不起来
        _DaliView.layer.cornerRadius = 8.0; //设置图片圆角的尺度
        [self addSubview:_DaliView];
        //标题
        _DalititleLabel = [[UILabel alloc] init];
        _DalititleLabel.font = [UIFont systemFontOfSize:DALItitle_ADDRESS_LABEL_FONT_SIZE];
        _DalititleLabel.textColor = [UIColor blackColor];
        _DalititleLabel.numberOfLines = 0;
        _DalititleLabel.textAlignment = NSTextAlignmentCenter;
        _DalititleLabel.backgroundColor = [UIColor clearColor];
        [_DaliView addSubview:_DalititleLabel];
        //内容
        _DalicontentLabel = [[UILabel alloc] init];
        _DalicontentLabel.font = [UIFont systemFontOfSize:DALIcontent_ADDRESS_LABEL_FONT_SIZE];
        _DalicontentLabel.textColor = [UIColor blackColor];
        _DalicontentLabel.numberOfLines = 0;
        _DalicontentLabel.backgroundColor = [UIColor clearColor];
        [_DaliView addSubview:_DalicontentLabel];
        //谢后语
        _DaliopinionLabel = [[UILabel alloc] init];
        _DaliopinionLabel.font = [UIFont systemFontOfSize:14];
        _DaliopinionLabel.textColor = RGBACOLOR(200, 200, 200, 1);
        _DaliopinionLabel.text = @"感谢您的打评，我们会继续努力！";
        _DaliopinionLabel.textAlignment = NSTextAlignmentCenter;
        _DaliopinionLabel.numberOfLines = 1;
        _DaliopinionLabel.backgroundColor = [UIColor clearColor];
        [_DaliopinionLabel setFrame:CGRectMake(5, 95, DALI_VIEW_SIZE_WIDTH-10, DALI_VIEW_SIZE_HEIGHT-100)];
        _DaliopinionLabel.hidden = YES;
        [_DaliView addSubview:_DaliopinionLabel];
        //按钮组合视图
        _DalichoseView = [[UIView alloc]init];
        [_DalichoseView setFrame: CGRectMake(0, 90, DALI_VIEW_SIZE_WIDTH, DALI_VIEW_SIZE_HEIGHT-90)];
        _DalichoseView.backgroundColor = [UIColor whiteColor];
        [_DaliView addSubview:_DalichoseView];
        //水平线
        _Dalilevelline = [[UIImageView alloc]init];
        _Dalilevelline.backgroundColor = RGBACOLOR(210, 210, 210, 1);
        [_DaliView addSubview:_Dalilevelline];
        //垂直线
        _Daliverticalline = [[UIImageView alloc]init];
        _Daliverticalline.backgroundColor = RGBACOLOR(210, 210, 210, 1);
        [_DalichoseView addSubview:_Daliverticalline];
        //满意
        _DalileftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _DalileftBtn.backgroundColor = [UIColor clearColor];
        [_DalileftBtn setTitle:@"满意" forState:UIControlStateNormal];
        [_DalileftBtn setTitleColor:RGBACOLOR(100, 201, 201, 1) forState:UIControlStateNormal];
        [_DalileftBtn.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
        _DalileftBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        _DalileftBtn.tag =99;
        [_DalileftBtn addTarget:self action:@selector(ChoseBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_DalichoseView addSubview:_DalileftBtn];
        //不满意
        _DalirightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _DalirightBtn.backgroundColor = [UIColor clearColor];
        [_DalirightBtn setTitle:@"不满意" forState:UIControlStateNormal];
        [_DalirightBtn setTitleColor:RGBACOLOR(55, 180, 180, 1) forState:UIControlStateNormal];
        [_DalirightBtn.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
        _DalirightBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        _DalirightBtn.tag =100;
        [_DalirightBtn addTarget:self action:@selector(ChoseBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_DalichoseView addSubview:_DalirightBtn];

        [self Didloadplist];
    }
    return self;
}

-(CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(DALI_VIEW_SIZE_WIDTH, DALI_VIEW_SIZE_HEIGHT);
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    [_DalititleLabel setFrame:CGRectMake(5, 5, DALI_VIEW_SIZE_WIDTH - 10, 25)];
    
    if (self.model.isSender) {
        [_DalicontentLabel setFrame:CGRectMake(5, 30, DALI_VIEW_SIZE_WIDTH - 10, 60+35)];
    }else{
    [_DalicontentLabel setFrame:CGRectMake(5, 30, DALI_VIEW_SIZE_WIDTH - 10, 60)];
    }
    
    [_Dalilevelline setFrame:CGRectMake(0, 90, DALI_VIEW_SIZE_WIDTH, 1)];
    
    [_Daliverticalline setFrame:CGRectMake(DALI_VIEW_SIZE_WIDTH/2, 0, 1, DALI_VIEW_SIZE_HEIGHT-90)];

    [_DalileftBtn setFrame:CGRectMake(10, 2, (DALI_VIEW_SIZE_WIDTH-40)/2, DALI_VIEW_SIZE_HEIGHT-90)];

    [_DalirightBtn setFrame:CGRectMake(DALI_VIEW_SIZE_WIDTH/2+10, 2, (DALI_VIEW_SIZE_WIDTH-40)/2, DALI_VIEW_SIZE_HEIGHT-90)];

}

#pragma mark - setter
- (void)setModel:(MessageModel *)model
{
    [super setModel:model];
    
    _DalititleLabel.text =@"售后服务打评";
    _DalicontentLabel.text = model.Dalicontent;
    
    if (model.isSender) {
        _DalichoseView.hidden = YES;
        _DaliopinionLabel.hidden = YES;
        _Dalilevelline.hidden = YES;

    }else
    {
        //获取路径
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"DaliPingPlist.plist"];
        
        NSMutableDictionary *applist = [[[NSMutableDictionary alloc]initWithContentsOfFile:path]mutableCopy];
        
        if ([[applist objectForKey:self.model.DaliserviceId] isEqualToString:@"1"]) {
            _DalichoseView.hidden = YES;
            _DaliopinionLabel.hidden = NO;
        }else
        {
            _DalichoseView.hidden = NO;
            _DaliopinionLabel.hidden = YES;
        }
    }
}

#pragma mark - public
-(void)bubbleViewPressed:(id)sender
{
    [self routerEventWithName:kRouterEventDaliBubbleTapEventName userInfo:@{KMESSAGEKEY:self.model}];
} 

+(CGFloat)heightForBubbleWithObject:(MessageModel *)object
{
    return DALI_VIEW_SIZE_HEIGHT+5;
}

-(void)ChoseBtn:(id)Sender;
{
    UIButton *Btn = (UIButton *)Sender;
    switch (Btn.tag) {
        case 99:
            [self requestSubmitPing:@"4" anddescription:@"服务满意"];
            break;
        case 100:
            [self ChoseRightBtn];
            break;
            
        default:
            break;
    }

}


-(void)ChoseRightBtn
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"提点建议吧" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView cancelButtonIndex] != buttonIndex) {
        UITextField *messageTextField = [alertView textFieldAtIndex:0];
        if (messageTextField.text.length > 0) {
            
            [self requestSubmitPing:@"2" anddescription:messageTextField.text];
            
        }
    }
}

//记录 已经评介过了
-(void)writeToFileED
{
    //获取路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"DaliPingPlist.plist"];
    NSMutableDictionary *applist = [[[NSMutableDictionary alloc]initWithContentsOfFile:path]mutableCopy];
    [applist setValue:@"1" forKey:self.model.DaliserviceId];
    //写入文件
    [applist writeToFile:path atomically:YES];

}

//2：不满意 4：满意
- (void)requestSubmitPing:(NSString *)start anddescription:(NSString *)description{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.model.DaliserviceId,@"serviceId",
                           self.model.username,     @"fromMemberId",
                           start,@"star",
                           description,@"description",
                           nil];
    [httpClient request:@"FeedBackService.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [self writeToFileED];
            [self setModel:self.model];

        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"打评失败，请稍后再试"];
    }];
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
        [SVProgressHUD showErrorWithStatus:@"网络不给力，请稍后再试！"];
    }
    return isExistenceNetWork;
    
}


-(void)Didloadplist
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"DaliPingPlist.plist"];
    //判断是否以创建文件
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        //如果没有plist文件就自动创建
        NSMutableDictionary *dictplist = [[NSMutableDictionary alloc ] init];
        //写入文件
        [dictplist writeToFile:plistPath atomically:YES];
    }

}


@end
