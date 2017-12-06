//
//  HH_AdvertViewController.m
//  HuiHui
//
//  Created by mac on 15-4-15.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HH_AdvertViewController.h"

#import "UIImageView+AFNetworking.h"


@interface HH_AdvertViewController ()

@property (weak, nonatomic) IBOutlet UITextField *m_title;

@property (weak, nonatomic) IBOutlet UITextField *m_city;

@property (weak, nonatomic) IBOutlet UITextField *m_weizhi;


@property (weak, nonatomic) IBOutlet UIView *m_addressView;

@property (weak, nonatomic) IBOutlet UITextField *m_urlTextField;

@property (weak, nonatomic) IBOutlet UIButton *m_urlBtn;

@property (weak, nonatomic) IBOutlet UIImageView *m_backImagV;

@property (weak, nonatomic) IBOutlet UIButton *m_imageVBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UIButton *m_proBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_webBtn;

@property (weak, nonatomic) IBOutlet UITextField *m_productTextField;

@property (weak, nonatomic) IBOutlet UITextField *m_commonTextField;

@property (weak, nonatomic) IBOutlet UILabel *m_productLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_webLabel;

@property (weak, nonatomic) IBOutlet UIButton *m_chooseMenuBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_menuLabel;

@property (weak, nonatomic) IBOutlet UITextField *m_menuTextField;

@property (weak, nonatomic) IBOutlet UIButton *m_menuBtn;


// 选择云菜单的展示
- (IBAction)chooseMenuClicked:(id)sender;

- (IBAction)chooseUrlClicked:(id)sender;
// 城市选择
- (IBAction)cityListClicked:(id)sender;

//位置选择
- (IBAction)weizhiClicked:(id)sender;



// 选择产品的按钮触发的事件
- (IBAction)productClicked:(id)sender;
// 设置按钮触发的事件
- (IBAction)settingClicked:(id)sender;

// 选择图片
- (IBAction)photoClicked:(id)sender;

// 选择通用使用的范围
- (IBAction)commonBtnClicked:(id)sender;

// 云菜单选择按钮触发的事件
- (IBAction)menuListChoose:(id)sender;


@end

@implementation HH_AdvertViewController

@synthesize isUrlSelected;

@synthesize isSelected;

@synthesize isMenuSelected;

@synthesize ispickerSelected;

@synthesize m_productList;

@synthesize m_pickerView;

@synthesize m_pickerToolBar;

@synthesize m_productId;

@synthesize m_productName;

@synthesize ImageDiction;

@synthesize m_type;

@synthesize m_webString;

@synthesize m_appMctIndexID;

@synthesize m_cityId;

@synthesize m_dic;

@synthesize m_isChange;

@synthesize m_commonString;

@synthesize gldtype;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.isUrlSelected = NO;
        
        self.isSelected = NO;
        
        self.isMenuSelected = NO;
        
        ispickerSelected = NO;
        
        m_productList = [[NSMutableArray alloc]initWithCapacity:0];
        
        ImageDiction = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_webString = @"";
        
        m_cityId = @"";
        
        pickerorphoto = 0;
        
        m_commonString = @"";
        
        weizhi = @"";
        
        gldtype = @"";
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    [self setTitle:@"广告设置"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 默认隐藏view
    self.m_addressView.hidden = YES;
    
    // 设置scrollerView的滚动范围
    [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 800)];
    
    // 请求产品数据
    [self productListRequest];
    
    // 设置这两个不能点击
    self.m_city.userInteractionEnabled = NO;

    self.m_productTextField.userInteractionEnabled = NO;
    
    self.m_commonTextField.userInteractionEnabled = NO;
    
    // 初始化pickerView
    [self initpickerView];
    
    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
    
    if ( [self.m_type isEqualToString:@"2"] ) {
        
        [self setRightButtonWithTitle:@"删除" action:@selector(deleteClicked)];
        
    }else{
        
        self.navigationItem.rightBarButtonItem = nil;

    }
    
    
    if ( [self.m_type isEqualToString:@"1"] ) {
        
        // 新增
        self.m_appMctIndexID = @"0";
        
        self.m_webString = @"";
        
        [self.m_proBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
        [self.m_webBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
        
        self.isUrlSelected = NO;
        self.isSelected = NO;
        self.m_addressView.hidden = YES;
        
        self.m_isChange = @"1";
        
        self.m_commonTextField.text = @"";
        
    }else if ( [self.m_type isEqualToString:@"2"] ) {
        
        self.m_isChange = @"0";
        
        // 编辑-赋值为广告的id
        self.m_appMctIndexID = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"AppMctIndexID"]];

        self.m_cityId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"CityID"]];
        
        self.m_city.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"CityName"]];
        
        self.m_title.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Title"]];
        
        // 赋值图片
        NSString *imagePath = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"OldImgUrl"]];
        
        [self.m_backImagV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                                placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                             self.m_backImagV.image = image;// [CommonUtil scaleImage:image toSize:CGSizeMake(70, 105)];
                                             //                                     self.m_imageView.contentMode = UIViewContentModeScaleAspectFit;
//                                             [self.imageCache addImage:self.m_imageView.image andUrl:imagePath];
                                             
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                             
                                         }];
        
        
        // 图片
        self.m_backImagV.frame = CGRectMake(self.m_backImagV.frame.origin.x, self.m_backImagV.frame.origin.y, 300, 60);
        
        self.m_imageVBtn.frame = self.m_backImagV.frame;
        self.m_imageVBtn.backgroundColor = [UIColor clearColor];
        
        [self.m_imageVBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.ImageDiction setValue:[self.m_dic objectForKey:@"OldImgUrl"] forKey:@"oldImgUrl"];
        
        
        
        self.m_commonString = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"DisplayPosition"]];
        
        
        if ( [self.m_commonString isEqualToString:@"APP"] ) {
            
            self.m_commonTextField.text = @"仅限于APP使用";
            
            
        }else if ( [self.m_commonString isEqualToString:@"WWZ"] ){
            
            self.m_commonTextField.text = @"仅限于微网站使用";
            
            self.m_productLabel.hidden = YES;
            
            self.m_proBtn.hidden = YES;
            
            self.m_chooseMenuBtn.hidden = YES;
            
            self.m_menuLabel.hidden = YES;
            
            
        }else{
            
            self.m_commonTextField.text = @"不限";
            
            self.m_productLabel.hidden = YES;
            
            self.m_proBtn.hidden = YES;
            
            self.m_chooseMenuBtn.hidden = YES;
            
            self.m_menuLabel.hidden = YES;
            
            
        }
        
        
        self.m_webString = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"IsWebUrl"]];

        if ( [self.m_webString isEqualToString:@"0"] ) {
            
            // 原生产品
            self.isUrlSelected = NO;
            
            // 取消第一响应
//            [self.m_urlTextField resignFirstResponder];
            self.isSelected = YES;
            
            self.isMenuSelected = NO;
            
            [self.m_webBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
            
            [self.m_proBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
            
            [self.m_chooseMenuBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];

            
            self.m_addressView.hidden = NO;
            
            self.m_urlBtn.hidden = NO;
            
            self.m_urlTextField.hidden = YES;
            
            self.m_productTextField.hidden = NO;
            
            self.m_productTextField.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"SvcName"]];
            
            self.m_productId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"SvcId"]];
            
        }else if ( [self.m_webString isEqualToString:@"1"] ){
        
            self.isSelected = NO;
            
            self.isUrlSelected = YES;
            
            self.isMenuSelected = NO;


            [self.m_proBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
            [self.m_webBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
            [self.m_chooseMenuBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];

            
            // 显示view
            self.m_addressView.hidden = NO;
            
            self.m_urlBtn.hidden = YES;
            
            self.m_urlTextField.hidden = NO;
            
            self.m_productTextField.hidden = YES;
            
            self.m_urlTextField.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Url"]];
            
            self.m_urlTextField.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Url"]];
            
        }else  if ( [self.m_webString isEqualToString:@"2"] ){
            
            [self.m_proBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
            [self.m_webBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];

            [self.m_chooseMenuBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];

            self.isUrlSelected = NO;
            self.isSelected = NO;
            
            self.isMenuSelected = YES;

            self.m_addressView.hidden = YES;

            
        }else{
            
            [self.m_proBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
            [self.m_webBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];

            [self.m_chooseMenuBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];

            self.isUrlSelected = NO;
            self.isSelected = NO;
            self.m_addressView.hidden = YES;
            
        }
      
        
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideTabBar:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)deleteClicked{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"确定删除该广告信息?"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    alertView.tag = 109341;
    [alertView show];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 109341 ) {
        
        if ( buttonIndex == 1 ) {
            
            // 删除广告请求数据
            [self deleteRequest];
        }
    }
    
    
}

- (IBAction)chooseMenuClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    self.isSelected = NO;
    
    self.isUrlSelected = NO;
    
    // 隐藏view
    self.m_addressView.hidden = YES;

    
    // 填写url地址
    self.isMenuSelected = !self.isMenuSelected;
    
    [self.m_webBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
    
    [self.m_proBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
    
    
    if ( self.isMenuSelected ) {
        
        [self.m_chooseMenuBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
        
        // 显示view
//        self.m_addressView.hidden = NO;
//        
//        self.m_urlBtn.hidden = YES;
//        
//        self.m_urlTextField.hidden = NO;
//        
//        self.m_productTextField.hidden = YES;
//        
//        self.m_urlTextField.placeholder = @"请输入跳转的链接地址";
//        
//        // textfield获取第一响应
//        [self.m_urlTextField becomeFirstResponder];
//        
//        // 链接地址类别
        self.m_webString = @"2";
        
        
    }else{
        
        [self.m_chooseMenuBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
       
        // 链接地址类别
        self.m_webString = @"";
        
    }

    
    
    
    
}

- (IBAction)chooseUrlClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 11 ) {
        
        self.isUrlSelected = NO;
        
        self.isMenuSelected = NO;
        
        // 取消第一响应
        [self.m_urlTextField resignFirstResponder];
        
        // 选择产品
        self.isSelected = !self.isSelected;
        
        [self.m_webBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];

        [self.m_chooseMenuBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];

        
        if ( self.isSelected ) {
            
            [self.m_proBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
            
            self.m_addressView.hidden = NO;
            
            self.m_urlBtn.hidden = NO;
            
            self.m_urlTextField.hidden = YES;
            
            self.m_productTextField.hidden = NO;
            
            self.m_productTextField.placeholder = @"请选择产品名称";
           
            // 链接地址类别
            self.m_webString = @"0";
            
        }else{
            
            [self.m_proBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];

            self.m_addressView.hidden = YES;
            
            // 链接地址类别
            self.m_webString = @"";


        }
        
    }else if ( btn.tag == 22 ){
        
        self.isSelected = NO;
        
        self.isMenuSelected = NO;


        // 填写url地址
        self.isUrlSelected = !self.isUrlSelected;
        
        [self.m_proBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
        
        [self.m_chooseMenuBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];

        
        if ( self.isUrlSelected ) {
            
            [self.m_webBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
            
            // 显示view
            self.m_addressView.hidden = NO;

            self.m_urlBtn.hidden = YES;
            
            self.m_urlTextField.hidden = NO;
            
            self.m_productTextField.hidden = YES;
            
            self.m_urlTextField.placeholder = @"请输入跳转的链接地址";

            // textfield获取第一响应
            [self.m_urlTextField becomeFirstResponder];
            
            // 链接地址类别
            self.m_webString = @"1";

            
        }else{
            
            [self.m_webBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
            
            self.m_addressView.hidden = YES;
            
            // textfield取消第一响应
            [self.m_urlTextField resignFirstResponder];
            
            // 链接地址类别
            self.m_webString = @"";

        }

    }else{
        
        
        
    }
   
}

- (IBAction)cityListClicked:(id)sender {
    
    [self.view endEditing:YES];

    // 进入城市选择的页面
    HH_advCityListViewController *VC = [HH_advCityListViewController shareobject];//[[HH_advCityListViewController alloc]initWithNibName:@"HH_advCityListViewController" bundle:nil];
    VC.delegate = self;
    VC.m_cityName = [NSString stringWithFormat:@"%@",self.m_city.text];
    VC.m_cityId = [NSString stringWithFormat:@"%@",self.m_cityId];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (IBAction)productClicked:(id)sender {
    
    self.m_pickerToolBar.hidden = NO;
    
    self.m_pickerView.hidden = NO;
    
    self.ispickerSelected = YES;

    [self.m_pickerView reloadAllComponents];
}

- (IBAction)settingClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    if ( self.m_title.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请填写广告标题"];
        
        return;
        
    }
    
    if ( self.m_city.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择所在城市"];
        
        return;
        
    }
    
    
    if ( pickerorphoto == 0 ) {
        
        if ( [self.m_type isEqualToString:@"1"] ) {
            
            [SVProgressHUD showErrorWithStatus:@"请选择广告图片"];
            
            return;

        }
    }
    
    if ( self.m_commonTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择广告通用范围"];
        
        return;
    }
    
    
    // 根据类型进行判断
    if ( [self.m_commonString isEqualToString:@"APP"] ) {
        
        if ( [self.m_webString isEqualToString:@"0"] ){
            
            if ( self.m_productTextField.text.length == 0 ) {
                
                [SVProgressHUD showErrorWithStatus:@"请选择产品"];
                
                return;
            }
            
        }else if ( [self.m_webString isEqualToString:@"1"] ){
            
            if ( self.m_urlTextField.text.length == 0 ) {
                
                [SVProgressHUD showErrorWithStatus:@"请输入跳转的链接地址"];
                
                return;
            }
            
        }else if ( [self.m_webString isEqualToString:@"2"] ){
            
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:@"请选择链接地址的跳转类别"];
            
            return;
            
        }

        
    }else {
        
        if ( [self.m_webString isEqualToString:@"1"] ){
            
            if ( self.m_urlTextField.text.length == 0 ) {
                
                [SVProgressHUD showErrorWithStatus:@"请输入跳转的链接地址"];
                
                return;
            }
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:@"请选择链接地址的跳转类别"];
            
            return;
            
        }

        
    }
    
    
    
    
    // 请求数据
    [self settingRequestSubmit];
   
    
}


- (IBAction)photoClicked:(id)sender {
    
    if ([weizhi isEqualToString:@""]) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择广告所在位置"];
        
    }else {
    
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:@"相册选取",nil];
        
        
        sheet.tag = 1;
        [sheet showInView:self.view];
        
    }
    
}

- (IBAction)commonBtnClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"不限",@"仅限于APP使用",@"仅限于微网站使用",nil];
    
    
    sheet.tag = 1039;
    [sheet showInView:self.view];
    
    
}

- (IBAction)menuListChoose:(id)sender {
    
    
}


#pragma mark -初始化显示地区的pickerView
- (void)initpickerView{
    UIWindow *window = self.navigationController.view.window;
    
    //  datePickerView初始化
    self.m_pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 216, WindowSizeWidth, 216)];
    self.m_pickerView.backgroundColor = [UIColor whiteColor];
    self.m_pickerView.delegate = self;
    self.m_pickerView.dataSource = self;
    // 设置pickerView选择时的背景，默认的为NO
    self.m_pickerView.showsSelectionIndicator = YES;
    [window addSubview:self.m_pickerView];
    
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
    pickerBar.frame = CGRectMake(0, self.m_pickerView.frame.origin.y - 44, WindowSizeWidth, 44);
    [window addSubview:pickerBar];
    pickerBar.backgroundColor = [UIColor clearColor];
    self.m_pickerToolBar = pickerBar;
    
}

#pragma mark - PickerBar按钮
- (void)doPickerDone:(id)sender{
    
    if (self.ispickerSelected !=YES)
    {
        
        return;
    }else
    {
        
        self.view.userInteractionEnabled = YES;
        
        self.m_pickerView.hidden = YES;
        
        self.m_pickerToolBar.hidden = YES;
        
        self.ispickerSelected = NO;
        
        // 赋值
        self.m_productTextField.text = [NSString stringWithFormat:@"%@",self.m_productName];
        
        
        
//        if ([self.m_typeString isEqualToString:@"color"]) {
//          
//            ColourViewController *vc =[[ColourViewController alloc]initWithNibName:@"ColourViewController" bundle:nil];
//            vc.CTitle = self.m_merchantString;
//            vc.MemberchantID = self.m_merchantID;
//            [self.navigationController pushViewController:vc animated:YES];
//      
//        }else if ([self.m_typeString isEqualToString:@"photo"])
//        {
//            FirstPhotoViewController *vc =[[FirstPhotoViewController alloc]initWithNibName:@"FirstPhotoViewController" bundle:nil];
//            vc.MemberchantID = self.m_merchantID;
//            vc.MemberchantName = self.m_merchantString;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
        
    }
    
}

- (void)doPickerCancel:(id)sender{
    
    self.view.userInteractionEnabled = YES;
    
    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
    
    
}

#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.m_productList.count;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if ( self.m_productList.count != 0 ) {
        
        NSDictionary *dic = [self.m_productList objectAtIndex:row];
        
        NSString * titleResult = [NSString stringWithFormat:@"%@",[dic objectForKey:@"SvcName"]];

        return titleResult;

    }
    
    return nil;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.ispickerSelected = YES;
    
//    self.m_merchantString = [self.chosearrayname objectAtIndex:row];
//    self.m_merchantID = [self.chosearraycode objectAtIndex:row];
    
    if ( self.m_productList.count != 0 ) {
        
        NSDictionary *dic = [self.m_productList objectAtIndex:row];
        
        self.m_productName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"SvcName"]];
        
        // 赋值产品的id
        self.m_productId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"SvcId"]];
    }

    for (int i = 0; i < [pickerView numberOfComponents]; i++) {
        
        [self.m_pickerView reloadComponent:i];
        
    }
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{

    if ( textField == self.m_title || textField == self.m_urlTextField || textField == self.m_productTextField || textField == self.m_commonTextField ) {
        
        [self hiddenNumPadDone:nil];
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - UIActionSheetDelegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1)
    {
        //打开照相
        if (buttonIndex==0)
        {
            
            //打开相册
            [self.ImageDiction removeAllObjects];
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];//打开照片文件
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:^{
                
            }];
        
        }
        
    }else if ( actionSheet.tag == 1039 ){
        
       // 显示位置（手机APP：APP,微网站：WWZ，不限：“ALL”）
        if ( buttonIndex == 0 ) {
            // 不限
            self.m_commonTextField.text = @"不限";
            
            self.m_commonString = @"ALL";
            
            // 只显示web地址填写
            self.m_proBtn.hidden = YES;
            self.m_productLabel.hidden = YES;
            
            self.m_webBtn.hidden = NO;
            self.m_webLabel.hidden = NO;
            

            // 显示view
            self.m_addressView.hidden = NO;
            
            self.m_urlBtn.hidden = YES;
            
            self.m_urlTextField.hidden = NO;
            
            self.m_productTextField.hidden = YES;
            
            self.m_urlTextField.placeholder = @"请输入跳转的链接地址";
            
            self.m_chooseMenuBtn.hidden = YES;
            
            self.m_menuLabel.hidden = YES;

            
        }else if ( buttonIndex == 1 ){
            // 仅限于app
            self.m_commonTextField.text = @"仅限于APP使用";
            
            self.m_commonString = @"APP";
            
            
            // 显示产品和web的填写
            self.m_proBtn.hidden = NO;
            self.m_productLabel.hidden = NO;
            
            self.m_webBtn.hidden = NO;
            self.m_webLabel.hidden = NO;
            
            
            if ( self.isUrlSelected ) {
                
                self.m_addressView.hidden = NO;

            }else{
                
                self.m_addressView.hidden = YES;

            }
            
            self.m_chooseMenuBtn.hidden = NO;
            
            self.m_menuLabel.hidden = NO;
            
        }else if ( buttonIndex == 2 ){
            // 仅限于微网站
            self.m_commonTextField.text = @"仅限于微网站使用";
            
            self.m_commonString = @"WWZ";
            
            
            
            // 只显示web地址填写
            self.m_proBtn.hidden = YES;
            self.m_productLabel.hidden = YES;
            
            self.m_webBtn.hidden = NO;
            self.m_webLabel.hidden = NO;
            
            
            // 显示view
            self.m_addressView.hidden = NO;
            
            self.m_urlBtn.hidden = YES;
            
            self.m_urlTextField.hidden = NO;
            
            self.m_productTextField.hidden = YES;
            
            self.m_urlTextField.placeholder = @"请输入跳转的链接地址";

            self.m_chooseMenuBtn.hidden = YES;
            
            self.m_menuLabel.hidden = YES;
            
            
        }
        
    }else if (actionSheet.tag == 10009) {
    
        if ( buttonIndex == 0 ) {
            
            self.m_weizhi.text = @"首页广告";
            
            weizhi = @"home";
            
            gldtype = @"";
        
        }else if (buttonIndex == 1) {
        
            self.m_weizhi.text = @"粉丝宝广告";
            
            weizhi = @"quanfanfu";
            
            gldtype = @"1";
            
        }
        
    }
    
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
    
    self.m_isChange = @"1";
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage *image = [[UIImage alloc]init];
    
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.m_backImagV.contentMode = UIViewContentModeScaleAspectFit;
    
    if ([weizhi isEqualToString:@"home"]) {
        
        if ( image.size.width == 960.0 && image.size.height == 300.0 ) {
            
            pickerorphoto = 1;
            
            [self saveImage:image withName:@"currentImage.png"];
            NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
            UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
            UIImageView *imgV = [[UIImageView alloc]init];
            imgV.image = savedImage;
            
            self.m_backImagV.image = savedImage;
            
            if ( savedImage ) {
                
                self.m_backImagV.frame = CGRectMake(self.m_backImagV.frame.origin.x, self.m_backImagV.frame.origin.y, 300, 60);
                
                self.m_imageVBtn.frame = self.m_backImagV.frame;
                self.m_imageVBtn.backgroundColor = [UIColor clearColor];
                
                [self.m_imageVBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                
            }
            
            // 存储图片到字典里用于上传服务器
            [self.ImageDiction setValue:[self getImageData:imgV] forKey:@"oldImgUrl"];
            
        }else{
            
            pickerorphoto = 0;
            
            [SVProgressHUD showErrorWithStatus:@"您选择的首页广告图片不符合所要求的尺寸大小，请重新选择"];
            
        }
        
    }else if ([weizhi isEqualToString:@"quanfanfu"]) {
    
        if ( image.size.width == 720.0 && image.size.height == 320.0 ) {
            
            pickerorphoto = 1;
            
            [self saveImage:image withName:@"currentImage.png"];
            NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
            UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
            UIImageView *imgV = [[UIImageView alloc]init];
            imgV.image = savedImage;
            
            self.m_backImagV.image = savedImage;
            
            if ( savedImage ) {
                
                self.m_backImagV.frame = CGRectMake(self.m_backImagV.frame.origin.x, self.m_backImagV.frame.origin.y, 300, 60);
                
                self.m_imageVBtn.frame = self.m_backImagV.frame;
                self.m_imageVBtn.backgroundColor = [UIColor clearColor];
                
                [self.m_imageVBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                
            }
            
            // 存储图片到字典里用于上传服务器
            [self.ImageDiction setValue:[self getImageData:imgV] forKey:@"oldImgUrl"];
            
        }else{
            
            pickerorphoto = 0;
            
            [SVProgressHUD showErrorWithStatus:@"您选择的粉丝宝广告图片不符合所要求的尺寸大小，请重新选择"];
            
        }
        
    }
   
}

- (NSData *)getImageData:(UIImageView *)imageView {
    UIImage *image = imageView.image;
    return UIImageJPEGRepresentation(image, 0.1);
}

#pragma mark - HH_AdvCityDelegate
- (void)getCityList:(NSMutableDictionary *)aDic{
    
    self.m_city.text = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"CityName"]];
    
    self.m_cityId = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"CityId"]];
    
}

#pragma mark - 请求数据
- (void)productListRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    //    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           merchantId, @"merchantId",
                           nil];
    
//    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"UpAdServiceList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
             [SVProgressHUD dismiss];
           
            self.m_productList = [json valueForKey:@"UpAdServiceList"];
            
            // 初始值赋值
            if ( self.m_productList.count != 0 ) {
                
                NSDictionary *dic = [self.m_productList objectAtIndex:0];
                
                self.m_productName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"SvcName"]];
                
                // 赋值产品的id
                self.m_productId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"SvcId"]];
            }
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

// 新增广告和修改广告的请求数据
- (void)settingRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 根据类型来判断
    NSString *productId = @"";
    NSString *urlString = @"";
    
    if ( [self.m_webString isEqualToString:@"0"] ) {
        
        productId = [NSString stringWithFormat:@"%@",self.m_productId];
        urlString = @"";
        
    }else if ( [self.m_webString isEqualToString:@"1"] ) {
        
        productId = @"";
        urlString = [NSString stringWithFormat:@"%@",self.m_urlTextField.text];
        
    }else{
        
        productId = @"";
        urlString = @"";
        
    }
    
    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    //    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           merchantId, @"merchantId",
                           self.m_cityId,@"cityId",
                           productId,@"serviceId",
                           self.m_appMctIndexID,@"appMctIndexID",
                           [NSString stringWithFormat:@"%@",self.m_type],@"operation",
                           [NSString stringWithFormat:@"%@",self.m_title.text],@"title",
                           [NSString stringWithFormat:@"%@",self.m_webString],@"urlType",
                           urlString,@"url",
                           self.m_isChange,@"isChange",
                           [NSString stringWithFormat:@"%@",self.m_commonString],@"displayPosition",
                           gldtype,@"gldtype",
                           nil];
    
    NSLog(@"params = %@",param);
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    if ( [self.m_isChange isEqualToString:@"0"] ) {
        
//        [httpClient multiRequest:@"UpAdServiceAdd.ashx" parameters:param files:self.ImageDiction success:^(NSJSONSerialization* json){  UpAdServiceAdd_2.ashx   UpAdServiceAdd_1
        
        [httpClient request:@"UpAdServiceAdd_2.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
            BOOL success = [[json valueForKey:@"status"] boolValue];
            if (success) {
                [SVProgressHUD dismiss];
                
                // 新增、编辑成功后设置值用于返回上一级的时候刷新数据
                [CommonUtil addValue:@"1" andKey:AdvertsKey];
                
                NSString *msg = [json valueForKey:@"msg"];
                [SVProgressHUD showSuccessWithStatus:msg];
                
                [self goBack];
                
            } else {
                
                NSString *msg = [json valueForKey:@"msg"];
                [SVProgressHUD showErrorWithStatus:msg];
            }
        } failure:^(NSError *error) {
            //NSLog(@"failed:%@", error);
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }];


    
    }else if ( [self.m_isChange isEqualToString:@"1"] ){
        
        
        [httpClient multiRequest:@"UpAdServiceAdd_2.ashx" parameters:param files:self.ImageDiction success:^(NSJSONSerialization* json){
            
            BOOL success = [[json valueForKey:@"status"] boolValue];
            if (success) {
                [SVProgressHUD dismiss];
                
                // 新增、编辑成功后设置值用于返回上一级的时候刷新数据
                [CommonUtil addValue:@"1" andKey:AdvertsKey];
                
                NSString *msg = [json valueForKey:@"msg"];
                [SVProgressHUD showSuccessWithStatus:msg];
                
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

   
}

- (void)deleteRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    

    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.m_appMctIndexID, @"appMctIndexID",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];

    [httpClient request:@"UpAdDelete.ashx" parameters:param success:^(NSJSONSerialization* json) {

        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            // 删除成功后设置值用于返回上一级的时候刷新数据
            [CommonUtil addValue:@"1" andKey:AdvertsKey];
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
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


- (IBAction)weizhiClicked:(id)sender {
    
    //选择广告位置
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"首页广告" otherButtonTitles:@"全返付广告", nil];
    
    sheet.tag = 10009;
    
    [sheet showInView:self.view];
    
}
@end
