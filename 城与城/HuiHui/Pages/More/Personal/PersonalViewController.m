//
//  PersonalViewController.m
//  HuiHui
//
//  Created by mac on 13-11-19.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "PersonalViewController.h"

#import "PersonalCell.h"

#import "CodeViewController.h"

#import "ChangePwdViewController.h"

#import "ModifyPhoneViewController.h"

#import "ModifyEmailViewController.h"

#import "RealAccountResultViewController.h"

#import "RealAccountViewController.h"

#import "BankCardListViewController.h"

#import "ModifyPayViewController.h"

#import "AppHttpClient.h"

#import "SVProgressHUD.h"

#import "CommonUtil.h"

#import "PaymentQueViewController.h"

#import "UIImageView+AFNetworking.h"

#import "BindingEmailViewController.h"

#import "MyAddressListViewController.h"

//实名认证页面
#import "AuthenticationViewController.h"

@interface PersonalViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;


// 初始化pickerView
- (void)initWithPickerView;

@end

@implementation PersonalViewController

@synthesize m_datePicker;

@synthesize m_toolbar;

@synthesize m_imagDic;

@synthesize m_provinceArray;

@synthesize m_CityArray;

@synthesize m_AreaArray;

@synthesize m_pickerView;

@synthesize m_pickerToolBar;

@synthesize isSelectedArea;

@synthesize isRequest;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.isSelected = NO;
        
        isSelectedArea = NO;
        
        isRequest = NO;
        
        m_imagDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        dbhelp = [[AreaDB alloc] init];
        
        m_provinceArray = [[NSMutableArray alloc]initWithCapacity:0];

        m_CityArray = [[NSMutableArray alloc]initWithCapacity:0];

        m_AreaArray = [[NSMutableArray alloc]initWithCapacity:0];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"个人信息"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    
    if ( isIOS7 ) {
        
        // tableView的线往右移了，添加这代码可以填充
        if ([self.m_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.m_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
    }

    
    // 设置默认的为空
    self.m_imagDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                      @"",@"photoSmlUrl",
                      @"",@"photoMidUrl",
                      @"",@"photoBigUrl",nil];
    
    self.m_birthString = @"";
    
    self.m_sexString = @"";
    
    self.m_phoneString = @"";
    
    self.m_emailString = @"";
    
    self.m_userString = @"";
    
    self.m_areaString = @"";
    
    // 初始化pickerView
    [self initWithPickerView];
    
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    imgV.backgroundColor = [UIColor whiteColor];
    self.m_imgV = imgV;

    self.m_tableView.separatorColor = [UIColor colorWithRed:215/255.0 green:215/255.0  blue:215/255.0  alpha:1.0];
    
    
    
    // 初始化地区所存放的pickerView
    [self initpickerView];
    
    // 隐藏pickerView和toolBar
    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
    
    self.m_pickerView.backgroundColor = [UIColor whiteColor];
    
    if ( [dbhelp queryCity].count != 0 ) {
      
        // 从保存的数据库中读取数据
        [self.m_provinceArray addObjectsFromArray:[dbhelp queryCity]];
        
        NSDictionary *proDic = [self.m_provinceArray objectAtIndex:0];
        
        self.m_provinceId = [NSString stringWithFormat:@"%@",[proDic objectForKey:@"code"]];
        
        self.m_CityArray = [dbhelp queryArea:self.m_provinceId];
        
        NSDictionary *cityDic = [self.m_CityArray objectAtIndex:0];
        
        
        self.m_cityId = [NSString stringWithFormat:@"%@",[cityDic objectForKey:@"code"]];
        
        self.m_AreaArray = [dbhelp queryArea:self.m_cityId];
        
        NSDictionary *areaDic = [self.m_AreaArray objectAtIndex:0];
        
        self.m_areaId = [NSString stringWithFormat:@"%@",[areaDic objectForKey:@"code"]];
        
         [self.m_pickerView reloadAllComponents];

    }
 
    // 安全问题检测请求数据
    [self paymentSafeRequest];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear: animated];
    
    if ( !self.isRequest ) {
        
        // 请求地区的数据
        [self requestAreaSubmit];
        
    }
    
    self.isRequest = YES;
    
    // 刷新列表
    [self.m_tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self requestAU];
    
    // 设置身份状态
    self.m_statuString = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:USER_REALAUSTATUS]];
    
    [self hideTabBar:YES];
 
}

- (void)requestAU {

    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           nil];
    
    [httpClient request:@"More.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSLog(@"success");
            
            [SVProgressHUD dismiss];
            
            NSDictionary *appMore = [json valueForKey:@"appMore"];

            [CommonUtil addValue:[appMore objectForKey:@"realAuName"] andKey:REAL_ACCOUNT_NAME];
            [CommonUtil addValue:[appMore objectForKey:@"realAuIdCard"] andKey:REAL_ACCOUNT_IDCARD];
            [CommonUtil addValue:[appMore objectForKey:@"realAuStatus"] andKey:USER_REALAUSTATUS];
            
            //充值
            NSString *vldStatus = [appMore objectForKey:@"realAuStatus"];
            
            // 保存用户的状态
            [CommonUtil addValue:vldStatus andKey:REALAUSTATUS];
            
            NSLog(@"%@",[CommonUtil getValueByKey:REALAUSTATUS]);
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
    } failure:^(NSError *error) {

    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
    
    // 隐藏pickerView和toolBar
    [m_datePicker setHidden:YES];
    
	[m_toolbar setHidden:YES];
    
    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

#pragma 初始化pickerView
- (void)initWithPickerView{

    UIWindow *window = self.navigationController.view.window;
	//  datePickerView初始化
	m_datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 210, WindowSizeWidth, 200)];
    [m_datePicker setDatePickerMode:UIDatePickerModeDate];
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
    
    // 判断是否滚动了pickerView
    if ( !self.isSelected ) {
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyy-MM-dd"];
        
        self.m_birthString = [formatter stringFromDate:m_datePicker.date];
        
    }
    
    self.isSelected = NO;
    
    if ( ![self.m_birthString isEqualToString:[CommonUtil getValueByKey:USER_BIRTHDAY]] ) {
        
        // 请求数据
        [self modifyUserInfo];
        
    }
  
}

- (void)doPCAPickerCancel:(id)sender{
    
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];

}

// pickerView的选择事件
- (void) togglePicker:(id)sender{
    
    self.isSelected = YES;
    
    // 判断不能选择今天日期以后的时间
    if ( [m_datePicker.date compare:[NSDate date]] == NSOrderedDescending ) {
		[m_datePicker setDate:[NSDate date] animated:YES];
	}
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyy-MM-dd"];
    
    NSString *str = [formatter stringFromDate:m_datePicker.date];
    
    self.m_birthString = [NSString stringWithFormat:@"%@",str];
    
}

#pragma mark - UserInfoMationDelegate
- (void)getUserName:(NSString *)aName{
    
    self.m_userString = [NSString stringWithFormat:@"%@",aName];
    
    // 请求数据
    [self modifyUserInfo];
    
}

#pragma mark - 修改用户信息
- (void)modifyUserInfo{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
        
    NSString *string = [NSString stringWithFormat:@"%@",self.m_sexString];
    
    NSString *sex;
    
    // 判断性别
    if ( [string isEqualToString:@"男"] ) {
        
        sex = @"Male";
        
    }else if ( [string isEqualToString:@"女"] ){
        
        sex = @"Female";
        
    }else{
        
        sex = @"";
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberid",
                           key,   @"key",
                           self.m_userString,@"nickName",
                           self.m_birthString,@"birthday",
                           [NSString stringWithFormat:@"%@",sex],@"sex",
                           self.m_areaString,@"liveAddress",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    // 判断是修改图片还是其他的
    NSString *imgString = [self.m_imagDic objectForKey:@"photoBigUrl"];
   
    if ( imgString.length != 0 ) {
        
        [httpClient multiRequest:@"MemberUpdata.ashx" parameters:param files:self.m_imagDic success:^(NSJSONSerialization* json){

            BOOL success = [[json valueForKey:@"status"] boolValue];
            if (success) {
                [SVProgressHUD dismiss];
                
                NSString *msg = [json valueForKey:@"msg"];
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                
                Appdelegate.isChange = YES;
                
                if ( msg.length != 0 ) {
                    
                    // 分解数据进行赋值
                    NSArray *array = [msg componentsSeparatedByString:@"|"];
                    
                    
                    // 图片
                    if ( [[array objectAtIndex:0] isEqualToString:@"photoBigUrl"] ) {
                        
                        [CommonUtil addValue:[array objectAtIndex:1] andKey:USER_PHOTO];

                        NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]];
                        
                        [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
                        
                    }else if ( [[array objectAtIndex:0] isEqualToString:@"nickName"] ){
                        
                        [CommonUtil addValue:[array objectAtIndex:1] andKey:NICK];
                        
                        
                        NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]];
                        
                        [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:
                         UITableViewRowAnimationFade];
                        
                    }else if ( [[array objectAtIndex:0] isEqualToString:@"birthday"] ){
                        
                        [CommonUtil addValue:[array objectAtIndex:1] andKey:USER_BIRTHDAY];
                        
                        
                        NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:1]];
                        
                        [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
                        
                    }else if ( [[array objectAtIndex:0] isEqualToString:@"sex"] ){
                        
                        [CommonUtil addValue:[array objectAtIndex:1] andKey:USER_SEX];
                        
                        NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:1]];
                        
                        [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
                        
                    }else if ( [[array objectAtIndex:0] isEqualToString:@"liveAddress"] ){
                        
                        [CommonUtil addValue:[array objectAtIndex:1] andKey:USER_AREA];
                        
                        NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:4 inSection:1]];
                        
                        [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
                        
                    }else{
                        
                        
                    }
                }
                
                // 每次请求数据后清空所有的数据
                self.m_userString = @"";
                self.m_birthString = @"";
                self.m_sexString = @"";
                self.m_areaString = @"";
                self.m_imagDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"",@"photoSmlUrl",
                                  @"",@"photoMidUrl",
                                  @"",@"photoBigUrl",nil];
                
            } else {
                NSString *msg = [json valueForKey:@"msg"];
                [SVProgressHUD showErrorWithStatus:msg];
                
                // 每次请求数据后清空所有的数据
                self.m_userString = @"";
                self.m_birthString = @"";
                self.m_sexString = @"";
                self.m_areaString = @"";
                self.m_imagDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"",@"photoSmlUrl",
                                  @"",@"photoMidUrl",
                                  @"",@"photoBigUrl",nil];
                
            }
        } failure:^(NSError *error) {
            //NSLog(@"failed:%@", error);
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            
            // 每次请求数据后清空所有的数据
            self.m_userString = @"";
            self.m_birthString = @"";
            self.m_sexString = @"";
            self.m_areaString = @"";
            self.m_imagDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                              @"",@"photoSmlUrl",
                              @"",@"photoMidUrl",
                              @"",@"photoBigUrl",nil];
        }];

    }else{
        
        [httpClient request:@"MemberUpdata.ashx" parameters:param success:^(NSJSONSerialization* json) {
            BOOL success = [[json valueForKey:@"status"] boolValue];
            if (success) {
                [SVProgressHUD dismiss];
                
                NSString *msg = [json valueForKey:@"msg"];
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                
                Appdelegate.isChange = YES;

                if ( msg.length != 0 ) {
                    
                    // 分解数据进行赋值
                    NSArray *array = [msg componentsSeparatedByString:@"|"];
                    
                    // 图片
                    if ( [[array objectAtIndex:0] isEqualToString:@"photoBigUrl"] ) {
                        
                        [CommonUtil addValue:[array objectAtIndex:1] andKey:USER_PHOTO];
                        
                        NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]];
                        
                        [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
                        
                    }else if ( [[array objectAtIndex:0] isEqualToString:@"nickName"] ){
                        
                        [CommonUtil addValue:[array objectAtIndex:1] andKey:NICK];
                        
                        
                        NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]];
                        
                        [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:
                         UITableViewRowAnimationFade];
                        
                    }else if ( [[array objectAtIndex:0] isEqualToString:@"birthday"] ){
                        
                        [CommonUtil addValue:[array objectAtIndex:1] andKey:USER_BIRTHDAY];
                        
                        
                        NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:1]];
                        
                        [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
                        
                    }else if ( [[array objectAtIndex:0] isEqualToString:@"sex"] ){
                                                
                        [CommonUtil addValue:[array objectAtIndex:1] andKey:USER_SEX];
                        
                        NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:1]];
                        
                        [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
                        
                    }else if ( [[array objectAtIndex:0] isEqualToString:@"liveAddress"] ){
                        
                        [CommonUtil addValue:[array objectAtIndex:1] andKey:USER_AREA];
                        
                        NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:4 inSection:1]];
                        
                        [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
                        
                    }else{
                        
                        
                    }
                }
                
                // 每次请求数据后清空所有的数据
                self.m_userString = @"";
                self.m_birthString = @"";
                self.m_sexString = @"";
                self.m_areaString = @"";
                self.m_imagDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"",@"photoSmlUrl",
                                  @"",@"photoMidUrl",
                                  @"",@"photoBigUrl",nil];
                
            } else {
                NSString *msg = [json valueForKey:@"msg"];
                [SVProgressHUD showErrorWithStatus:msg];
                
                // 每次请求数据后清空所有的数据
                self.m_userString = @"";
                self.m_birthString = @"";
                self.m_sexString = @"";
                self.m_areaString = @"";
                self.m_imagDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"",@"photoSmlUrl",
                                  @"",@"photoMidUrl",
                                  @"",@"photoBigUrl",nil];
                
            }
        } failure:^(NSError *error) {
            //NSLog(@"failed:%@", error);
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            
            // 每次请求数据后清空所有的数据
            self.m_userString = @"";
            self.m_birthString = @"";
            self.m_sexString = @"";
            self.m_areaString = @"";
            self.m_imagDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                              @"",@"photoSmlUrl",
                              @"",@"photoMidUrl",
                              @"",@"photoBigUrl",nil];
        }];

    }
       
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ( section == 0 ) {
        
//        return 3;
        
        return 4;

        
    }else if ( section == 1 ){
        
        return 5;
        
    }else{
        
        return 4;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 0 ) {
        
        if ( indexPath.row == 0 ) {
            
            static NSString *cellIdentifier = @"PersonalCelldentifier";
            
            PersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ( cell == nil ) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PersonalCell" owner:self options:nil];
                
                cell = (PersonalCell *)[nib objectAtIndex:0];
                
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
            }
            
            // 获取图片
            NSString *path = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:USER_PHOTO]];
                        
            [cell.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]
                               placeholderImage:[UIImage imageNamed:@"moren.png"]
                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                            cell.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                            
//                                            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

                                            //获取完整路径
                                            NSString *documentsDirectory = [paths objectAtIndex:0];
                                            NSString *path = [documentsDirectory stringByAppendingPathComponent:@"MemberHeaderPhoto.plist"];
                                            NSMutableDictionary * data  = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
                                                NSData *dataObj = UIImageJPEGRepresentation(image, 1.0);
                                            [data setObject:dataObj forKey:[NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:USER_PHOTO]]];
                                            [data writeToFile:path atomically:YES];
                                            
                                        }
                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                            
                                        }];
            
            
            cell.m_imageView.layer.masksToBounds = YES;
            cell.m_imageView.layer.cornerRadius = 5.0;
            cell.m_imageView.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;


            cell.m_imageView.frame = CGRectMake(WindowSizeWidth - 98, cell.m_imageView.frame.origin.y, cell.m_imageView.frame.size.width, cell.m_imageView.frame.size.height);
            
            
            return cell;
            
        }else{
            
            static NSString *cellIdentifier = @"InformationCellIdentifier";
            
            InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ( cell == nil ) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PersonalCell" owner:self options:nil];
                
                cell = (InformationCell *)[nib objectAtIndex:1];
                
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                
                
                cell.m_subLabel.frame = CGRectMake(WindowSizeWidth - 212, cell.m_subLabel.frame.origin.y, cell.m_subLabel.frame.size.width, cell.m_subLabel.frame.size.height);


            }
            
            
            if ( indexPath.row == 1 ) {
                
                cell.m_titleLabel.text = @"昵称";
                
                cell.m_iconImgV.hidden = YES;
                
                cell.m_subLabel.hidden = NO;
                
                cell.m_subLabel.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:NICK]];
                
            }else if ( indexPath.row == 2 ){
                
                cell.m_titleLabel.text = @"我的二维码";
                
                cell.m_iconImgV.hidden = NO;
                
                cell.m_subLabel.hidden = YES;
                
            }else{
                
                cell.m_titleLabel.text = @"我的地址";
                
                cell.m_iconImgV.hidden = NO;
                
                cell.m_subLabel.hidden = YES;
                
            }
            
            return cell;
        }
    }else if ( indexPath.section == 2 ){
        
        static NSString *cellIdentifier = @"InformationCellIdentifier";
        
        InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PersonalCell" owner:self options:nil];
            
            cell = (InformationCell *)[nib objectAtIndex:1];
            
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
            
        }
        
        cell.m_iconImgV.hidden = YES;
        
        cell.m_subLabel.hidden = YES;
        
        if ( indexPath.row == 0 ) {
            
            cell.m_titleLabel.text = @"实名认证";
            
        }else if ( indexPath.row == 1 ){
            
            cell.m_titleLabel.text = @"我的银行卡";
            
        }else if ( indexPath.row == 2 ){
            
            cell.m_titleLabel.text = @"修改登录密码";
            
        }else{
            
            cell.m_titleLabel.text = @"修改支付密码";
            
        }
        
        return cell;
        
        
    }else {
        
        static NSString *cellIdentifier = @"InformationCellIdentifier";
        
        InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"PersonalCell" owner:self options:nil];
            
            cell = (InformationCell *)[nib objectAtIndex:1];
            
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
            cell.m_subLabel.frame = CGRectMake(WindowSizeWidth - 212, cell.m_subLabel.frame.origin.y, cell.m_subLabel.frame.size.width, cell.m_subLabel.frame.size.height);

        }
        
        if ( indexPath.section == 1 ) {
            
            cell.m_iconImgV.hidden = YES;
            
            cell.m_subLabel.hidden = NO;
            
            if ( indexPath.row == 0 ) {
                
                cell.m_titleLabel.text = @"生日";
                
                cell.m_subLabel.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:USER_BIRTHDAY]];
                
            }else if ( indexPath.row == 1 ){
                
                cell.m_titleLabel.text = @"性别";
                
                cell.m_subLabel.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:USER_SEX]];
                
            }else if ( indexPath.row == 2 ){
                
                cell.m_titleLabel.text = @"手机号";
                
                cell.m_subLabel.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:ACCOUNT]];
                
            }else if ( indexPath.row == 3 ){
                
                cell.m_titleLabel.text = @"邮箱";
                
                cell.m_subLabel.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:USER_EMAIL]];
                
            }else if ( indexPath.row == 4 ){
                
                cell.m_titleLabel.text = @"地区";
                
                cell.m_subLabel.text = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:USER_AREA]];
                
            }else{
                
                
 
            }
            
        }else {
            
            if ( indexPath.row == 0 ) {
                
                cell.m_iconImgV.hidden = YES;
                
                cell.m_subLabel.hidden = YES;
                
                cell.m_titleLabel.text = @"修改密码";
                
            }else{
                
                
            }
        }
        
        return cell;
        
    }
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 0 ) {
        
        if ( indexPath.row == 0 ) {
            
            return 70.0f;
            
        }else{
            
            return 44.0f;
        }
    }else{
        
        return 44.0f;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ( indexPath.section == 0 ) {
        
        if ( indexPath.row == 0 ) {
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"更换头像"
                                                                    delegate:self
                                                           cancelButtonTitle:@"取消"
                                                      destructiveButtonTitle:nil
                                                           otherButtonTitles:@"拍照",@"从相册中选择", nil];
            
            actionSheet.tag = 1009;
            [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
            
        }else if ( indexPath.row == 1 ){
            // 名字编辑的页面
            UserNameViewController *VC = [[UserNameViewController alloc]initWithNibName:@"UserNameViewController" bundle:nil];
            VC.delegate = self;
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if ( indexPath.row == 2 ){
            
            // 我的二维码页面
            CodeViewController *VC = [[CodeViewController alloc]initWithNibName:@"CodeViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else{
            
            // 进入我的地址列表页面
            MyAddressListViewController *VC = [[MyAddressListViewController alloc]initWithNibName:@"MyAddressListViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
        }
        
    }else if ( indexPath.section == 1 ){
        
        if ( indexPath.row == 0 ) {
            // 生日选择
            self.m_datePicker.hidden = NO;
            
            self.m_toolbar.hidden = NO;
            
            // 点击的时候自动滚动到第几行
            [self.m_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            
        }else if ( indexPath.row == 1 ){
            
            // 性别选择
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"更换性别"
                                                                    delegate:self
                                                           cancelButtonTitle:@"取消"
                                                      destructiveButtonTitle:nil
                                                           otherButtonTitles:@"男",@"女", nil];
            
            actionSheet.tag = 1010;
            [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
            
            
        }else if ( indexPath.row == 2 ){
            
            if ( [self.m_securityString isEqualToString:@"2"] ) {
                
                // 手机号修改
                ModifyPhoneViewController *VC = [[ModifyPhoneViewController alloc]initWithNibName:@"ModifyPhoneViewController" bundle:nil];
                [self.navigationController pushViewController:VC animated:YES];
                
            }else{
                
                // 进入设置安全问题及支付密码的页面
                PaymentQueViewController *viewController = [[PaymentQueViewController alloc]initWithNibName:@"PaymentQueViewController" bundle:nil];
                [self.navigationController pushViewController:viewController animated:YES];
                
            }
            
        }else if ( indexPath.row == 3 ){
            
            NSString *emailString = [CommonUtil getValueByKey:USER_EMAIL];
            
            NSLog(@"emailString = %@",emailString);
            
            // 如果邮箱地址为空则进入绑定邮箱的页面，否则就进行判断
            if ( emailString.length == 0 ) {
                // 绑定邮箱的页面
                BindingEmailViewController *VC = [[BindingEmailViewController alloc]initWithNibName:@"BindingEmailViewController" bundle:nil];
                [self.navigationController pushViewController:VC animated:YES];
                
                
            }else{

                if ( [self.m_securityString isEqualToString:@"2"] ) {
                    
                    // 邮箱修改
                    ModifyEmailViewController *VC = [[ModifyEmailViewController alloc]initWithNibName:@"ModifyEmailViewController" bundle:nil];
                    [self.navigationController pushViewController:VC animated:YES];
                    
                }else{
                    
                    // 进入设置安全问题及支付密码的页面
                    PaymentQueViewController *viewController = [[PaymentQueViewController alloc]initWithNibName:@"PaymentQueViewController" bundle:nil];
                    [self.navigationController pushViewController:viewController animated:YES];
                    
                }
            }
            
            
        }else if ( indexPath.row == 4 ){
            
            // 地区选择
            
//            AreaViewController *VC = [[AreaViewController alloc]initWithNibName:@"AreaViewController" bundle:nil];
//            VC.delegate = self;
//            [self.navigationController pushViewController:VC animated:YES];
            
            
            self.m_pickerView.hidden = NO;
            
            self.m_pickerToolBar.hidden = NO;
            
            
            // 点击的时候自动滚动到第几行
            [self.m_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            
        }else{
            
          
            
            
        }
            
        
        
    }else{
        
        if ( indexPath.row == 0 ) {
            // 进入实名认证的页面
            if ([self.m_statuString isEqualToString:@"NotCertified"]) {
                
                // 填写身份证号码的页面
                AuthenticationViewController *vc = [[AuthenticationViewController alloc] init];
                
                [self.navigationController pushViewController:vc animated:YES];
                
//                RealAccountViewController *viewController = [[RealAccountViewController alloc] initWithNibName:@"RealAccountViewController" bundle:nil];
//                [self.navigationController pushViewController:viewController animated:YES];
                
            } else {
                // 实名认证结果页面
                RealAccountResultViewController *viewController = [[RealAccountResultViewController alloc] initWithNibName:@"RealAccountResultViewController" bundle:nil];
                [self.navigationController pushViewController:viewController animated:YES];
            }
            
            
        }else if ( indexPath.row == 1 ){
            // 进入我的银行卡的页面
            
            if ([self.m_statuString isEqualToString:@"Valid"]) {
                
                // 有效的进入银行卡列表
                BankCardListViewController *viewController = [[BankCardListViewController alloc] initWithNibName:@"BankCardListViewController" bundle:nil];
                [self.navigationController pushViewController:viewController animated:YES];
                
            } else if ([self.m_statuString isEqualToString:@"NotCertified"]) {
                
                // 未认证 进入实名认证页面
                AuthenticationViewController *vc = [[AuthenticationViewController alloc] init];
                
                [self.navigationController pushViewController:vc animated:YES];
                
//                RealAccountViewController *viewController = [[RealAccountViewController alloc] initWithNibName:@"RealAccountViewController" bundle:nil];
//                [self.navigationController pushViewController:viewController animated:YES];
                
            } else {
                
                // 其他的进入认证结果页面
                RealAccountResultViewController *viewController = [[RealAccountResultViewController alloc] initWithNibName:@"RealAccountResultViewController" bundle:nil];

                [self.navigationController pushViewController:viewController animated:YES];
                
            }
            
            
        }else if ( indexPath.row == 2 ){
            
            // 修改登录密码
            ChangePwdViewController *VC = [[ChangePwdViewController alloc]initWithNibName:@"ChangePwdViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
       
        } else{
            
            // 验证有支付密码时则进入修改支付密码的页面 - 要通过验证进入修改支付密码页面还是选择填写问题的页面
            //            ModifyPayViewController *viewController = [[ModifyPayViewController alloc]initWithNibName:@"ModifyPayViewController" bundle:nil];
            //
            //            [self.navigationController pushViewController:viewController animated:YES];
            
            
//            [self paymentSafeRequest];
            
            if ( [self.m_securityString isEqualToString:@"2"] ) {
                
                // 验证有支付密码时则进入修改支付密码的页面
                ModifyPayViewController *viewController = [[ModifyPayViewController alloc]initWithNibName:@"ModifyPayViewController" bundle:nil];
                
                [self.navigationController pushViewController:viewController animated:YES];
            
            }else{
                
                // 进入设置安全问题及支付密码的页面
                PaymentQueViewController *viewController = [[PaymentQueViewController alloc]initWithNibName:@"PaymentQueViewController" bundle:nil];
                [self.navigationController pushViewController:viewController animated:YES];

                
            }
            
        }
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

// 验证用户是否填写了支付问题的网络请求
- (void)paymentSafeRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           nil];
//    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"PaymentSafetyTesting.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
            
            self.m_securityString = @"2";
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];

            if ( [msg isEqualToString:@"用户信息丢失，请重新登录"] ) {
                
                [SVProgressHUD showErrorWithStatus:msg];
                
//                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
//                                                                   message:msg
//                                                                  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                alertView.tag = 11324;
//                [alertView show];

                
                
            }else{
                
                self.m_securityString = @"1";

            }
                       
        }
        
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 11324 ) {
        if ( buttonIndex == 0 ) {
            
            // 判断是否登录的值
            [self.tabBarController.navigationController popViewControllerAnimated:YES];
            
            
        }
    }
}

#pragma mark - ActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( actionSheet.tag == 1009 ) {
        
        if ( buttonIndex == 0 ) {
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            
            // 判断设备是否支持拍照
            if([[[UIDevice currentDevice] model] rangeOfString:@"iPhone Simulator"].location != NSNotFound) {
                
                [self alertWithMessage:@"本设备暂不支持拍照功能"];
                
            }else{
                
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePicker.allowsEditing = YES;
                [self presentViewController:imagePicker animated:YES completion:nil];
                
            }
            
        }else if ( buttonIndex == 1 ){
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }else{
            
            
        }
    }else if ( actionSheet.tag == 1010 ){
        
        if ( buttonIndex == 0 ) {
            
            self.m_sexString = @"男";
            
            // 请求数据
            
            [self modifyUserInfo];
            
            
        }else if ( buttonIndex == 1 ){
            
            self.m_sexString = @"女";
            
            // 请求数据
            
            [self modifyUserInfo];
            
        }else{
            
            
        }

//        NSArray *arr = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:1]];
//        
//        [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

#pragma 拍照选择照片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.image"]){
        
        UIImage *originImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
//        self.m_image = originImage;
        
        // 判断当前设备的分辨率
        UIScreen *MainScreen = [UIScreen mainScreen];
        CGSize Size = [MainScreen bounds].size;
        CGFloat scale = [MainScreen scale];
        CGFloat screenWidth = Size.width * scale;
//        CGFloat screenHeight = Size.height * scale;
        
        // 根据屏幕的大小来判断图片大小要大于160
        if ( screenWidth <= 320.0 ) {
            
            if ( originImage.size.width < 160.0 || originImage.size.height < 160.0 ) {
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
                [SVProgressHUD showErrorWithStatus:@"图片尺寸太小请重新选择"];
                
                return;
                
            }
        }else{
            
            if ( originImage.size.width < 320.0 || originImage.size.height < 320.0 ) {
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
                [SVProgressHUD showErrorWithStatus:@"图片尺寸太小请重新选择"];
                
                return;
                
            }
        }
        
        
        UIImage *scaleImage = [self scaleImage:originImage toScale:0.3];
        
        
        self.m_image = scaleImage;
        
        // 修改头像请求数据
        [self modifyUserInfo];

        
        
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSData *)getImageData:(UIImageView *)imageView {
    UIImage *iamge = imageView.image;
    return UIImageJPEGRepresentation(iamge, 1);
}

#pragma mark- 缩放图片
-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    
    // 将图片存储在字典里
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(30, 30)];
    
    UIImageView *imgV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    
    imgV1.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
    
    UIImageView *imgV2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 160, 160)];
    
    imgV2.image = [CommonUtil scaleImage:image toSize:CGSizeMake(160, 160)];
    
    self.m_imagDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                      [self getImageData:imgV],@"photoSmlUrl",
                      [self getImageData:imgV1],@"photoMidUrl",
                      [self getImageData:imgV2],@"photoBigUrl",nil];
    
    // 计算图片显示的大小
    float height = image.size.width / 50.0f;
    
    UIGraphicsBeginImageContext(CGSizeMake(50,image.size.height / height));
    [image drawInRect:CGRectMake(0, 0, 50, image.size.height / height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return scaledImage;
}


#pragma mark - AreaListDelegate
- (void)getAreaName:(NSString *)aCityName{
    
    self.m_areaString = aCityName;
    
    [self.m_tableView reloadData];
    
}

#pragma mark - 初始化显示地区的pickerView
- (void)initpickerView{
    UIWindow *window = self.navigationController.view.window;
	
	//  datePickerView初始化
	m_pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 216, WindowSizeWidth, 216)];
    m_pickerView.delegate = self;
    m_pickerView.dataSource = self;
    // 设置pickerView选择时的背景，默认的为NO
    m_pickerView.showsSelectionIndicator = YES;
	[window addSubview:m_pickerView];
    
	//添加 PickerView上面的左右按钮
    UIBarButtonItem *pickItemCancle = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(doPickerCancel:)];
    pickItemCancle.style = UIBarButtonItemStyleBordered;
    
    UIBarButtonItem *pickItemOK = [[UIBarButtonItem alloc]initWithTitle:@"确定"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(doPickerDone:)];
    pickItemOK.style = UIBarButtonItemStyleBordered;
    
    UIBarButtonItem *pickSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItem)UIBarButtonSystemItemFlexibleSpace
                                                                               target:self
                                                                               action:nil];
    // 自定义PickerView顶部的Toolbar，加载左右的取消和确定按钮
    UIToolbar *pickerBar = [[UIToolbar alloc] init];
    pickerBar.barStyle = UIBarStyleBlackTranslucent;
    NSArray *pickArray = [NSArray arrayWithObjects:pickItemCancle, pickSpace, pickItemOK,nil];
    [pickerBar setItems:pickArray animated:YES];
    pickerBar.frame = CGRectMake(0, m_pickerView.frame.origin.y - 44, WindowSizeWidth, 44);
    [window addSubview:pickerBar];
    pickerBar.backgroundColor = [UIColor clearColor];
    self.m_pickerToolBar = pickerBar;
    
   }

#pragma mark - PickerBar按钮
- (void)doPickerDone:(id)sender{
    
    self.m_pickerView.hidden = YES;
 
    self.m_pickerToolBar.hidden = YES;
 
    self.m_areaString = [NSString stringWithFormat:@"%@|%@|%@",self.m_provinceId,self.m_cityId,self.m_areaId];
    
    if ( self.isSelectedArea ) {
        
        // 请求修改用户的接口
        [self modifyUserInfo];
        
    }
    
    self.isSelectedArea = NO;
  
}

- (void)doPickerCancel:(id)sender{
    
    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
    
}

#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if ( component == 0 ) {
        
        return self.m_provinceArray.count;
        
    }else if ( component == 1 ){
        
        return self.m_CityArray.count;
        
    }else if ( component == 2 ){
        
        return self.m_AreaArray.count;
        
    }else{
        
        return 0;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *titleResult = @"";
    
    if ( component == 0 ) {
        
        if ( self.m_provinceArray.count > 0 ) {
            
            NSDictionary *dic = [self.m_provinceArray objectAtIndex:row];
            
            titleResult = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
            
        }
    }else if ( component == 1 ){
        
        if ( self.m_CityArray.count > 0 ) {
            
            NSDictionary *dic = [self.m_CityArray objectAtIndex:row];
            
            titleResult = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
            
        }
    }else if ( component == 2 ){
        
        if ( self.m_AreaArray.count > 0 ) {
            
            NSDictionary *dic = [self.m_AreaArray objectAtIndex:row];
            
            titleResult = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
            
        }
    }else{
        
        titleResult = @"";
    }
    
    return titleResult;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.isSelectedArea = YES;
    
    if ( component == 0 ) {
        
        NSDictionary *dic = [self.m_provinceArray objectAtIndex:row];
        
        self.m_provinceId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        
        self.m_CityArray = [dbhelp queryArea:self.m_provinceId];
        
        if ( self.m_CityArray && [self.m_CityArray count] > 0 ) {
           
            NSDictionary *dic = [self.m_CityArray objectAtIndex:0];

            self.m_cityId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
            
            // 取得市数组第一个所对应的区
            if ( self.m_cityId ) {
                
                self.m_AreaArray = [dbhelp queryArea:self.m_cityId];
                
                NSDictionary *dic = [self.m_AreaArray objectAtIndex:0];
                
                self.m_areaId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
                
            }
            
            // 刷新选择器
            [self.m_pickerView selectRow:0 inComponent:1 animated:YES];
            [self.m_pickerView selectRow:0 inComponent:2 animated:YES];
        }

    }else if ( component == 1 ){
        
        NSDictionary *dic = [self.m_CityArray objectAtIndex:row];
        
        self.m_cityId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        
        self.m_AreaArray = [dbhelp queryArea:self.m_cityId];
        
        NSDictionary *areaDic = [self.m_AreaArray objectAtIndex:0];
        
        self.m_areaId = [NSString stringWithFormat:@"%@",[areaDic objectForKey:@"code"]];
        
        [self.m_pickerView selectRow:0 inComponent:2 animated:YES];

    }else{
        
        NSDictionary *dic = [self.m_AreaArray objectAtIndex:row];

        self.m_areaId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        
    }
    
    for (int i=0; i<[pickerView numberOfComponents]; i++) {
       
        [self.m_pickerView reloadComponent:i];
        
    }
    
}


#pragma mark - 城市请求数据
- (void)requestAreaSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSDictionary *versions = [dbhelp queryVersion];
    NSString *cityVer = [versions objectForKey:TYPE_CITY];
    
    if (cityVer == nil) {
        cityVer = @"0";
    }
    
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                       
                           cityVer,@"memberCityVer",
                           nil];
    
    [httpClient request:@"MemberCity.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
                    
            NSArray *versionList = [json valueForKey:@"MemberVersion"];
            if (versionList == nil || [versionList count] == 0) {
                
                return;
            }
            
            int cityVersion = 0;
            int categoryVersion = 0;
            
            for (NSDictionary *version in versionList) {
                NSString *type = [version objectForKey:@"VersionType"];
                if ([@"VersionMemberCity" isEqualToString:type]) {
                    cityVersion = [[version objectForKey:@"MemberVersionNum"] intValue];
                }
                
                if ([@"VersionClass" isEqualToString:type]) {
                    categoryVersion = [[version objectForKey:@"VersionNum"] intValue];
                }
                
            }
                        
            if (cityVersion > 0) {
                NSArray *cityList = [json valueForKey:@"memberCity"];
                [dbhelp updateData:cityList andType:TYPE_CITY andVersion:[NSString stringWithFormat:@"%d", cityVersion]];
            }
            
            // 清空数据重新赋值
            [self.m_provinceArray removeAllObjects];
            [self.m_CityArray removeAllObjects];
            [self.m_AreaArray removeAllObjects];
            
            // 赋值
            [self.m_provinceArray addObjectsFromArray:[dbhelp queryCity]];
            
            NSDictionary *proDic = [self.m_provinceArray objectAtIndex:0];
            
            self.m_provinceId = [NSString stringWithFormat:@"%@",[proDic objectForKey:@"code"]];
            
            self.m_CityArray = [dbhelp queryArea:self.m_provinceId];
            
            NSDictionary *cityDic = [self.m_CityArray objectAtIndex:0];
            
            
            self.m_cityId = [NSString stringWithFormat:@"%@",[cityDic objectForKey:@"code"]];
            
            self.m_AreaArray = [dbhelp queryArea:self.m_cityId];
            
            NSDictionary *areaDic = [self.m_AreaArray objectAtIndex:0];
            
            self.m_areaId = [NSString stringWithFormat:@"%@",[areaDic objectForKey:@"code"]];
            
             [self.m_pickerView reloadAllComponents];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

@end
