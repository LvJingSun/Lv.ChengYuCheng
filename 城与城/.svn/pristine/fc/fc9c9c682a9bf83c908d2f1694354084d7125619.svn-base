//
//  AboutmeViewController.m
//  HuiHui
//
//  Created by 冯海强 on 14-5-13.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "AboutmeViewController.h"

#import "PersonalViewController.h"

#import "DynamicCell.h"

#import "MorecommentViewController.h"

#import "WebViewController.h"

#import "ActivityDetailViewController.h"

#import "ProductDetailViewController.h"

#import "MarkupParser.h"

#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface AboutmeViewController ()

@property (weak, nonatomic) IBOutlet PullTableView      *m_tableView;

@property (weak, nonatomic) IBOutlet UIButton           *m_heardBtn;//头像

@property (weak, nonatomic) IBOutlet UIButton           *m_coverBtn;//封面

@property (weak, nonatomic) IBOutlet UIImageView        *m_headerImageView;
// 表示上传图片转圈圈
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *m_activityV;

@property (weak, nonatomic) IBOutlet UIImageView        *m_imageView;

@property (weak, nonatomic) IBOutlet UILabel            *m_nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView        *m_whiteImageV;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@end

@implementation AboutmeViewController

@synthesize m_deleteIndex;

@synthesize isChooseFrontCover;

@synthesize m_imageDic;

@synthesize m_dic;

@synthesize m_index;

@synthesize m_BigimageArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.m_imageArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        self.m_CommentArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        self.m_LeixingArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        self.m_DynamicArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        page = 1;
        
        m_deleteIndex = 0;
        
        m_index = 0;
        
        isChooseFrontCover = NO;
        
        m_imageDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_BigimageArray = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    page = 1;
    
    // 设置导航栏的标题
    [self setTitle:[CommonUtil getValueByKey:NICK]];
    
    if ( !self.isChooseFrontCover ) {
        
        [self hideTabBar:YES];
        
        if ( Appdelegate.isChange ) {
            
            //请求数据
            [self memberRequestSubmit];
            
            [self MyComment];
            
            Appdelegate.isChangeCover = YES;
            
            Appdelegate.isChange = NO;
        }
        
    }else{
        
//        if ( isIOS7 ) {
//            
//            for(UIView *view in self.tabBarController.view.subviews)
//            {
//                
//                if([view isKindOfClass:[UITabBar class]])
//                {
//                    
//                    if (self.tabBarController.tabBar.hidden) {
//                        [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width, 0)];
//                    }
//                }
//            }
//        }
        
    }
    
    self.isChooseFrontCover = NO;
    
    // label上面的链接网址可以点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openURLString:) name:@"OpenUrl" object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    // 判断是否隐藏tabBar
    if ( !self.isChooseFrontCover ) {
        // 修改选择了图片后产生的bug =======
//        if ( isIOS7 ) {
        
//            for(UIView *view in self.tabBarController.view.subviews)
//            {
//                
//                if([view isKindOfClass:[UITabBar class]])
//                {
//                    
//                    if (self.tabBarController.tabBar.hidden) {
//                        [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width, 49)];
//                        
//                    }
//                }
//                
//            }
            
//        }
        //=========
        
        [self hideTabBar:NO];
        
    }else{
        
        
    }
    
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"OpenUrl" object:nil];
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(LeftClicked)];
    
    [self setheard];//资料
    
    [self.m_coverBtn addTarget:self action:@selector(ChangeTheCoverImage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView = YES;
    
    self.m_tableView.hidden = NO;
    
    self.m_activityV.hidden = YES;
    
    self.m_emptyLabel.hidden = YES;
    
    //请求数据
    [self memberRequestSubmit];
    
    // 请求接口
    [self MyComment];
    
    // 设置默认类型为好友动态
    self.m_typeString = KEY_DYNAMIC_FRIENDS;
    
}

- (void)LeftClicked{
    
    [self goBack];
}

//关于我的
- (void)setheard
{
    
    [self.m_heardBtn.layer setMasksToBounds:YES];
    
    [self.m_heardBtn.layer setCornerRadius:30.0];
    
    [self.m_headerImageView.layer setMasksToBounds:YES];
    
    [self.m_headerImageView.layer setCornerRadius:30.0];
    
    [self.m_heardBtn addTarget:self action:@selector(AboutMe) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置为白色的背景
    [self.m_whiteImageV.layer setMasksToBounds:YES];
    
    [self.m_whiteImageV.layer setCornerRadius:30.0];
    
}

- (void)AboutMe
{
    PersonalViewController * VC = [[PersonalViewController alloc]initWithNibName:@"PersonalViewController" bundle:nil];
    
    [self.navigationController pushViewController:VC animated:YES];
    
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_DynamicArray.count;
    
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
    
    cell.m_zanView.hidden = YES;
    
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
        
    
    cell.m_zhuanzai.text = @"转发";
    
    cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"NickName"]];
    
    cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"CreateDate"]];
    
    cell.m_fromLabel.text = [NSString stringWithFormat:@"来自:%@",[Dydic objectForKey:@"Source"]];
    
    CGSize namesize = [cell.m_nameLabel.text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(90, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
    cell.m_nameLabel.frame = CGRectMake(cell.m_nameLabel.frame.origin.x, cell.m_nameLabel.frame.origin.y, namesize.width, 26);
    cell.m_zhuanzai.frame = CGRectMake(cell.m_nameLabel.frame.origin.x+cell.m_nameLabel.frame.size.width, cell.m_zhuanzai.frame.origin.y, cell.m_zhuanzai.frame.size.width, cell.m_zhuanzai.frame.size.height);
    
    [cell.m_DelBtn setTitle:@"删除" forState:UIControlStateNormal];
    cell.m_DelBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    cell.m_DelBtn.tag = indexPath.row;
    [cell.m_DelBtn addTarget:self action:@selector(DeleAboutMe:) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    
    CTFontRef verdana = CTFontCreateWithName((CFStringRef)@"Verdana",13,NULL);
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
    
    //发表说说的点击头像
    cell.m_PhotoBtn.tag = indexPath.row;
    [cell.m_PhotoBtn addTarget:self action:@selector(PhotoBtn:) forControlEvents:UIControlEventTouchUpInside];
    
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
        label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二NSLineBreakByCharWrapping
        
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
            label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
            
            
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
                [PINGLUMOREbtn setFrame:CGRectMake(0, cell.m_commentView.frame.size.height, 233, 25)];
                
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
            label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
            
            
            [cell.m_commentView setFrame:CGRectMake(80, cell.m_recourceView.frame.origin.y +cell.m_recourceView.frame.size.height , cell.m_commentView.frame.size.width, pingluHIGHT2)];
            
            [cell.m_commentView addSubview:label];
            
            
        }
        
    }
    
    
    cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x, cell.m_commentView.frame.origin.y + cell.m_commentView.frame.size.height, cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
    
    cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
    
    
    
    return cell;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ( self.m_DynamicArray.count != 0 ) {
        
        NSDictionary * Dydic = [self.m_DynamicArray objectAtIndex:indexPath.row];
        self.m_typeString = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"DynamicType"]];
        
        if ( [self.m_typeString isEqualToString:KEY_DYNAMIC_FRIENDS] ||[self.m_typeString isEqualToString:KEY_DYNAMIC_FromFRIENDS] )
        {
            
            static NSString *cellIdentifier = @"DynamicCellIdentifier";
            
            DynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ( cell == nil ) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DynamicCell" owner:self options:nil];

                cell = (DynamicCell *)[nib objectAtIndex:0];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            cell.m_zanView.hidden = YES;
            
            //昵称
            cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"NickName"]];
            
            cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"CreateDate"]];
            
            cell.m_fromLabel.text = [NSString stringWithFormat:@"来自:%@",[Dydic objectForKey:@"Source"]];
            
            CGSize namesize = [cell.m_nameLabel.text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(90, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
            
            cell.m_nameLabel.frame = CGRectMake(cell.m_nameLabel.frame.origin.x, cell.m_nameLabel.frame.origin.y, namesize.width, 26);
            cell.m_zhuanzai.frame = CGRectMake(cell.m_nameLabel.frame.origin.x+cell.m_nameLabel.frame.size.width, cell.m_zhuanzai.frame.origin.y, cell.m_zhuanzai.frame.size.width, cell.m_zhuanzai.frame.size.height);
            
            [cell.m_DelBtn setTitle:@"删除" forState:UIControlStateNormal];
            cell.m_DelBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
            cell.m_DelBtn.tag = indexPath.row;
            [cell.m_DelBtn addTarget:self action:@selector(DeleAboutMe:) forControlEvents:UIControlEventTouchUpInside];
            
            NSString * FormNickName = @"";
            
            //不是转发
            if ([[NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormDynamicType"] ]isEqualToString:@""]) {
                
                cell.m_zhuanzai.text = @"分享";
                //内容
                cell.m_contentLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"Contents"]];
                //图片列表
                self.m_imageArray = [Dydic objectForKey:@"DynamicPicList"];
                
            }//是转发
            else if (![[Dydic objectForKey:@"FormDynamicType"]isEqualToString:@""])
            {
                if ([[Dydic objectForKey:@"FormDynamicType"] isEqualToString:KEY_DYNAMIC_FRIENDS]||[[Dydic objectForKey:@"FormDynamicType"] isEqualToString:KEY_DYNAMIC_FromFRIENDS]) {
                    
                    self.m_imageArray = [Dydic objectForKey:@"ForwardingDynPicList"];
                    
                    cell.m_zhuanzai.text = @"转发";
                    FormNickName = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormNickName"]];
                    
                    if ( FormNickName.length != 0) {
                        
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
                else if ([[Dydic objectForKey:@"FormDynamicType"] isEqualToString: KEY_DYNAMIC_SvcShare]||[[Dydic objectForKey:@"FormDynamicType"] isEqualToString: KEY_DYNAMIC_WebViewShare]||[[Dydic objectForKey:@"FormDynamicType"] isEqualToString: KEY_DYNAMIC_DianPingShare])
                {
                    
                    
                    return  [self tableViewSHA:tableView cellForRowAtIndexPath:indexPath DIC:Dydic] ;
                    
                }
                
                
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
            
            
            
            // 设置label，可以点击链接地址
            MarkupParser* p = [[MarkupParser alloc] init];
            // 清空数组重新赋值
            [p.images removeAllObjects];
            
            [cell.m_contentLabel.imageInfoArr removeAllObjects];
            
            NSMutableAttributedString* attString = [p attrStringFromMarkup:[Dydic objectForKey:@"Contents"]];
            CTFontRef verdana = CTFontCreateWithName((CFStringRef)@"Verdana",13,NULL);
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
            
            
            
            // 评论数组进行赋值
            self.m_CommentArray = [Dydic objectForKey:@"DynamicComment"];
            
            
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
                    label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                    
                    
                    [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height, cell.m_commentView.frame.size.width, pinglu.height)];
                    
                    [cell.m_commentView addSubview:label];
                    
                    
                }
                else if (self.m_CommentArray.count==2) {
                    
                    CGFloat pingluHIGHT2 = 0;
                    
                    cell.m_commentView.hidden =NO;
                    
                    for (int i=0; i<self.m_CommentArray.count; i++) {
                        
                        
                        NSDictionary * dic = [self.m_CommentArray objectAtIndex:i];
                        
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
                        label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                        
                        
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
                        label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                        
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
                    label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                    
                    [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height+ cell.m_ImgView.frame.size.height , cell.m_commentView.frame.size.width, pinglu.height)];
                    
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
                        label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                        
                        
                        [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height+ cell.m_ImgView.frame.size.height , cell.m_commentView.frame.size.width, pingluHIGHT2)];
                        
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
                        label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                        
                        
                        [cell.m_commentView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y +size.height+ cell.m_ImgView.frame.size.height , cell.m_commentView.frame.size.width, pingluHIGHT2)];
                        
                        [cell.m_commentView addSubview:label];
                        
                        
                    }
                    
                }
                
                
                cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x, cell.m_commentView.frame.origin.y+cell.m_commentView.frame.size.height, cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
                
                cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
                
                
            }
            
            
            return cell;
            
        }
        else if ( [self.m_typeString isEqualToString: KEY_DYNAMIC_SvcShare]||[self.m_typeString isEqualToString: KEY_DYNAMIC_WebViewShare]||[self.m_typeString isEqualToString: KEY_DYNAMIC_DianPingShare]){
            
            
            static NSString *cellIdentifier = @"DynamicDetailCellIdentifier";
            
            DynamicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ( cell == nil ) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DynamicCell" owner:self options:nil];
                
                cell = (DynamicDetailCell *)[nib objectAtIndex:1];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            cell.m_zanView.hidden = YES;
            
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
            
            cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"NickName"]];
            
            cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"CreateDate"]];
            
            cell.m_fromLabel.text = [NSString stringWithFormat:@"来自:%@",[Dydic objectForKey:@"Source"]];
            
            CGSize namesize = [cell.m_nameLabel.text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(90, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
            cell.m_nameLabel.frame = CGRectMake(cell.m_nameLabel.frame.origin.x, cell.m_nameLabel.frame.origin.y, namesize.width, 26);
            cell.m_zhuanzai.frame = CGRectMake(cell.m_nameLabel.frame.origin.x+cell.m_nameLabel.frame.size.width, cell.m_zhuanzai.frame.origin.y, cell.m_zhuanzai.frame.size.width, cell.m_zhuanzai.frame.size.height);
            
            
            [cell.m_DelBtn setTitle:@"删除" forState:UIControlStateNormal];
            cell.m_DelBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
            cell.m_DelBtn.tag = indexPath.row;
            [cell.m_DelBtn addTarget:self action:@selector(DeleAboutMe:) forControlEvents:UIControlEventTouchUpInside];
            
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
            
            self.m_CommentArray = [Dydic objectForKey:@"DynamicComment"];
            
            
            cell.m_contentLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"Contents"]];
            
            cell.m_titleLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"Title"]];
            
            cell.m_SubtitleLabel.text = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"SubTitle"]];
            
            
            // 设置label，可以点击链接地址
            MarkupParser* p = [[MarkupParser alloc] init];
            // 清空数组重新赋值
            [p.images removeAllObjects];
            
            [cell.m_contentLabel.imageInfoArr removeAllObjects];
            
            NSMutableAttributedString* attString = [p attrStringFromMarkup:[Dydic objectForKey:@"Contents"]];
            CTFontRef verdana = CTFontCreateWithName((CFStringRef)@"Verdana",13,NULL);
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
            
            
            
            CGSize size;
            
            if ([cell.m_contentLabel.text isEqualToString:@""]) {
                size.height = 0.f;
            }else{
                
                size= [cell.m_contentLabel.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            }
            
            cell.m_contentLabel.frame = CGRectMake(cell.m_contentLabel.frame.origin.x, cell.m_contentLabel.frame.origin.y, 233, size.height+3);
            
            cell.m_recourceView.frame = CGRectMake(cell.m_recourceView.frame.origin.x, cell.m_contentLabel.frame.origin.y + size.height + 5, cell.m_recourceView.frame.size.width, cell.m_recourceView.frame.size.height);
            
            
            
            
            if (self.m_CommentArray.count == 0) {
                
                cell.m_commentView.hidden =YES;
                
                cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x,cell.m_recourceView.frame.origin.y + cell.m_recourceView.frame.size.height  , cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
                
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
                label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                
                [cell.m_commentView setFrame:CGRectMake(80,  cell.m_recourceView.frame.origin.y + cell.m_recourceView.frame.size.height , cell.m_commentView.frame.size.width, pinglu.height)];
                
                [cell.m_commentView addSubview:label];
                
            }
            else if (self.m_CommentArray.count==2) {
                
                cell.m_commentView.hidden =NO;

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
                    label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                    
                    
                    [cell.m_commentView setFrame:CGRectMake(80, cell.m_recourceView.frame.origin.y +cell.m_recourceView.frame.size.height , cell.m_commentView.frame.size.width, pingluHIGHT2)];
                    
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
                    label.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                    
                    
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
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.m_DynamicArray.count == 0) {
        
        return 0;
    }
    
    
    NSDictionary * Dydic = [self.m_DynamicArray objectAtIndex:indexPath.row];
    
    self.m_typeString = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"DynamicType"]];
    
    self.m_CommentArray = [Dydic objectForKey:@"DynamicComment"];
    
    if ( [self.m_typeString isEqualToString: KEY_DYNAMIC_FRIENDS]||[self.m_typeString isEqualToString: KEY_DYNAMIC_FromFRIENDS]) {
        
        NSString *ssstring = @"";
        
        //好友动态
        if ([self.m_typeString isEqualToString: KEY_DYNAMIC_FRIENDS]) {
            
            ssstring =  [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"Contents"]];
            
            self.m_imageArray = [Dydic objectForKey:@"DynamicPicList"];
            
        }
        //转发
        else if ([self.m_typeString isEqualToString: KEY_DYNAMIC_FromFRIENDS])
        {
            
            self.m_imageArray = [Dydic objectForKey:@"ForwardingDynPicList"];
            
            //转发
            if (![[Dydic objectForKey:@"FormDynamicType"]isEqualToString:@""])
            {
                if ([[Dydic objectForKey:@"FormDynamicType"] isEqualToString:KEY_DYNAMIC_FRIENDS]||[[Dydic objectForKey:@"FormDynamicType"] isEqualToString:KEY_DYNAMIC_FromFRIENDS]) {
                    
                    NSString * FromName = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormNickName"]];
                    ssstring =  [NSString stringWithFormat:@"%@:%@",FromName,[Dydic objectForKey:@"ForwardingContents"]];
                    
                }
                else if ([[Dydic objectForKey:@"FormDynamicType"] isEqualToString: KEY_DYNAMIC_SvcShare]||[[Dydic objectForKey:@"FormDynamicType"] isEqualToString: KEY_DYNAMIC_WebViewShare]||[[Dydic objectForKey:@"FormDynamicType"] isEqualToString: KEY_DYNAMIC_DianPingShare])
                {
                    
                    
                    NSString * FromName = [NSString stringWithFormat:@"%@",[Dydic objectForKey:@"FormNickName"]];
                    
                    NSString * zfstring = @"";
                    if ( FromName.length != 0 ) {
                        
                        //不同颜色
                        zfstring = [NSString stringWithFormat:@"%@|%@:%@",[Dydic objectForKey:@"Contents"],FromName,[Dydic objectForKey:@"ForwardingContents"]];
                        
                    }else{
                        
                        zfstring =[NSString stringWithFormat:@"%@|%@",[Dydic objectForKey:@"Contents"],[Dydic objectForKey:@"ForwardingContents"]];
                    }
                    
                    CGSize zfsize ;
                    
                    if ([zfstring isEqualToString:@""]) {
                        
                        zfsize.height = 0.f;
                        
                    }else{
                        zfsize= [zfstring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                    }
                    
                    if (self.m_CommentArray.count == 0) {
                        
                        return 39 + zfsize.height + 70 + 29;
                        
                    }else if (self.m_CommentArray.count == 1){
                        
                        NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
                        NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                        
                        CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                        
                        return 39 + zfsize.height + 70 + 29 +size1.height;
                        
                        
                    }else if (self.m_CommentArray.count == 2){
                        
                        CGFloat SIZEPING = 0;
                        
                        for (int i=0; i<2; i++) {
                            
                            NSDictionary * dic = [self.m_CommentArray objectAtIndex:i];
                            NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                            
                            CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                            
                            SIZEPING =SIZEPING+size1.height;
                            
                            
                        }
                        
                        return 39 + zfsize.height + 70 + 29 +SIZEPING;
                        
                        
                        
                    }else if (self.m_CommentArray.count >=3){
                        
                        CGFloat SIZEPING = 0;
                        
                        for (int i=0; i<2; i++) {
                            
                            NSDictionary * dic = [self.m_CommentArray objectAtIndex:i];
                            NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                            
                            CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                            
                            SIZEPING =SIZEPING+size1.height;
                            
                        }
                        return 39 + zfsize.height + 70 + 29 +SIZEPING +25;
                        
                    }
                    
                }
                
            }
            
        }
        
        
        CGSize size = [ssstring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        
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
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:i];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    SIZEPING =SIZEPING+size1.height;
                    
                }
                
                return 39 + size.height + 30 + +SIZEPING -5;
                
                
            }else if (self.m_CommentArray.count >=3){
                
                CGFloat SIZEPING = 0;
                
                for (int i=0; i<2; i++) {
                    
                    NSDictionary * dic = [self.m_CommentArray objectAtIndex:i];
                    NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                    
                    CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                    
                    SIZEPING =SIZEPING+size1.height;
                    
                }
                return 39 + size.height + 30 +  +SIZEPING +29;
                
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
            
            return 39 + size.height + 70 + 29  ;
            
            
        }else if (self.m_CommentArray.count == 1){
            
            NSDictionary * dic = [self.m_CommentArray objectAtIndex:0];
            NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
            
            CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            return 39 + size.height + 70 + 29 +size1.height ;
            
        }else if (self.m_CommentArray.count == 2){
            
            CGFloat SIZEPING = 0;
            
            for (int i=0; i<2; i++) {
                
                NSDictionary * dic = [self.m_CommentArray objectAtIndex:i];
                NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                
                CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                SIZEPING =SIZEPING+size1.height;
                
            }
            
            return 39 + size.height + 70 +SIZEPING +29 ;
            
            
        }else if (self.m_CommentArray.count >=3){
            
            CGFloat SIZEPING = 0;
            
            for (int i=0; i<2; i++) {
                
                NSDictionary * dic = [self.m_CommentArray objectAtIndex:i];
                NSString *pinglustring =[NSString stringWithFormat:@"%@:%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"Contents"]];
                
                CGSize size1 = [pinglustring sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                SIZEPING =SIZEPING+size1.height;
                
            }
            
            return 39 + size.height + 70 + 29 +SIZEPING + 25  ;
            
        }
        
    }
    
    return 0;
    
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





-(void)MorepingluView:(id)Btn
{
    
    UIButton *btn = (UIButton *)Btn;
    
    NSMutableDictionary *dic = [self.m_DynamicArray objectAtIndex:btn.tag];
    
    MorecommentViewController * VC = [[MorecommentViewController alloc]initWithNibName:@"MorecommentViewController" bundle:nil];
    
    VC.m_MoreDIC  = dic;
    
    [self.navigationController pushViewController:VC animated:YES];
    
    
}



#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}


#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
	[picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image=[[UIImage alloc]init];
    if (pickerorphoto==0)
    {
        image = [info objectForKey:UIImagePickerControllerEditedImage];
        
    }else if (pickerorphoto==1)
    {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    [self saveImage:image withName:@"currentImage.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    
    self.m_activityV.hidden = NO;
    
    [self.m_activityV startAnimating];
    
    
    UIImageView * Imageview = [[UIImageView alloc]init];
    Imageview.image = savedImage;
    
    // 保存图片到字典用于请求数据
    [self.m_imageDic setValue:[self getImageData:Imageview] forKey:@"frontCover"];
    
    
    // 请求数据
    [self modifyPictureRequest];
    
    //=======
    
}

- (NSData *)getImageData:(UIImageView *)imageView {
    UIImage *iamge = imageView.image;
    return UIImageJPEGRepresentation(iamge, 1);
}

//截取图片
- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    // [self.m_coverBtn setBackgroundImage:newImage forState:UIControlStateNormal];
    
    self.m_imageView.image = newImage;
    
    // 保存图片到字典用于请求数据
    [self.m_imageDic setValue:[self getImageData:self.m_imageView] forKey:@"frontCover"];
    
    // 请求数据
    [self modifyPictureRequest];
    
    return newImage;
}

//更换封面
- (void)ChangeTheCoverImage
{
    
    UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:@"更换封面" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"立即拍照",@"相册选取", nil];
    sheet.tag = 10001;
    [sheet showInView:self.view];
}


- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 10001)
    {
        
        //打开照相
        if (buttonIndex==0)
        {
            self.isChooseFrontCover = YES;
            
            pickerorphoto = 1;
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                [self presentViewController:imagePicker animated:YES completion:^{
                    
                }];
            }
            else{
                
                self.isChooseFrontCover = NO;
                
                //如果没有提示用户
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"手机没有摄像头" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
        }
        
        //打开相册
        if (buttonIndex == 1) {
            
            self.isChooseFrontCover = YES;
            
            pickerorphoto = 0;
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];//打开照片文件
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            
            [self presentViewController:imagePicker animated:YES completion:^{
            }];
            
        }
    }
    
}

-(void)DeleAboutMe:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    self.m_deleteIndex = btn.tag;
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                       message:@"确定删除？"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    alertView.tag = 100005;
    [alertView show];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 100005 ) {
        if ( buttonIndex == 1 ) {
            //            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            
            // 删除数据请求接口
            [self deleteDynamicRequest];
            
        }
    }
    
}

// 删除某条动态
- (void)deleteDynamicRequest{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSMutableDictionary *dic = [self.m_DynamicArray objectAtIndex:self.m_deleteIndex];
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedSpace];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [NSString stringWithFormat:@"%@",[dic objectForKey:@"DynamicID"]],@"dynamicID",
                           nil];
    [SVProgressHUD showWithStatus:@"数据删除中…"];
    [httpClient requestSpace:@"DynamicDelete.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            [self.deldele deldelegate];
            // 删除成功后重新刷新数据
            [self MyComment];
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"删除失败"];
    }];
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



//请求数据 我的动态
-(void)MyComment
{
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
                           [NSString stringWithFormat:@"%d",page],@"pageIndex",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient requestSpace:@"DynamicAboutMeList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [json valueForKey:@"DynamicList"];
            if (page == 1) {
                if (metchantShop == nil || metchantShop.count == 0) {
                    [self.m_DynamicArray removeAllObjects];
                    self.m_emptyLabel.hidden = NO;
                    [SVProgressHUD showErrorWithStatus:@"暂无动态"];
                    [self.m_tableView reloadData];
                    return;
                } else {
                    self.m_DynamicArray = metchantShop;
                }
            } else {
                if (metchantShop == nil || metchantShop.count == 0) {
                    page--;
                } else {
                    [self.m_DynamicArray addObjectsFromArray:metchantShop];
                }
            }
            self.m_tableView.hidden = NO;
            self.m_emptyLabel.hidden = YES;
            [self.m_tableView reloadData];
            
        } else {
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
        if (page > 1) {
            page--;
        }
        //self.tableView.pullLastRefreshDate = [NSDate date];
        [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    }];
    
}


#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    page = 1;
    
    [self MyComment];
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
    page ++;
    
    [self MyComment];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - NetWork
// 会员信息请求数据
- (void)memberRequestSubmit{
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
                                                     
                                                     self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(WindowSizeWidth, 135)];
                                                     
                                                 }
                                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                     
                                                 }];
            }
            
            
            // 头像
            NSString *userHeadImage = /*[self.m_dic objectForKey:@"PhotoMidUrl"];*/[CommonUtil getValueByKey:USER_PHOTO];
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
                                                           self.m_headerImageView.contentMode = UIViewContentModeScaleAspectFit;
                                                           
                                                       }
                                                       failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                           
                                                       }];
            }
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
    }];
    
}


// 修改用户的背景图片请求数据
- (void)modifyPictureRequest{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        // 没有网络的情况下，还原图片值
        [self getImage];
        return;
    }
    NSString * memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString * key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedSpace];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           nil];
    [SVProgressHUD showWithStatus:@"图片上传中"];
    [httpClient multiRequestSpace:@"DynamicConfigAdd.ashx" parameters:param files:self.m_imageDic success:^(NSJSONSerialization* json){
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            NSString *msg=[json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            // 停止转圈圈
            if ( [self.m_activityV isAnimating] ) {
                [self.m_activityV stopAnimating];
            }
            self.m_activityV.hidden = YES;
            [self memberRequestSubmit];//请求用户信息（封面）
            // 设置了封面的BOOL值,用于上个页面刷新数据
            Appdelegate.isChangeCover = YES;
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            // 请求失败的话，还原图片值
            [self getImage];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"图片修改失败"];
        // 请求失败的话，还原图片值
        [self getImage];
        
    }];
    
}

- (void)getImage{
    
    // 停止转圈圈
    if ( [self.m_activityV isAnimating] ) {
        
        [self.m_activityV stopAnimating];
    }
    
    self.m_activityV.hidden = YES;
    
    
    NSString *headImage = [self.m_dic objectForKey:@"FrontCover"];
    
    [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:headImage]]
                            placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                         
                                         self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(WindowSizeWidth, 135)];
                                         
                                     }
                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                         
                                     }];
    
}


- (void)productDetail:(id)sender{
    // 进入商品详情-商品
    ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
    
    VC.m_FromDPId = @"0";
    
    VC.m_productId = [NSString stringWithFormat:@"%@",[sender objectForKey:@"ServiceID"]];
    VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[sender objectForKey:@"MerchantShopID"]];
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)activityDetail:(id)sender{
    
    // 进入商品详情 - 活动
    ActivityDetailViewController *VC = [[ActivityDetailViewController alloc]initWithNibName:@"ActivityDetailViewController" bundle:nil];
    
    VC.m_typeString = MERCHANTACTIVITY;
    VC.m_partyString = @"1";
    VC.m_serviceId = [NSString stringWithFormat:@"%@",[sender objectForKey:@"ActivityID"]];
    
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)DPDetail:(id)sender{
    
    // 进入商品详情 -点评
    ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
    
    VC.m_FromDPId = @"1";
    
    VC.m_productId = [NSString stringWithFormat:@"%@",[sender objectForKey:@"DealId"]];
    
    
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark - OPen URL
- (void)openURLString:(NSNotification *)notification{
    
    NSString *string = [NSString stringWithFormat:@"%@",[notification.userInfo objectForKey:@"urlString"]];
    
    // 进入网页页面
    WebViewController *VC = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
    VC.m_scanString = string;
    VC.m_typeString = @"2";
    [self.navigationController pushViewController:VC animated:YES];
    
}

@end
