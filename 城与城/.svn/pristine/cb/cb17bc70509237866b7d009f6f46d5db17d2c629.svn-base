//
//  MorecommentViewController.m
//  HuiHui
//
//  Created by 冯海强 on 14-5-8.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "MorecommentViewController.h"

#import "ZanListViewController.h"

#import "MarkupParser.h"

#import "WebViewController.h"

#import "ActivityDetailViewController.h"

#import "ProductDetailViewController.h"

#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface MorecommentViewController ()

@property (weak, nonatomic) IBOutlet UITableView    *m_tableView;

@property (strong, nonatomic) IBOutlet UIView *m_commentView;

@property (weak, nonatomic) IBOutlet UITextField *m_commentTextField;

@property (nonatomic, strong) UITextField *m_textField;

@end

@implementation MorecommentViewController

@synthesize m_index;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.m_imageArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.m_praiseArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.m_MoreDIC = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        self.m_commentArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_index = 0;
        
    }
    return self;
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"评论详情"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(LeftClicked)];
    
    self.m_tableView.hidden = YES;
    
    if ( isIOS7 ) {
        
        // tableView的线往右移了，添加这代码可以填充
        if ([self.m_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.m_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
    }
    
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    
    textField.delegate = self;
    
    self.m_textField = textField;
    
    [self.view addSubview:self.m_textField];
    
    self.m_textField.hidden = YES;
    
    self.m_textField.inputAccessoryView = self.m_commentView;
    
    self.m_commentTextField.delegate = self;
    
    imagechage = [[ImageCache alloc] init];
    
    
    [self Zanlist];//赞的人
    
    [self setExtraCellLineHidden:self.m_tableView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // 隐藏tabBar
    [self hideTabBar:YES];
    
    // label上面的链接网址可以点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openURLString:) name:@"OpenUrl" object:nil];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"OpenUrl" object:nil];
    
    [self.m_commentTextField resignFirstResponder];
    [self.m_textField resignFirstResponder];
    
    [self.view endEditing:YES];
    
    
}

- (void)LeftClicked{
    
    [self goBack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableViewSHA:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellIdentifier = @"DynamicDetailCellIdentifier";
    
    DynamicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DynamicCell" owner:self options:nil];
        
        cell = (DynamicDetailCell *)[nib objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    cell.m_linkBtn.tag = indexPath.row;//链接按钮；
    [cell.m_linkBtn addTarget:self action:@selector(resourcelink:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.m_DelBtn.hidden = YES;
    cell.m_tempView.hidden = YES;
    cell.m_commentView.hidden= YES;
    cell.m_lineImgV.hidden = YES;
    
    cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"NickName"]];
    
    cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"CreateDate"]];
    
    cell.m_fromLabel.text = [NSString stringWithFormat:@"来自:%@",[self.m_MoreDIC objectForKey:@"Source"]];
    
    CGSize namesize = [cell.m_nameLabel.text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(90, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
    cell.m_nameLabel.frame = CGRectMake(cell.m_nameLabel.frame.origin.x, cell.m_nameLabel.frame.origin.y, namesize.width, 26);
    cell.m_zhuanzai.frame = CGRectMake(cell.m_nameLabel.frame.origin.x+cell.m_nameLabel.frame.size.width, cell.m_zhuanzai.frame.origin.y, cell.m_zhuanzai.frame.size.width, cell.m_zhuanzai.frame.size.height);
    
    
    
    UIImageView*imv=[[UIImageView alloc]init];
    UIImage *reSizeImage = [imagechage getImage:[self.m_MoreDIC objectForKey:@"PhotoMidUrl"]];
    if (reSizeImage != nil){
        cell.m_imageView.image = reSizeImage;}
    else{
        [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"PhotoMidUrl"]]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            cell.m_imageView.image = image;
            [imagechage addImage:image andUrl:[self.m_MoreDIC objectForKey:@"PhotoMidUrl"]];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        }];}
    
    
    
    self.m_imageArray = [self.m_MoreDIC objectForKey:@"ForwardingDynPicList"];
    
    NSLog(@"%@",self.m_MoreDIC);
    
    
    if (self.m_imageArray.count==0) {
        
        
        if ([[NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormDynamicType"]] isEqualToString: KEY_DYNAMIC_SvcShare]) {
            [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
            
        }else if ([[NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormDynamicType"]] isEqualToString: KEY_DYNAMIC_ActShare])
        {
            [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
            
        }else if ([[NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormDynamicType"]] isEqualToString: KEY_DYNAMIC_WebViewShare])
        {
            [cell.self.m_imgV setImage:[UIImage imageNamed:@"lianjie.png"]];
            
        }else if ([[NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormDynamicType"]] isEqualToString: KEY_DYNAMIC_DianPingShare]){
            
            [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
            
        }
        
        
    }else{
        NSDictionary * imageDic = [self.m_imageArray objectAtIndex:0];
        
        NSString *path=[NSString stringWithFormat:@"%@",[imageDic objectForKey:@"MidImgUrl"]];
        
        [cell ShareCellimage:path];
    }
    
    
    cell.m_titleLabel.text = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormTitle"]];
    cell.m_SubtitleLabel.text = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormSubTitle"]];
    
    NSString * FormNickName = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormNickName"]];
    
    NSMutableAttributedString *attributedString;
    
    if ( FormNickName.length != 0) {
        
        attributedString= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@|%@:%@",[self.m_MoreDIC objectForKey:@"Contents"],FormNickName,[self.m_MoreDIC objectForKey:@"ForwardingContents"]]];
        
             if ([NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"Contents"]].length !=0) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:108.0/255 green:166.0/255  blue:205.0/255 alpha:1.0f] range:NSMakeRange([[self.m_MoreDIC objectForKey:@"Contents"] length] + 1,[FormNickName length])];
             }
        
        //内容
        cell.m_contentLabel.attributedText = attributedString;
        
    }else{
        
        
        attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@|%@",[self.m_MoreDIC objectForKey:@"Contents"],[self.m_MoreDIC objectForKey:@"ForwardingContents"]]];
        
         if ([NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"Contents"]].length !=0) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([[self.m_MoreDIC objectForKey:@"Contents"] length] + 1,[[self.m_MoreDIC objectForKey:@"Contents"],[self.m_MoreDIC objectForKey:@"ForwardingContents"] length])];
         }
        
        //内容
        cell.m_contentLabel.attributedText = attributedString;
    }
    
    CGSize size;
    
    if ([cell.m_contentLabel.text isEqualToString:@""]) {
        size.height = 0.f;
    }else{
        
        size= [cell.m_contentLabel.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    cell.m_contentLabel.frame = CGRectMake(cell.m_contentLabel.frame.origin.x, cell.m_contentLabel.frame.origin.y, 233, size.height+3);
    
    
    cell.m_recourceView.frame = CGRectMake(cell.m_recourceView.frame.origin.x, cell.m_contentLabel.frame.origin.y + size.height + 5, cell.m_recourceView.frame.size.width, cell.m_recourceView.frame.size.height);
    
    cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x,cell.m_recourceView.frame.origin.y + cell.m_recourceView.frame.size.height , cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
    
    cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
    
    // 设置label，可以点击链接地址
    MarkupParser* p = [[MarkupParser alloc] init];
    // 清空数组重新赋值
    [p.images removeAllObjects];
    [cell.m_contentLabel.imageInfoArr removeAllObjects];
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",cell.m_contentLabel.text]];
    CTFontRef verdana = CTFontCreateWithName((CFStringRef)@"Verdana",14,NULL);
    [attString addAttribute:(NSString*)(kCTFontAttributeName) value:(__bridge id)verdana range:NSMakeRange(0, attString.length)];
    [cell.m_contentLabel setAttString:attString withImages:p.images];
    
    
    return cell;
    
    
    
}





#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_commentArray.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        
        self.m_typeString = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"DynamicType"]];
        
        if ( [self.m_typeString isEqualToString: KEY_DYNAMIC_FRIENDS]||[self.m_typeString isEqualToString: KEY_DYNAMIC_FromFRIENDS]) {
            
            static NSString *cellIdentifier = @"DynamicCellIdentifier";
            
            DynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ( cell == nil ) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DynamicCell" owner:self options:nil];
                
                cell = (DynamicCell *)[nib objectAtIndex:0];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            cell.m_zanView.hidden = YES;
            
            cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"NickName"]];
            
            CGSize namesize = [cell.m_nameLabel.text sizeWithFont:[UIFont systemFontOfSize:18.0f] constrainedToSize:CGSizeMake(90, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
            cell.m_nameLabel.frame = CGRectMake(cell.m_nameLabel.frame.origin.x, cell.m_nameLabel.frame.origin.y, namesize.width, 26);
            cell.m_zhuanzai.frame = CGRectMake(cell.m_nameLabel.frame.origin.x+cell.m_nameLabel.frame.size.width, cell.m_zhuanzai.frame.origin.y, cell.m_zhuanzai.frame.size.width, cell.m_zhuanzai.frame.size.height);
            
            
            CGSize size = [cell.m_contentLabel.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            cell.m_contentLabel.frame = CGRectMake(cell.m_contentLabel.frame.origin.x, cell.m_contentLabel.frame.origin.y, 233, size.height+3);
            
            cell.m_tempView.hidden = YES;
            cell.m_commentView.hidden= YES;
            cell.m_lineImgV.hidden = YES;
            //头像
            
            NSString * FormNickName = @"";
            
            //好友动态
            if ([self.m_typeString isEqualToString: KEY_DYNAMIC_FRIENDS]) {
                
                //内容
                cell.m_contentLabel.text = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"Contents"]];
                
                cell.m_zhuanzai.text = @"分享";
                
                //图片列表
                self.m_imageArray = [self.m_MoreDIC objectForKey:@"DynamicPicList"];
                
            }
            //转发动态
            else if ([self.m_typeString isEqualToString: KEY_DYNAMIC_FromFRIENDS]) {
                
                
                if(![[NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormDynamicType"]]isEqualToString:@""])
                {
                    
                    if ([[NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormDynamicType"]]isEqualToString:KEY_DYNAMIC_SvcShare]||[[NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormDynamicType"]]isEqualToString:KEY_DYNAMIC_WebViewShare]||[[NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormDynamicType"]]isEqualToString:KEY_DYNAMIC_DianPingShare])
                    {
                        
                        return [self tableViewSHA:tableView cellForRowAtIndexPath:indexPath];
                        
                    }
                    
                }
                
                
                cell.m_zhuanzai.text = @"转发";
                FormNickName = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormNickName"]];
                
                //不同颜色
                
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@:%@",FormNickName,[self.m_MoreDIC objectForKey:@"ForwardingContents"]]];
                
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:108.0/255 green:166.0/255  blue:205.0/255 alpha:1.0f] range:NSMakeRange(0,[FormNickName length]+1)];
                
                //内容
                cell.m_contentLabel.attributedText = attributedString ;
                
                //图片列表
                self.m_imageArray = [self.m_MoreDIC objectForKey:@"ForwardingDynPicList"];
            }
            
            
            UIImageView*imv=[[UIImageView alloc]init];
            UIImage *reSizeImage = [imagechage getImage:[self.m_MoreDIC objectForKey:@"PhotoMidUrl"]];
            if (reSizeImage != nil){
                cell.m_imageView.image = reSizeImage;}
            else{
                [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"PhotoMidUrl"]]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                    cell.m_imageView.image = image;
                    [imagechage addImage:image andUrl:[self.m_MoreDIC objectForKey:@"PhotoMidUrl"]];
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                }];}
            
            
            
            for(id tmpView in cell.m_ImgView.subviews)
            {
                [tmpView removeFromSuperview];
            }
            
            
            if (self.m_imageArray.count == 0) {
                
                cell.m_ImgView.hidden =YES;
                
            }
            else if (self.m_imageArray.count>=1&&self.m_imageArray.count<=9)
            {
                cell.m_ImgView.hidden = NO;
                
                int line =0;
                
                if (self.m_imageArray.count<=3) {
                    [cell.m_ImgView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y + size.height,225, 80)];
                }else if (self.m_imageArray.count<=6){
                    line =1;
                    [cell.m_ImgView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y + size.height,225, 160)];
                    
                }else if (self.m_imageArray.count<=9){
                    line =2;
                    [cell.m_ImgView setFrame:CGRectMake(80, cell.m_contentLabel.frame.origin.y + size.height,225, 240)];
                    
                }
                
                for (int i=0; i<self.m_imageArray.count; i++) {
                    
                    NSDictionary * imageDic = [self.m_imageArray objectAtIndex:i];
                    NSString *path=[NSString stringWithFormat:@"%@",[imageDic objectForKey:@"MidImgUrl"]];
                    
                    UIImageView*imv=[[UIImageView alloc]init];
                    
                    UIButton * Btn = [[UIButton alloc]init];
                    
                    [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",path]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                        
                        [Btn setFrame:CGRectMake(5+(i%3*75), 5+(i/3*75), 70, 70)];
                        
                        [Btn setBackgroundImage:[CommonUtil scaleImage:image toSize:CGSizeMake(70, 70)] forState:UIControlStateNormal];
                        
                        [Btn addTarget:self action:@selector(ChangeBigImage:) forControlEvents:UIControlEventTouchUpInside];
                        
                        Btn.tag =i;
                        
                        [cell.m_ImgView addSubview:Btn];
                        
                        
                    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                        
                        [Btn setFrame:CGRectMake(5+(i%3*75), 5+(i/3*75), 70, 70)];
                        [Btn setBackgroundImage:[CommonUtil scaleImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] toSize:CGSizeMake(70, 70)] forState:UIControlStateNormal];
                        [Btn addTarget:self action:@selector(ChangeBigImage:) forControlEvents:UIControlEventTouchUpInside];
                        Btn.tag =i;
                        [cell.m_ImgView addSubview:Btn];
                    }];
                }
                
                cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x, cell.m_contentLabel.frame.origin.y + (size.height +(line+1)*80), cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
                
                cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
                
            }
            
            // 设置label，可以点击链接地址
            MarkupParser* p = [[MarkupParser alloc] init];
            // 清空数组重新赋值
            [p.images removeAllObjects];
            [cell.m_contentLabel.imageInfoArr removeAllObjects];
            NSMutableAttributedString* attString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",cell.m_contentLabel.text]];
            CTFontRef verdana = CTFontCreateWithName((CFStringRef)@"Verdana",14,NULL);
            [attString addAttribute:(NSString*)(kCTFontAttributeName) value:(__bridge id)verdana range:NSMakeRange(0, attString.length)];
            [cell.m_contentLabel setAttString:attString withImages:p.images];
            
            
            return cell;
            
            
        }
        else if ([self.m_typeString isEqualToString: KEY_DYNAMIC_SvcShare]||[self.m_typeString isEqualToString: KEY_DYNAMIC_WebViewShare]||[self.m_typeString isEqualToString: KEY_DYNAMIC_DianPingShare]){
            
            
            static NSString *cellIdentifier = @"DynamicDetailCellIdentifier";
            
            DynamicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ( cell == nil ) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DynamicCell" owner:self options:nil];
                
                cell = (DynamicDetailCell *)[nib objectAtIndex:1];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            cell.m_linkBtn.tag = indexPath.row;//链接按钮；
            [cell.m_linkBtn addTarget:self action:@selector(resourcelink:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.m_DelBtn.hidden = YES;
            cell.m_tempView.hidden = YES;
            cell.m_commentView.hidden= YES;
            cell.m_lineImgV.hidden = YES;
            
            cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"NickName"]];
            
            cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"CreateDate"]];
            
            cell.m_fromLabel.text = [NSString stringWithFormat:@"来自:%@",[self.m_MoreDIC objectForKey:@"Source"]];
            
            CGSize namesize = [cell.m_nameLabel.text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(90, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
            cell.m_nameLabel.frame = CGRectMake(cell.m_nameLabel.frame.origin.x, cell.m_nameLabel.frame.origin.y, namesize.width, 26);
            cell.m_zhuanzai.frame = CGRectMake(cell.m_nameLabel.frame.origin.x+cell.m_nameLabel.frame.size.width, cell.m_zhuanzai.frame.origin.y, cell.m_zhuanzai.frame.size.width, cell.m_zhuanzai.frame.size.height);
            
            
            
            UIImageView*imv=[[UIImageView alloc]init];
            UIImage *reSizeImage = [imagechage getImage:[self.m_MoreDIC objectForKey:@"PhotoMidUrl"]];
            
            if (reSizeImage != nil)
            {
                cell.m_imageView.image = reSizeImage;
            }
            else{
                
                [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"PhotoMidUrl"]]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                    cell.m_imageView.image = image;
                    [imagechage addImage:image andUrl:[self.m_MoreDIC objectForKey:@"PhotoMidUrl"]];
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                    
                }];
            }
            
            
            
            self.m_imageArray = [self.m_MoreDIC objectForKey:@"DynamicPicList"];
            
            if (self.m_imageArray.count==0) {
                
                
                if ([[NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"DynamicType"]] isEqualToString: KEY_DYNAMIC_SvcShare]) {
                    [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
                    
                }else if ([[NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"DynamicType"]] isEqualToString: KEY_DYNAMIC_ActShare])
                {
                    [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
                    
                }else if ([[NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"DynamicType"]] isEqualToString: KEY_DYNAMIC_WebViewShare])
                {
                    [cell.self.m_imgV setImage:[UIImage imageNamed:@"lianjie.png"]];
                    
                }else if ([[NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"DynamicType"]] isEqualToString: KEY_DYNAMIC_DianPingShare]){
                    
                    [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
                    
                }
                
                
            }else{
                NSDictionary * imageDic = [self.m_imageArray objectAtIndex:0];
                
                NSString *path=[NSString stringWithFormat:@"%@",[imageDic objectForKey:@"MidImgUrl"]];
                
                [cell ShareCellimage:path];
            }
            
            cell.m_titleLabel.text = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"Title"]];
            cell.m_SubtitleLabel.text = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"SubTitle"]];
            
            cell.m_contentLabel.text = [NSString stringWithFormat:@"%@",[self.self.m_MoreDIC objectForKey:@"Contents"]];
            
            CGSize size;
            
            if ([cell.m_contentLabel.text isEqualToString:@""]) {
                size.height = 0.f;
            }else{
                
                size= [cell.m_contentLabel.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            }
            
            cell.m_contentLabel.frame = CGRectMake(cell.m_contentLabel.frame.origin.x, cell.m_contentLabel.frame.origin.y, 233, size.height+3);
            
            
            cell.m_recourceView.frame = CGRectMake(cell.m_recourceView.frame.origin.x, cell.m_contentLabel.frame.origin.y + size.height + 5, cell.m_recourceView.frame.size.width, cell.m_recourceView.frame.size.height);
            
            cell.m_tempView.frame = CGRectMake(cell.m_tempView.frame.origin.x,cell.m_recourceView.frame.origin.y + cell.m_recourceView.frame.size.height , cell.m_tempView.frame.size.width, cell.m_tempView.frame.size.height);
            
            cell.m_lineImgV.frame = CGRectMake(cell.m_lineImgV.frame.origin.x, cell.m_tempView.frame.origin.y + cell.m_tempView.frame.size.height, cell.m_lineImgV.frame.size.width, cell.m_lineImgV.frame.size.height);
            
            
            
            // 设置label，可以点击链接地址
            MarkupParser* p = [[MarkupParser alloc] init];
            // 清空数组重新赋值
            [p.images removeAllObjects];
            [cell.m_contentLabel.imageInfoArr removeAllObjects];
            NSMutableAttributedString* attString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",cell.m_contentLabel.text]];
            CTFontRef verdana = CTFontCreateWithName((CFStringRef)@"Verdana",14,NULL);
            [attString addAttribute:(NSString*)(kCTFontAttributeName) value:(__bridge id)verdana range:NSMakeRange(0, attString.length)];
            [cell.m_contentLabel setAttString:attString withImages:p.images];
            
            
            return cell;
            
            
        }
        
        
        
    }
    //从第1行开始；
    else{
        //有没有人赞；如果没有人点赞
        
        if ( self.m_praiseArray.count == 0 ) {
            
            static NSString *cellIdentifier = @"MoreCommentCellIdentifier";
            
            MoreCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ( cell == nil ) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DynamicCell" owner:self options:nil];
                
                cell = (MoreCommentCell *)[nib objectAtIndex:2];
                
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                
            }
            if (indexPath.row == 1) {
                
                cell.hidden = YES;
                
                return cell;
            }else{
                
                cell.hidden = NO;
                
            }
            
            // 分割线隐藏
            cell.m_lineLabel.hidden = YES;

            NSDictionary * DIC = [self.m_commentArray objectAtIndex:indexPath.row-2];
            
            cell.m_Name.text = [DIC objectForKey:@"NickName"];
            cell.m_Time.text = [DIC objectForKey:@"CreateTime"];
            
            //评论的
            if ([[NSString stringWithFormat:@"%@",[DIC objectForKey:@"ToNickName"]]isEqualToString:@"<null>"]) {
                
                cell.m_contents.text = [DIC objectForKey:@"Contents"];
                
                CGSize size = [cell.m_contents.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(245, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                cell.m_contents.frame = CGRectMake(cell.m_contents.frame.origin.x, cell.m_contents.frame.origin.y, 245, size.height+3);
                
            }else{
                //回复评论的
                
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"回复%@:%@",[DIC objectForKey:@"ToNickName"],[DIC objectForKey:@"Contents"]]];
                
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:108.0/255 green:166.0/255  blue:205.0/255 alpha:1.0f] range:NSMakeRange(2,[[DIC objectForKey:@"ToNickName"] length]+1)];
                
                CGSize size = [[NSString stringWithFormat:@"回复%@:%@",[DIC objectForKey:@"ToNickName"],[DIC objectForKey:@"Contents"]] sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(245, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                //内容
                cell.m_contents.attributedText = attributedString;
                
                cell.m_contents.frame = CGRectMake(cell.m_contents.frame.origin.x, cell.m_contents.frame.origin.y, 245, size.height+3);
                
            }
            
            
            
            UIImageView*imv=[[UIImageView alloc]init];
            UIImage *reSizeImage = [imagechage getImage:[DIC objectForKey:@"PhotoMidUrl"]];
            
            if (reSizeImage != nil)
            {
                [cell.m_PhotoBtn setBackgroundImage:reSizeImage forState:UIControlStateNormal];
            }
            else{
                
                [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[DIC objectForKey:@"PhotoMidUrl"]]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                    [cell.m_PhotoBtn setBackgroundImage:reSizeImage forState:UIControlStateNormal];
                    [imagechage addImage:image andUrl:[DIC objectForKey:@"PhotoMidUrl"]];
                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                    
                }];
            }
            
            return cell;
            
        }
        //有人点赞
        else{
            
            if (indexPath.row == 1) {
                
                static NSString *cellIdentifier = @"PraiseCellIdentifier";
                
                PraiseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                
                if ( cell == nil ) {
                    
                    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DynamicCell" owner:self options:nil];
                    
                    cell = (PraiseCell *)[nib objectAtIndex:3];
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                }
                
                NSDictionary * Praisedic = [self.m_praiseArray objectAtIndex:0];
                NSString *PraiseLabel = [Praisedic objectForKey:@"NickName"];
                
                for (int i=1; i<self.m_praiseArray.count; i++) {
                    
                    NSDictionary * PDIC = [self.m_praiseArray objectAtIndex:i];
                    NSString *PLAB = [PDIC objectForKey:@"NickName"];
                    
                    PraiseLabel = [NSString stringWithFormat:@"%@、%@",PraiseLabel,PLAB];
                    
                }
                PraiseLabel = [NSString stringWithFormat:@"%@ 觉得很赞",PraiseLabel];
                
                CGSize size = [PraiseLabel sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                cell.m_PraiseLabel.text = PraiseLabel;
                cell.m_PraiseLabel.backgroundColor = [UIColor clearColor];
                cell.m_PraiseLabel.textColor = [UIColor lightGrayColor];
                [cell.m_PraiseLabel setFont:[UIFont systemFontOfSize:14.0f]];
                cell.m_PraiseLabel.numberOfLines = 0;// 不可少Label属性
                cell.m_PraiseLabel.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
                
                [cell.m_PraiseLabel setFrame:CGRectMake(20,5, 280,size.height)];
                
                return cell;
                
            }
            else  if (indexPath.row > 1) {
                
                static NSString *cellIdentifier = @"MoreCommentCellIdentifier";
                
                MoreCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                
                if ( cell == nil ) {
                    
                    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DynamicCell" owner:self options:nil];
                    
                    cell = (MoreCommentCell *)[nib objectAtIndex:2];
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleGray;
                    
                }
                
                // 分割线隐藏
                cell.m_lineLabel.hidden = YES;
                
                NSDictionary * DIC = [self.m_commentArray objectAtIndex:indexPath.row-2];
                
                //                cell.m_Name.text = [DIC objectForKey:@"NickName"];
                
                if ( ![[NSString stringWithFormat:@"%@",[DIC objectForKey:@"ToNickName"]]isEqualToString:@"<null>"] ) {
                    
                    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@回复%@",[DIC objectForKey:@"NickName"],[DIC objectForKey:@"ToNickName"]]];
                    
                    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange([[DIC objectForKey:@"NickName"] length],2)];
                    
                    //内容
                    cell.m_Name.attributedText = attributedString;
                    
                }else{
                    
                    cell.m_Name.text = [NSString stringWithFormat:@"%@",[DIC objectForKey:@"NickName"]];
                    
                }
                
                
                cell.m_Time.text = [DIC objectForKey:@"CreateTime"];
                cell.m_contents.text = [DIC objectForKey:@"Contents"];
                
                CGSize size = [cell.m_contents.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(245, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                cell.m_contents.frame = CGRectMake(cell.m_contents.frame.origin.x, cell.m_contents.frame.origin.y, 245, size.height+3);
                
                
                
                UIImageView*imv=[[UIImageView alloc]init];
                UIImage *reSizeImage = [imagechage getImage:[DIC objectForKey:@"PhotoMidUrl"]];
                
                if (reSizeImage != nil)
                {
                    [cell.m_PhotoBtn setBackgroundImage:reSizeImage forState:UIControlStateNormal];
                }
                else{
                    
                    [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[DIC objectForKey:@"PhotoMidUrl"]]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                        [cell.m_PhotoBtn setBackgroundImage:reSizeImage forState:UIControlStateNormal];
                        [imagechage addImage:image andUrl:[DIC objectForKey:@"PhotoMidUrl"]];
                    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                        
                    }];
                }
                
                return cell;
                
            }
            
        }
        
    }
    
    return nil;
}




#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.view endEditing:YES];
    [self.view endEditing:YES];
    
    
    
    if ( indexPath.row != 0 && indexPath.row != 1 ) {
        
        indexpath = indexPath.row;
        
        UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"回复评论",@"举报评论",@"复制评论", nil];
        sheet.tag = 101;
        [sheet showInView:self.view];
        
    }else{
        
        if ( self.m_praiseArray.count != 0 ) {
            
            if ( indexPath.row == 1 ) {
                
                // 进入赞的列表
                ZanListViewController *VC = [[ZanListViewController alloc]initWithNibName:@"ZanListViewController" bundle:nil];
                VC.m_dynimacId = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"DynamicID"]];
                
                [self.navigationController pushViewController:VC animated:YES];
            }
            
        }
        
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        
        self.m_typeString = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"DynamicType"]];
        
        
        self.m_imageArray = [self.m_MoreDIC objectForKey:@"DynamicPicList"];
        
        if ( [self.m_typeString isEqualToString: KEY_DYNAMIC_FRIENDS]||[self.m_typeString isEqualToString: KEY_DYNAMIC_FromFRIENDS]) {
            
            NSString *string = @"";
            //好友动态
            if ([self.m_typeString isEqualToString: KEY_DYNAMIC_FRIENDS]) {
                
                string =  [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"Contents"]];
                
            }
            //转发动态
            else if ([self.m_typeString isEqualToString: KEY_DYNAMIC_FromFRIENDS]) {
                
                self.m_imageArray = [self.m_MoreDIC objectForKey:@"ForwardingDynPicList"];
                
                
                
                NSString * FormNickName = @"";
                
                if ( FormNickName.length != 0 ) {
                    
                    
                    string= [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@|%@:%@",[self.m_MoreDIC objectForKey:@"Contents"],FormNickName,[self.m_MoreDIC objectForKey:@"ForwardingContents"]]];
                    
                    
                    //内容
                    
                }else{
                    
                    
                    string = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@|%@",[self.m_MoreDIC objectForKey:@"Contents"],[self.m_MoreDIC objectForKey:@"ForwardingContents"]]];
                    
                    
                    //内容
                }
                
                
            }
            //转发连接的情况也是一张图片，默认高度设为一张图片高度；
            
            int line = 0;
            if (self.m_imageArray.count>0) {
                
                if (self.m_imageArray.count<=3) {
                    line =1;
                }else if (self.m_imageArray.count<=6){
                    line =2;
                }else if (self.m_imageArray.count<=9){
                    line =3;
                }
            }
            
            CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            if ( self.m_imageArray.count > 0 ) {
                
                return (line*80)+ 39 + size.height;
                
            }else{
                
                if ( size.height < 35.000000 ) {
                    
                    return 80;
                    
                }else{
                    
                    return (line*80)+ 39 + size.height;
                    
                }
            }
        }
        else if ([self.m_typeString isEqualToString: KEY_DYNAMIC_SvcShare]||[self.m_typeString isEqualToString: KEY_DYNAMIC_WebViewShare]||[self.m_typeString isEqualToString: KEY_DYNAMIC_DianPingShare] )
        {
            CGSize size ;
            NSString * string =  [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"Contents"]];//说说内容
            
            if ([string isEqualToString:@""]) {
                
                size.height = 0.f;
                
            }else{
                
                size= [string sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
            }
            
            return 39+70+10+size.height;
            
        }
        
    }
    //第二行开始
    else{
        
        //赞的人为空，全部是评论
        if (self.m_praiseArray.count==0&&indexPath.row == 1) {
            
            return 0;
            
        }
        //赞的人到少一个
        else{
            
            //行一行是赞的人
            if (indexPath.row == 1)
            {
                NSDictionary * Praisedic = [self.m_praiseArray objectAtIndex:0];
                NSString *PraiseLabel = [Praisedic objectForKey:@"NickName"];
                
                for (int i=1; i<self.m_praiseArray.count; i++) {
                    
                    NSDictionary * PDIC = [self.m_praiseArray objectAtIndex:i];
                    NSString *PLAB = [PDIC objectForKey:@"NickName"];
                    
                    PraiseLabel = [NSString stringWithFormat:@"%@、%@",PraiseLabel,PLAB];
                    
                }
                PraiseLabel = [NSString stringWithFormat:@"%@ 觉得很赞",PraiseLabel];
                
                CGSize size = [PraiseLabel sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                
                return size.height +10 ;
            }
            //评论
            else{
                
                NSDictionary * DIC = [self.m_commentArray objectAtIndex:indexPath.row-2];
                
                CGSize size = [ [DIC objectForKey:@"Contents"] sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(245, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                return 30 + size.height +3;
                
            }
            
        }
        
        
    }
    
    
    return 0;
}


-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 101)
    {
        if (buttonIndex==0)
        {
            [self ReplyClicked:indexpath];
            
        }
        if (buttonIndex==1)
        {
            //没有接口获取举报列表
            UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"广告信息",@"诈骗信息",@"造谣诽谤信息",@"暴力色情信息", nil];
            sheet.tag = 102;
            [sheet showInView:self.view];
            
        }
        if (buttonIndex==2)
        {
            //复制
            NSDictionary * DIC = [self.m_commentArray objectAtIndex:indexpath-2];
            
            [UIPasteboard generalPasteboard].string = [NSString stringWithFormat:@"%@",[DIC objectForKey:@"Contents"]];
            
            [SVProgressHUD showSuccessWithStatus:@"已复制到粘贴板"];
            
        }
    }
    
    if (actionSheet.tag == 102)
    {
        NSDictionary * DIC = [self.m_commentArray objectAtIndex:indexpath-2];
        
        if (buttonIndex==0)
        {
            [self ReportComment:@"ReportType_0" Second:[NSString stringWithFormat:@"%@",[DIC objectForKey:@"DynamicCommentsID"]]];
            
        }
        if (buttonIndex==1)
        {
            [self ReportComment:@"ReportType_1" Second:[NSString stringWithFormat:@"%@",[DIC objectForKey:@"DynamicCommentsID"]]];
            
        }
        if (buttonIndex==2)
        {
            [self ReportComment:@"ReportType_2" Second:[NSString stringWithFormat:@"%@",[DIC objectForKey:@"DynamicCommentsID"]]];
            
        }
        if (buttonIndex==3)
        {
            
            [self ReportComment:@"ReportType_3" Second:[NSString stringWithFormat:@"%@",[DIC objectForKey:@"DynamicCommentsID"]]];
        }
    }
    
}


//放大图片
-(void)ChangeBigImage:(UIButton*)btn
{
    int count = self.m_imageArray.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSDictionary * BigimageDic = [self.m_imageArray objectAtIndex:i];
        NSString *path = [BigimageDic objectForKey:@"BigImgUrl"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:path]; // 图片路径
        
        DynamicCell *cell = (DynamicCell *)[self tableView:self.m_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
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


- (void)ReplyClicked:(int)sender{
    
    [self hiddenNumPadDone:nil];
    
    [self.m_textField becomeFirstResponder];
    
    [self.m_commentTextField becomeFirstResponder];
    
    NSDictionary * DIC = [self.m_commentArray objectAtIndex:sender-2];
    
    toMemberID = [DIC objectForKey:@"FromMemberID"];
    
    self.m_commentTextField.placeholder = [NSString stringWithFormat:@"回复【%@】:",[DIC objectForKey:@"NickName"]];
    
}


- (IBAction)sendReplyClicked:(id)sender {
    
    [self.m_textField resignFirstResponder];
    
    [self.m_commentTextField resignFirstResponder];
    
    [self.view endEditing:YES];
    
    if ( self.m_commentTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入要回复的内容"];
        
        return;
    }
    
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
                           [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"DynamicID"]],@"dynamicID",
                           toMemberID,@"toMemberID",
                           [NSString stringWithFormat:@"%@",self.m_commentTextField.text],@"contents",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据提交中"];
    
    [httpClient requestSpace:@"DynamicComment.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            self.m_commentTextField.text = @"";
            
            [self Morepinglulist];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
    
    
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    [self.view endEditing:YES];
    
    return YES;
}


-(void)Zanlist
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
                           [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"DynamicID"]],@"dynamicID",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestSpace:@"PraiseMembers.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            self.m_praiseArray = [json valueForKey:@"DynPraiseList"];
            
            [self Morepinglulist];
            
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}


-(void)Morepinglulist
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
                           [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"DynamicID"]],@"dynamicID",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestSpace:@"DynamicCommentDetail.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            self.m_commentArray = [[json valueForKey:@"DynDetail"] objectForKey:@"DynamicComment"];
            
            [SVProgressHUD dismiss];
            
            self.m_tableView.hidden = NO;
            
            [self.m_tableView reloadData];
            
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

- (void)ReportComment:(NSString *)reportType Second:(NSString *)DynamicCommentsID
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
                           reportType,@"reportType",
                           DynamicCommentsID,@"DynamicCommentsID",
                           @"0",@"DynamicID",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据提交中"];
    
    [httpClient requestSpace:@"ReportComment.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
    
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



- (void)resourcelink:(id)sender{
    
    [self.view endEditing:YES];
    [self.view endEditing:YES];
    
    
    NSString * Type;
    
    NSString * ID;
    
    if ([[NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormDynamicType"]] isEqualToString:@""]) {
        
        Type = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"DynamicType"]];
        
        ID = @"0";
        
    }else if (![[NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormDynamicType"]] isEqualToString:@""])
    {
        Type = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormDynamicType"]];
        
        ID = @"1";
        
    }
    
    
    if ([Type isEqualToString: KEY_DYNAMIC_SvcShare]) {
        
        [self productDetail:ID];
        
    }else if ([Type isEqualToString: KEY_DYNAMIC_ActShare])
    {
        [self activityDetail:ID];
        
    }else if ([Type isEqualToString: KEY_DYNAMIC_WebViewShare])
    {
        // 进入网页页面
        WebViewController *VC = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
        
        if ([[NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormDynamicType"]] isEqualToString:@""]) {
            
            VC.m_scanString = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"WebUrl"]];
            
        }else if (![[NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormDynamicType"]] isEqualToString:@""])
        {
            VC.m_scanString = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormWebUrl"]];
        }
        
        VC.m_typeString = @"2";
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ([Type isEqualToString: KEY_DYNAMIC_DianPingShare]){
        
        [self DPDetail:ID];
        
    }
    
}



- (void)productDetail:(id)sender{
    // 进入商品详情-商品
    ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
    
    VC.m_FromDPId = @"0";
    
    if ([sender isEqualToString:@"1"]) {
        VC.m_productId = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormSvcId"]];
        VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormMerchantShopId"]];
    }else{
        VC.m_productId = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"ServiceID"]];
        VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"MerchantShopID"]];
    }
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)activityDetail:(id)sender{
    
    // 进入商品详情 - 活动
    ActivityDetailViewController *VC = [[ActivityDetailViewController alloc]initWithNibName:@"ActivityDetailViewController" bundle:nil];
    
    VC.m_typeString = MERCHANTACTIVITY;
    VC.m_partyString = @"1";
    
    if ([sender isEqualToString:@"1"]) {
        VC.m_serviceId = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormActId"]];
    }else{
        VC.m_serviceId = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"ActivityID"]];
        
    }
}

- (void)DPDetail:(id)sender{
    
    
    // 进入商品详情 -点评
    ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
    
    VC.m_FromDPId = @"1";
    
    if ([sender isEqualToString:@"1"]) {
        VC.m_productId = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"FormdealId"]];
    }else{
        VC.m_productId = [NSString stringWithFormat:@"%@",[self.m_MoreDIC objectForKey:@"DealId"]];
        
    }
    
    [self.navigationController pushViewController:VC animated:YES];
}




@end
