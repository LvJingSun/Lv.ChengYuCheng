//
//  ForwardingViewController.m
//  HuiHui
//
//  Created by mac on 13-12-6.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "ForwardingViewController.h"

#import "SVProgressHUD.h"

#import "WebViewController.h"

#import "ActivityDetailViewController.h"

#import "ProductDetailViewController.h"

#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface ForwardingViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_activityView;

@property (weak, nonatomic) IBOutlet UIImageView *m_acImgV;

@property (weak, nonatomic) IBOutlet UILabel *m_acProductName;

@property (weak, nonatomic) IBOutlet UILabel *m_acInfoLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_acAddressLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_acCompanyLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_acattentionLabel;


@property (weak, nonatomic) IBOutlet UIView *m_resourceView;

@property (weak, nonatomic) IBOutlet UIImageView *m_reImgV;

@property (weak, nonatomic) IBOutlet UILabel *m_reProductName;

@property (weak, nonatomic) IBOutlet UILabel *m_reInfoLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_rePriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_reOrignLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_lineLabel;


@property (weak, nonatomic) IBOutlet UIView *m_friendsView;

@property (weak, nonatomic) IBOutlet UIImageView *m_friImgV;

@property (weak, nonatomic) IBOutlet UILabel *m_friNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_friContentLabel;

@property (weak, nonatomic) IBOutlet UITextView *m_contentTextView;

@property (weak, nonatomic) IBOutlet UILabel *m_PromptLabel;

////////////////////////////////////
@property (weak, nonatomic) IBOutlet UITableView    *m_tableView;

@end

@implementation ForwardingViewController

@synthesize m_index;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.m_Dyanmicdic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        self.m_imageArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_index = 0;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"转发动态"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(liftClicked)];
    
    [self setRightButtonWithTitle:@"发送" action:@selector(send)];
    
    if ( isIOS7 ) {
        
        // tableView的线往右移了，添加这代码可以填充
        if ([self.m_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.m_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
    }
    
    // 隐藏view
    self.m_friendsView.hidden = NO;
    
    self.m_activityView.hidden = YES;
    
    self.m_resourceView.hidden = YES;
    
    if ( self.m_contentTextView.text.length == 0 ) {
        
        self.m_PromptLabel.hidden = NO;
    }
    
    
    imagechage = [[ImageCache alloc] init];
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
    
    if ( [self.m_contentTextView isFirstResponder] ) {
        
        [self.m_contentTextView resignFirstResponder];
        
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)liftClicked{
    
    [self goBack];
}

- (void)send{
    
    [self.view endEditing:YES];
    
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedSpace];
    
    UIDevice *dev = [UIDevice currentDevice];
    NSString *devname =  [NSString stringWithFormat:@"%@",dev.model];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [self.m_Dyanmicdic objectForKey:@"DynamicID"],@"formDynamicID",
                           devname,@"source",
                           [NSString stringWithFormat:@"%@",self.m_contentTextView.text],@"contents",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient requestSpace:@"ForwardingDynamic.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            [self.forwarddele forwarddelegate];
            
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(liftClicked) userInfo:nil repeats:NO];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
//        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        [SVProgressHUD showErrorWithStatus:@"转发失败"];
    }];

}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text; {
    
    if ([@"\n" isEqualToString:text] == YES) {
        [self.view endEditing:YES];
        return NO;
    }
    return YES;
}


#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    [self hiddenNumPadDone:nil];
    
    self.m_PromptLabel.hidden = YES;
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if ( textView.text.length != 0 ) {
        
        self.m_PromptLabel.hidden = YES;
        
    }else{
        
        self.m_PromptLabel.hidden = NO;
    }
    
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
    
    cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"NickName"]];
    
    cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"CreateDate"]];
    
    cell.m_fromLabel.text = [NSString stringWithFormat:@"来自:%@",[self.m_Dyanmicdic objectForKey:@"Source"]];
    
    CGSize namesize = [cell.m_nameLabel.text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(90, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
    cell.m_nameLabel.frame = CGRectMake(cell.m_nameLabel.frame.origin.x, cell.m_nameLabel.frame.origin.y, namesize.width, 26);
    cell.m_zhuanzai.frame = CGRectMake(cell.m_nameLabel.frame.origin.x+cell.m_nameLabel.frame.size.width, cell.m_zhuanzai.frame.origin.y, cell.m_zhuanzai.frame.size.width, cell.m_zhuanzai.frame.size.height);
    
    UIImageView*imv=[[UIImageView alloc]init];
    UIImage *reSizeImage = [imagechage getImage:[self.m_Dyanmicdic objectForKey:@"PhotoMidUrl"]];
    if (reSizeImage != nil){
        cell.m_imageView.image = reSizeImage;}
    else{
        [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"PhotoMidUrl"]]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            cell.m_imageView.image = image;
            [imagechage addImage:image andUrl:[self.m_Dyanmicdic objectForKey:@"PhotoMidUrl"]];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        }];}
    
    
    self.m_imageArray = [self.m_Dyanmicdic objectForKey:@"ForwardingDynPicList"];
    
    NSLog(@"%@",self.m_Dyanmicdic);
    
    
    if (self.m_imageArray.count==0) {
        
        
        if ([[NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormDynamicType"]] isEqualToString: KEY_DYNAMIC_SvcShare]) {
            [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
            
        }else if ([[NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormDynamicType"]] isEqualToString: KEY_DYNAMIC_ActShare])
        {
            [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
            
        }else if ([[NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormDynamicType"]] isEqualToString: KEY_DYNAMIC_WebViewShare])
        {
            [cell.self.m_imgV setImage:[UIImage imageNamed:@"lianjie.png"]];
            
        }else if ([[NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormDynamicType"]] isEqualToString: KEY_DYNAMIC_DianPingShare]){
            
            [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
            
        }
        
        
    }else{
        NSDictionary * imageDic = [self.m_imageArray objectAtIndex:0];
        
        NSString *path=[NSString stringWithFormat:@"%@",[imageDic objectForKey:@"MidImgUrl"]];
        
        [cell ShareCellimage:path];
    }
    
    
    cell.m_titleLabel.text = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormTitle"]];
    cell.m_SubtitleLabel.text = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormSubTitle"]];
    
    NSString * FormNickName = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormNickName"]];
    
    NSMutableAttributedString *attributedString;
    
    if ( FormNickName.length != 0 ) {
        
        
        attributedString= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@|%@:%@",[self.m_Dyanmicdic objectForKey:@"Contents"],FormNickName,[self.m_Dyanmicdic objectForKey:@"ForwardingContents"]]];
                           if ([NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"Contents"]].length !=0) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:108.0/255 green:166.0/255  blue:205.0/255 alpha:1.0f] range:NSMakeRange([[self.m_Dyanmicdic objectForKey:@"Contents"] length] + 1,[FormNickName length])];
                           }
        
        //内容
        cell.m_contentLabel.attributedText = attributedString;
        
    }else{
        
        
        attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@|%@",[self.m_Dyanmicdic objectForKey:@"Contents"],[self.m_Dyanmicdic objectForKey:@"ForwardingContents"]]];
        
                           if ([NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"Contents"]].length !=0) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([[self.m_Dyanmicdic objectForKey:@"Contents"] length] + 1,[[self.m_Dyanmicdic objectForKey:@"Contents"],[self.m_Dyanmicdic objectForKey:@"ForwardingContents"] length])];
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
    
    
    
    return cell;
    
    
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellIdentifier = @"DynamicCellIdentifier";
    
    DynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DynamicCell" owner:self options:nil];
        
        cell = (DynamicCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
        
        [self.m_tableView setTableFooterView:v];
        
    }
    
    cell.m_zanView.hidden = YES;
    
    
    self.m_typeString = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"DynamicType"]];
    
    if ( [self.m_typeString isEqualToString: KEY_DYNAMIC_FRIENDS]||[self.m_typeString isEqualToString: KEY_DYNAMIC_FromFRIENDS]) {
        
        //好友动态
        if ([self.m_typeString isEqualToString: KEY_DYNAMIC_FRIENDS]) {
            
            //内容
            NSString *string = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"Contents"]];
            
            cell.m_contentLabel.text = [NSString stringWithFormat:@"%@",string];
            //图片列表
            
            self.m_imageArray = [self.m_Dyanmicdic objectForKey:@"DynamicPicList"];
            
        }
        //转发动态
        else if ([self.m_typeString isEqualToString: KEY_DYNAMIC_FromFRIENDS]) {
            
            
            
            if(![[NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormDynamicType"]]isEqualToString:@""])
            {
                
                if ([[NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormDynamicType"]]isEqualToString:KEY_DYNAMIC_SvcShare]||[[NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormDynamicType"]]isEqualToString:KEY_DYNAMIC_WebViewShare]||[[NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormDynamicType"]]isEqualToString:KEY_DYNAMIC_DianPingShare])
                {
                    
                    return [self tableViewSHA:tableView cellForRowAtIndexPath:indexPath];
                    
                }
                
            }
            
            
            
            cell.m_zhuanzai.text = @"转发";
            
            NSString * FormNickName=@"";
            
            FormNickName = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormNickName"]];
            //不同颜色
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@:%@",FormNickName,[self.m_Dyanmicdic objectForKey:@"ForwardingContents"]]];
            
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:108.0/255 green:166.0/255  blue:205.0/255 alpha:1.0f] range:NSMakeRange(0,[FormNickName length]+1)];
            
            //内容
            cell.m_contentLabel.attributedText = attributedString ;
            //图片列表
            self.m_imageArray = [self.m_Dyanmicdic objectForKey:@"ForwardingDynPicList"];
        }
        
        
        cell.m_nameLabel.text = [self.m_Dyanmicdic objectForKey:@"NickName"];
        
        cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"CreateDate"]];
        
        cell.m_fromLabel.text = [NSString stringWithFormat:@"来自:%@",[self.m_Dyanmicdic objectForKey:@"Source"]];
        
        CGSize namesize = [cell.m_nameLabel.text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(90, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
        cell.m_nameLabel.frame = CGRectMake(cell.m_nameLabel.frame.origin.x, cell.m_nameLabel.frame.origin.y, namesize.width, 26);
        cell.m_zhuanzai.frame = CGRectMake(cell.m_nameLabel.frame.origin.x+cell.m_nameLabel.frame.size.width, cell.m_zhuanzai.frame.origin.y, cell.m_zhuanzai.frame.size.width, cell.m_zhuanzai.frame.size.height);
        
        
        CGSize size = [cell.m_contentLabel.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        cell.m_contentLabel.frame = CGRectMake(cell.m_contentLabel.frame.origin.x, cell.m_contentLabel.frame.origin.y, 233, size.height+3);
        
        cell.m_tempView.hidden = YES;
        cell.m_commentView.hidden= YES;
        cell.m_lineImgV.hidden = YES;
        
        
        UIImageView*imv=[[UIImageView alloc]init];
        UIImage *reSizeImage = [imagechage getImage:[self.m_Dyanmicdic objectForKey:@"PhotoMidUrl"]];
        if (reSizeImage != nil){
            cell.m_imageView.image = reSizeImage;}
        else{
            [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"PhotoMidUrl"]]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                cell.m_imageView.image = image;
                [imagechage addImage:image andUrl:[self.m_Dyanmicdic objectForKey:@"PhotoMidUrl"]];
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
                
                NSDictionary * ImageDic = [self.m_imageArray objectAtIndex:i];
                
                NSString *path=[ImageDic objectForKey:@"MidImgUrl"];
                
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
        
        
        UIImageView*imv=[[UIImageView alloc]init];
        UIImage *reSizeImage = [imagechage getImage:[self.m_Dyanmicdic objectForKey:@"PhotoMidUrl"]];
        
        if (reSizeImage != nil)
        {
            cell.m_imageView.image = reSizeImage;
        }
        else{
            
            [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"PhotoMidUrl"]]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                
                cell.m_imageView.image = image;
                [imagechage addImage:image andUrl:[self.m_Dyanmicdic objectForKey:@"PhotoMidUrl"]];
                
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            }];
        }
        
        
        cell.m_linkBtn.tag = indexPath.row;//链接按钮；
        [cell.m_linkBtn addTarget:self action:@selector(resourcelink:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.m_DelBtn.hidden = YES;
        cell.m_tempView.hidden = YES;
        cell.m_commentView.hidden= YES;
        cell.m_lineImgV.hidden = YES;
        
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"NickName"]];
        
        cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"CreateDate"]];
        
        cell.m_fromLabel.text = [NSString stringWithFormat:@"来自:%@",[self.m_Dyanmicdic objectForKey:@"Source"]];
        
        CGSize namesize = [cell.m_nameLabel.text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(90, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
        cell.m_nameLabel.frame = CGRectMake(cell.m_nameLabel.frame.origin.x, cell.m_nameLabel.frame.origin.y, namesize.width, 26);
        cell.m_zhuanzai.frame = CGRectMake(cell.m_nameLabel.frame.origin.x+cell.m_nameLabel.frame.size.width, cell.m_zhuanzai.frame.origin.y, cell.m_zhuanzai.frame.size.width, cell.m_zhuanzai.frame.size.height);
        
        self.m_imageArray = [self.m_Dyanmicdic objectForKey:@"DynamicPicList"];
        
        if (self.m_imageArray.count==0) {
            
            
            if ([[NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"DynamicType"]] isEqualToString: KEY_DYNAMIC_SvcShare]) {
                [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
                
            }else if ([[NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"DynamicType"]] isEqualToString: KEY_DYNAMIC_ActShare])
            {
                [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
                
            }else if ([[NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"DynamicType"]] isEqualToString: KEY_DYNAMIC_WebViewShare])
            {
                [cell.self.m_imgV setImage:[UIImage imageNamed:@"lianjie.png"]];
                
            }else if ([[NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"DynamicType"]] isEqualToString: KEY_DYNAMIC_DianPingShare]){
                
                [cell.self.m_imgV setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
                
            }
            
            
        }else{
            NSDictionary * imageDic = [self.m_imageArray objectAtIndex:0];
            
            NSString *path=[NSString stringWithFormat:@"%@",[imageDic objectForKey:@"MidImgUrl"]];
            
            [cell ShareCellimage:path];
        }
        
        cell.m_titleLabel.text = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"Title"]];
        cell.m_SubtitleLabel.text = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"SubTitle"]];
        
        cell.m_contentLabel.text = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"Contents"]];
        
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
        
        
        
        return cell;
        
    }
    
    return nil;
    
}



#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    self.m_typeString = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"DynamicType"]];
    
    self.m_imageArray = [self.m_Dyanmicdic objectForKey:@"DynamicPicList"];
    
    if ( [self.m_typeString isEqualToString: KEY_DYNAMIC_FRIENDS]||[self.m_typeString isEqualToString: KEY_DYNAMIC_FromFRIENDS]) {
        
        NSString *string  = @"";
        
        //好友动态
        if ([self.m_typeString isEqualToString: KEY_DYNAMIC_FRIENDS]) {
            
            
            string =  [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"Contents"]];
            
        }
        //转发动态
        else if ([self.m_typeString isEqualToString: KEY_DYNAMIC_FromFRIENDS]) {
            
            self.m_imageArray = [self.m_Dyanmicdic objectForKey:@"ForwardingDynPicList"];
            
            
            NSString * FormNickName = @"";
            
            if ( FormNickName.length != 0 ) {
                
                
                string= [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@|%@:%@",[self.m_Dyanmicdic objectForKey:@"Contents"],FormNickName,[self.m_Dyanmicdic objectForKey:@"ForwardingContents"]]];
                
                
                //内容
                
            }else{
                
                
                string = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@|%@",[self.m_Dyanmicdic objectForKey:@"Contents"],[self.m_Dyanmicdic objectForKey:@"ForwardingContents"]]];
                
                
                //内容
            }
            
        }
        
        if (indexPath.row == 0) {
            
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
    }
    
    
    else if ([self.m_typeString isEqualToString: KEY_DYNAMIC_SvcShare]||[self.m_typeString isEqualToString: KEY_DYNAMIC_WebViewShare]||[self.m_typeString isEqualToString: KEY_DYNAMIC_DianPingShare] )
    {
        CGSize size ;
        NSString * string =  [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"Contents"]];//说说内容
        
        if ([string isEqualToString:@""]) {
            
            size.height = 0.f;
            
        }else{
            size= [string sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(233, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
        }
        
        return 39+70+10+size.height;
        
    }
    
    return 0;
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

- (void)resourcelink:(id)sender{
    
    [self.view endEditing:YES];
    [self.view endEditing:YES];
    
    NSString * Type;
    NSString * ID;
    
    if ([[NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormDynamicType"]] isEqualToString:@""]) {
        Type = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"DynamicType"]];
        ID = @"0";
    }else if (![[NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormDynamicType"]] isEqualToString:@""])
    {
        Type = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormDynamicType"]];
        ID = @"1";
    }
    
    if ([Type isEqualToString: KEY_DYNAMIC_SvcShare]) {
        [self productDetail:ID];
        
    }else if ([Type isEqualToString: KEY_DYNAMIC_ActShare]){
        [self activityDetail:ID];
        
    }else if ([Type isEqualToString: KEY_DYNAMIC_WebViewShare])
    {
        // 进入网页页面
        WebViewController *VC = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
        
        if ([[NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormDynamicType"]] isEqualToString:@""]) {
            
            VC.m_scanString = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"WebUrl"]];
            
        }else if (![[NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormDynamicType"]] isEqualToString:@""])
        {
            VC.m_scanString = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormWebUrl"]];
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
        VC.m_productId = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormSvcId"]];
        VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormMerchantShopId"]];
    }else{
        VC.m_productId = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"ServiceID"]];
        VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"MerchantShopID"]];
    }
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)activityDetail:(id)sender{
    
    // 进入商品详情 - 活动
    ActivityDetailViewController *VC = [[ActivityDetailViewController alloc]initWithNibName:@"ActivityDetailViewController" bundle:nil];
    
    VC.m_typeString = MERCHANTACTIVITY;
    VC.m_partyString = @"1";
    
    if ([sender isEqualToString:@"1"]) {
        VC.m_serviceId = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormActId"]];
    }else{
        VC.m_serviceId = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"ActivityID"]];
        
    }
}

- (void)DPDetail:(id)sender{
    
    
    // 进入商品详情 -点评
    ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
    
    VC.m_FromDPId = @"1";
    
    if ([sender isEqualToString:@"1"]) {
        VC.m_productId = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"FormdealId"]];
    }else{
        VC.m_productId = [NSString stringWithFormat:@"%@",[self.m_Dyanmicdic objectForKey:@"DealId"]];
        
    }
    
    [self.navigationController pushViewController:VC animated:YES];
}




@end
