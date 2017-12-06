//
//  SponsorViewController.m
//  HuiHuiApp
//
//  Created by mac on 13-10-16.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "SponsorViewController.h"


@interface SponsorViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UIView *m_objectView;

@property (weak, nonatomic) IBOutlet UILabel *m_typeLabel;

// 重置按钮触发的事件
- (IBAction)ResetClicked:(id)sender;
// 赞助按钮触发的事件
- (IBAction)sponsorClicked:(id)sender;
// 增加
- (IBAction)plusClicked:(id)sender;
// 减少
- (IBAction)menuClicked:(id)sender;
// 选择地区
- (IBAction)choseArea:(id)sender;
// 选择性别
- (IBAction)chooseSex:(id)sender;
// 选择时间
- (IBAction)chooseTime:(id)sender;
// 选择类型
- (IBAction)chooseType:(id)sender;

// 初始化pickerView
- (void)initWithPickerView;


@end

@implementation SponsorViewController

@synthesize m_datePicker;

@synthesize m_toolbar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.isSelected = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 默认设置为0
    self.m_Credit = 0;
    
    self.m_count = 0;
    
    self.m_sponsorCredit.text = [NSString stringWithFormat:@"%i",self.m_Credit];
    
    self.m_sponsorCount.text = [NSString stringWithFormat:@"%i",self.m_count];

    
    [self setTitle:@"赞助"];
    
    [self setLeftButtonWithNormalImage:@"back.png" action:@selector(leftClicked)];
    
    
    // 设置view的圆角
    self.m_tempView.layer.cornerRadius = 10.0f;
    self.m_tempView.layer.borderWidth = 1.0f;
    
    self.m_tempView.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;
    
    self.m_objectView.layer.cornerRadius = 10.0f;
    self.m_objectView.layer.borderWidth = 1.0f;
    
    self.m_objectView.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor;
    
    // 初始化pickerView    
    [self initWithPickerView];
    
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
    // 设置scrollerView的滚动范围
    [self.m_scrollerView setContentSize:CGSizeMake(320, 520)];
   
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    // 隐藏pickerView和toolBar
    [m_datePicker setHidden:YES];
    
	[m_toolbar setHidden:YES];
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
	m_datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 210, 320, 200)];
    [m_datePicker setDatePickerMode:UIDatePickerModeDate];
	[m_datePicker addTarget:self action:@selector(togglePicker:) forControlEvents:UIControlEventValueChanged];
    m_datePicker.backgroundColor = [UIColor whiteColor];
    
	[window addSubview:m_datePicker];
    
    
//    UIView *view = [[UIView alloc]initWithFrame: CGRectMake(0, m_datePicker.frame.origin.y - 44, 320, 44)];
//    view.backgroundColor = [UIColor blackColor];
//    view.alpha = 0.6;
//    
//    // view上面的取消、确定按钮
//    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    cancelBtn.backgroundColor = [UIColor blackColor];
//    
//    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//    
//    [cancelBtn setFrame:CGRectMake(20, 7, 60, 30)];
//    
//    [cancelBtn addTarget:self action:@selector(doPCAPickerCancel:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [view addSubview:cancelBtn];
//    
//    
//    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    sureBtn.backgroundColor = [UIColor blackColor];
//
//    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
//    
//    [sureBtn setFrame:CGRectMake(240, 7, 60, 30)];
//    
//    [sureBtn addTarget:self action:@selector(doPCAPickerDone:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [view addSubview:sureBtn];
//    
//    self.m_toolbar = view;
//    
//    [window addSubview:self.m_toolbar];
    
	//添加 PickerView上面的左右按钮
    UIBarButtonItem *pickItemCancle = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(doPCAPickerCancel:)];
    pickItemCancle.style = UIBarButtonItemStyleBordered;
    
    UIBarButtonItem *pickItemOK = [[UIBarButtonItem alloc]initWithTitle:@"确定"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(doPCAPickerDone:)];
    pickItemOK.style = UIBarButtonItemStyleBordered;
    
    UIBarButtonItem *pickSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItem)UIBarButtonSystemItemFlexibleSpace
                                                                               target:self
                                                                               action:nil];
    // 自定义PickerView顶部的Toolbar，加载左右的取消和确定按钮
    UIToolbar *pickerBar = [[UIToolbar alloc] init];
    pickerBar.barStyle = UIBarStyleBlackTranslucent;
    NSArray *pickArray = [NSArray arrayWithObjects:pickItemCancle, pickSpace, pickItemOK,nil];
    [pickerBar setItems:pickArray animated:YES];
    pickerBar.frame = CGRectMake(0, m_datePicker.frame.origin.y - 44, 320, 44);
    [window addSubview:pickerBar];
    pickerBar.backgroundColor = [UIColor clearColor];
    self.m_toolbar = pickerBar;

}

#pragma mark - PickerBar按钮
- (void)doPCAPickerDone:(id)sender{
    
    // 设置scrollerView的滚动范围
    [self.m_scrollerView setContentSize:CGSizeMake(320, 520)];
    
    // 点击选择时间时设置scrollerView的移动范围
    [self.m_scrollerView setContentOffset:CGPointMake(0, 0)];
    
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
    // 判断是否滚动了pickerView
    if ( !self.isSelected ) {
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYY-MM-dd"];
                
        self.m_timeLabel.text = [formatter stringFromDate:m_datePicker.date];

    }
    
    self.m_sexCopyString = self.m_timeLabel.text;

}

- (void)doPCAPickerCancel:(id)sender{
    
    // 设置scrollerView的滚动范围
    [self.m_scrollerView setContentSize:CGSizeMake(320, 520)];
    
    // 点击选择时间时设置scrollerView的移动范围
    [self.m_scrollerView setContentOffset:CGPointMake(0, 0)];
    
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];
    
    
    if ( self.m_sexCopyString.length == 0 ) {
        
        self.m_timeLabel.text = @"选择时间";
        
    }else{
        
        self.m_timeLabel.text = self.m_sexCopyString;
        
    }
    
}

// pickerView的选择事件
- (void) togglePicker:(id)sender{
    
    self.isSelected = YES;
    
    // 判断不能选择今天日期以后的时间
    if ( [m_datePicker.date compare:[NSDate date]] == NSOrderedDescending ) {
		[m_datePicker setDate:[NSDate date] animated:YES];
	}

    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYY-MM-dd"];
    
    NSString *str = [formatter stringFromDate:m_datePicker.date];
    
    self.m_timeLabel.text = [NSString stringWithFormat:@"%@",str];
    
    self.m_sexString = str;
    

}


#pragma mark - BtnClicked
- (IBAction)ResetClicked:(id)sender {
    
    [self alertWithMessage:@"reset"];
}

- (IBAction)sponsorClicked:(id)sender {
    
    [self alertWithMessage:@"sponsor"];

}

- (IBAction)plusClicked:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 222 ) {
                
        self.m_minuCreditBtn.userInteractionEnabled = YES;

        self.m_Credit = self.m_Credit + 100;
        
        self.m_sponsorCredit.text = [NSString stringWithFormat:@"%i",self.m_Credit];

        
    }else{
                
        self.m_minuCountBtn.userInteractionEnabled = YES;

        self.m_count = self.m_count + 10;
        
        self.m_sponsorCount.text = [NSString stringWithFormat:@"%i",self.m_count];


    }
}

- (IBAction)menuClicked:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 111 ) {
              
        if ( self.m_Credit == 0 ) {
            
            self.m_minuCreditBtn.userInteractionEnabled = NO;
            
        }else{
            
            self.m_Credit = self.m_Credit - 100;

            self.m_minuCreditBtn.userInteractionEnabled = YES;

        }
        
        self.m_sponsorCredit.text = [NSString stringWithFormat:@"%i",self.m_Credit];
        
    }else{
                
         if ( self.m_count == 0 ) {
            
            self.m_minuCountBtn.userInteractionEnabled = NO;
            
        }else{
            
            self.m_count = self.m_count - 10;

            self.m_minuCountBtn.userInteractionEnabled = YES;
            
        }
        
        self.m_sponsorCount.text = [NSString stringWithFormat:@"%i",self.m_count];

    }
}

- (IBAction)choseArea:(id)sender {
    
    [self.view endEditing:YES];
    
    if ( !self.m_datePicker.hidden ) {
        
        self.m_datePicker.hidden = YES;
        self.m_toolbar.hidden = YES;
    }
}

- (IBAction)chooseSex:(id)sender {
    
    [self.view endEditing:YES];
    
    if ( !self.m_datePicker.hidden ) {
        
        self.m_datePicker.hidden = YES;
        self.m_toolbar.hidden = YES;
    }
        
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"男",@"女", nil];
    
    [sheet showInView:self.view];
    
}

- (IBAction)chooseTime:(id)sender {

    // 设置scrollerView的滚动范围
    [self.m_scrollerView setContentSize:CGSizeMake(320, 620)];
    
    // 点击选择时间时设置scrollerView的移动范围
    [self.m_scrollerView setContentOffset:CGPointMake(0, 150)];
    
    [self.view endEditing:YES];
    
    [self.m_toolbar setHidden:NO];
    
    [self.m_datePicker setHidden:NO];
}

- (IBAction)chooseType:(id)sender {
    
//    [self alertWithMessage:@"choose type"];
    
    // 进入选择类型的界面
    SponsorTypeViewController *VC = [[SponsorTypeViewController alloc]initWithNibName:@"SponsorTypeViewController" bundle:nil];
    VC.delegate = self;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - TypeDelegate
- (void)getTypeName:(NSString *)aName{
    
    self.m_typeLabel.text = [NSString stringWithFormat:@"%@",aName];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
        
    NSString *offset = [NSString stringWithFormat:@"%.2f",self.m_scrollerView.contentOffset.y];
    
    if ( ![offset isEqualToString:@"0.00"] ) {
        
        [self.m_scrollerView setContentOffset:CGPointMake(0, 0)];
        
        [self.m_scrollerView setContentSize:CGSizeMake(320, 520)];
    }
    
    if ( buttonIndex == 0 ) {
        
        self.m_sexLabel.text = @"男";
        
    }else if ( buttonIndex == 1 ){
        
        self.m_sexLabel.text = @"女";
   
    }else{
        
        
    }
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ( !self.m_datePicker.hidden ) {
        
        self.m_datePicker.hidden = YES;
        self.m_toolbar.hidden = YES;
    }
    
    if ( textField == self.m_messageLabel ) {
        
        [self hiddenNumPadDone:nil];
    }
    
    // 设置scrollerView的滚动范围
    [self.m_scrollerView setContentSize:CGSizeMake(320, 620)];
    
    // 点击选择时间时设置scrollerView的移动范围
    [self.m_scrollerView setContentOffset:CGPointMake(0, 220)];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    // 设置scrollerView的滚动范围
    [self.m_scrollerView setContentSize:CGSizeMake(320, 520)];
    
    // 点击选择时间时设置scrollerView的移动范围
    [self.m_scrollerView setContentOffset:CGPointMake(0, 0)];
    
    [self.m_messageLabel resignFirstResponder];
    
    return YES;
}

@end
