//
//  EditingPartyViewController.m
//  HuiHui
//
//  Created by mac on 14-10-24.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "EditingPartyViewController.h"

#import "DynamicCell.h"

#import "EditPartyCell.h"

#import "CommonUtil.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#import "UserInformationViewController.h"

@interface EditingPartyViewController ()

@property (weak, nonatomic) IBOutlet UIButton           *m_normalBtn;

@property (weak, nonatomic) IBOutlet UIButton           *m_signBtn;

@property (weak, nonatomic) IBOutlet UIButton           *m_zanBtn;

@property (weak, nonatomic) IBOutlet UIButton           *m_commentBtn;

@property (weak, nonatomic) IBOutlet UIImageView        *m_moveImgV;

@property (weak, nonatomic) IBOutlet UITableView        *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel            *m_emptyLabel;

@property (strong, nonatomic) IBOutlet UIView           *m_commentView;

@property (weak, nonatomic) IBOutlet UITextField        *m_commentField;

@property (nonatomic, strong) UITextField               *m_textField;

@property (strong, nonatomic) IBOutlet UIView           *m_headerView;

@property (weak, nonatomic) IBOutlet UIView             *m_phototView;

// 发送评论按钮触发的事件
- (IBAction)sendCommentClicked:(id)sender;

// 按钮点击事件
- (IBAction)typeChange:(id)sender;
// 滑块移动位置
- (void)moveImageMoveTo:(CGFloat)rectPoint;

- (void)setNormal:(BOOL)isNormal withSign:(BOOL)isSign withZan:(BOOL)isZan withComment:(BOOL)isComment;
// 编辑图片按钮触发的事件
- (IBAction)editPhotoClicked:(id)sender;

@end

@implementation EditingPartyViewController

@synthesize m_zanList;

@synthesize m_signUpList;

@synthesize m_commentList;

@synthesize m_datePicker;

@synthesize isSelected;

@synthesize m_toolbar;

@synthesize m_timeString;

@synthesize m_addressString;

@synthesize m_imageArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_zanList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_signUpList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_commentList = [[NSMutableArray alloc]initWithCapacity:0];

        imagechage = [[ImageCache alloc] init];
        
        isSelected = NO;
        
        m_imageArray = [[NSMutableArray alloc]initWithCapacity:0];


    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"活动"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
  

    
    // 测试 ================
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[CommonUtil getValueByKey:MEMBER_ID],@"MemberID",@"诚诚",@"NickName", nil];

    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[CommonUtil getValueByKey:MEMBER_ID],@"MemberID",[CommonUtil getValueByKey:NICK],@"NickName", nil];

    
    for (int i = 0; i < 6; i++) {
        
        [self.m_zanList addObject:dic];
        
        [self.m_signUpList addObject:dic1];
        
    }

    
    NSDictionary *l_dic = [NSDictionary dictionaryWithObjectsAndKeys:[CommonUtil getValueByKey:NICK],@"NickName",@"2014-10-23",@"CreateTime",@"你好hello啊",@"Contents",[CommonUtil getValueByKey:MEMBER_ID],@"MemberId",@"ddddddd",@"ToNickName", nil];
    
    for (int i = 0; i < 2; i++) {
        
        [self.m_commentList addObject:l_dic];
        
    }
    
    
    // 初始化日期的pickerView
    [self initWithPickerView];
    
    // 先隐藏pickerView
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
    // 赋值 - test
    self.m_temporaryDate = @"报名截止时间";

    self.m_timeString = @"2014-10-28 10:22:22";
    
    self.m_addressString = @"苏州市金阊区金储街";
   
    self.m_partyTopic = @"活动主题 2014-10-28";
    
    self.m_partyDetail = @"活动详情的信息";
    
    
    //自定义键盘输入
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    textField.delegate = self;
    self.m_textField = textField;
    [self.view addSubview:self.m_textField];
    self.m_textField.hidden = YES;
    self.m_textField.inputAccessoryView = self.m_commentView;
    self.m_commentField.delegate = self;
    
    
    // 设置图片所在的view的边框
    self.m_phototView.layer.borderWidth = 1.0;
    self.m_phototView.layer.borderColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:208/255.0 alpha:1.0].CGColor;
    
    // 初始化图片
    
    [self.m_imageArray addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//35287b8b8dad25dfca18fc8acb53dbf33fef3ede_1395941778406.jpg" ];
    
    [self.m_imageArray addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//539e8e324c587ac7_1395941334203.jpg" ];
    
    [self.m_imageArray addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//539e8e324c587ac7_1395941334281.jpg" ];
    
    [self.m_imageArray addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//539e8e324c587ac7_1395941334156.jpg" ];
    
     [self.m_imageArray addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//11fe460ffcb14399_1395945336218.JPG" ];
    
    [self.m_imageArray addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//539e8e324c587ac7_1395941257796.jpg" ];
    
    [self.m_imageArray addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//d03ca12a6525e008_1395940809640.jpg" ];
    
    [self.m_imageArray addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//35287b8b8dad25dfca18fc8acb53dbf33fef3ede_1395941778406.jpg" ];
    
//    [self.m_imageArray addObject: @"http://app.ijianren.com:9898//jr//upload//post//hd//539e8e324c587ac7_1395941334203.jpg" ];
    
    
    
    // 默认的按钮的状态
    [self setNormal:YES withSign:NO withZan:NO withComment:NO];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    // 隐藏pickerView
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
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

// 滑块移动位置
- (void)moveImageMoveTo:(CGFloat)rectPoint
{
    [UIView beginAnimations:@"Flips1" context:(__bridge void *)(self)];
    [UIView setAnimationDuration:0.3];
    self.m_moveImgV.frame = CGRectMake(rectPoint, 35, 80, 4);
    [UIView commitAnimations];
}

- (IBAction)typeChange:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 100 ) {
        
        [self setNormal:YES withSign:NO withZan:NO withComment:NO];
        
        // 设置滑块滚动的坐标
        [self moveImageMoveTo:0];
        
    }else if ( btn.tag == 101 ) {
        
        [self setNormal:NO withSign:YES withZan:NO withComment:NO];
        
        // 设置滑块滚动的坐标
        [self moveImageMoveTo:80];
        
    }else if ( btn.tag == 102 ) {
        
        [self setNormal:NO withSign:NO withZan:YES withComment:NO];
        
        // 设置滑块滚动的坐标
        [self moveImageMoveTo:160];
        
    }else if ( btn.tag == 103 ) {
        
        [self setNormal:NO withSign:NO withZan:NO withComment:YES];
        
        // 设置滑块滚动的坐标
        [self moveImageMoveTo:240];
        
    }
    
}

- (void)hiddenPickerView{
    
    if ( !self.m_toolbar.hidden ) {
        
        // 隐藏pickerView和ToolBar
        [self.m_toolbar setHidden:YES];
        [self.m_datePicker setHidden:YES];
    }
  
}

- (void)setNormal:(BOOL)isNormal withSign:(BOOL)isSign withZan:(BOOL)isZan withComment:(BOOL)isComment{
    
    // 隐藏pickerView和ToolBar
    [self hiddenPickerView];

    self.m_normalBtn.selected = isNormal;
    
    self.m_signBtn.selected = isSign;
    
    self.m_zanBtn.selected = isZan;
    
    self.m_commentBtn.selected = isComment;
    
    if ( isNormal ) {
        
        self.m_normalBtn.userInteractionEnabled = NO;
        self.m_signBtn.userInteractionEnabled = YES;
        self.m_zanBtn.userInteractionEnabled = YES;
        self.m_commentBtn.userInteractionEnabled = YES;
        
        self.m_typeString = kNoramlType;
        
        
        // 判断tableView的headerView
        if ( self.m_imageArray.count != 0 ) {
            
            
            [self getImageView];
            
        }else{
            
            self.m_tableView.tableHeaderView = nil;
            
        }
        
    }
   
    if ( isSign ) {
        
        self.m_normalBtn.userInteractionEnabled = YES;
        self.m_signBtn.userInteractionEnabled = NO;
        self.m_zanBtn.userInteractionEnabled = YES;
        self.m_commentBtn.userInteractionEnabled = YES;
        
        self.m_typeString = kSignUpType;
        
        // 设置tableView的headerView
        self.m_tableView.tableHeaderView = nil;
    }

    if ( isZan ) {
        
        self.m_normalBtn.userInteractionEnabled = YES;
        self.m_signBtn.userInteractionEnabled = YES;
        self.m_zanBtn.userInteractionEnabled = NO;
        self.m_commentBtn.userInteractionEnabled = YES;
        
        self.m_typeString = kZanType;
        
        // 设置tableView的headerView
        self.m_tableView.tableHeaderView = nil;
    }

    if ( isComment ) {
        
        self.m_normalBtn.userInteractionEnabled = YES;
        self.m_signBtn.userInteractionEnabled = YES;
        self.m_zanBtn.userInteractionEnabled = YES;
        self.m_commentBtn.userInteractionEnabled = NO;
        
        self.m_typeString = kCommentType;
        
        // 设置tableView的headerView
        self.m_tableView.tableHeaderView = nil;
    
    }

    // 刷新列表
    [self.m_tableView reloadData];
    
    // 请求数据
    
}

- (IBAction)editPhotoClicked:(id)sender {
    
    // 进入图片编辑的页面
    HH_EditPhotoViewController *VC = [[HH_EditPhotoViewController alloc]initWithNibName:@"HH_EditPhotoViewController" bundle:nil];
    VC.delegate = self;
    VC.m_imageList = self.m_imageArray;
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if ( self.m_typeString == kNoramlType ) {
        
        return 5;
        
    }else if ( self.m_typeString == kSignUpType ){
        
        return self.m_signUpList.count;
        
    }else if ( self.m_typeString == kZanType ){
        
        return self.m_zanList.count;
        
    }else{
        
        return self.m_commentList.count;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    
    if ( self.m_typeString == kNoramlType ) {
        
        cell = [self tableViewNormal:tableView cellForRowAtIndexPath:indexPath];
        
    }else if ( self.m_typeString == kSignUpType ){
        
        cell = [self tableViewSign:tableView cellForRowAtIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }else if ( self.m_typeString == kZanType ){
        
        cell = [self tableViewZan:tableView cellForRowAtIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;

    }else{
        
        cell = [self tableViewComment:tableView cellForRowAtIndexPath:indexPath];
       
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    }
    
    return cell;
    
}

- (UITableViewCell *)tableViewNormal:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.row == 0 ) {
        
        static NSString *cellIdentifier = @"EditPartyTopicCellIdentifier";
        
        EditPartyTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"EditPartyCell" owner:self options:nil];
            
            cell = (EditPartyTopicCell *)[nib objectAtIndex:1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        // 赋值
        
        cell.m_Label.text = @"2014-10-28";
        
        cell.m_subLabel.text = @"发布时间";
        
        cell.m_editBtn.tag = indexPath.row;
        
        cell.m_editBtn.hidden = YES;
        
        [cell.m_editBtn addTarget:self action:@selector(editClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }else if ( indexPath.row == 1 ) {
        
        static NSString *cellIdentifier = @"EditPartyTopicCellIdentifier";
        
        EditPartyTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"EditPartyCell" owner:self options:nil];
            
            cell = (EditPartyTopicCell *)[nib objectAtIndex:1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        // 赋值
        cell.m_editBtn.hidden = NO;

        cell.m_Label.text = [NSString stringWithFormat:@"%@",self.m_partyTopic];
        
        cell.m_subLabel.text = @"活动主题";
        
        cell.m_editBtn.tag = indexPath.row;
        
        [cell.m_editBtn addTarget:self action:@selector(editClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }else if ( indexPath.row == 2 ) {
        
        static NSString *cellIdentifier = @"EditPartyTopicCellIdentifier";
        
        EditPartyTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"EditPartyCell" owner:self options:nil];
            
            cell = (EditPartyTopicCell *)[nib objectAtIndex:1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        // 赋值
        cell.m_editBtn.hidden = NO;

        cell.m_Label.text = [NSString stringWithFormat:@"%@",self.m_partyDetail];
        
        cell.m_subLabel.text = @"活动详情";
        
        cell.m_editBtn.tag = indexPath.row;

        [cell.m_editBtn addTarget:self action:@selector(editClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }else if ( indexPath.row == 3 ) {
        
        static NSString *cellIdentifier = @"EditPartyTopicCellIdentifier";
        
        EditPartyTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"EditPartyCell" owner:self options:nil];
            
            cell = (EditPartyTopicCell *)[nib objectAtIndex:1];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        // 赋值
        cell.m_editBtn.hidden = NO;
        
        cell.m_Label.text = [NSString stringWithFormat:@"%@",self.m_timeString];
        
        cell.m_subLabel.text = @"截止时间";
        
        cell.m_editBtn.tag = indexPath.row;
        
        [cell.m_editBtn addTarget:self action:@selector(editClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }else {  //if ( indexPath.row == 4 ) {
        
        static NSString *cellIdentifier = @"EditPartyMapCellIdentifier";
        
        EditPartyMapCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"EditPartyCell" owner:self options:nil];
            
            cell = (EditPartyMapCell *)[nib objectAtIndex:2];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        // 赋值
        cell.m_editBtn.hidden = NO;
        
        cell.m_Label.text = [NSString stringWithFormat:@"%@",self.m_addressString];
        
        cell.m_editBtn.tag = indexPath.row;
        
        [cell.m_editBtn addTarget:self action:@selector(editClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }
    
//    else{
//        
//        static NSString *cellIdentifier = @"cellIdentifier";
//        
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//        
//        if ( cell == nil ) {
//            
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//            
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            
//        }
//        
//        
//        
//        return cell;
//    }

}

- (UITableViewCell *)tableViewSign:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"EditPartyCellIdentifier";
    
    EditPartyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"EditPartyCell" owner:self options:nil];
        
        cell = (EditPartyCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    // 进行赋值
    if ( self.m_signUpList.count != 0 ) {
        
        NSDictionary *dic = [self.m_signUpList objectAtIndex:indexPath.row];
        
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"NickName"]];
        
    }
    
    
    return cell;

}

- (UITableViewCell *)tableViewZan:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"EditPartyCellIdentifier";
    
    EditPartyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"EditPartyCell" owner:self options:nil];
        
        cell = (EditPartyCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
    // 进行赋值
    if ( self.m_zanList.count != 0 ) {
        
        NSDictionary *dic = [self.m_zanList objectAtIndex:indexPath.row];
        
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"NickName"]];
        
    }
    
    
    return cell;
    
}

- (UITableViewCell *)tableViewComment:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"MoreCommentCellIdentifier";
    
    MoreCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DynamicCell" owner:self options:nil];
        
        cell = (MoreCommentCell *)[nib objectAtIndex:2];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;

        
    }

    if ( self.m_commentList.count != 0 ) {
        
        NSDictionary * dic = [self.m_commentList objectAtIndex:indexPath.row];
        
        cell.m_Name.text = [dic objectForKey:@"NickName"];
        cell.m_Time.text = [dic objectForKey:@"CreateTime"];
        
        if ( ![[NSString stringWithFormat:@"%@",[dic objectForKey:@"ToNickName"]]isEqualToString:@"<null>"] ) {
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@回复%@",[dic objectForKey:@"NickName"],[dic objectForKey:@"ToNickName"]]];
            
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange([[dic objectForKey:@"NickName"] length],2)];
            
            //内容
            cell.m_Name.attributedText = attributedString;
            
        }else{
            
            cell.m_Name.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"NickName"]];
            
        }
        
        cell.m_contents.text = [dic objectForKey:@"Contents"];

        CGSize size = [cell.m_contents.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(245, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        cell.m_contents.frame = CGRectMake(cell.m_contents.frame.origin.x, cell.m_contents.frame.origin.y, 245, size.height+3);
        
        
        cell.m_lineLabel.hidden = NO;
        // 设置线的坐标
        cell.m_lineLabel.frame = CGRectMake(0, cell.m_contents.frame.origin.y + size.height + 8, cell.m_lineLabel.frame.size.width, 1);
        
        
        UIImageView *imv = [[UIImageView alloc]init];
        UIImage *reSizeImage = [imagechage getImage:[dic objectForKey:@"PhotoMidUrl"]];
        
        if (reSizeImage != nil){
            
            [cell.m_PhotoBtn setBackgroundImage:reSizeImage forState:UIControlStateNormal];
            
        }
        else{
            
            [imv setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"PhotoMidUrl"]]]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                [cell.m_PhotoBtn setBackgroundImage:reSizeImage forState:UIControlStateNormal];
                [imagechage addImage:image andUrl:[dic objectForKey:@"PhotoMidUrl"]];
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                
            }];
        }

    }
    return cell;

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( self.m_typeString == kNoramlType ) {
      
        return 50.0f;

    }else if ( self.m_typeString == kSignUpType ){
        
        return 50.0f;
        
    }else if ( self.m_typeString == kZanType ){
        
        return 50.0f;
        
    }else{
        
        NSDictionary *dic = [self.m_commentList objectAtIndex:indexPath.row];
        
        CGSize size = [ [dic objectForKey:@"Contents"] sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(245, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        return 30 + size.height + 3;
    }

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ( self.m_typeString == kNoramlType ) {
        // 基本信息
        
        
    }else if ( self.m_typeString == kSignUpType ){
        // 报名的的进入个人信息页面
        
        NSDictionary *dic = [self.m_signUpList objectAtIndex:indexPath.row];
        
        // 进入详细资料
        UserInformationViewController *VC = [[UserInformationViewController alloc]initWithNibName:@"UserInformationViewController" bundle:nil];
        VC.m_typeString = @"2";
        
        ///// 好友Id================
        VC.m_friendId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]];
        [self.navigationController pushViewController:VC animated:YES];
        

        
    }else if ( self.m_typeString == kZanType ){
        // 赞的进入个人信息页面
        
        NSDictionary *dic = [self.m_zanList objectAtIndex:indexPath.row];

        // 进入详细资料
        UserInformationViewController *VC = [[UserInformationViewController alloc]initWithNibName:@"UserInformationViewController" bundle:nil];
        VC.m_typeString = @"2";
        
        ///// 好友Id================
        VC.m_friendId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]];
        [self.navigationController pushViewController:VC animated:YES];
        

        
    }else{
        // 评论的进行回复
        [self hiddenNumPadDone:nil];
        
        commentIndex = indexPath.row;
        
        [self.m_textField becomeFirstResponder];
        
        [self.m_commentField becomeFirstResponder];
        
        // 点击评价，设置tableView滚动到第几行
        [self.m_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

#pragma - mark btnClicked
- (void)editClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    // 1修改活动主题 2修改活动详情 3修改报名截止日期 4修改位置
    
    if ( btn.tag == 1 ) {
        // 进入修改活动主题的页面
        HH_EditTopicViewController *VC = [[HH_EditTopicViewController alloc]initWithNibName:@"HH_EditTopicViewController" bundle:nil];
        VC.m_stringType = @"修改活动主题";
        VC.delegate = self;
        VC.m_FieldString = [NSString stringWithFormat:@"%@",self.m_partyTopic];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ( btn.tag == 2){
        // 进入修改活动详情的页面
        HH_EditTopicViewController *VC = [[HH_EditTopicViewController alloc]initWithNibName:@"HH_EditTopicViewController" bundle:nil];
        VC.m_stringType = @"修改活动详情";
        VC.delegate = self;
        VC.m_ViewString = [NSString stringWithFormat:@"%@",self.m_partyDetail];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ( btn.tag == 3 ){
         // 修改截止日期
        [self.m_toolbar setHidden:NO];
        [self.m_datePicker setHidden:NO];
        
    }else{
        // 进入修改位置的页面
        BBMapViewController *VC = [[BBMapViewController alloc]initWithNibName:@"BBMapViewController" bundle:nil];
        VC.Chosemapdelegate = self;
        [self.navigationController pushViewController:VC animated:YES];
    
    }
}

#pragma - mark - EditTopicDelegate
- (void)editPartyTopicAndDetail:(NSString *)aString withType:(NSString *)aType{

    // 根据类型来判断修改的是活动主题还是活动详情  1表示活动主题 2表示活动详情
    if ( [aType isEqualToString:@"1"] ) {
        
        // 修改活动主题
        self.m_partyTopic = [NSString stringWithFormat:@"%@",aString];
       
        // 刷新某一行
        NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil];
        
        [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
    }else{
        
        // 修改活动详情
        self.m_partyDetail = [NSString stringWithFormat:@"%@",aString];
        
        // 刷新某一行
        NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:2 inSection:0], nil];
        
        [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
        
    }
    
}
    
#pragma mark - BBMapDelegateChosesMapDelegate
- (void)ChosesMapValue:(NSString *)address mapx:(NSString *)mapx mapy:(NSString *)mapy level:(NSString *)level
    {
        //    MapX = longitude 经度
        //    MapY = latitude 纬度
        
        
        self.m_addressString = [NSString stringWithFormat:@"%@",address];

        // 刷新某一行
        NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:4 inSection:0], nil];
        
        [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];

        
}

#pragma 初始化pickerView
- (void)initWithPickerView{
    
    UIWindow *window = self.navigationController.view.window;
	//  datePickerView初始化
	m_datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 210, WindowSizeWidth, 200)];
    [m_datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
	[m_datePicker addTarget:self action:@selector(togglePicker:) forControlEvents:UIControlEventValueChanged];
    m_datePicker.backgroundColor = [UIColor whiteColor];
    
	[window addSubview:m_datePicker];
    UIToolbar *pickerBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.m_datePicker.frame.origin.y - 44, WindowSizeWidth, 44)];
    pickerBar.barStyle = UIBarStyleBlackTranslucent;
    
    
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(doPCAPickerCancel:)];
    cancelBarButton.style = UIBarButtonItemStyleBordered;
    
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:nil
                                                                                    action:nil];
    
    
    UIBarButtonItem *lastButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(doPCAPickerDone:)];
    lastButtonItem.style = UIBarButtonItemStyleBordered;
    
    NSArray *pickArray = [NSArray arrayWithObjects: cancelBarButton, spaceButtonItem, lastButtonItem, nil];
    [pickerBar setItems:pickArray animated:YES];
    [window addSubview:pickerBar];
    pickerBar.backgroundColor = [UIColor clearColor];
    self.m_toolbar = pickerBar;
    
    [window addSubview:self.m_toolbar];
}
#pragma mark - PickerBar按钮
- (void)doPCAPickerDone:(id)sender{
    
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
    if ( self.isSelected ) {
        
        self.m_timeString = [NSString stringWithFormat:@"%@",self.m_dataString];
        
    }else{
        
        // 如果未选择pickerView，则直接赋值为显示的日期
        if ( [self.m_temporaryDate isEqualToString:@"报名截止时间"] ) {
            
            NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSString *str = [formatter stringFromDate:m_datePicker.date];
            
            self.m_timeString = [NSString stringWithFormat:@"%@",str];
            
        }else{
            
            self.m_timeString = [NSString stringWithFormat:@"%@",self.m_temporaryDate];
            
        }
        
    }
    
    self.m_temporaryDate = [NSString stringWithFormat:@"%@",self.m_timeString];
    
    // 刷新某一行
    NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:3 inSection:0], nil];
    
    [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];

    
}

- (void)doPCAPickerCancel:(id)sender{
    
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
    // 如果没值的话则显示placeholder的值，否则显示text的值
    if ( [self.m_temporaryDate isEqualToString:@"报名截止时间"] ) {
        
        self.m_timeString = @"";
        
    }else{
        
        self.m_timeString = [NSString stringWithFormat:@"%@",self.m_temporaryDate];
        
    }
    
}

// pickerView的选择事件
- (void) togglePicker:(id)sender{
    
    self.isSelected = YES;
    
    // 判断不能选择今天日期以后的时间
    if ( [m_datePicker.date compare:[NSDate date]] == NSOrderedAscending ) {
        [m_datePicker setDate:[NSDate date] animated:YES];
    }
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *str = [formatter stringFromDate:m_datePicker.date];
    
    self.m_dataString = [NSString stringWithFormat:@"%@",str];
    
    //    self.m_timeTextField.text = [NSString stringWithFormat:@"%@",self.m_dataString];
    
}


- (IBAction)sendCommentClicked:(id)sender {
    
    [self.m_commentField resignFirstResponder];
    
    [self.m_commentField resignFirstResponder];
    
    [self.view endEditing:YES];
    
    
    if ( self.m_commentField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入要评价的内容"];
        
        return;
    }

}


// 获取图片
- (void)getImageView{
    
    // 先清空view里面的所有控件
    for (id view in self.m_phototView.subviews) {
        [view removeFromSuperview];
    }
    
    int BtnW = 65;
    int BtnWS = 10;
    int BtnX = 10;
    
    int BtnH = 65;
    int BtnHS = 10;
    int BtnY = 10;
    
    int i = 0;
    
    for (i = 0; i < [m_imageArray count]; i++ ) {
        
        UIImageView * imageview = [[UIImageView alloc] init];
        imageview.frame = CGRectMake( (BtnW+BtnWS) * (i%4) + BtnX , (BtnH+BtnHS) *(i/4) + BtnY, BtnW, BtnH );
        imageview.tag = 10000 + i;
        imageview.userInteractionEnabled = YES;
        // 内容模式
        imageview.clipsToBounds = YES;
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        
        // 判断图片数组里面是URL还是UIimage的类型
        if ( [[self.m_imageArray objectAtIndex:i] isKindOfClass:[UIImage class]] ) {

            imageview.image = [self.m_imageArray objectAtIndex:i];
     
        }else{
            
            [imageview setImageWithURL: [NSURL URLWithString: [m_imageArray objectAtIndex:i]] placeholderImage: [UIImage imageNamed:@"TopViewRight.png"]];

        }

        // 添加图片手势
        [imageview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BtnClick:)]];
        
        [self.m_phototView addSubview:imageview];
        
    }
    
    int getEndImageYH = (BtnH + BtnHS) * (i/4) + BtnY;
    
    if ( self.m_imageArray.count > 0 && self.m_imageArray.count <= 4) {
        
        self.m_phototView.frame = CGRectMake(self.m_phototView.frame.origin.x, self.m_phototView.frame.origin.y, self.m_phototView.frame.size.width, 85);
        
    }else if ( self.m_imageArray.count > 4 && self.m_imageArray.count <= 8 ){
        
        self.m_phototView.frame = CGRectMake(self.m_phototView.frame.origin.x, self.m_phototView.frame.origin.y, self.m_phototView.frame.size.width, 160);
        
    } else if ( self.m_imageArray.count == 9 ){
        
        self.m_phototView.frame = CGRectMake(self.m_phototView.frame.origin.x, self.m_phototView.frame.origin.y, self.m_phototView.frame.size.width, getEndImageYH + 75);
        
    }
  
    self.m_headerView.frame = CGRectMake(self.m_headerView.frame.origin.x, self.m_headerView.frame.origin.y, self.m_headerView.frame.size.width, self.m_phototView.frame.size.height + 4 + 40);
    
    
    // 设置tableView的headerView
    self.m_tableView.tableHeaderView = self.m_headerView;
    
}

- (void)BtnClick:(UITapGestureRecognizer *)imageTap
{
    
    // 隐藏pickerView和ToolBar
    [self hiddenPickerView];
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [self.m_imageArray count]];
    
    for (int i = 0; i < [self.m_imageArray count]; i++) {
        // 替换为中等尺寸图片
      
        MJPhoto *photo = [[MJPhoto alloc] init];

        // 判断数组里面的是什么类型的数据
        if ( [[self.m_imageArray objectAtIndex:i] isKindOfClass:[UIImage class]] ) {
            
            photo.image = [self.m_imageArray objectAtIndex:i];
            
        }else{
            
            NSString * getImageStrUrl = [NSString stringWithFormat:@"%@", [self.m_imageArray objectAtIndex:i]];
            
            photo.url = [NSURL URLWithString: getImageStrUrl]; // 图片路径
        }
        
        
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

#pragma mark - EditPhotoDelegate
- (void)photoArray:(NSMutableArray *)photoArray{
    
    NSLog(@"photoArray = %@",photoArray);
    
    self.m_imageArray = photoArray;
    
    if ( self.m_imageArray.count != 0 ) {
        
        [self getImageView];

    }else{
        
        self.m_tableView.tableHeaderView = nil;
    }
}


@end
