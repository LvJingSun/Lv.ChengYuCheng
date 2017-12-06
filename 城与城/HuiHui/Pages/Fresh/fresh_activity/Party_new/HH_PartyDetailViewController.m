//
//  HH_PartyDetailViewController.m
//  HuiHui
//
//  Created by mac on 14-10-21.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "HH_PartyDetailViewController.h"

#import "MJPhoto.h"

#import "MJPhotoBrowser.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

#import "FriDynamicViewController.h"

#import "NSString+CXAHyperlinkParser.h"

#import "SignUpCell.h"




@interface HH_PartyDetailViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView       *m_scrollerView;

@property (weak, nonatomic) IBOutlet UILabel            *m_topicLabel;

@property (weak, nonatomic) IBOutlet UILabel            *m_nameLabel;

@property (weak, nonatomic) IBOutlet UILabel            *m_timeLabel;

@property (weak, nonatomic) IBOutlet UIView             *m_view;

@property (weak, nonatomic) IBOutlet UILabel            *m_detailLabel;

@property (weak, nonatomic) IBOutlet UIView             *m_photoView;

@property (weak, nonatomic) IBOutlet UIView             *m_addressView;

@property (weak, nonatomic) IBOutlet UILabel            *m_addressLabel;

@property (strong, nonatomic) IBOutlet UIView           *m_showView;

@property (weak, nonatomic) IBOutlet UIButton           *HuiHuiDyn;

@property (weak, nonatomic) IBOutlet UIButton           *HuiHuiFri;

@property (weak, nonatomic) IBOutlet UITableView        *m_tableView;

@property (strong, nonatomic) IBOutlet UIView           *m_commentView;

@property (weak, nonatomic) IBOutlet UITextField        *m_commentField;

@property (nonatomic, strong) UITextField               *m_textField;


// 进入地图显示的页面
- (IBAction)addressToMap:(id)sender;

- (IBAction)cancelShare:(id)sender;
// 发送评论的按钮事件
- (IBAction)sendCommentClicked:(id)sender;

@end

@implementation HH_PartyDetailViewController

@synthesize m_imageList;

@synthesize m_addressString;

@synthesize m_values;

@synthesize m_Funtions;

@synthesize m_keyTimes;

@synthesize m_zanList;

@synthesize m_signUpList;

@synthesize m_commentList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_imageList = [[NSMutableArray alloc]initWithCapacity:0];
    
        m_values = [[NSArray alloc]init];
        
        m_Funtions = [[NSArray alloc]init];
        
        m_keyTimes = [[NSArray alloc]init];
        
        m_zanList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_signUpList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_commentList = [[NSMutableArray alloc]initWithCapacity:0];

        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"活动"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithNormalImage:@"huihui_share.png" action:@selector(shareClicked)];
    
    // 设置scrollerView的滚动范围
    self.m_scrollerView.contentSize = CGSizeMake(self.m_scrollerView.frame.size.width , 800);
    
    
    //圆角
    [self.HuiHuiDyn.layer setMasksToBounds:YES];
    [self.HuiHuiDyn.layer setCornerRadius:10];
    
    //圆角
    [self.HuiHuiFri.layer setMasksToBounds:YES];
    [self.HuiHuiFri.layer setCornerRadius:10];
    
  
    // 初始化三个用于动画的数组
    NSArray *array = [[NSArray alloc]initWithObjects:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DIdentity], nil];
    
    NSArray *keyTimes = [[NSArray alloc]initWithObjects:@"0.2f",@"0.5f", @"0.75f", @"1.0f", nil];
    
    NSArray *funtions = [[NSArray alloc]initWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], nil];
    
    self.m_values = array;
    
    self.m_keyTimes = keyTimes;
    
    self.m_Funtions = funtions;
    
   
    // 设置view的边框
    self.m_view.layer.borderWidth = 1.0;
    self.m_view.layer.borderColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:208/255.0 alpha:1.0].CGColor;
    
    NSString *string = @"活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活";

    
    self.m_detailLabel.text = [NSString stringWithFormat:@"%@",string];
    // 赋值
    CGSize size = [self.m_detailLabel.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    self.m_detailLabel.frame = CGRectMake(self.m_detailLabel.frame.origin.x, self.m_detailLabel.frame.origin.y, self.m_detailLabel.frame.size.width, size.height);
    
    NSLog(@"addressString = %@",self.m_addressString);
    
    self.m_addressLabel.text = [NSString stringWithFormat:@"%@",self.m_addressString];
    
    // 判断没有图片的情况下
    if ( self.m_imageList.count == 0 ) {
        
        self.m_photoView.hidden = YES;
        
        // 判断没有地理位置的情况下
        if ( self.m_addressString.length != 0 ) {
            
            self.m_addressView.hidden = NO;
            
            // 计算view的坐标
            self.m_addressView.frame = CGRectMake(self.m_addressView.frame.origin.x, self.m_detailLabel.frame.size.height + self.m_detailLabel.frame.origin.y + 10, self.m_addressView.frame.size.width, self.m_addressView.frame.size.height);
            
            self.m_view.frame = CGRectMake(self.m_view.frame.origin.x, self.m_view.frame.origin.y, self.m_view.frame.size.width, self.m_addressView.frame.size.height + self.m_addressView.frame.origin.y);
            
        }else{
            
            self.m_addressView.hidden = YES;
            
            // 计算view的坐标
            self.m_view.frame = CGRectMake(self.m_view.frame.origin.x, self.m_view.frame.origin.y, self.m_view.frame.size.width, self.m_detailLabel.frame.size.height + self.m_detailLabel.frame.origin.y + 10);
            
        }
        
        
    }else{
        
        self.m_photoView.hidden = NO;
        
        // 设置图片所在的view
        [self getimageView];
        
    }
    
    // 测试 - 赞的数组
    [self getZanList];
    
    
    
    //自定义键盘输入
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    textField.delegate = self;
    self.m_textField = textField;
    [self.view addSubview:self.m_textField];
    self.m_textField.hidden = YES;
    self.m_textField.inputAccessoryView = self.m_commentView;
    self.m_commentField.delegate = self;

    
    
    
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

- (void)leftClicked{
    
      
    [self goBack];
    
}

- (void)shareClicked{
    
    NSLog(@"分享");
    
    [self.view addSubview:self.m_showView];
    
    // 动画
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = self.m_values;
    popAnimation.keyTimes = self.m_keyTimes;
    popAnimation.timingFunctions = self.m_Funtions;
    
    [self.m_showView.layer addAnimation:popAnimation forKey:nil];
    
}

- (void)getZanList{
    
    // 测试
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[CommonUtil getValueByKey:MEMBER_ID],@"MemberID",@"诚诚",@"NickName", nil];
    
    for (int i = 0; i < 6; i++) {
        
        [self.m_zanList addObject:dic];

    }

    if ( self.m_zanList.count != 0 ) {
        
        
        // 根据数组计算赞的view的大小
        NSString *zanstringman = @"";
        
        zanstringman = [[self.m_zanList objectAtIndex:0]objectForKey:@"NickName"];
        
        //赞的人数组
        for (int iii = 1; iii < self.m_zanList.count; iii++) {
            
            
            NSDictionary * zandic = [self.m_zanList objectAtIndex:iii ];
            
            zanstringman = [NSString stringWithFormat:@"%@、%@",zanstringman,[zandic objectForKey:@"NickName"]];
            
        }
        
        
        zanSize = [zanstringman sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
    }
    
    
    // 测试数据
    self.m_signUpList = [NSMutableArray arrayWithObjects:@"sss",@"ffff",@"ssssddf", nil];

    NSDictionary *l_dic = [NSDictionary dictionaryWithObjectsAndKeys:[CommonUtil getValueByKey:NICK],@"NickName",@"2014-10-23",@"TimeKey",@"你好啊啊啊啊啊啊啊啊啊你好啊啊啊啊啊啊啊啊啊你好啊啊啊啊啊啊啊啊啊你好啊啊啊啊啊啊啊啊啊hello啊",@"Content",[CommonUtil getValueByKey:MEMBER_ID],@"MemberId", nil];
    
    for (int i = 0; i < 2; i++) {
        
        [self.m_commentList addObject:l_dic];

    }
    
    
    // 计算评论的cell的高度
    if ( self.m_commentList.count != 0 ) {
        
        // 根据数组计算评论所在的cell的大小
     
        commentHeight = 0.0f;
        
        for (int i = 0; i < self.m_commentList.count; i++) {
            
            
            NSDictionary * dic = [self.m_commentList objectAtIndex:i];
            
            NSString *string = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Content"]];
            
            CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
            // 计算评论cell的高度
            commentHeight = commentHeight + size.height + 38;
            
            
            NSLog(@"height = %f",commentHeight);
        }
      
    }
    
}

- (void)getimageView{
    
    // 先清空view里面的所有控件
    for (id view in self.m_photoView.subviews) {
        [view removeFromSuperview];
    }
    
    int BtnW = 65;
    int BtnWS = 6;
    int BtnX = 6;
    
    int BtnH = 65;
    int BtnHS = 10;
    int BtnY = 10;
    
    int i = 0;
    
    for (i = 0; i < [m_imageList count]; i++ ) {
        
        UIImageView * imageview = [[UIImageView alloc] init];
        imageview.frame = CGRectMake( (BtnW+BtnWS) * (i%4) + BtnX , (BtnH+BtnHS) *(i/4) + BtnY, BtnW, BtnH );
        imageview.tag = 10000 + i;
        imageview.userInteractionEnabled = YES;
        // 内容模式
        imageview.clipsToBounds = YES;
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        
        imageview.image = [self.m_imageList objectAtIndex:i];
        //        [imageview setImageWithURL: [NSURL URLWithString: [m_imageArray objectAtIndex:i]] placeholderImage: [UIImage imageNamed:@"TopViewRight.png"]];
        // 添加图片手势
        [imageview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BtnClick:)]];
        
        [self.m_photoView addSubview:imageview];
        
    }
    
    int getEndImageYH = (BtnH + BtnHS) * (i/4) + BtnY;
    
    // 根据图片数组的个数来判断view的坐标大小
    float heightY = 0.0f;
    
    if ( self.m_imageList.count > 0 && self.m_imageList.count <= 4) {
        
        heightY = 85.0f;
        
    }else if ( self.m_imageList.count > 4 && self.m_imageList.count <= 8 ){
        
        heightY = 160.0f;
        
        
    } else if ( self.m_imageList.count > 8 ){
     
        heightY = getEndImageYH + 75;
        
    }
    
    // 设置图片所在的view的大小
    self.m_photoView.frame = CGRectMake(self.m_photoView.frame.origin.x, self.m_detailLabel.frame.size.height + self.m_detailLabel.frame.origin.y + 10, self.m_detailLabel.frame.size.width, heightY);
    
    // 判断没有地理位置的情况下
    if ( self.m_addressString.length != 0 ) {
        
        self.m_addressView.hidden = NO;
        
        // 计算view的坐标大小
        self.m_addressView.frame = CGRectMake(self.m_addressView.frame.origin.x, self.m_photoView.frame.size.height + self.m_photoView.frame.origin.y + 10, self.m_addressView.frame.size.width, self.m_addressView.frame.size.height);
       
        self.m_view.frame = CGRectMake(self.m_view.frame.origin.x, self.m_view.frame.origin.y, self.m_view.frame.size.width, self.m_addressView.frame.size.height + self.m_addressView.frame.origin.y);
        
        
    }else{
        
        self.m_addressView.hidden = YES;
        
        // 计算view的坐标
        self.m_view.frame = CGRectMake(self.m_view.frame.origin.x, self.m_view.frame.origin.y, self.m_view.frame.size.width, self.m_photoView.frame.size.height + self.m_photoView.frame.origin.y + 10);
        
    }
    
    
    // 设置scrollerView的滚动范围
    self.m_scrollerView.contentSize = CGSizeMake(self.m_scrollerView.frame.size.width, 800);
    
//    self.m_scrollerView.frame = CGRectMake(self.m_scrollerView.frame.origin.x, self.m_scrollerView.frame.origin.y, self.m_scrollerView.frame.size.width, self.m_view.frame.size.height + self.m_view.frame.origin.y);
   
    
    NSLog(@"height = %f",self.m_view.frame.size.height + self.m_view.frame.origin.y);
  
}


- (void)BtnClick:(UITapGestureRecognizer *)imageTap
{
    NSLog(@"imageTag==%d", imageTap.view.tag);
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [self.m_imageList count]];
    
    for (int i = 0; i < [self.m_imageList count]; i++) {
        // 替换为中等尺寸图片
        //        NSString * getImageStrUrl = [NSString stringWithFormat:@"%@", [self.m_imageArray objectAtIndex:i]];
        MJPhoto *photo = [[MJPhoto alloc] init];
        //        photo.url = [NSURL URLWithString: getImageStrUrl]; // 图片路径
        
        photo.image = [self.m_imageList objectAtIndex:i];
        
        UIImageView * imageView = (UIImageView *)[self.view viewWithTag: imageTap.view.tag ];
        photo.srcImageView = imageView;
        [photos addObject:photo];
        
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = (imageTap.view.tag - 10000); // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    
}


- (IBAction)addressToMap:(id)sender {
    
    
}

- (IBAction)shareBtnClicked:(id)sender {
    
    [self.m_showView removeFromSuperview];
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 1000 ) {
        //检测是否安装QQ
        if (![self checkIsVaildQQType]) {
            return;
        }
        // qq好友
        tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];
        
        
        //        http://wx.cityandcity.com/commodity_detail.aspx?svcid=101&mctid=63
        
        
        QQApiNewsObject *newsObj;
        
        /*
        if ([self.m_FromDPId isEqualToString:@"1"]) {
            
            
            NSString *utf8String = [NSString stringWithFormat:@"%@?hasheader=0",[self.m_itemsDic objectForKey:@"deal_h5_url"]];
            NSString *title = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"title"]];
            NSString *description =  [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"description"]];
            newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:[CommonUtil getValueByKey:@"productImage"]]];
            
        }else{
            
            NSString *utf8String = [NSString stringWithFormat:@"http://wx.cityandcity.com/commodity_detail.aspx?svcid=%@&mctid=%@",[self.m_itemsDic objectForKey:@"ServiceID"],[self.m_itemsDic objectForKey:@"MerchantID"]];
            NSString *title = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcSimpleName"]];
            NSString *description =  [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcName"]];
            newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:[CommonUtil getValueByKey:@"productImage"]]];
        }
        
        */
        
        
        
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        //将内容分享到qq
        QQApiSendResultCode sent = 0;
        sent = [QQApiInterface sendReq:req];
        // 判断QQ的情况
        [self handleSendResult:sent];
        
        
    }else if ( btn.tag == 1001 ) {
        //检测是否安装QQ
        if (![self checkIsVaildQQType]) {
            return;
        }
        QQApiNewsObject *newsObj;
        
        /*
        if ([self.m_FromDPId isEqualToString:@"1"]) {
            
            // QQ空间分享
            tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];
            
            
            NSString *utf8String = [NSString stringWithFormat:@"%@?hasheader=0",[self.m_itemsDic objectForKey:@"deal_h5_url"]];
            NSString *title = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"title"]];
            NSString *description =  [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"description"]];
            newsObj= [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:[CommonUtil getValueByKey:@"productImage"]]];
            
        }else{
            
            // QQ空间分享
            tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentQzoneAppId andDelegate:self];
            NSString *utf8String = [NSString stringWithFormat:@"http://wx.cityandcity.com/commodity_detail.aspx?svcid=%@&mctid=%@",[self.m_itemsDic objectForKey:@"ServiceID"],[self.m_itemsDic objectForKey:@"MerchantID"]];
            NSString *title = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcSimpleName"]];
            NSString *description =  [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcName"]];
            newsObj= [QQApiNewsObject objectWithURL:[NSURL URLWithString:utf8String] title:title description:description previewImageURL:[NSURL URLWithString:[CommonUtil getValueByKey:@"productImage"]]];
        }
        
        
        */
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        //将内容分享到qq
        QQApiSendResultCode sent = 0;
        
        //将内容分享到qzone
        sent = [QQApiInterface SendReqToQZone:req];
        
        // 判断QQ的情况
        [self handleSendResult:sent];
        
        
    }else if ( btn.tag == 1002 ) {
        
        // 微信分享
        [self checkIsVaildweixinType:1002];
        
    }else if ( btn.tag == 1003 ) {
        
        // 朋友圈分享
        [self checkIsVaildweixinType:1003];
        
    }else if ( btn.tag == 1004 ){
        //诲诲好友
        
        
    }else if ( btn.tag == 1005 ){
        //诲诲朋友圈
//        SharetoHuiHuiViewController * VC = [[SharetoHuiHuiViewController alloc]initWithNibName:@"SharetoHuiHuiViewController" bundle:nil];
//        
//        if ([self.m_FromDPId isEqualToString:@"1"]){
//            
//            VC.dealId = self.m_productId;
//            VC.serviceID = @"0";
//            VC.m_merchantShopId = @"0";
//            VC.dynamicType = @"DianPingShare";
//            VC.STitle = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"title"]];
//            VC.subTitle =  [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"description"]];
//            
//            
//        }else{
//            VC.dealId = @"0";
//            VC.serviceID = self.m_productId;
//            VC.m_merchantShopId = self.m_merchantShopId;
//            VC.dynamicType = @"SvcShare";
//            VC.STitle = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcSimpleName"]];
//            VC.subTitle =  [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcName"]];
//            
//        }
//        
//        VC.webUrl = @"";
//        VC.activityID = @"0";
//        
//        [self.navigationController pushViewController:VC animated:YES];
    }
    
}

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPISENDFAILD:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        default:
        {
            break;
        }
    }
}
// 检查是否安装了QQ的客户端
-(BOOL)checkIsVaildQQType
{
    if ([QQApi isQQInstalled] &&[QQApi isQQSupportApi]) {
        return YES;
    }else
    {
        //未安装
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"您尚未安装QQ或是当前版本太低"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    
}

// 检查是否安装了微信的客户端
-(void)checkIsVaildweixinType:(NSInteger)aType
{
    if( [WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi] ){ //判断是否安装且支持微信
        if ( aType == 1002 ) {
            
            // 好友
            [self shareTogoodFriend];
            
            
        }else if ( aType == 1003 ) {
            
            // 朋友圈
            [self shareTogoodFriendShipsWithMessage];
            
        }else{
            
            
        }
        
    }else{
        
        //未安装
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"您尚未安装微信,确认进行安装吗？"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定",nil];
        alert.tag = 100100;
        [alert show];
        
        
    }
    
}

//发送给好友
-(void)shareTogoodFriend
{
    /*
    WXMediaMessage *message = [WXMediaMessage message];//发送消息的多媒体内容
    message.title = [NSString stringWithFormat:@"%@", [self.m_itemsDic objectForKey:@"SvcSimpleName"]];
    message.description = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcName"]];
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"productImage"]];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             ext.webpageUrl = [NSString stringWithFormat:@"http://wx.cityandcity.com/commodity_detail.aspx?svcid=%@&mctid=%@",[self.m_itemsDic objectForKey:@"ServiceID"],[self.m_itemsDic objectForKey:@"MerchantID"]];
                             message.mediaObject = ext;
                             SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
                             req.bText = NO;//发送消息的类型，包括文本消息和多媒体消息两种，两者只能选择其一，不能同时发送文本和多媒体消息
                             req.message = message;
                             req.scene = WXSceneSession;//选择发送好友
                             [WXApi sendReq:req];
                             
                             
                         }
                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                             
                         }];
     
     */
    
}

// 朋友圈
-(void)shareTogoodFriendShipsWithMessage {
    
    /*
    WXMediaMessage *message = [WXMediaMessage message];//发送消息的多媒体内容
    message.title =@"分享";
    message.description = [NSString stringWithFormat:@"%@",[self.m_itemsDic objectForKey:@"SvcName"]];
    message.title = [NSString stringWithFormat:@"%@", [self.m_itemsDic objectForKey:@"SvcSimpleName"]];
    
    
    NSString *imagePath = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:@"productImage"]];
    
    UIImageView *imgV = [[UIImageView alloc]init];
    
    [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                placeholderImage:[UIImage imageNamed:@""]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                             imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                             
                             // 微信进行赋值
                             [message setThumbImage:imgV.image];
                             
                             WXWebpageObject *ext = [WXWebpageObject object];
                             ext.webpageUrl = [NSString stringWithFormat:@"http://wx.cityandcity.com/commodity_detail.aspx?svcid=%@&mctid=%@",[self.m_itemsDic objectForKey:@"ServiceID"],[self.m_itemsDic objectForKey:@"MerchantID"]];
                             message.mediaObject = ext;
                             
                             SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
                             req.bText = NO;//发送消息的类型，包括文本消息和多媒体消息两种，两者只能选择其一，不能同时发送文本和多媒体消息
                             req.message = message;
                             req.scene = WXSceneTimeline;//发送到朋友圈
                             
                             [WXApi sendReq:req];
                             
                             
                         }
                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                             
                         }];
     
     */
    
}

- (IBAction)cancelShare:(id)sender {
    
    [self.m_showView removeFromSuperview];
    
}

- (IBAction)sendCommentClicked:(id)sender {
    
    NSLog(@"commentIndex = %i",commentIndex);
    
    [self.m_commentField resignFirstResponder];
    
    [self.m_commentField resignFirstResponder];
    
    [self.view endEditing:YES];
    
    
    if ( self.m_commentField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入要评价的内容"];
        
        return;
    }

}

#pragma mark - UITableVIewDataSouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 6;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.row == 0 ) {
        
        static NSString *cellIdentifier = @"PartyDetailCellIdentifier";
        
        PartyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PartyDetailCell" owner:self options:nil];
            
            cell = (PartyDetailCell *)[nib objectAtIndex:0];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        NSString *string = @"活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活动详情活";
        
        // 赋值
        [cell setDetail:string withPhoto:self.m_imageList withAddress:self.m_addressString];
        
        return cell;

    }else if ( indexPath.row == 1 ){
        
        static NSString *cellIdentifier = @"ZanCellIdentifier";
        
        ZanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PartyDetailCell" owner:self options:nil];
            
            cell = (ZanCell *)[nib objectAtIndex:1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }

        
        // 赋值赞的字体的颜色
        [cell setZanTitle:@"0" withCount:@"1" withZanArray:self.m_zanList];
        
        cell.delegate = self;
        
        [cell.m_zanBtn addTarget:self action:@selector(zanClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;

        
    }else if ( indexPath.row == 2 ){
        
        // SignUpCellIdentifier
        
        static NSString *cellIdentifier = @"SignUpCellIdentifier";
        
        SignUpCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SignUpCell" owner:self options:nil];
            
            cell = (SignUpCell *)[nib objectAtIndex:0];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }

        // 赋值
        cell.m_countLabel.text = [NSString stringWithFormat:@"已有%i人报名",self.m_signUpList.count];

        cell.m_endTime.text = [NSString stringWithFormat:@"报名将于%@截止",@"2014-10-22 22:00"];

        
        return cell;
        
    }else if ( indexPath.row == 3 ){
        
        if ( self.m_signUpList.count == 0 ) {
            
            static NSString *cellIdentifier = @"SignListCellIdentifier";
            
            SignListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ( cell == nil ) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SignUpCell" owner:self options:nil];
                
                cell = (SignListCell *)[nib objectAtIndex:1];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            cell.m_tipLabel.text = @"目前还没有人报名";
           
            return cell;

        }else{
            
            
            static NSString *cellIdentifier = @"SignListCellIdentifier";
            
            SignDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ( cell == nil ) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SignUpCell" owner:self options:nil];
                
                cell = (SignDetailCell *)[nib objectAtIndex:2];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            // 加载报名的信息
            [cell getSignView:self.m_signUpList];

            
            return cell;
  
        }
        
        
        
    }else if ( indexPath.row == 4 ){
        
        // 评论的cell
        static NSString *cellIdentifier = @"PartyCommentCellIdentifier";
        
        PartyCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SignUpCell" owner:self options:nil];
            
            cell = (PartyCommentCell *)[nib objectAtIndex:3];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        // 添加评论按钮的tag值和触发事件
        cell.m_commentBtn.tag = indexPath.row;
        
        [cell.m_commentBtn addTarget:self action:@selector(commentClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;

        
    }else if ( indexPath.row == 5 ){
        
        if ( self.m_commentList.count == 0 ) {
            
            static NSString *cellIdentifier = @"SignListCellIdentifier";
            
            SignListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ( cell == nil ) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SignUpCell" owner:self options:nil];
                
                cell = (SignListCell *)[nib objectAtIndex:1];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            cell.m_tipLabel.text = @"目前还没有人评论";
            
            return cell;
            
        }else{
            
            static NSString *cellIdentifier = @"CommentDetailCellIdentifier";
           
            CommentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ( cell == nil ) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CommentDetailCell" owner:self options:nil];
                
                cell = (CommentDetailCell *)[nib objectAtIndex:0];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
          
            cell.delegate = self;
            
            // 赋值
            [cell getCommentView:self.m_commentList];
            
            
            return cell;
        
        }
       
    }
    
    else{
        
        return nil;
    }

}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    // 如果报名时间还没截止的话则显示我要报名的，否则的话则显示报名已关闭
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 60)];
    
    footerView.backgroundColor = [UIColor clearColor];
    
    // 添加按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 0, 300, 40);
    [btn setTitle:@"我要报名" forState:UIControlStateNormal];
    btn.layer.borderWidth = 1.0;
    btn.layer.borderColor = [UIColor grayColor].CGColor;
    btn.backgroundColor = [UIColor colorWithRed:96/255.0 green:207/255.0 blue:248/255.0 alpha:1.0];
    [btn addTarget:self action:@selector(signUpClick) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:btn];
    
    return footerView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.row == 0 ) {
        
        return self.m_view.frame.size.height;

    }else if ( indexPath.row == 1 ){
        
        if ( self.m_zanList.count != 0 ) {
            
            return zanSize.height + 55.0;

        }else{
            
            return 29.0f;
        }
    }else if ( indexPath.row == 2 ){
        
        return 40.0f;
 
    }else if ( indexPath.row == 3 ){
        
        if ( self.m_signUpList.count != 0 ) {
            
            return (self.m_signUpList.count * 44.0);
            
        }else{
            
            return 50.0f;

        }
    }else if ( indexPath.row == 3 ){
       
        return 44.0f;
        
    }else if ( indexPath.row == 4 ){
        
        return 44.0f;
        
    }else if ( indexPath.row == 5 ){
        
        // 计算cell的高度
        if ( self.m_commentList.count != 0 ) {
            
            return commentHeight + 5;
            
            
            NSLog(@"commentHeight = %f",commentHeight);

        }else{
            
            return 50.0f;
            
        }
        
    }else{
        
        return 0.0f;

    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 44.0f;
    
}

- (void)zanClicked:(id)sender{
    
    NSLog(@"zan");
    
}

#pragma mark - zanDelegate
- (void)zanNameClicked:(NSString *)aString{
    
    NSLog(@"astring = %@",aString);
    
    
    // 进入某个人的空间动态列表
    FriDynamicViewController * VC = [[FriDynamicViewController alloc]initWithNibName:@"FriDynamicViewController" bundle:nil];
    
    VC.m_memberId = [NSString stringWithFormat:@"%@",[aString substringFromIndex:3]];
    
    [self.navigationController pushViewController:VC animated:YES];
    
    
}

- (void)commentClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSLog(@"tag = %i",btn.tag);
    
    [self hiddenNumPadDone:nil];
    
    commentIndex = btn.tag;
    
    [self.m_textField becomeFirstResponder];
    
    [self.m_commentField becomeFirstResponder];
    
    // 点击评价，设置tableView滚动到第几行
    [self.m_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:btn.tag inSection:0]atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

#pragma mark - CommentDelegate
- (void)partyCommentClicked:(NSDictionary *)dic{
    
    NSLog(@"dic = %@",dic);
    
    
    [self hiddenNumPadDone:nil];
    
    [self.m_textField becomeFirstResponder];
    
    [self.m_commentField becomeFirstResponder];
    
    
}

// 我要报名的按钮触发的事件
- (void)signUpClick{
    
    NSLog(@"我要报名");
    
    
    
}


@end
