//
//  Fl_ContactViewController.m
//  HuiHui
//
//  Created by mac on 14-12-29.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "Fl_ContactViewController.h"



@interface Fl_ContactViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_tipView;

@property (weak, nonatomic) IBOutlet UILabel *m_tipLabel1;

@property (weak, nonatomic) IBOutlet UILabel *m_tipLabel2;

@property (weak, nonatomic) IBOutlet UITextField *m_nameField;

@property (weak, nonatomic) IBOutlet UITextField *m_IdCardField;

@property (weak, nonatomic) IBOutlet UITextField *m_typeField;

@property (weak, nonatomic) IBOutlet UIView *m_otherView;

@property (weak, nonatomic) IBOutlet UITextField *m_sexField;

@property (weak, nonatomic) IBOutlet UITextField *m_birthField;

@property (weak, nonatomic) IBOutlet UIButton *m_finishBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UIImageView *m_imgV1;
@property (weak, nonatomic) IBOutlet UIImageView *m_imgV2;
@property (weak, nonatomic) IBOutlet UIImageView *m_imgV3;
@property (weak, nonatomic) IBOutlet UIImageView *m_imgV4;
@property (weak, nonatomic) IBOutlet UIImageView *m_imgV5;

// 证件类型按钮点击事件
- (IBAction)idCardClicked:(id)sender;
// 性别选择
- (IBAction)sexChooseClicked:(id)sender;
// 出生日期选择
- (IBAction)birthChooseClicked:(id)sender;
// 完成按钮触发的事件
- (IBAction)finishClicked:(id)sender;


@end

@implementation Fl_ContactViewController

@synthesize m_dic;

@synthesize m_type;

@synthesize m_datePicker;

@synthesize m_toolbar;

@synthesize isSelected;

@synthesize m_birthString;

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        
        isSelected = NO;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 根据类型来判断是添加乘机人还是编辑乘机人的状态来设置导航栏的标题
    if ( [self.m_stringType isEqualToString:@"1"] ) {
        
        [self setTitle:@"新增乘机人"];
        
        // 默认值为身份证
        self.m_type = IdCardType;
        self.m_typeField.text = @"身份证";
        
        // 身份证选择的时候性别选择所在的view隐藏起来
        self.m_otherView.hidden = YES;

        // 设置完成按钮
        [self.m_finishBtn setFrame:CGRectMake(15, 340, 290, 42)];
        
    }else{
       
        [self setTitle:@"编辑乘机人"];
        
        NSString *type = [self.m_dic objectForKey:@"cardType"];
        
        if ( [type isEqualToString:@"NI"] ) {
            
            self.m_typeField.text = @"身份证";
            self.m_type = IdCardType;
            
            // 身份证选择的时候性别选择所在的view隐藏起来
            self.m_otherView.hidden = YES;
            
            // 赋值
            self.m_nameField.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"name"]];
            self.m_IdCardField.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"cardNum"]];
           
            NSString *sexString = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"gender"]];
            // 判断性别
            if ( [sexString isEqualToString:@"true"] ) {
                
                self.m_sexField.text = @"男";
                
            }else{
                
                self.m_sexField.text = @"女";
            }
            
            // 设置完成按钮
            [self.m_finishBtn setFrame:CGRectMake(15, 340, 290, 42)];
         
        }else{
            
            // 身份证选择的时候性别选择所在的view隐藏起来
            self.m_otherView.hidden = NO;
            
            if ( [type isEqualToString:@"护照"] ) {
                
                self.m_typeField.text = @"护照";
                self.m_type = PassPortType;

            }else{
                
                self.m_typeField.text = @"其他";
                self.m_type = OtherType;

            }
            
            // 赋值
            self.m_nameField.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"name"]];
            self.m_IdCardField.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"cardNum"]];
            
            NSString *sexString = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"gender"]];
            // 判断性别
            if ( [sexString isEqualToString:@"true"] ) {
                
                self.m_sexField.text = @"男";
                
            }else{
                
                self.m_sexField.text = @"女";
            }
            
            
            self.m_birthField.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"birthday"]];
            
            
            // 设置完成按钮
            [self.m_finishBtn setFrame:CGRectMake(15, 407, 290, 42)];
            
        }
        
        
    }
    
    // 设置导航栏的左按钮返回的操作
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    
    // 设置提示语
    self.m_tipLabel1.text = @"请您严格按照办理登机手续时所持有效证件上的姓名进行填写;\n若使用身份证购买机票，请确保预定和乘机均为二代身份证。";
    
    self.m_tipLabel2.text = @"若姓名填写含英文或拼音，我们将自动转成大写";
    
    // 设置view的背景颜色及圆角
    self.m_tipView.layer.cornerRadius = 5.0f;
    // 设置线的坐标大小
    self.m_imgV1.frame = CGRectMake(15, 152, 290, 0.4);
    self.m_imgV2.frame = CGRectMake(15, 208, 290, 0.4);
    self.m_imgV3.frame = CGRectMake(15, 264, 290, 0.4);
    self.m_imgV4.frame = CGRectMake(15, 321, 290, 0.4);
    self.m_imgV5.frame = CGRectMake(15, 48, 290, 0.4);
    
    
    // 初始化pickerView-出生日期的选择
    [self initWithPickerView];
    
    [self.m_datePicker setHidden:YES];
    
    [self.m_toolbar setHidden:YES];

    // 默认设置为空-用于存储选择的出生日期
    self.m_birthString = @"";
    
    
    if ( isIOS7 ) {
        
        [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 700)];
        
    }else{
        
        [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 500)];

    }
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
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

#pragma mark - BtnClick
- (IBAction)idCardClicked:(id)sender {
    
    /*
    
    [self.view endEditing:YES];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择证件类型"
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"身份证",@"护照",@"其他", nil];
    actionSheet.tag = 1090;
    [actionSheet showInView:self.view];
     
     */
    
}

- (IBAction)sexChooseClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择性别"
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"男",@"女", nil];
    
    actionSheet.tag = 1091;
    [actionSheet showInView:self.view];
}

- (IBAction)birthChooseClicked:(id)sender {

    [self.view endEditing:YES];
    
    self.m_datePicker.hidden = NO;
    self.m_toolbar.hidden = NO;
}

- (IBAction)finishClicked:(id)sender {
    
    [self.view endEditing:YES];
    

        
    if ( self.m_type == IdCardType ) {
        // 身份证的类型下要进行的判断
        if ( self.m_nameField.text.length == 0 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请输入乘机人姓名"];
            
            return;
        }
        
        if ( self.m_IdCardField.text.length == 0 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请输入证件号码"];
            
            return;
        }
        
        if ( self.m_sexField.text.length == 0 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请选择性别"];
            
            return;
        }
        
        // 设置性别的字段 true 表示男 false 表示女
        NSString *sexString;
        if ( [self.m_sexField.text isEqualToString:@"男"] ) {
            
            sexString = @"true";
            
        }else{
            
            sexString = @"false";
            
        }
        
        
        // 完成响应的事件
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.m_nameField.text,@"name",@"NI",@"cardType",self.m_IdCardField.text,@"cardNum",@"0",@"ageType",@"",@"birthday",sexString,@"gender", nil];
        
        if ( [self.m_stringType isEqualToString:@"1"] ) {
            // 新增乘机人的情况
            if ( self.delegate && [self.delegate respondsToSelector:@selector(flightsTride:)] ) {
                
                [self.delegate performSelector:@selector(flightsTride:) withObject:dic];
                
            }
        }else{
         
            // 编辑乘机人的情况
            if ( self.delegate && [self.delegate respondsToSelector:@selector(EditTride:)] ) {
                
                [self.delegate performSelector:@selector(EditTride:) withObject:dic];
                
            }
            
        }
        
        // 返回上一级
        [self goBack];
        
        
    }else{
        
        // 护照或者其他类型下的判断
        if ( self.m_nameField.text.length == 0 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请输入乘机人姓名"];
            
            return;
        }
        
        if ( self.m_IdCardField.text.length == 0 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请输入证件号码"];
            
            return;
        }
        
        if ( self.m_sexField.text.length == 0 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请选择性别"];
            
            return;
        }
        
        
        if ( self.m_birthField.text.length == 0 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请选择出生日期"];
            
            return;
        }
        
        
        // 设置性别的字段 true 表示男 false 表示女
        NSString *sexString;
        if ( [self.m_sexField.text isEqualToString:@"男"] ) {
            
            sexString = @"true";
            
        }else{
            
            sexString = @"false";
            
        }
        
        // 完成响应的事件
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.m_nameField.text,@"name",self.m_typeField.text,@"cardType",self.m_IdCardField.text,@"cardNum",@"0",@"ageType",self.m_birthField.text,@"birthday",sexString,@"gender", nil];
                
        if ( [self.m_stringType isEqualToString:@"1"] ) {
            // 新增乘机人的情况
            if ( self.delegate && [self.delegate respondsToSelector:@selector(flightsTride:)] ) {
                
                [self.delegate performSelector:@selector(flightsTride:) withObject:dic];
                
            }
        }else{
            
            // 编辑乘机人的情况
            if ( self.delegate && [self.delegate respondsToSelector:@selector(EditTride:)] ) {
                
                [self.delegate performSelector:@selector(EditTride:) withObject:dic];
                
            }
            
        }

        
        [SVProgressHUD showWithStatus:@"保存数据中"];
        
        // 返回上一级
        [NSTimer scheduledTimerWithTimeInterval:1.0
                                         target:self
                                       selector:@selector(LastView)
                                       userInfo:nil
                                        repeats:NO];
        
        
    }
    
    
    
   
}

- (void)LastView{
    
    [SVProgressHUD dismiss];
    [self goBack];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( actionSheet.tag == 1090 ) {
        
        if ( buttonIndex == 0 ) {
        
            self.m_typeField.text = @"身份证";
            
            self.m_type = IdCardType;
            
            self.m_otherView.hidden = YES;
            
            // 设置完成按钮
            [self.m_finishBtn setFrame:CGRectMake(15, 340, 290, 42)];
            
        }else if ( buttonIndex == 1 ){
            
            self.m_typeField.text = @"护照";
            
            self.m_type = PassPortType;
            
            self.m_otherView.hidden = NO;

            // 设置完成按钮
            [self.m_finishBtn setFrame:CGRectMake(15, 407, 290, 42)];
            
        }else if ( buttonIndex == 2 ){
            
            self.m_typeField.text = @"其他";
            
            self.m_type = OtherType;
            
            self.m_otherView.hidden = NO;
            // 设置完成按钮
            [self.m_finishBtn setFrame:CGRectMake(15, 407, 290, 42)];
            
        }else{
            
            
        }
        
    }else if ( actionSheet.tag == 1091 ) {
        
        NSLog(@"buttonIndex  1091 = %i",buttonIndex);

        if ( buttonIndex == 0 ) {
            
            self.m_sexField.text = @"男";
       
        }else if ( buttonIndex == 1 ){
           
            self.m_sexField.text = @"女";
            
        }else{
            
            
        }
    }else{
        
        
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
     [self hiddenNumPadDone:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ( textField == self.m_nameField ) {
        
        self.m_nameField.text = [NSString stringWithFormat:@"%@",self.m_nameField.text.uppercaseString];
        
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
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
    
    NSLog(@"isSelected  = %i",self.isSelected);
    
    // 判断是否滚动了pickerView
    if ( !self.isSelected ) {
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYY-MM-dd"];
        
        self.m_birthString = [formatter stringFromDate:m_datePicker.date];
        
    }
    
    self.isSelected = NO;
    
    self.m_birthField.text = [NSString stringWithFormat:@"%@",self.m_birthString];
    
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
    [formatter setDateFormat:@"YYY-MM-dd"];
    
    NSString *str = [formatter stringFromDate:m_datePicker.date];
    
    self.m_birthString = [NSString stringWithFormat:@"%@",str];
    
}


@end
