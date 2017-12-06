//
//  FriDynamicViewController.m
//  HuiHui
//
//  Created by mac on 14-6-12.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "FriDynamicViewController.h"

#import "DynamicCell.h"

#import "ProductDetailViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "SVProgressHUD.h"

#import "PublishViewController.h"

#import "MorecommentViewController.h"

#import "AboutmeViewController.h"

#import "ProductBigViewController.h"

#import "WebViewController.h"

#import "ActivityDetailViewController.h"

#import "ProductDetailViewController.h"


#import "MarkupParser.h"

#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "UserInformationViewController.h"

@interface FriDynamicViewController ()

@property (weak, nonatomic) IBOutlet PullTableView    *m_tableView;

@property (strong, nonatomic) IBOutlet UIView       *m_commentView;

@property (nonatomic, strong) UITextField           *m_textField;

@property (weak, nonatomic) IBOutlet UITextField    *m_commentTextField;

@property (weak, nonatomic) IBOutlet UILabel        *m_nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView    *m_imageView;

@property (weak, nonatomic) IBOutlet UIImageView    *m_headerImageView;

@property (nonatomic, strong) UIImageView           *l_imageView;

@property (weak, nonatomic) IBOutlet UIImageView    *m_whiteImagV;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

// 发送按钮触发的事件
- (IBAction)sendCommentClicked:(id)sender;

@end

@implementation FriDynamicViewController

@synthesize m_dic;

@synthesize m_imageDic;

@synthesize l_imageView;

@synthesize m_zanDic;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.m_DynamicArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        self.m_imageArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        self.m_CommentArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        self.m_BigimageArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_imageDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        l_imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 135)];
        
        m_zanDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(LeftClicked)];
    
    //自定义键盘输入
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    textField.delegate = self;
    self.m_textField = textField;
    [self.view addSubview:self.m_textField];
    self.m_textField.hidden = YES;
    self.m_textField.inputAccessoryView = self.m_commentView;
    self.m_commentTextField.delegate = self;
    
    // 设置图片的圆角
    [self setheard];
    
    imagechage = [[ImageCache alloc] init];
    
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView= YES;
    //    self.m_tableView.hidden = YES;
    
    self.m_emptyLabel.hidden = YES;
    
    // 请求用户信息
    [self memberRequestSubmit];
    
}


//关于我的头像
-(void)setheard
{
    
    [self.m_headerImageView.layer setMasksToBounds:YES];
    
    [self.m_headerImageView.layer setCornerRadius:30.0];
    
    // 设置为白色的背景
    [self.m_whiteImagV.layer setMasksToBounds:YES];
    
    [self.m_whiteImagV.layer setCornerRadius:30.0];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
    page = 1;//第一页
    
    [self DynamicList];//请求数据
    
    NewPingjia = NO;
    
    // label上面的链接网址可以点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openURLString:) name:@"OpenUrl" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
    
    [self.m_commentTextField resignFirstResponder];
    
    [self.m_textField resignFirstResponder];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"OpenUrl" object:nil];
    
    [SVProgressHUD dismiss];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)LeftClicked{
    
    [self goBack];
}


#pragma mark - NetWork
// 会员信息请求数据
- (void)memberRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedSpace];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.m_memberId,     @"memberId",
                           key,   @"key",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestSpace:@"DynamicConfig.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            self.m_tableView.hidden = NO;
            
            self.m_dic = [json valueForKey:@"DynConfig"];
            
            // 赋值
            self.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"NickName"]];
            
            [self setTitle:self.m_nameLabel.text];
            
            
            NSString *headImage = [self.m_dic objectForKey:@"FrontCover"];
            
            UIImage *reSizeImage = [imagechage getImage:headImage];
            
            if (reSizeImage != nil)
            {
                self.m_imageView.image = [CommonUtil scaleImage:reSizeImage toSize:CGSizeMake(WindowSizeWidth, 135)];
            }
            else{
                [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:headImage]]
                                        placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                     
                                                     self.m_imageView.image = image;//[CommonUtil scaleImage:image toSize:CGSizeMake(WindowSizeWidth, 135)];
                                                     
                                                 }
                                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                     
                                                 }];
            }
            
            
            // 头像
            NSString *userHeadImage = [self.m_dic objectForKey:@"PhotoMidUrl"];
            UIImage *reSizeImage2 = [imagechage getImage:userHeadImage];
            
            if (reSizeImage2 != nil)
            {
                self.m_headerImageView.image = [CommonUtil scaleImage:reSizeImage2 toSize:CGSizeMake(60, 60)];
            }
            else{
                
                [self.m_headerImageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:userHeadImage]]
                                              placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                           
                                                           self.m_headerImageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                                           //                                                 self.m_headerImageView.contentMode = UIViewContentModeScaleAspectFit;
                                                           
                                                       }
                                                       failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                           
                                                       }];
            }
            
            
            
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:@"请求失败，请稍后再试！"];
    }];
    
}

- (UITableViewCell *)tableViewSHA:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath DIC:(NSDictionary *)Dydic
{
    
    static NSString *cellIdentifier = @"DynamicDetailCellIdentifier";
    
    DynamicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DynamicCell" owner:self options:nil];
        
        cell = (DynamicDetailCell *)[nib objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    cell.m_imageView.layer.masksToBounds = YES;
    cell.m_imageView.layer.cornerRadius = 8.0;
    //头像
    UIImageView*imv=[[UIImageView alloc]init];
    UIImage *reSizeImage = [imagechage getImage:[Dydic objectForKey:@"PhotoMidUrl"]];
    
    if (reSizeImage != nil)
    {
        cell.m_imageView.image = reSizeImage;
    }
    else{
        
        [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"PhotoMidUrl"]]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            cell.m_imageView.image = image;
            [imagechage addImage:image andUrl:[Dydic objectForKey:@"PhotoMidUrl"]];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
        }];
    }
    
    cell.m_PhotoBtn.tag = indexPath.row;
    [cell.m_PhotoBtn addTarget:self action:@selector(PhotoBtnSend:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.m_DelBtn.hidden = YES;
    
    // 添加按钮事件
    cell.m_zanBtn.tag = indexPath.row;
    cell.m_zhuanfaBtn.tag = indexPath.row;
    cell.m_pingjiaBtn.tag = indexPath.row;
    [cell.m_zanBtn addTarget:self action:@selector(zanClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.m_zhuanfaBtn addTarget:self action:@selector(zhuanfaClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.m_pingjiaBtn addTarget:self action:@selector(pingjiaClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *zanString = [self.m_zanDic objectForKey:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
    
    if ( [zanString isEqualToString:@"1"] ) {
        
        // 1表示赞 0表示未赞
        
        cell.m_cancelLabel.hidden = NO;
        
    }else if ( [zanString isEqualToString:@"0"] ) {
        
        cell.m_cancelLabel.hidden = YES;
        
    }
    
    
    self.m_CommentArray = [Dydic objectForKey:@"DynamicComment"];
    
    if (NewPingjia&&indexPath.row == Pingjiaindex) {
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        [dic setObject:[CommonUtil getValueByKey:NICK] forKey:@"NickName"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.m_commentTextField.text] forKey:@"Contents"];
        
        self.m_commentTextField.text = @"";
        
        NewPingjia = NO;
        
    }
    
    
    cell.m_zhuanzai.text = @"转发";
    
    cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"NickName"]];
    
    cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"CreateDate"]];
    
    cell.m_fromLabel.text = [NSString stringWithFormat:@"来自:%@",[Dydic objectForKey:@"Source"]];
    
    CGSize namesize = [cell.m_contentLabel.text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(90, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
    cell.m_nameLabel.frame = CGRectMake(cell.m_nameLabel.frame.origin.x, cell.m_nameLabel.frame.origin.y, namesize.width, 26);
    cell.m_zhuanzai.frame = CGRectMake(cell.m_nameLabel.frame.origin.x+cell.m_nameLabel.frame.size.width, cell.m_zhuanzai.frame.origin.y, cell.m_zhuanzai.frame.size.width, cell.m_zhuanzai.frame.size.height);
    
    
    
    NSString * FormNickName = @"";
    
    FormNickName = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormNickName"]];
    
    NSMutableAttributedString *attributedString;
    
    
    if ( FormNickName.length != 0) {
        
        //不同颜色
        attributedString= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@|%@:%@",[Dydic objectForKey:@"Contents"],FormNickName,[Dydic objectForKey:@"ForwardingContents"]]];
        
                           if ([NSString stringWithFormat:@"%@",[Dydic objectForKey:@"Contents"]].length !=0) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:108.0/255 green:166.0/255  blue:205.0/255 alpha:1.0f] range:NSMakeRange([[Dydic objectForKey:@"Contents"] length] + 1,[FormNickName length])];
                           }
        //内容
        cell.m_contentLabel.attributedText = attributedString;
        
    }else{
        
        attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@|%@",[Dydic objectForKey:@"Contents"],[Dydic objectForKey:@"ForwardingContents"]]];
        
                           if ([NSString stringWithFormat:@"%@",[Dydic objectForKey:@"Contents"]].length !=0) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([[Dydic objectForKey:@"Contents"] length] + 1,[[Dydic objectForKey:@"Contents"],[Dydic objectForKey:@"ForwardingContents"] length])];
                           }
        
        //内容
        cell.m_contentLabel.attributedText = attributedString;
    }
    
    cell.m_recourceView.frame = CGRectMake(cell.m_recourceView.frame.origin.x, cell.m_contentLabel.frame.origin.y + cell.m_contentLabel.frame.size.height , cell.m_recourceView.frame.size.width, cell.m_recourceView.frame.size.height);
    
    cell.m_titleLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormTitle"]];
    cell.m_SubtitleLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormSubTitle"]];
    
    
    
    // 设置label，可以点击链接地址
    MarkupParser* p = [[MarkupParser alloc] init];
    // 清空数组重新赋值
    [p.images removeAllObjects];
    
    [cell.m_contentLabel.imageInfoArr removeAllObjects];
    
    NSMutableAttributedString* attString = attributedString;
    
    CTFontRef verdana = CTFontCreateWithName((CFStringRef)@"Verdana",14,NULL);
    [attString addAttribute:(NSString*)(kCTFontAttributeName) value:(__bridge id)verdana range:NSMakeRange(0, attString.length)];
    
    [cell.m_contentLabel setAttString:attString withImages:p.images];
    // 这个属性设置为YES时就表示可以对网址进行操作
    cell.m_contentLabel.underlineLinks = YES;
    cell.m_contentLabel.userInteractionEnabled = YES;
    
    CGRect labelRect = cell.m_contentLabel.frame;
    
    labelRect.size.width = [cell.m_contentLabel sizeThatFits:CGSizeMake(233, CGFLOAT_MAX)].width;
    labelRect.size.height = [cell.m_contentLabel sizeThatFits:CGSizeMake(233, CGFLOAT_MAX)].height;
    
    CGFloat textX = 20;
    
    textX = 80;
    
    labelRect.origin = CGPointMake(textX, 30);
    cell.m_contentLabel.frame = labelRect;
    [cell.m_contentLabel.layer display];
    
    
    cell.m_recourceView.frame = CGRectMake(cell.m_recourceView.frame.origin.x, cell.m_contentLabel.frame.origin.y + cell.m_contentLabel.frame.size.height , cell.m_recourceView.frame.size.width, cell.m_recourceView.frame.size.height);
    
    
    self.m_imageArray = [Dydic objectForKey:@"ForwardingDynPicList"];
    
    
    if (self.m_imageArray.count==0) {
        
        
        if ([[Dydic objectForKey:@"FormDynamicType"] isEqualToString: KEY_DYNAMIC_SvcShare]) {
            
            [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
            
        }else if ([[Dydic objectForKey:@"FormDynamicType"] isEqualToString: KEY_DYNAMIC_ActShare])
        {
            [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
            
        }else if ([[Dydic objectForKey:@"FormDynamicType"] isEqualToString: KEY_DYNAMIC_WebViewShare])
        {
            [cell.self.m_imgV setImage:[UIImage imageNamed:@"lianjie.png"]];
            
            
        }else if ([[Dydic objectForKey:@"FormDynamicType"] isEqualToString: KEY_DYNAMIC_DianPingShare]){
            
            [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
            
        }
        
        
    }else{
        
        NSDictionary * imageDic = [self.m_imageArray objectAtIndex:0];
        
        NSString *path=[NSString stringWithFormat:@"%@",[imageDic objectForKey:@"MidImgUrl"]];
        
        [cell ShareCellimage:path];
    }
    
    
    for(id tmpView in cell.m_commentView.subviews)
    {
        [tmpView removeFromSuperview];
    }
    for (id tepview in cell.m_zanView.subviews) {
        [tepview removeFromSuperview];
    }
 
//    //发表说说的点击头像
//    cell.m_PhotoBtn.tag = indexPath.row;
//    [cell.m_PhotoBtn addTarget:self action:@selector(PhotoBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加按钮事件
    cell.m_zanBtn.tag = indexPath.row;
    cell.m_zhuanfaBtn.tag = indexPath.row;
    cell.m_pingjiaBtn.tag = indexPath.row;
    [cell.m_zanBtn addTarget:self action:@selector(zanClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.m_zhuanfaBtn addTarget:self action:@selector(zhuanfaClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.m_pingjiaBtn addTarget:self action:@selector(pingjiaClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.m_linkBtn.tag = indexPath.row;//链接按钮；
    
    [cell.m_linkBtn addTarget:self action:@selector(resourcelink:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.m_CommentArray = [Dydic objectForKey:@"DynamicComment"];
    
    if (self.m_CommentArray.count == 0) {
        
        cell.m_commentView.hidden =YES;
        
        
        cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x,cell.m_recourceView.frame.origin.y + cell.m_recourceView.frame.size.height, cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
        
        cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
        
        
        
        return cell;
        
    }
    else if (self.m_CommentArray.count==1) {
        
        cell.m_commentView.hidden =NO;
        
        NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
        
        NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
        
        CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        UILabel * label = [[UILabel alloc]init];
        
        [label setFrame:CGRectMake(0 , 0, 223, pinglu.height)];
        
        label.text = pinglu0;
        
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor lightGrayColor];
        [label setFont:[UIFont systemFontOfSize:14.0f]];
        label.numberOfLines = 0;// 不可少Label属性
//        label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
        
        [cell.m_commentView setFrame:CGRectMake(80,  cell.m_recourceView.frame.origin.y + cell.m_recourceView.frame.size.height , cell.m_commentView.frame.size.width, pinglu.height)];
        
        [cell.m_commentView addSubview:label];
        
    }
    else if (self.m_CommentArray.count==2) {
        
        CGFloat pingluHIGHT2 = 0;
        cell.m_commentView.hidden =NO;
        
        
        for (int i=0; i<self.m_CommentArray.count; i++) {
            
            
            NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
            NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
            CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            NSDictionary * dic2 = [self.m_CommentArray objectAtIndex:1];
            NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic2 objectForKey:@"NickName"],[dic2 objectForKey:@"Contents"]];
            CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            
            UILabel * label = [[UILabel alloc]init];
            
            if (i==0)
            {
                pingluHIGHT2 = pingluHIGHT2+ pinglu.height;
                
                [label setFrame:CGRectMake(0 , i*pinglu.height, 223, pinglu.height)];
                
                label.text = pinglu0;
                
                
            }else if (i==1)
            {
                
                pingluHIGHT2 = pingluHIGHT2+ size1.height;
                
                [label setFrame:CGRectMake(0 , i*pinglu.height, 223, size1.height)];
                
                label.text = pinglustring;
            }
            
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor lightGrayColor];
            [label setFont:[UIFont systemFontOfSize:14.0f]];
            label.numberOfLines = 0;// 不可少Label属性
//            label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
            
            
            [cell.m_commentView setFrame:CGRectMake(80, cell.m_recourceView.frame.origin.y +cell.m_recourceView.frame.size.height  , cell.m_commentView.frame.size.width, pingluHIGHT2)];
            
            [cell.m_commentView addSubview:label];
            
            
        }
        
    }
    else if (self.m_CommentArray.count>=3) {
        
        CGFloat pingluHIGHT2 = 0;
        cell.m_commentView.hidden =NO;
        
        
        for (int i=0; i<3; i++) {
            
            if (i==2) {
                
                UIButton * PINGLUMOREbtn =[UIButton buttonWithType:UIButtonTypeCustom];
                [PINGLUMOREbtn setFrame:CGRectMake(0, cell.m_commentView.frame.size.height,233, 25)];
                
                PINGLUMOREbtn.backgroundColor = [UIColor clearColor];
                [PINGLUMOREbtn setTitle: @"查看更多评论" forState: UIControlStateNormal];
                [PINGLUMOREbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                [PINGLUMOREbtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
                PINGLUMOREbtn.showsTouchWhenHighlighted = YES;
                PINGLUMOREbtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
                
                PINGLUMOREbtn.tag = indexPath.row;
                
                [PINGLUMOREbtn addTarget:self action:@selector(MorepingluView:) forControlEvents:UIControlEventTouchUpInside];
                
                [cell.m_commentView setFrame:CGRectMake(80, cell.m_recourceView.frame.origin.y +cell.m_recourceView.frame.size.height , cell.m_commentView.frame.size.width, pingluHIGHT2+25)];
                
                [cell.m_commentView addSubview:PINGLUMOREbtn];
                
                break;
                
            }
            
            
            NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
            NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
            CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            NSDictionary * dic2 = [self.m_CommentArray objectAtIndex:1];
            NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic2 objectForKey:@"NickName"],[dic2 objectForKey:@"Contents"]];
            CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            UILabel * label = [[UILabel alloc]init];
            
            if (i==0)
            {
                pingluHIGHT2 = pingluHIGHT2+ pinglu.height;
                
                [label setFrame:CGRectMake(0 , i*pinglu.height, 223, pinglu.height)];
                
                label.text = pinglu0;
                
            }else if (i==1)
            {
                
                pingluHIGHT2 = pingluHIGHT2+ size1.height;
                
                [label setFrame:CGRectMake(0 , i*pinglu.height, 223, size1.height)];
                
                label.text = pinglustring;
                
            }
            
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor lightGrayColor];
            [label setFont:[UIFont systemFontOfSize:14.0f]];
            label.numberOfLines = 0;// 不可少Label属性
//            label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
            
            
            [cell.m_commentView setFrame:CGRectMake(80, cell.m_recourceView.frame.origin.y +cell.m_recourceView.frame.size.height , cell.m_commentView.frame.size.width, pingluHIGHT2)];
            
            [cell.m_commentView addSubview:label];
            
            
        }
        
    }
    
    
    cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x, cell.m_commentView.frame.origin.y + cell.m_commentView.frame.size.height, cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
    
    cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
    
    
    
    return cell;
    
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_DynamicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( self.m_DynamicArray.count != 0 ) {
        
        NSDictionary * Dydic = [self.m_DynamicArray objectAtIndex:indexPath.row];
        
        self.m_typeString = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"DynamicType"]];
        
        if ( [self.m_typeString isEqualToString: KEY_DYNAMIC_FRIENDS]||[self.m_typeString isEqualToString: KEY_DYNAMIC_FromFRIENDS]) {
            
            static NSString *cellIdentifier = @"DynamicCellIdentifier";
            
            DynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ( cell == nil ) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DynamicCell" owner:self options:nil];
                
                cell = (DynamicCell *)[nib objectAtIndex:0];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            cell.m_zanView.hidden = YES;
            
            cell.m_DelBtn.hidden = YES;
            //昵称
            cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"NickName"]];
            
            CGSize namesize = [cell.m_nameLabel.text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(90, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
            
            cell.m_nameLabel.frame = CGRectMake(cell.m_nameLabel.frame.origin.x, cell.m_nameLabel.frame.origin.y, namesize.width, 26);
            cell.m_zhuanzai.frame = CGRectMake(cell.m_nameLabel.frame.origin.x+cell.m_nameLabel.frame.size.width, cell.m_zhuanzai.frame.origin.y, cell.m_zhuanzai.frame.size.width, cell.m_zhuanzai.frame.size.height);
            
            cell.m_fromLabel.text = [NSString stringWithFormat:@"来自:%@",[Dydic objectForKey:@"Source"]];
            
            NSString * FormNickName = @"";
            
            //好友动态
            if ([self.m_typeString isEqualToString: KEY_DYNAMIC_FRIENDS]) {
                
                cell.m_zhuanzai.text = @"分享";
                //内容
                cell.m_contentLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"Contents"]];
                
                //图片列表
                self.m_imageArray = [Dydic objectForKey:@"DynamicPicList"];
                
                
            }
            //转发动态
            else if ([self.m_typeString isEqualToString: KEY_DYNAMIC_FromFRIENDS]) {
                
                //图片列表
                self.m_imageArray = [Dydic objectForKey:@"ForwardingDynPicList"];
                
                if ([[Dydic objectForKey:@"FormDynamicType"] isEqualToString: KEY_DYNAMIC_SvcShare]||[[Dydic objectForKey:@"FormDynamicType"] isEqualToString: KEY_DYNAMIC_WebViewShare]||[[Dydic objectForKey:@"FormDynamicType"] isEqualToString: KEY_DYNAMIC_DianPingShare])
                {
                    
                    return  [self tableViewSHA:tableView cellForRowAtIndexPath:indexPath DIC:Dydic] ;
                    
                }
                
                cell.m_zhuanzai.text = @"转发";
                FormNickName = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormNickName"]];
                
                if ( FormNickName.length != 0 ) {
                    
                    //不同颜色
                    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@|%@:%@",[Dydic objectForKey:@"Contents"],FormNickName,[Dydic objectForKey:@"ForwardingContents"]]];
                    
                    if ([NSString stringWithFormat:@"%@",[Dydic objectForKey:@"Contents"]].length !=0) {
                            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:108.0/255 green:166.0/255  blue:205.0/255 alpha:1.0f] range:NSMakeRange([[Dydic objectForKey:@"Contents"] length] + 1,[FormNickName length])];
                    }
     
                    
                    //内容
                    cell.m_contentLabel.attributedText = attributedString;
                    
                }else{
                    
                    
                    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@|%@",[Dydic objectForKey:@"Contents"],[Dydic objectForKey:@"ForwardingContents"]]];
                    
                    if ([NSString stringWithFormat:@"%@",[Dydic objectForKey:@"Contents"]].length !=0) {
                    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([[Dydic objectForKey:@"Contents"] length] + 1,[[Dydic objectForKey:@"Contents"],[Dydic objectForKey:@"ForwardingContents"] length])];
                    }
                    
                    //内容
                    cell.m_contentLabel.attributedText = attributedString;
                }
                
                
            }
            
            
            // 设置label，可以点击链接地址
            MarkupParser* p = [[MarkupParser alloc] init];
            // 清空数组重新赋值
            [p.images removeAllObjects];
            
            [cell.m_contentLabel.imageInfoArr removeAllObjects];
            
            NSMutableAttributedString* attString = [p attrStringFromMarkup:[Dydic objectForKey:@"Contents"]];
            CTFontRef verdana = CTFontCreateWithName((CFStringRef)@"Verdana",14,NULL);
            [attString addAttribute:(NSString*)(kCTFontAttributeName) value:(__bridge id)verdana range:NSMakeRange(0, attString.length)];
            
            [cell.m_contentLabel setAttString:attString withImages:p.images];
            // 这个属性设置为YES时就表示可以对网址进行操作
            cell.m_contentLabel.underlineLinks = YES;
            cell.m_contentLabel.userInteractionEnabled = YES;
            
            CGRect labelRect = cell.m_contentLabel.frame;
            
            labelRect.size.width = [cell.m_contentLabel sizeThatFits:CGSizeMake(233, CGFLOAT_MAX)].width;
            labelRect.size.height = [cell.m_contentLabel sizeThatFits:CGSizeMake(233, CGFLOAT_MAX)].height;
            
            CGFloat textX = 20;
            
            textX = 80;
            
            labelRect.origin = CGPointMake(textX, 30);
            cell.m_contentLabel.frame = labelRect;
            [cell.m_contentLabel.layer display];
            
            
            CGSize size = [cell.m_contentLabel.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            cell.m_contentLabel.frame = CGRectMake(cell.m_contentLabel.frame.origin.x, cell.m_contentLabel.frame.origin.y, 233, size.height+3);
            
            cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x, cell.m_contentLabel.frame.origin.y + size.height, cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
            
            cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
            //日期
            cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"NickName"]];
            
            cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"CreateDate"]];
            
            cell.m_fromLabel.text = [NSString stringWithFormat:@"来自:%@",[Dydic objectForKey:@"Source"]];
            
            cell.m_imageView.layer.masksToBounds = YES;
            cell.m_imageView.layer.cornerRadius = 8.0;
            //头像
            UIImageView*imv=[[UIImageView alloc]init];
            UIImage *reSizeImage = [imagechage getImage:[Dydic objectForKey:@"PhotoMidUrl"]];
            
            if (reSizeImage != nil)
            {
                cell.m_imageView.image = reSizeImage;
            }
            else{
                
                [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"PhotoMidUrl"]]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                    cell.m_imageView.image = image;
                    [imagechage addImage:image andUrl:[Dydic objectForKey:@"PhotoMidUrl"]];
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                    
                }];
            }
            
            cell.m_PhotoBtn.tag = indexPath.row;
            [cell.m_PhotoBtn addTarget:self action:@selector(PhotoBtnSend:) forControlEvents:UIControlEventTouchUpInside];
            
            //删除
            for(id tmpView in cell.m_ImgView.subviews)
            {
                [tmpView removeFromSuperview];
            }
            for(id tmpView in cell.m_commentView.subviews)
            {
                [tmpView removeFromSuperview];
            }
            
            // 添加按钮事件
            cell.m_zanBtn.tag = indexPath.row;
            cell.m_zhuanfaBtn.tag = indexPath.row;
            cell.m_pingjiaBtn.tag = indexPath.row;
            [cell.m_zanBtn addTarget:self action:@selector(zanClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.m_zhuanfaBtn addTarget:self action:@selector(zhuanfaClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.m_pingjiaBtn addTarget:self action:@selector(pingjiaClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *zanString = [self.m_zanDic objectForKey:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
            
            NSLog(@"%@",zanString);
            
            if ( [zanString isEqualToString:@"1"] ) {
                
                // 1表示赞 0表示未赞
                
                cell.m_cancelLabel.hidden = NO;
                
            }else if ( [zanString isEqualToString:@"0"] ) {
                
                cell.m_cancelLabel.hidden = YES;
                
            }else{
                
                
            }
            
            
            self.m_CommentArray = [Dydic objectForKey:@"DynamicComment"];
            
            if (NewPingjia&&indexPath.row == Pingjiaindex) {
                
                
                NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithCapacity:0];
                [dic setObject:[CommonUtil getValueByKey:NICK] forKey:@"NickName"];
                [dic setObject:[NSString stringWithFormat:@"%@",self.m_commentTextField.text] forKey:@"Contents"];
                
                self.m_commentTextField.text = @"";
                
                NewPingjia = NO;
                
            }
            
            
            //图片为空
            if (self.m_imageArray.count == 0) {
                
                cell.m_ImgView.hidden =YES;
                
                if (self.m_CommentArray.count == 0) {
                    
                    cell.m_commentView.hidden =YES;
                    
                    cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x, cell.m_contentLabel.frame.origin.y+size.height, cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
                    
                    cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
                    
                    return cell;
                    
                }
                else if (self.m_CommentArray.count==1) {
                    
                    cell.m_commentView.hidden =NO;
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                    
                    NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    
                    CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    
                    UILabel * label = [[UILabel alloc]init];
                    
                    [label setFrame:CGRectMake(0 , 0, 223, pinglu.height)];
                    
                    label.text = pinglu0;
                    
                    
                    label.backgroundColor = [UIColor clearColor];
                    label.textColor = [UIColor lightGrayColor];
                    [label setFont:[UIFont systemFontOfSize:14.0f]];
                    label.numberOfLines = 0;// 不可少Label属性
//                    label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                    
                    
                    [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height, cell.m_commentView.frame.size.width, pinglu.height)];
                    
                    [cell.m_commentView addSubview:label];
                    
                    
                }
                else if (self.m_CommentArray.count==2) {
                    
                    CGFloat pingluHIGHT2 = 0;
                    
                    cell.m_commentView.hidden =NO;
                    
                    for (int i=0; i<self.m_CommentArray.count; i++) {
                        
                        
                        NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                        
                        NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                        CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        NSDictionary * dic2 = [self.m_CommentArray objectAtIndex:1];
                        NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic2 objectForKey:@"NickName"],[dic2 objectForKey:@"Contents"]];
                        CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        
                        UILabel * label = [[UILabel alloc]init];
                        
                        if (i==0)
                        {
                            pingluHIGHT2 = pingluHIGHT2+ pinglu.height;
                            
                            [label setFrame:CGRectMake(0 , i*pinglu.height, 223, pinglu.height)];
                            
                            label.text = pinglu0;
                            
                            
                        }else if (i==1)
                        {
                            
                            pingluHIGHT2 = pingluHIGHT2+ size1.height;
                            
                            [label setFrame:CGRectMake(0 , i*pinglu.height, 223, size1.height)];
                            
                            label.text = pinglustring;
                            
                        }
                        
                        label.backgroundColor = [UIColor clearColor];
                        label.textColor = [UIColor lightGrayColor];
                        [label setFont:[UIFont systemFontOfSize:14.0f]];
                        label.numberOfLines = 0;// 不可少Label属性
//                        label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                        
                        
                        [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height, cell.m_commentView.frame.size.width, pingluHIGHT2)];
                        
                        [cell.m_commentView addSubview:label];
                        
                        
                    }
                    
                }
                else if (self.m_CommentArray.count>=3) {
                    
                    CGFloat pingluHIGHT2 = 0;
                    
                    cell.m_commentView.hidden =NO;
                    
                    for (int i=0; i<3; i++) {
                        
                        if (i==2) {
                            
                            UIButton * PINGLUMOREbtn =[UIButton buttonWithType:UIButtonTypeCustom];
                            [PINGLUMOREbtn setFrame:CGRectMake(0, cell.m_commentView.frame.size.height, 233, 25)];
                            
                            PINGLUMOREbtn.backgroundColor = [UIColor clearColor];
                            [PINGLUMOREbtn setTitle: @"查看更多评论" forState: UIControlStateNormal];
                            [PINGLUMOREbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                            [PINGLUMOREbtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
                            PINGLUMOREbtn.showsTouchWhenHighlighted = YES;
                            PINGLUMOREbtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
                            
                            PINGLUMOREbtn.tag = indexPath.row;
                            
                            [PINGLUMOREbtn addTarget:self action:@selector(MorepingluView:) forControlEvents:UIControlEventTouchUpInside];
                            
                            [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height, cell.m_commentView.frame.size.width, pingluHIGHT2+25)];
                            
                            [cell.m_commentView addSubview:PINGLUMOREbtn];
                            
                            break;
                            
                        }
                        
                        
                        NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                        NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                        CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        NSDictionary * dic2 = [self.m_CommentArray objectAtIndex:1];
                        NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic2 objectForKey:@"NickName"],[dic2 objectForKey:@"Contents"]];
                        CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        
                        UILabel * label = [[UILabel alloc]init];
                        
                        if (i==0)
                        {
                            pingluHIGHT2 = pingluHIGHT2+ pinglu.height;
                            
                            [label setFrame:CGRectMake(0 , i*pinglu.height, 223, pinglu.height)];
                            
                            label.text = pinglu0;
                            
                        }else if (i==1)
                        {
                            
                            pingluHIGHT2 = pingluHIGHT2+ size1.height;
                            
                            [label setFrame:CGRectMake(0 , i*pinglu.height, 223, size1.height)];
                            
                            label.text = pinglustring;
                        }
                        
                        label.backgroundColor = [UIColor clearColor];
                        label.textColor = [UIColor lightGrayColor];
                        [label setFont:[UIFont systemFontOfSize:14.0f]];
                        label.numberOfLines = 0;// 不可少Label属性
//                        label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                        
                        [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height, cell.m_commentView.frame.size.width, pingluHIGHT2)];
                        
                        [cell.m_commentView addSubview:label];
                        
                        
                    }
                    
                }
                
                
                cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x, cell.m_commentView.frame.origin.y+cell.m_commentView.frame.size.height, cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
                
                cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
                
                
            }
            //图片是1-9之间
            else if (self.m_imageArray.count>=1&&self.m_imageArray.count<=9)
            {
                cell.m_ImgView.hidden = NO;
                
                int line =0;
                
                if (self.m_imageArray.count<=3) {
                    [cell.m_ImgView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y + size.height,cell.m_ImgView.frame.size.width, 80)];
                }else if (self.m_imageArray.count<=6){
                    line =1;
                    [cell.m_ImgView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y + size.height,cell.m_ImgView.frame.size.width, 160)];
                    
                }else if (self.m_imageArray.count<=9){
                    line =2;
                    [cell.m_ImgView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y + size.height,cell.m_ImgView.frame.size.width, 235)];
                    
                }
                
                for (int i=0; i<self.m_imageArray.count; i++) {
                    
                    NSDictionary * imageDic = [self.m_imageArray objectAtIndex:i];
                    
                    NSString *path=[NSString stringWithFormat:@"%@",[imageDic objectForKey:@"MidImgUrl"]];
                    
                    UIImageView*imv=[[UIImageView alloc]init];
                    UIButton * Btn = [[UIButton alloc]init];
                    
                    UIImage *reSizeImage = [imagechage getImage:path];
                    
                    
                    if (reSizeImage != nil)
                    {
                        [Btn setFrame:CGRectMake(5+(i%3*75), 5+(i/3*75), 70, 70)];
                        
                        [Btn setBackgroundImage:[CommonUtil scaleImage:reSizeImage toSize:CGSizeMake(70, 70)] forState:UIControlStateNormal];
                        [Btn addTarget:self action:@selector(ChangeBigImage:) forControlEvents:UIControlEventTouchUpInside];
                        Btn.tag = i;
                        [cell.m_ImgView addSubview:Btn];
                        
                        continue;
                    }
                    else{
                        
                        [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",path]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                            
                            [Btn setFrame:CGRectMake(5+(i%3*75), 5+(i/3*75), 70, 70)];
                            
                            [Btn setBackgroundImage:[CommonUtil scaleImage:image toSize:CGSizeMake(70, 70)] forState:UIControlStateNormal];
                            
                            [Btn addTarget:self action:@selector(ChangeBigImage:) forControlEvents:UIControlEventTouchUpInside];
                            
                            Btn.tag =i;
                            
                            [cell.m_ImgView addSubview:Btn];
                            
                            [imagechage addImage:[CommonUtil scaleImage:image toSize:CGSizeMake(70, 70)] andUrl:path];
                            
                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                            
                            [Btn setFrame:CGRectMake(5+(i%3*75), 5+(i/3*75), 70, 70)];
                            [Btn setBackgroundImage:[CommonUtil scaleImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] toSize:CGSizeMake(70, 70)] forState:UIControlStateNormal];
                            [Btn addTarget:self action:@selector(ChangeBigImage:) forControlEvents:UIControlEventTouchUpInside];
                            Btn.tag =i;
                            [cell.m_ImgView addSubview:Btn];
                        }];
                        
                    }
                    
                }
                
                if (self.m_CommentArray.count == 0) {
                    
                    cell.m_commentView.hidden =YES;
                    
                    cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x,cell.m_contentLabel.frame.origin.y + size.height +((line+1)*80), cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
                    
                    cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
                    
                    return cell;
                    
                }
                else if (self.m_CommentArray.count==1) {
                    
                    cell.m_commentView.hidden =NO;
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                    
                    NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    
                    CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    UILabel * label = [[UILabel alloc]init];
                    
                    [label setFrame:CGRectMake(0 , 0, 223, pinglu.height)];
                    
                    label.text = pinglu0;
                    
                    label.backgroundColor = [UIColor clearColor];
                    label.textColor = [UIColor lightGrayColor];
                    [label setFont:[UIFont systemFontOfSize:14.0f]];
                    label.numberOfLines = 0;// 不可少Label属性
//                    label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                    
                    [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height+ cell.m_ImgView.frame.size.height, cell.m_commentView.frame.size.width, pinglu.height)];
                    
                    [cell.m_commentView addSubview:label];
                    
                    
                }
                else if (self.m_CommentArray.count==2) {
                    
                    CGFloat pingluHIGHT2 = 0;
                    
                    cell.m_commentView.hidden =NO;
                    
                    for (int i=0; i<self.m_CommentArray.count; i++) {
                        
                        NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                        NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                        CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        NSDictionary * dic2 = [self.m_CommentArray objectAtIndex:1];
                        NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic2 objectForKey:@"NickName"],[dic2 objectForKey:@"Contents"]];
                        CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        
                        UILabel * label = [[UILabel alloc]init];
                        
                        if (i==0)
                        {
                            pingluHIGHT2 = pingluHIGHT2+ pinglu.height;
                            
                            [label setFrame:CGRectMake(0 , i*pinglu.height, 223, pinglu.height)];
                            
                            label.text = pinglu0;
                            
                        }else if (i==1)
                        {
                            
                            pingluHIGHT2 = pingluHIGHT2+ size1.height;
                            
                            [label setFrame:CGRectMake(0 , i*pinglu.height, 223, size1.height)];
                            
                            label.text = pinglustring;
                        }
                        
                        label.backgroundColor = [UIColor clearColor];
                        label.textColor = [UIColor lightGrayColor];
                        [label setFont:[UIFont systemFontOfSize:14.0f]];
                        label.numberOfLines = 0;// 不可少Label属性
//                        label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                        
                        
                        [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height+ cell.m_ImgView.frame.size.height, cell.m_commentView.frame.size.width, pingluHIGHT2)];
                        
                        [cell.m_commentView addSubview:label];
                        
                        
                    }
                    
                }
                else if (self.m_CommentArray.count>=3) {
                    
                    cell.m_commentView.hidden =NO;
                    
                    CGFloat pingluHIGHT2 = 0;
                    
                    for (int i=0; i<3; i++) {
                        
                        if (i==2) {
                            
                            UIButton * PINGLUMOREbtn =[UIButton buttonWithType:UIButtonTypeCustom];
                            [PINGLUMOREbtn setFrame:CGRectMake(0, cell.m_commentView.frame.size.height, 233, 25)];
                            
                            PINGLUMOREbtn.backgroundColor = [UIColor clearColor];
                            [PINGLUMOREbtn setTitle: @"查看更多评论" forState: UIControlStateNormal];
                            [PINGLUMOREbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                            [PINGLUMOREbtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
                            PINGLUMOREbtn.showsTouchWhenHighlighted = YES;
                            PINGLUMOREbtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
                            
                            PINGLUMOREbtn.tag = indexPath.row;
                            
                            [PINGLUMOREbtn addTarget:self action:@selector(MorepingluView:) forControlEvents:UIControlEventTouchUpInside];
                            
                            [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height+ cell.m_ImgView.frame.size.height, cell.m_commentView.frame.size.width, pingluHIGHT2+25)];
                            
                            [cell.m_commentView addSubview:PINGLUMOREbtn];
                            
                            break;
                            
                        }
                        
                        
                        NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                        NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                        CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        NSDictionary * dic2 = [self.m_CommentArray objectAtIndex:1];
                        NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic2 objectForKey:@"NickName"],[dic2 objectForKey:@"Contents"]];
                        CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        
                        UILabel * label = [[UILabel alloc]init];
                        
                        if (i==0)
                        {
                            pingluHIGHT2 = pingluHIGHT2+ pinglu.height;
                            
                            [label setFrame:CGRectMake(0 , i*pinglu.height, 223, pinglu.height)];
                            
                            label.text = pinglu0;
                            
                        }else if (i==1)
                        {
                            
                            pingluHIGHT2 = pingluHIGHT2+ size1.height;
                            
                            [label setFrame:CGRectMake(0 , i*pinglu.height, 223, size1.height)];
                            
                            label.text = pinglustring;
                        }
                        
                        label.backgroundColor = [UIColor clearColor];
                        label.textColor = [UIColor lightGrayColor];
                        [label setFont:[UIFont systemFontOfSize:14.0f]];
                        label.numberOfLines = 0;// 不可少Label属性
//                        label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                        
                        
                        [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height+ cell.m_ImgView.frame.size.height, cell.m_commentView.frame.size.width, pingluHIGHT2)];
                        
                        [cell.m_commentView addSubview:label];
                        
                        
                    }
                    
                }
                
                
                cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x, cell.m_commentView.frame.origin.y+cell.m_commentView.frame.size.height, cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
                
                cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
                
                
            }
            
            
            return cell;
            
            
        }else if ([self.m_typeString isEqualToString: KEY_DYNAMIC_SvcShare]||[self.m_typeString isEqualToString: KEY_DYNAMIC_WebViewShare]||[self.m_typeString isEqualToString: KEY_DYNAMIC_DianPingShare]){
            
            
            static NSString *cellIdentifier = @"DynamicDetailCellIdentifier";
            
            DynamicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ( cell == nil ) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DynamicCell" owner:self options:nil];
                
                cell = (DynamicDetailCell *)[nib objectAtIndex:1];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            cell.m_imageView.layer.masksToBounds = YES;
            cell.m_imageView.layer.cornerRadius = 8.0;
            
            //头像
            UIImageView*imv=[[UIImageView alloc]init];
            UIImage *reSizeImage = [imagechage getImage:[Dydic objectForKey:@"PhotoMidUrl"]];
            
            if (reSizeImage != nil)
            {
                cell.m_imageView.image = reSizeImage;
            }
            else{
                
                [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"PhotoMidUrl"]]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                    cell.m_imageView.image = image;
                    [imagechage addImage:image andUrl:[Dydic objectForKey:@"PhotoMidUrl"]];
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                    
                }];
            }
            
            cell.m_PhotoBtn.tag = indexPath.row;
            [cell.m_PhotoBtn addTarget:self action:@selector(PhotoBtnSend:) forControlEvents:UIControlEventTouchUpInside];
            cell.m_DelBtn.hidden = YES;
            
            cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"NickName"]];
            
            cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"CreateDate"]];
            
            cell.m_fromLabel.text = [NSString stringWithFormat:@"来自:%@",[Dydic objectForKey:@"Source"]];
            
            CGSize namesize = [cell.m_nameLabel.text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(90, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
            cell.m_nameLabel.frame = CGRectMake(cell.m_nameLabel.frame.origin.x, cell.m_nameLabel.frame.origin.y, namesize.width, 26);
            cell.m_zhuanzai.frame = CGRectMake(cell.m_nameLabel.frame.origin.x+cell.m_nameLabel.frame.size.width, cell.m_zhuanzai.frame.origin.y, cell.m_zhuanzai.frame.size.width, cell.m_zhuanzai.frame.size.height);
            
            self.m_imageArray = [Dydic objectForKey:@"DynamicPicList"];
            
            if (self.m_imageArray.count==0) {
                
                
                if ([[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"DynamicType"]] isEqualToString: KEY_DYNAMIC_SvcShare]) {
                    [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
                    
                }else if ([[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"DynamicType"]] isEqualToString: KEY_DYNAMIC_ActShare])
                {
                    [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
                    
                }else if ([[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"DynamicType"]] isEqualToString: KEY_DYNAMIC_WebViewShare])
                {
                    [cell.self.m_imgV setImage:[UIImage imageNamed:@"lianjie.png"]];
                    
                    
                }else if ([[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"DynamicType"]] isEqualToString: KEY_DYNAMIC_DianPingShare]){
                    
                    [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
                    
                }
                
                
            }else{
                NSDictionary * imageDic = [self.m_imageArray objectAtIndex:0];
                
                NSString *path=[NSString stringWithFormat:@"%@",[imageDic objectForKey:@"MidImgUrl"]];
                
                [cell ShareCellimage:path];
            }
            
            
            for(id tmpView in cell.m_commentView.subviews)
            {
                [tmpView removeFromSuperview];
            }
            
            // 添加按钮事件
            cell.m_zanBtn.tag = indexPath.row;
            cell.m_zhuanfaBtn.tag = indexPath.row;
            cell.m_pingjiaBtn.tag = indexPath.row;
            [cell.m_zanBtn addTarget:self action:@selector(zanClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.m_zhuanfaBtn addTarget:self action:@selector(zhuanfaClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.m_pingjiaBtn addTarget:self action:@selector(pingjiaClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.m_linkBtn.tag = indexPath.row;//链接按钮；
            [cell.m_linkBtn addTarget:self action:@selector(resourcelink:) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *zanString = [self.m_zanDic objectForKey:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
            
            if ( [zanString isEqualToString:@"1"] ) {
                
                // 1表示赞 0表示未赞
                cell.m_cancelLabel.hidden = NO;
                
            }else if ( [zanString isEqualToString:@"0"] ) {
                
                cell.m_cancelLabel.hidden = YES;
                
            }else{
                
                
            }
            
            if (NewPingjia&&indexPath.row == Pingjiaindex) {
                
                
                NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithCapacity:0];
                [dic setObject:[CommonUtil getValueByKey:NICK] forKey:@"NickName"];
                [dic setObject:[NSString stringWithFormat:@"%@",self.m_commentTextField.text] forKey:@"Contents"];
                
                self.m_commentTextField.text = @"";
                
                NewPingjia = NO;
                
            }
            
            self.m_CommentArray = [Dydic objectForKey:@"DynamicComment"];
            
            
            cell.m_contentLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"Contents"]];
            
            CGSize size;
            
            if ([cell.m_contentLabel.text isEqualToString:@""]) {
                size.height = 0.f;
            }else{
                
                size= [cell.m_contentLabel.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            }
            
            cell.m_contentLabel.frame = CGRectMake(cell.m_contentLabel.frame.origin.x, cell.m_contentLabel.frame.origin.y, 233, size.height+3);
            
            cell.m_recourceView.frame = CGRectMake(cell.m_recourceView.frame.origin.x, cell.m_contentLabel.frame.origin.y + size.height + 5, cell.m_recourceView.frame.size.width, cell.m_recourceView.frame.size.height);
            
            
            cell.m_titleLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"Title"]];
            cell.m_SubtitleLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"SubTitle"]];
            
            if (self.m_CommentArray.count == 0) {
                
                cell.m_commentView.hidden =YES;
                
                cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x,cell.m_recourceView.frame.origin.y + cell.m_recourceView.frame.size.height  , cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
                
                cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
                
                return cell;
                
            }
            else if (self.m_CommentArray.count==1) {
                
                cell.m_commentView.hidden = NO;
                
                NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                
                NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                
                CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                UILabel * label = [[UILabel alloc]init];
                
                [label setFrame:CGRectMake(0 , 0, 223, pinglu.height)];
                
                label.text = pinglu0;
                
                label.backgroundColor = [UIColor clearColor];
                label.textColor = [UIColor lightGrayColor];
                [label setFont:[UIFont systemFontOfSize:14.0f]];
                label.numberOfLines = 0;// 不可少Label属性
//                label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                
                [cell.m_commentView setFrame:CGRectMake(80,  cell.m_recourceView.frame.origin.y + cell.m_recourceView.frame.size.height , cell.m_commentView.frame.size.width, pinglu.height)];
                
                [cell.m_commentView addSubview:label];
                
            }
            else if (self.m_CommentArray.count==2) {
                
                cell.m_commentView.hidden = NO;
                
                CGFloat pingluHIGHT2 = 0;
                
                for (int i=0; i<self.m_CommentArray.count; i++) {
                    
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                    NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    NSDictionary * dic2 = [self.m_CommentArray objectAtIndex:1];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic2 objectForKey:@"NickName"],[dic2 objectForKey:@"Contents"]];
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    
                    UILabel * label = [[UILabel alloc]init];
                    
                    if (i==0)
                    {
                        pingluHIGHT2 = pingluHIGHT2+ pinglu.height;
                        
                        [label setFrame:CGRectMake(0 , i*pinglu.height, 223, pinglu.height)];
                        
                        label.text = pinglu0;
                        
                        
                    }else if (i==1)
                    {
                        
                        pingluHIGHT2 = pingluHIGHT2+ size1.height;
                        
                        [label setFrame:CGRectMake(0 , i*pinglu.height, 223, size1.height)];
                        
                        label.text = pinglustring;
                    }
                    
                    label.backgroundColor = [UIColor clearColor];
                    label.textColor = [UIColor lightGrayColor];
                    [label setFont:[UIFont systemFontOfSize:14.0f]];
                    label.numberOfLines = 0;// 不可少Label属性
//                    label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                    
                    
                    [cell.m_commentView setFrame:CGRectMake(80, cell.m_recourceView.frame.origin.y +cell.m_recourceView.frame.size.height , cell.m_commentView.frame.size.width, pingluHIGHT2)];
                    
                    [cell.m_commentView addSubview:label];
                    
                    
                }
                
            }
            else if (self.m_CommentArray.count>=3) {
                
                cell.m_commentView.hidden = NO;
                
                CGFloat pingluHIGHT2 = 0;
                
                for (int i=0; i<3; i++) {
                    
                    if (i==2) {
                        
                        UIButton * PINGLUMOREbtn =[UIButton buttonWithType:UIButtonTypeCustom];
                        [PINGLUMOREbtn setFrame:CGRectMake(0, cell.m_commentView.frame.size.height, 233, 25)];
                        
                        PINGLUMOREbtn.backgroundColor = [UIColor clearColor];
                        [PINGLUMOREbtn setTitle: @"查看更多评论" forState: UIControlStateNormal];
                        [PINGLUMOREbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                        [PINGLUMOREbtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
                        PINGLUMOREbtn.showsTouchWhenHighlighted = YES;
                        PINGLUMOREbtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
                        
                        PINGLUMOREbtn.tag = indexPath.row;
                        
                        [PINGLUMOREbtn addTarget:self action:@selector(MorepingluView:) forControlEvents:UIControlEventTouchUpInside];
                        
                        [cell.m_commentView setFrame:CGRectMake(80, cell.m_recourceView.frame.origin.y +cell.m_recourceView.frame.size.height, cell.m_commentView.frame.size.width, pingluHIGHT2+25)];
                        
                        [cell.m_commentView addSubview:PINGLUMOREbtn];
                        
                        break;
                        
                    }
                    
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                    NSString *pinglu0 =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    CGSize pinglu = [pinglu0 sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    NSDictionary * dic2 = [self.m_CommentArray objectAtIndex:1];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic2 objectForKey:@"NickName"],[dic2 objectForKey:@"Contents"]];
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    
                    UILabel * label = [[UILabel alloc]init];
                    
                    if (i==0)
                    {
                        pingluHIGHT2 = pingluHIGHT2+ pinglu.height;
                        
                        [label setFrame:CGRectMake(0 , i*pinglu.height, 223, pinglu.height)];
                        
                        label.text = pinglu0;
                        
                    }else if (i==1)
                    {
                        
                        pingluHIGHT2 = pingluHIGHT2+ size1.height;
                        
                        [label setFrame:CGRectMake(0 , i*pinglu.height, 223, size1.height)];
                        
                        label.text = pinglustring;
                        
                    }
                    
                    label.backgroundColor = [UIColor clearColor];
                    label.textColor = [UIColor lightGrayColor];
                    [label setFont:[UIFont systemFontOfSize:14.0f]];
                    label.numberOfLines = 0;// 不可少Label属性
//                    label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                    
                    
                    [cell.m_commentView setFrame:CGRectMake(80, cell.m_recourceView.frame.origin.y +cell.m_recourceView.frame.size.height , cell.m_commentView.frame.size.width, pingluHIGHT2)];
                    
                    [cell.m_commentView addSubview:label];
                    
                    
                }
                
            }
            
            
            cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x, cell.m_commentView.frame.origin.y + cell.m_commentView.frame.size.height, cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
            
            cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
            
            return cell;
            
        } else{
            
            static NSString *cellIdentifier = @"cellIdentifier";
            
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            if ( cell == nil ) {
                
                cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            }
            
            return cell;
        }
        
    }else{
        
        static NSString *cellIdentifier = @"cellIdentifier";
        
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        }
        
        return cell;
    }
    
    
}



#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.view endEditing:YES];
    [self.view endEditing:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.m_DynamicArray.count == 0) {
        
        return 0;
    }
    
    
    NSDictionary * Dydic = [self.m_DynamicArray objectAtIndex:indexPath.row];
    
    self.m_typeString = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"DynamicType"]];
    
    self.m_CommentArray = [Dydic objectForKey:@"DynamicComment"];
    
    if (NewPingjia&&indexPath.row == Pingjiaindex) {
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        [dic setObject:[CommonUtil getValueByKey:NICK] forKey:@"NickName"];
        [dic setObject:[NSString stringWithFormat:@"%@",self.m_commentTextField.text] forKey:@"Contents"];
        
        [self.m_CommentArray addObject:dic];
        
    }
    
    if ( [self.m_typeString isEqualToString: KEY_DYNAMIC_FRIENDS]||[self.m_typeString isEqualToString: KEY_DYNAMIC_FromFRIENDS]) {
        
        NSString *string = @"";
        
        //好友动态
        if ([self.m_typeString isEqualToString: KEY_DYNAMIC_FRIENDS]) {
            
            string =  [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"Contents"]];
            
            self.m_imageArray = [Dydic objectForKey:@"DynamicPicList"];
            
        }
        //转发
        else if ([self.m_typeString isEqualToString: KEY_DYNAMIC_FromFRIENDS])
        {
            NSString * FromName = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormNickName"]];
            
            self.m_imageArray = [Dydic objectForKey:@"ForwardingDynPicList"];
            
            if ( FromName.length != 0 ) {
                
                //不同颜色
                string = [NSString stringWithFormat:@"%@|%@:%@",[Dydic objectForKey:@"Contents"],FromName,[Dydic objectForKey:@"ForwardingContents"]];
                
            }else{
                
                
                string =[NSString stringWithFormat:@"%@|%@",[Dydic objectForKey:@"Contents"],[Dydic objectForKey:@"ForwardingContents"]];
                
            }
            
            
        }
        
        CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        
        int line = 0;
        //有图片
        if (self.m_imageArray.count>0) {
            
            if (self.m_imageArray.count<=3) {
                line =0;
            }else if (self.m_imageArray.count<=6){
                line =1;
            }else if (self.m_imageArray.count<=9){
                line =2;
            }
            
            if (self.m_CommentArray.count == 0) {
                
                return 39 + size.height + 30 + ((line+1)*80) - 5;
                
                
            }else if (self.m_CommentArray.count == 1){
                
                NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                return 39 + size.height + 30 + ((line+1)*80)+size1.height -5;
                
            }else if (self.m_CommentArray.count == 2){
                
                
                CGFloat SIZEPING = 0;
                
                for (int i=0; i<2; i++) {
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:i];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    SIZEPING =SIZEPING+size1.height;
                    
                }
                return 39 + size.height + 30 + ((line+1)*80) +SIZEPING -5 ;
                
                
            }else if (self.m_CommentArray.count >=3){
                
                CGFloat SIZEPING = 0;
                
                for (int i=0; i<2; i++) {
                    
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:i];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    SIZEPING =SIZEPING+size1.height;
                    
                }
                return 39 + size.height + 30 + ((line+1)*80) +SIZEPING + 20 ;
                
            }
            
        }
        //空的图片
        else{
            
            if (self.m_CommentArray.count == 0) {
                
                return 39 + size.height + 25 ;
                
                
            }else if (self.m_CommentArray.count == 1){
                
                NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                
                CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                return 39 + size.height + 30 +size1.height +5;
                
            }else if (self.m_CommentArray.count == 2){
                
                CGFloat SIZEPING = 0;
                
                for (int i=0; i<2; i++) {
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    SIZEPING =SIZEPING+size1.height;
                    
                }
                
                return 39 + size.height + 30 + +SIZEPING -5;
                
                
            }else if (self.m_CommentArray.count >=3){
                
                CGFloat SIZEPING = 0;
                
                for (int i=0; i<2; i++) {
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    SIZEPING =SIZEPING+size1.height;
                    
                }
                return 39 + size.height + 30 +  +SIZEPING +20;
                
            }
            
        }
        
    }
    
    else  if ( [self.m_typeString isEqualToString: KEY_DYNAMIC_SvcShare]||[self.m_typeString isEqualToString: KEY_DYNAMIC_WebViewShare]||[self.m_typeString isEqualToString: KEY_DYNAMIC_DianPingShare] ){
        
        CGSize size ;
        NSString * string =  [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"Contents"]];//说说内容
        
        if ([string isEqualToString:@""]) {
            
            size.height = 0.f;
            
        }else{
            size= [string sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
        }
        
        if (self.m_CommentArray.count == 0) {
            
            return 39 + size.height + 70 + 29 ;
            
            
        }else if (self.m_CommentArray.count == 1){
            
            NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
            NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
            
            CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            return 39 + size.height + 70 + 29 +size1.height;
            
        }else if (self.m_CommentArray.count == 2){
            
            CGFloat SIZEPING = 0;
            
            for (int i=0; i<2; i++) {
                
                NSDictionary * dic = [self.m_CommentArray objectAtIndex:i];
                NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                
                CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                SIZEPING =SIZEPING+size1.height;
                
            }
            
            return 39 + size.height + 70 +SIZEPING +29;
            
            
        }else if (self.m_CommentArray.count >=3){
            
            CGFloat SIZEPING = 0;
            
            for (int i=0; i<2; i++) {
                
                NSDictionary * dic = [self.m_CommentArray objectAtIndex:i];
                NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                
                CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                SIZEPING =SIZEPING+size1.height;
                
            }
            return 39 + size.height + 70 + 29 +SIZEPING + 25 ;
            
        }
        
    }
    
    return 0;
    
}


//发送评价
- (IBAction)sendCommentClicked:(id)sender {
    
    [self.m_textField resignFirstResponder];
    [self.m_commentTextField resignFirstResponder];
    [self.view endEditing:YES];
    
    if ( self.m_commentTextField.text.length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"请输入要评价的内容"];
        return;
    }
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSMutableDictionary *dic = [self.m_DynamicArray objectAtIndex:Pingjiaindex];
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedSpace];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [NSString stringWithFormat:@"%@",[dic objectForKey:@"DynamicID"]],@"dynamicID",
                           @"0",@"toMemberID",
                           [NSString stringWithFormat:@"%@",self.m_commentTextField.text],@"contents",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据提交中..."];
    
    [httpClient requestSpace:@"DynamicComment.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            NewPingjia = YES;
            
            // 刷新某一行
            NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:Pingjiaindex inSection:0]];
            
            [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];//不刷新高度
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试！"];
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self.view endEditing:YES];
    [self.view endEditing:YES];
    
    return YES;
    
}

- (void)zanClicked:(id)sender{
    
    [self.view endEditing:YES];
    [self.view endEditing:YES];
    
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dic = [self.m_DynamicArray objectAtIndex:btn.tag];
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedSpace];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [NSString stringWithFormat:@"%@",[dic objectForKey:@"DynamicID"]],@"dynamicID",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestSpace:@"Praise.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            DynamicCell *cell = (DynamicCell *)[self tableView:self.m_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:btn.tag inSection:0]];
            
            if ( [cell.m_cancelLabel isHidden] ) {
                
                cell.m_cancelLabel.hidden = NO;
                
                [self.m_zanDic setValue:@"1" forKey:[NSString stringWithFormat:@"%li",(long)btn.tag]];
                
            }else{
                
                cell.m_cancelLabel.hidden = YES;
                
                [self.m_zanDic setValue:@"0" forKey:[NSString stringWithFormat:@"%li",(long)btn.tag]];
                
                
            }
            
            // 刷新某一行
            NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:btn.tag inSection:0]];
            
            [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
            
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试！"];

    }];
    
}

- (void)zhuanfaClicked:(id)sender{
    
    [self.view endEditing:YES];
    [self.view endEditing:YES];
    
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dic = [self.m_DynamicArray objectAtIndex:btn.tag];
    
    // 进入转发页面
    ForwardingViewController *VC = [[ForwardingViewController alloc]initWithNibName:@"ForwardingViewController" bundle:nil];
    
    VC.m_Dyanmicdic = dic;
    
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

//评价
- (void)pingjiaClicked:(id)sender{
    
    [self hiddenNumPadDone:nil];
    
    UIButton *btn = (UIButton *)sender;
    
    Pingjiaindex = btn.tag;
    
    [self.m_textField becomeFirstResponder];
    
    [self.m_commentTextField becomeFirstResponder];
    
    // 点击评价，设置tableView滚动到第几行
    [self.m_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:btn.tag inSection:0]atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

//放大图片
- (void)ChangeBigImage:(id)sender
{
    
    [self.view endEditing:YES];
    [self.view endEditing:YES];
    
    int index;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0&&[[[UIDevice currentDevice] systemVersion] floatValue]<8.0) {
        //获取Cell的indexpath.row
        index = [self.m_tableView indexPathForCell:((DynamicCell*)[[[[sender   superview]superview] superview]superview])].row; //这个方便一点点，不用设置tag。
    }else
    {
        //获取Cell的indexpath.row
        index = [self.m_tableView indexPathForCell:((DynamicCell*)[[[sender   superview]superview] superview])].row; //这个方便一点点，不用设置tag。
    }
    
    NSDictionary * Dydic = [self.m_DynamicArray objectAtIndex:index];
    
    self.m_typeString = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"DynamicType"]];
    
    //好友动态
    if ([self.m_typeString isEqualToString: KEY_DYNAMIC_FRIENDS]) {
        
        self.m_BigimageArray = [[self.m_DynamicArray objectAtIndex:index] objectForKey:@"DynamicPicList"];
        
    }
    //转发动态
    else if ([self.m_typeString isEqualToString: KEY_DYNAMIC_FromFRIENDS]) {
        
        self.m_BigimageArray = [[self.m_DynamicArray objectAtIndex:index] objectForKey:@"ForwardingDynPicList"];
        
    }
    
    UIButton *btn = (UIButton *)sender;
    
    int count = self.m_BigimageArray.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSDictionary * BigimageDic = [self.m_BigimageArray objectAtIndex:i];
        NSString *path = [BigimageDic objectForKey:@"BigImgUrl"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:path]; // 图片路径
        
        DynamicCell *cell = (DynamicCell *)[self tableView:self.m_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        
        UIButton * BBBtn = cell.m_ImgView.subviews[i];
        if (BBBtn.imageView.image !=nil) {
            photo.srcImageView = BBBtn.imageView;
        }
        [photos addObject:photo];
    }
    
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = btn.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    
    [browser show];
    
}





//更多评论页面
-(void)MorepingluView:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dic = [self.m_DynamicArray objectAtIndex:btn.tag];
    
    MorecommentViewController * VC = [[MorecommentViewController alloc]initWithNibName:@"MorecommentViewController" bundle:nil];
    
    VC.m_MoreDIC  = dic;
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

// 动态列表
-(void)DynamicList
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedSpace];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,  @"memberId",
                           key,   @"key",
                           self.m_memberId,@"otherMemberId",
                           [NSString stringWithFormat:@"%d",page],@"pageIndex",
                           nil];
    NSLog(@"zidian::%@",param);
    
    NSLog(@"%@",self.m_DynamicArray);
    
    if (self.m_DynamicArray.count ==0) {
        [SVProgressHUD showWithStatus:@"数据加载中"];
    }
    [httpClient requestSpace:@"DynamicAboutOtherList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [json valueForKey:@"DynamicList"];
            
            NSLog(@"%@",metchantShop);
            
            if (page == 1) {
                //metchantShop == nil ||
                if (metchantShop.count == 0) {
                    [self.m_DynamicArray removeAllObjects];
                    
                    self.m_emptyLabel.hidden = NO;
                    
                    [SVProgressHUD showErrorWithStatus:@"暂无动态"];
                    
                    [self.m_tableView reloadData];
                    
                    NSLog(@"111111");
                    
                    return;
                } else {
                    
                    self.m_DynamicArray = metchantShop;
                    
                    NSLog(@"333333");
                    
                }
            } else {
                //metchantShop == nil ||
                if (metchantShop.count == 0) {
                    page--;
                    
                    NSLog(@"444444");
                    
                } else {
                    NSLog(@"5555555");
                    [self.m_DynamicArray addObjectsFromArray:metchantShop];
                    
                }
            }
            self.m_tableView.hidden = NO;
            
            self.m_emptyLabel.hidden = YES;
            
            [self.m_tableView reloadData];
            
            
            for (int i = 0; i < self.m_DynamicArray.count; i ++) {
                
                NSMutableDictionary *dic = [self.m_DynamicArray objectAtIndex:i];
                
                [self.m_zanDic setValue:[dic objectForKey:@"IsPraise"] forKey:[NSString stringWithFormat:@"%i",i]];

            }
            
        } else {
            
            NSLog(@"2222222");
            
            if (page > 1) {
                page--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        self.m_tableView.pullLastRefreshDate = [NSDate date];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    } failure:^(NSError *error) {
        
        NSLog(@"666666");
        
        if (page > 1) {
            page--;
        }
        [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试！"];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    }];
    
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    page = 1;
    
    [self DynamicList];
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    page ++;
    
    [self DynamicList];
    
}



- (void)resourcelink:(id)sender{
    
    [self.view endEditing:YES];
    [self.view endEditing:YES];
    
    UIButton *btn = (UIButton *)sender;
    
    NSDictionary * Dydic = [self.m_DynamicArray objectAtIndex:btn.tag];
    
    NSString * Type;
    
    NSString * ID;
    
    if ([[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormDynamicType"]] isEqualToString:@""]) {
        
        Type = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"DynamicType"]];
        
        ID = @"0";
        
    }else if (![[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormDynamicType"]] isEqualToString:@""])
    {
        Type = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormDynamicType"]];
        
        ID = @"1";
    }
    
    
    if ([Type isEqualToString: KEY_DYNAMIC_SvcShare]) {
        
        [self productDetail:Dydic ID:ID];
        
    }else if ([Type isEqualToString: KEY_DYNAMIC_ActShare])
    {
        [self activityDetail:Dydic ID:ID];
        
    }else if ([Type isEqualToString: KEY_DYNAMIC_WebViewShare])
    {
        // 进入网页页面
        WebViewController *VC = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
        
        if ([[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormDynamicType"]] isEqualToString:@""]) {
            
            VC.m_scanString = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"WebUrl"]];
            
        }else if (![[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormDynamicType"]] isEqualToString:@""])
        {
            VC.m_scanString = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormWebUrl"]];
        }
        
        VC.m_typeString = @"2";
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ([Type isEqualToString: KEY_DYNAMIC_DianPingShare]){
        
        [self DPDetail:Dydic  ID:ID];
        
    }
    
    
}



- (void)productDetail:(NSDictionary*)sender ID:(NSString*)ZF{
    // 进入商品详情-商品
    ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
    
    VC.m_FromDPId = @"0";
    
    if ([ZF isEqualToString:@"1"]) {
        VC.m_productId = [NSString stringWithFormat:@"%@",[sender objectForKey:@"FormSvcId"]];
        VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[sender objectForKey:@"FormMerchantShopId"]];
    }else{
        VC.m_productId = [NSString stringWithFormat:@"%@",[sender objectForKey:@"ServiceID"]];
        VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[sender objectForKey:@"MerchantShopID"]];
    }
    
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)activityDetail:(NSDictionary*)sender ID:(NSString*)ZF{
    
    // 进入商品详情 - 活动
    ActivityDetailViewController *VC = [[ActivityDetailViewController alloc]initWithNibName:@"ActivityDetailViewController" bundle:nil];
    
    VC.m_typeString = MERCHANTACTIVITY;
    VC.m_partyString = @"1";
    
    if ([ZF isEqualToString:@"1"]) {
        VC.m_serviceId = [NSString stringWithFormat:@"%@",[sender objectForKey:@"FormActId"]];
    }else{
        VC.m_serviceId = [NSString stringWithFormat:@"%@",[sender objectForKey:@"ActivityID"]];
        
    }
    
    
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)DPDetail:(NSDictionary*)sender ID:(NSString*)ZF{
    
    // 进入商品详情 -点评
    ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
    
    VC.m_FromDPId = @"1";
    
    if ([ZF isEqualToString:@"1"]) {
        VC.m_productId = [NSString stringWithFormat:@"%@",[sender objectForKey:@"FormdealId"]];
    }else{
        VC.m_productId = [NSString stringWithFormat:@"%@",[sender objectForKey:@"DealId"]];
        
    }
    
    [self.navigationController pushViewController:VC animated:YES];
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

//点击头像
- (void)PhotoBtnSend:(id)sender{
    
    if ([self.m_Isback isEqualToString:@"YES"]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    UIButton *btn = (UIButton *)sender;
    
    NSDictionary *dic = [self.m_DynamicArray objectAtIndex:btn.tag];
        
    // 进入详细资料
    UserInformationViewController *VC = [[UserInformationViewController alloc]initWithNibName:@"UserInformationViewController" bundle:nil];
    VC.m_friendId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]];
//    VC.m_RName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"RealName"] ];
    [self.navigationController pushViewController:VC animated:YES];
    
    
}

@end

