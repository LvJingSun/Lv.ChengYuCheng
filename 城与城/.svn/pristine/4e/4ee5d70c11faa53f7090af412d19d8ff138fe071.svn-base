//
//  HH_RelseaeQuanViewController.m
//  HuiHui
//
//  Created by mac on 15-3-19.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HH_RelseaeQuanViewController.h"

@interface HH_RelseaeQuanViewController ()

@property (weak, nonatomic) IBOutlet UITextField *m_titleField;

@property (weak, nonatomic) IBOutlet UIImageView *m_imagV;

@property (weak, nonatomic) IBOutlet UITextView *m_textView;

@property (weak, nonatomic) IBOutlet UILabel *m_tipLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_time;

@property (weak, nonatomic) IBOutlet UILabel *m_endTime;

@property (weak, nonatomic) IBOutlet UILabel *m_shopName;

@property (weak, nonatomic) IBOutlet UITextField *m_totalCount;

@property (weak, nonatomic) IBOutlet UITextField *m_singleCount;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UIButton *m_releaseBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_deleteBtn;

// 删除券券按钮触发的事件
- (IBAction)deleteQuanquan:(id)sender;
// 选择时间的按钮触发的事件
- (IBAction)timeClicked:(id)sender;
// 选择店铺的按钮触发的事件
- (IBAction)shopClicked:(id)sender;
// 发布按钮触发的事件
- (IBAction)releaseClicked:(id)sender;

// Control点击事件
- (IBAction)tapDown:(id)sender;

@end

@implementation HH_RelseaeQuanViewController

@synthesize m_datePicker;

@synthesize m_toolbar;

@synthesize isSelected;

@synthesize m_dateString;

//@synthesize m_shopString;

@synthesize m_shopList;

@synthesize m_EndDataString;

@synthesize m_typeString;

@synthesize m_type;

@synthesize m_shopId;

@synthesize m_voucherId;

@synthesize m_dic;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.isSelected = NO;
        
        m_shopList = [[NSMutableArray alloc]initWithCapacity:0];

        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ( [self.m_type isEqualToString:@"1"] ) {
        
        [self setTitle:@"发布券券"];
        
        [self setRightButtonWithTitle:@"发布" action:@selector(releaseClicked:)];

        
        self.m_releaseBtn.hidden = NO;
        
        self.m_deleteBtn.hidden = YES;
        
        // 赋值默认为空的
        self.m_dateString = @"";
        
        self.m_EndDataString = @"";
        
//        self.m_shopString = @"";
        
        self.m_shopId = @"";
        
        self.m_voucherId = @"0";

    }else{
        
        [self setTitle:@"编辑券券"];
        
        [self setRightButtonWithTitle:@"保存" action:@selector(releaseClicked:)];
        
        self.m_releaseBtn.hidden = YES;
        
        self.m_deleteBtn.hidden = NO;
        
        // 赋值
        // vocherId
        self.m_voucherId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"VouchersID"]];

        self.m_titleField.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Title"]];
        self.m_textView.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Description"]];
        self.m_time.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"MinDateTime"]];
        self.m_endTime.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"MaxDateTime"]];
        self.m_totalCount.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Amount"]];
        self.m_singleCount.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"AllowGetAmount"]];
        
        self.m_dateString = [NSString stringWithFormat:@"%@",self.m_time.text];
        self.m_EndDataString = [NSString stringWithFormat:@"%@",self.m_endTime.text];
        
        // 设置字体的颜色
        if ( self.m_textView.text.length != 0 ) {
            self.m_tipLabel.text = @"";
        }
        
        self.m_time.textColor = RGBACKTAB;
        self.m_endTime.textColor = RGBACKTAB;
//        self.m_shopName.textColor = RGBACKTAB;

        // 赋值
        self.m_shopList = [self.m_dic objectForKey:@"VoucherMctShopList"];
  
        if ( self.m_shopList.count != 0 ) {
            
            // 赋值shopId和shopName
            [self getShopId:self.m_shopList];
            
        }else{
            
            self.m_shopName.text = @"请选择券券可使用店铺";
            
//            self.m_shopString = @"";
            
            self.m_shopName.textColor = [UIColor colorWithRed:207/255.0 green:207/255.0 blue:211/255.0 alpha:1.0];
            
            self.m_shopId = @"";

        }

        
    }
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
    // 设置图片不拉伸的情况
    UIImage *image = [UIImage imageNamed:@"login_shuru.png"];
    image = [image stretchableImageWithLeftCapWidth:floorf(image.size.width/2) topCapHeight:floorf(image.size.height/2)];
    
    self.m_imagV.image = image;
    
    
    // 初始化pickerView
    [self initWithPickerView];
    
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
    self.m_typeString = @"";

    // 设置scrollerView的滚动范围
    if ( isIOS7 ) {
        
        [self.m_scrollerView setContentSize:CGSizeMake(self.m_scrollerView.frame.size.width, 800)];

    }else{
        
        [self.m_scrollerView setContentSize:CGSizeMake(self.m_scrollerView.frame.size.width, 600)];

    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 赋值shopId和shopname
- (void)getShopId:(NSMutableArray *)arr{
    
    if ( arr.count != 0 ) {
        
        NSString *nameString = @"";
        
        NSString *shopIdString = @"";
        
        for (int i = 0; i < arr.count; i++) {
            
            NSDictionary *dic = [arr objectAtIndex:i];
            
            NSString *name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopName"]];
            
            NSString *shopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopID"]];
            
            
            // 赋值
            if ( i != arr.count - 1 ) {
                
                nameString = [nameString stringByAppendingString:[NSString stringWithFormat:@"%@,",name]];
                
                shopIdString = [shopIdString stringByAppendingString:[NSString stringWithFormat:@"%@,",shopId]];
                
                
            }else{
                
                nameString = [nameString stringByAppendingString:[NSString stringWithFormat:@"%@",name]];
                
                shopIdString = [shopIdString stringByAppendingString:[NSString stringWithFormat:@"%@",shopId]];
                
            }
            
            self.m_shopName.text = [NSString stringWithFormat:@"%@",nameString];
            
//            self.m_shopString = [NSString stringWithFormat:@"%@",nameString];
            
            self.m_shopName.textColor = RGBACKTAB;//[UIColor blackColor];
            
            self.m_shopId = [NSString stringWithFormat:@"%@",shopIdString];
            
        }
        
    }else{
        
        self.m_shopName.text = @"请选择券券可使用店铺";
        
//        self.m_shopString = @"";
        
        self.m_shopName.textColor = [UIColor colorWithRed:207/255.0 green:207/255.0 blue:211/255.0 alpha:1.0];
        
        self.m_shopId = @"";
        
    }
    
}

- (void)leftClicked{
    
    [self goBack];
    
}

- (IBAction)releaseClicked:(id)sender {
    
    [self hidenPicker];
    
    if ( self.m_titleField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入券券标题"];
        
        return;

    }
    
    if ( self.m_textView.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入券券的详细说明"];
        
        return;
        
    }
    
    if ( self.m_dateString.length == 0 || self.m_EndDataString.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入券券的有效期"];
        
        return;
        
    }

    
    // 生效时间和截止时间的判断，生效时间不能晚于截止时间
    NSDate *startDate = [self dateWithstringFromScenery:self.m_dateString];

    NSDate *endDate = [self dateWithstringFromScenery:self.m_EndDataString];

    if ( [startDate compare:endDate] == NSOrderedDescending ) {
    
        [SVProgressHUD showErrorWithStatus:@"生效时间不能晚于失效时间,请重新选择"];
        
        return;
    
    }
    
    if ( self.m_shopId.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择券券可适用的店铺"];
        
        return;
        
    }
    
    if ( self.m_totalCount.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入券券可使用的总份数"];
        
        return;
        
    }
    
    if ( self.m_singleCount.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入券券每个用户可使用的份数"];
        
        return;
        
    }
 
    // 请求数据
    [self releaseQuanSubmit];
    
}

- (IBAction)deleteQuanquan:(id)sender {
    // 删除券券的按钮触发的事件
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"确定删除该券券？"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    
    alertView.tag = 1356;
    [alertView show];
    
}

- (IBAction)tapDown:(id)sender {
    
    [self hidenPicker];
    
    [self setScrollerViewScrollwithHeight:0.0f];
    
}

- (void)hidenPicker{
    
    [self.view endEditing:YES];
   
    // 隐藏pickerView和toolBar
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 1356 ) {
        
        if ( buttonIndex == 1 ) {
            
            // 确定删除执行的一些操作
            [self deleteRequest];
            
//            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            
        }
    }
    
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView;
{
    
//    [self hidenPicker];
    
    [self setScrollerViewScrollwithHeight:0.0f];
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        
        self.m_tipLabel.text = @"请填写券券的详细说明";
        
    }else{
        
        self.m_tipLabel.text = @"";
        
    }

}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    [self hiddenNumPadDone:nil];
    return YES;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    // 隐藏pickerView和toolBar
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];

    if ( textField == self.m_titleField ) {
        
        [self hiddenNumPadDone:nil];
        
        [self setScrollerViewScrollwithHeight:0.0f];

    }else if ( textField == self.m_totalCount ){
        
        [self showNumPadDone:nil];
        
        [self setScrollerViewScrollwithHeight:250.0f];

    }else if ( textField == self.m_singleCount ){
        
        [self setScrollerViewScrollwithHeight:250.0f];
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

- (IBAction)timeClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    // 选择时间的时候scrollerView滚动到一定的位置
    [self setScrollerViewScrollwithHeight:150.0f];
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 10 ) {
        // 开始时间的选择
        self.m_typeString = @"StartData";
        
    }else{
        // 截止日期的选择
        self.m_typeString = @"EndData";
    }

    [self.m_datePicker setHidden:NO];
    [self.m_toolbar setHidden:NO];
    
}

- (IBAction)shopClicked:(id)sender {
    
    [self hidenPicker];
    
    // 进入店铺选择的页面
    HH_shopListViewController *VC = [[HH_shopListViewController alloc]initWithNibName:@"HH_shopListViewController" bundle:nil];//[HH_shopListViewController shareobject];
    VC.delegate = self;
    VC.m_shopArray = self.m_shopList;
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - 发布券券请求接口
- (void)releaseQuanSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    // voucherId 0表示是新增  其他表示是编辑
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           [NSString stringWithFormat:@"%@",self.m_titleField.text],@"title",
                           [NSString stringWithFormat:@"%@",self.m_textView.text],@"description",
                           [NSString stringWithFormat:@"%@",self.m_time.text],@"minDateTime",
                           [NSString stringWithFormat:@"%@",self.m_endTime.text],@"maxDateTime",
                           [NSString stringWithFormat:@"%@",self.m_shopId],@"mctShopIds",
                           [NSString stringWithFormat:@"%@",self.m_totalCount.text],@"amount",
                           [NSString stringWithFormat:@"%@",self.m_singleCount.text],@"allowGetAmount",
                           [NSString stringWithFormat:@"%@",self.m_voucherId],@"voucherId",
                           
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"VoucherAdd.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];

            // 返回上一级
            [self goBack];
            
        } else {
            
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
    
}

- (void)deleteRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
 
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    // voucherId 0表示是新增  其他表示是编辑
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           [NSString stringWithFormat:@"%@",self.m_voucherId],@"voucherId",
                           
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"VoucherDelete.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 返回上一级
            [self goBack];
            
        } else {
            
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

    
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

// 设置scrollerView滚动的范围
- (void)setScrollerViewScrollwithHeight:(CGFloat)height{
    
    // 选择时间的时候scrollerView滚动到一定的位置
    [self.m_scrollerView setContentOffset:CGPointMake(0, height) animated:NO];
}

#pragma mark - PickerBar按钮
- (void)doPCAPickerDone:(id)sender{
    
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
    [self setScrollerViewScrollwithHeight:0.0f];
    
    // 判断是否滚动了pickerView
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyy-MM-dd"];
    
    // 判断选择时间的类型，是开始时间还是截止时间
    if ( [self.m_typeString isEqualToString:@"StartData"] ) {
        
        self.m_dateString = [formatter stringFromDate:m_datePicker.date];
        
        if ( self.m_dateString.length == 0 ) {
            
            self.m_time.text = @"请选择券券生效时间";
            
            self.m_time.textColor = [UIColor colorWithRed:207/255.0 green:207/255.0 blue:211/255.0 alpha:1.0];
            
        }else{
            
            self.m_time.text = [NSString stringWithFormat:@"%@",self.m_dateString];
            
            self.m_time.textColor = RGBACKTAB;//[UIColor blackColor];
            
        }
        
    }else{
        
        self.m_EndDataString = [formatter stringFromDate:m_datePicker.date];
        
        if ( self.m_EndDataString.length == 0 ) {
            
            self.m_endTime.text = @"请选择券券失效时间";
            
            self.m_endTime.textColor = [UIColor colorWithRed:207/255.0 green:207/255.0 blue:211/255.0 alpha:1.0];
            
        }else{
            
            self.m_endTime.text = [NSString stringWithFormat:@"%@",self.m_EndDataString];
            
            self.m_endTime.textColor = RGBACKTAB;//[UIColor blackColor];
            
        }
        
    }
    
    self.isSelected = NO;
    
}

- (void)doPCAPickerCancel:(id)sender{
    
    [self setScrollerViewScrollwithHeight:0.0f];

    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
}

// pickerView的选择事件
- (void) togglePicker:(id)sender{
    
    self.isSelected = YES;
    
    // 判断不能选择今天日期以前的时间
    if ( [m_datePicker.date compare:[NSDate date]] == NSOrderedAscending ) {
        [m_datePicker setDate:[NSDate date] animated:YES];
    }
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyy-MM-dd"];
    
    NSString *str = [formatter stringFromDate:m_datePicker.date];
    
    
    // 判断选择时间的类型，是开始时间还是截止时间
    if ( [self.m_typeString isEqualToString:@"StartData"] ) {

        self.m_dateString = [NSString stringWithFormat:@"%@",str];

    }else{
        
        self.m_EndDataString = [NSString stringWithFormat:@"%@",str];

    }
    
}

#pragma mark - ShopListDelegate
- (void)getShopList:(NSMutableArray *)aShopArray{

    // 数组有值时将数据先清空
    if ( self.m_shopList.count != 0 ) {
        
        [self.m_shopList removeAllObjects];
    }
    // 添加到数组里
    [self.m_shopList addObjectsFromArray:aShopArray];
    
    if ( aShopArray.count != 0 ) {
        
        [self getShopId:aShopArray];
    
    }
}


@end
