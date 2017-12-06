//
//  HH_partyViewController.m
//  HuiHui
//
//  Created by mac on 14-10-16.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "HH_partyViewController.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "HH_PartyDetailViewController.h"

@interface HH_partyViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UIView *m_topicVIew;

@property (weak, nonatomic) IBOutlet UIView *m_detailView;

@property (weak, nonatomic) IBOutlet UIView *m_addressView;

@property (weak, nonatomic) IBOutlet UIView *m_timeView;

@property (weak, nonatomic) IBOutlet UITextField *m_topicField;

@property (weak, nonatomic) IBOutlet UITextView *m_detailTextView;

@property (weak, nonatomic) IBOutlet UILabel *m_detailLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_addressLabel;

@property (weak, nonatomic) IBOutlet UITextField *m_timeField;

@property (weak, nonatomic) IBOutlet UIView *m_photoView;

@property (weak, nonatomic) IBOutlet UIButton *m_photoChooseBtn;

// 选择活动位置
- (IBAction)addressChooseClicked:(id)sender;
// 选择报名截止时间
- (IBAction)timeChooseClicked:(id)sender;
// 选择图片
- (IBAction)photoChooseClicked:(id)sender;

@end

@implementation HH_partyViewController

@synthesize m_datePicker;
@synthesize m_toolbar;
@synthesize isSelected;
@synthesize m_temporaryDate;
@synthesize m_imageArray;
@synthesize ImageDic;
@synthesize isChoosePhoto;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.isSelected = NO;
        
        m_imageArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        ImageDic = [[NSMutableDictionary alloc]initWithCapacity:0];

         isChoosePhoto = NO;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"发起活动"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    
    [self setRightButtonWithTitle:@"发布" action:@selector(submitParty)];
    
    // 设置view的边框
    self.m_topicVIew.layer.borderWidth = 1.0;
    self.m_topicVIew.layer.borderColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:208/255.0 alpha:1.0].CGColor;
   
    self.m_detailView.layer.borderWidth = 1.0;
    self.m_detailView.layer.borderColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:208/255.0 alpha:1.0].CGColor;
    
    self.m_addressView.layer.borderWidth = 1.0;
    self.m_addressView.layer.borderColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:208/255.0 alpha:1.0].CGColor;
  
    self.m_timeView.layer.borderWidth = 1.0;
    self.m_timeView.layer.borderColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:208/255.0 alpha:1.0].CGColor;
    
    self.m_photoView.layer.borderWidth = 1.0;
    self.m_photoView.layer.borderColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:208/255.0 alpha:1.0].CGColor;
    
    
    // 设置scrollerView的滚动范围
    [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 600)];
    
    
    // 设置键盘上面的完成按钮
    [self createKeyboard];
    
    // 初始化日期的pickerView
    [self initWithPickerView];
   
    // 先隐藏pickerView
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
    // 赋值
    self.m_temporaryDate = @"报名截止时间";
    
    self.m_photoChooseBtn.hidden = NO;
 
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if ( !self.isChoosePhoto ) {
        
        // 隐藏tabBar
        [self hideTabBar:YES];
        
    }else{
        
        // =========
//        if ( isIOS7 ) {
        
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
        //========
    }
    
    self.isChoosePhoto = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    // 隐藏pickerView
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
    // 判断是否隐藏tabBar
    if ( !self.isChoosePhoto ) {
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

// 发布活动
- (void)submitParty{
    
    NSLog(@"topic = %@,detail = %@,time = %@",self.m_topicField.text,self.m_detailTextView.text,self.m_timeField.text);
    
//    if ( self.m_topicField.text.length == 0 ) {
//        
//        [SVProgressHUD showErrorWithStatus:@"请输入活动主题"];
//        
//        return;
//    }
//    
//    
//    if ( self.m_detailTextView.text.length == 0 ) {
//        
//        [SVProgressHUD showErrorWithStatus:@"请输入活动详情"];
//        
//        return;
//    }
//   
//    if ( self.m_timeField.text.length == 0 ) {
//        
//        [SVProgressHUD showErrorWithStatus:@"请选择活动截止时间"];
//        
//        return;
//    }
    
    
    // 发布活动-成功后进入活动详细的页面
    HH_PartyDetailViewController *VC = [[HH_PartyDetailViewController alloc]initWithNibName:@"HH_PartyDetailViewController" bundle:nil];
    VC.m_imageList = self.m_imageArray;
    
    // 进行地理位置的赋值
    if ( [self.m_addressLabel.text isEqualToString:@"标记活动位置,可不标"] ) {
        
        VC.m_addressString = @"";

    }else{
        
        VC.m_addressString = [NSString stringWithFormat:@"%@",self.m_addressLabel.text];

    }
    
    [self.navigationController pushViewController:VC animated:YES];
    

}

// 获取图片
- (void)getImageView{
    
    // 先清空view里面的所有控件
    for (id view in self.m_photoView.subviews) {
        [view removeFromSuperview];
    }
    
    int BtnW = 65;
    int BtnWS = 7;
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
        
        imageview.image = [self.m_imageArray objectAtIndex:i];
//        [imageview setImageWithURL: [NSURL URLWithString: [m_imageArray objectAtIndex:i]] placeholderImage: [UIImage imageNamed:@"TopViewRight.png"]];
        // 添加图片手势
        [imageview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BtnClick:)]];
        
//        UILongPressGestureRecognizer *longPress =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handlegesture:)];//初始化一个手势，关联动作函数；
//        longPress.minimumPressDuration = 0.6; //定义按的时间
//        
//        [imageview addGestureRecognizer:longPress];
    
        // 删除图片的按钮
        UIButton *btn_delete = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_delete setFrame:CGRectMake(0, 0, 25, 25)];
        btn_delete.backgroundColor = [UIColor clearColor];
        [btn_delete setImage:[UIImage imageNamed:@"red_wrong.png"] forState:UIControlStateNormal];
        [btn_delete setCenter:CGPointMake(55, 10)];
        [btn_delete addTarget:self action:@selector(deletePicHandler:) forControlEvents:UIControlEventTouchUpInside];
        [btn_delete setTag:i];
        [imageview addSubview:btn_delete];
        
        [self.m_photoView addSubview:imageview];
        
    }
    
    int getEndImageYH = (BtnH + BtnHS) * (i/4) + BtnY;
   
    // 设置添加图片的按钮
    UIButton * AddBtn  = [[UIButton alloc]initWithFrame:CGRectMake(15, 15, 80, 80)];
    AddBtn.frame = CGRectMake((BtnW+BtnWS) * (i%4) + BtnX, (BtnH+BtnHS) *(i/4) + BtnY, BtnW, BtnH);
    [AddBtn setBackgroundImage:[UIImage imageNamed:@"addicon.png"] forState:UIControlStateNormal];
    [AddBtn addTarget:self action:@selector(photoChooseClicked:) forControlEvents:UIControlEventTouchUpInside];
  
    // 显示数量的label
    UILabel *Numlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    Numlabel.center = CGPointMake(32, 10);
    Numlabel.textColor = [UIColor lightGrayColor];
    Numlabel.textAlignment = UITextAlignmentRight;
    [Numlabel setFont:[UIFont systemFontOfSize:14.0f]];
    
    [AddBtn addSubview:Numlabel];
    [self.m_photoView addSubview:AddBtn];
    
    Numlabel.text = [NSString stringWithFormat:@"%d/9",self.m_imageArray.count];
    
    if ( self.m_imageArray.count > 0 && self.m_imageArray.count < 4) {
    
        Numlabel.hidden = NO;
        AddBtn.hidden = NO;
        
        self.m_photoView.frame = CGRectMake(self.m_photoView.frame.origin.x, self.m_photoView.frame.origin.y, self.m_photoView.frame.size.width, 85);
        
    }else if ( self.m_imageArray.count >= 4 && self.m_imageArray.count < 8 ){
        
        Numlabel.hidden = NO;
        AddBtn.hidden = NO;
        
        self.m_photoView.frame = CGRectMake(self.m_photoView.frame.origin.x, self.m_photoView.frame.origin.y, self.m_photoView.frame.size.width, 160);
        
    } else if ( self.m_imageArray.count >= 8 && self.m_imageArray.count <= 9 ){
        
        if ( self.m_imageArray.count == 8 ) {
            
            Numlabel.hidden = NO;
            AddBtn.hidden = NO;
            
        }else{
            
            Numlabel.hidden = YES;
            AddBtn.hidden = YES;
        }
        
        self.m_photoView.frame = CGRectMake(self.m_photoView.frame.origin.x, self.m_photoView.frame.origin.y, self.m_photoView.frame.size.width, getEndImageYH + 75);

    }
    
    // 设置scrollerView的滚动范围
    self.m_scrollerView.contentSize = CGSizeMake(self.m_scrollerView.frame.size.width , 800);

    
}

- (void)BtnClick:(UITapGestureRecognizer *)imageTap
{
    NSLog(@"imageTag==%d", imageTap.view.tag);
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [self.m_imageArray count]];
   
    for (int i = 0; i < [self.m_imageArray count]; i++) {
        // 替换为中等尺寸图片
//        NSString * getImageStrUrl = [NSString stringWithFormat:@"%@", [self.m_imageArray objectAtIndex:i]];
        MJPhoto *photo = [[MJPhoto alloc] init];
//        photo.url = [NSURL URLWithString: getImageStrUrl]; // 图片路径
        
        photo.image = [self.m_imageArray objectAtIndex:i];
        
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

- (IBAction)addressChooseClicked:(id)sender {
    
    [self.view endEditing:YES];
  
    // 选择地理位置
    BBMapViewController *VC = [[BBMapViewController alloc]initWithNibName:@"BBMapViewController" bundle:nil];
    VC.Chosemapdelegate = self;
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - BBMapDelegate
- (void)ChosesMapValue:(NSString *)address mapx:(NSString *)mapx mapy:(NSString *)mapy level:(NSString *)level
{
//    MapX = longitude 经度
//    MapY = latitude 纬度
    
    NSLog(@"mapx = %@,mapy = %@",mapx,mapy);
    NSLog(@"address = %@",address);
    
    
    self.m_addressLabel.text = [NSString stringWithFormat:@"%@",address];
    
    self.m_addressLabel.textColor = [UIColor blackColor];
    
}
// 选择截止日期时间
- (IBAction)timeChooseClicked:(id)sender {
    
    [self.view endEditing:YES];

    // 显示pickerView进行选择日期
    [self.m_datePicker setHidden:NO];
    
    [self.m_toolbar setHidden:NO];
}

// 选择图片
- (IBAction)photoChooseClicked:(id)sender {
    [self.view endEditing:YES];

    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择图片"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"马上拍照",@"相册选择", nil];
    
    sheet.tag = 100;
    [sheet showInView:[UIApplication sharedApplication].keyWindow];

}

//在键盘上加一个完成按钮，取消键盘
- (void)createKeyboard
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 44)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    self.m_textToolBar = toolbar;
    
    UIBarButtonItem *lastButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(removeKeyborad:)];
    
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:nil
                                                                                    action:nil];
    
    NSArray *array = [NSArray arrayWithObjects: spaceButtonItem,lastButtonItem, nil];
    
    [self.m_textToolBar setItems:array];
    
    self.m_topicField.inputAccessoryView = self.m_textToolBar;
    
    self.m_detailTextView.inputAccessoryView = self.m_textToolBar;
    
    
}

//关闭键盘
- (void)removeKeyborad:(id)sender
{
	[self.view endEditing:YES];
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
        
        self.m_timeField.text = [NSString stringWithFormat:@"%@",self.m_dataString];
        
    }else{
        
        // 如果未选择pickerView，则直接赋值为显示的日期
        if ( [self.m_temporaryDate isEqualToString:@"报名截止时间"] ) {
            
            NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSString *str = [formatter stringFromDate:m_datePicker.date];
            
            self.m_timeField.text = [NSString stringWithFormat:@"%@",str];
            
        }else{
            
            self.m_timeField.text = [NSString stringWithFormat:@"%@",self.m_temporaryDate];

        }
        
    }
    
    self.m_temporaryDate = [NSString stringWithFormat:@"%@",self.m_timeField.text];
    
}

- (void)doPCAPickerCancel:(id)sender{
    
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
    // 如果没值的话则显示placeholder的值，否则显示text的值
    if ( [self.m_temporaryDate isEqualToString:@"报名截止时间"] ) {
        
        self.m_timeField.text = @"";
        
        self.m_timeField.placeholder = [NSString stringWithFormat:@"%@",self.m_temporaryDate];
        
    }else{
        
        self.m_timeField.text = [NSString stringWithFormat:@"%@",self.m_temporaryDate];
        
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

#pragma mark - UITextField
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self hiddenNumPadDone:nil];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - UITextVIewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    [self hiddenNumPadDone:nil];
    
    self.m_detailLabel.hidden = YES;

    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if ( self.m_detailTextView.text.length == 0 ) {
        
        self.m_detailLabel.hidden = NO;
        
    }else{
        
        self.m_detailLabel.hidden = YES;
    }
    
}

#pragma mark - UIActionSheetDelegate
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 100)
    {
        //打开照相
        if (buttonIndex == 0)
        {
            self.isChoosePhoto = YES;
            
            pickerorphoto = 1;
          
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                
                [self presentViewController:imagePicker animated:YES completion:^{}];
            }
            else{
                
                self.isChoosePhoto = NO;
                
                //如果没有提示用户
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"本设备暂不支持拍照功能"
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }else if (buttonIndex == 1) {
           
            //打开相册

            self.isChoosePhoto = YES;
            
            pickerorphoto = 0;
            
            MHImagePickerMutilSelector* imagePickerMutilSelector = [MHImagePickerMutilSelector standardSelector];//自动释放
            imagePickerMutilSelector.Allnum = [NSString stringWithFormat:@"%d",self.m_imageArray.count];
            
            imagePickerMutilSelector.delegate=self;//设置代理
            
            UIImagePickerController* picker = [[UIImagePickerController alloc] init];
            picker.delegate = imagePickerMutilSelector;//将UIImagePicker的代理指向到imagePickerMutilSelector
            [picker setAllowsEditing:NO];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            picker.navigationController.delegate=imagePickerMutilSelector;//将UIImagePicker的导航代理指向到imagePickerMutilSelector
            imagePickerMutilSelector.imagePicker = picker;//使imagePickerMutilSelector得知其控制的UIImagePicker实例，为释放时需要。
            [self presentModalViewController:picker animated:YES];
            
        }
    }
}

- (void)deletePicHandler:(UIButton*)btn
{
    [self.view endEditing:YES];
    
    for(UIButton * tmpView in self.m_photoView.subviews)
    {
        [tmpView removeFromSuperview];
        
    }
    
    [self.m_imageArray removeObjectAtIndex:btn.tag];

    
    [self getImageView];
    
}


#pragma mark - Assets Picker Delegate
- (void)imagePickerMutilSelectorDidGetImages:(NSArray *)imageArray
{
    CGRect rx = [ UIScreen mainScreen ].bounds;
    
    
    NSLog(@"imageArray = %i",imageArray.count);
    
    if ( imageArray.count == 0 ) {
        
        return;
    }
    
    NSLog(@"self.m_imageArray = %i",self.m_imageArray.count);
    
    NSArray *importItems = [[NSArray alloc] initWithArray:imageArray copyItems:YES];
    
    for (int i = 0; i < importItems.count; i++) {
        
        UIImage * image = [importItems objectAtIndex:i];
        
        if (image.size.width > rx.size.width||image.size.height>rx.size.height) {
            
            UIImage * image2 = [CommonUtil scaleImage:image toSize:CGSizeMake(WindowSize.size.width, WindowSize.size.width*image.size.height/image.size.width)];
            
            [self.m_imageArray addObject:image2];
            
        }else{
            
            [self.m_imageArray addObject:image];
            
        }
        
    }
    
    
    [self getImageView];
    
    
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
//拍照
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image=[[UIImage alloc]init];
    
    if (pickerorphoto == 0)
    {
        //        image = [info objectForKey:UIImagePickerControllerEditedImage];
        
    }else if (pickerorphoto == 1){
        
        // 表示拍照的图片
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        UIImage * imagenew = [CommonUtil scaleImage:image toSize:CGSizeMake(WindowSize.size.width, WindowSize.size.width*image.size.height/image.size.width)];
        
        NSData *imageData = UIImageJPEGRepresentation(imagenew,0.4f);
        
        
        [self.m_imageArray addObject:[UIImage imageWithData:imageData]];
        
        [self getImageView];
        
        
        
    }
    
    
}

- (NSData *)getImageData:(UIImageView *)imageView {
   
    UIImage *iamge = imageView.image;
    return UIImageJPEGRepresentation(iamge, 1);

}

//循环加到字典中
- (void)ImageFromArrayToDic
{
    
    for (int i = 0; i < self.m_imageArray.count; i++) {
        
        UIImageView *imgV = [[UIImageView alloc]init];
        
        imgV.image = [self.m_imageArray objectAtIndex:i];
        
        [self.ImageDic setValue:[self getImageData:imgV] forKey:[NSString stringWithFormat:@"picUrl%d",i]];
        
    }
    
}


@end
