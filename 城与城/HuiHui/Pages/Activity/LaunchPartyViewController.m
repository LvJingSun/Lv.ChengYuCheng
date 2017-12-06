//
//  LaunchPartyViewController.m
//  baozhifu
//
//  Created by mac on 14-3-4.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "LaunchPartyViewController.h"

#import "NextPartyViewController.h"

#import "SVProgressHUD.h"

#import "CommonUtil.h"

#import "AppHttpClient.h"

@interface LaunchPartyViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;
// 聚会分类
@property (weak, nonatomic) IBOutlet UITextField *m_onetextField;
// 聚会名称
@property (weak, nonatomic) IBOutlet UITextField *m_partynameTextField;
// 价格
@property (weak, nonatomic) IBOutlet UITextField *m_priceTextField;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UITextView *m_arrangementsTextView;

@property (weak, nonatomic) IBOutlet UITextView *m_SpecialNoteTextVIew;

@property (weak, nonatomic) IBOutlet UILabel *m_anpaiLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_noteLabel;


// 类别选择按钮触发的事件
- (IBAction)btnClicked:(id)sender;

// 下一步按钮触发的事件
- (IBAction)mextStep:(id)sender;

@end

@implementation LaunchPartyViewController

@synthesize m_oneArray;

@synthesize m_twoArray;

@synthesize m_pickerToolBar;

@synthesize m_pickerView;

@synthesize isSelected;

@synthesize m_items;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_oneArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_twoArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        dbhelp = [[DBHelper alloc] init];
        
        isSelected = NO;
        
        m_items = [[NSMutableDictionary alloc]initWithCapacity:0];

    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self setTitle:@"发起聚会"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 初始化pickerView
    [self initpickerView];
    
    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
    
    // 设置默认的数组
    if ( [dbhelp queryCategory].count != 0 ) {
        
        self.m_oneArray = [dbhelp queryCategory];
        
        NSDictionary *dic = [self.m_oneArray objectAtIndex:0];
        
        self.m_twoArray = [dbhelp queryProject:[dic objectForKey:@"code"]];
        
        NSLog(@"m_oneArray = %@",self.m_oneArray);

        
        NSLog(@"self.m_twoArray = %@",self.m_twoArray);
        
        self.m_categoryString1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        
        
        if ( self.m_twoArray.count != 0 ) {
            
            NSDictionary *dic1 = [self.m_twoArray objectAtIndex:0];
            
            self.m_projectString1 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"name"]];
            
            self.m_classId1 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"code"]];

        }
        
        
       
    }

    self.m_categoryString = @"";
    
    self.m_classId = @"";
    
    self.m_classId2 = @"";
    
    [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 700)];
    
    
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        // 来自于新增的页面
        
        
    }else{
        
        // 来自于编辑的页面
        [self editDataRequestSubmit];

    }
    
    // 键盘
    [self createKeyboard];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear: animated];
    
    [self hideTabBar:YES];

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];

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

- (void)editDataRequestSubmit
{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    
    // operation 1：新增；2：修改 actId聚会ID（默认为0）
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,     @"memberId",
                                  key,   @"key",
                                  [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"ActivityID"]],@"activityId",
                                  nil];
    
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ActivityDetail.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            NSMutableDictionary *dic = [json valueForKey:@"Activity"];
            
            self.m_items = dic;
            
            self.m_onetextField.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"ActCatgNames"]];
            self.m_partynameTextField.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"ActivityName"]];

            self.m_priceTextField.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Fee"]];
            self.m_arrangementsTextView.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Content"]];
            self.m_SpecialNoteTextVIew.text = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"Explain"]];
            
            self.m_classId = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"SecondClassID"]];
            
            // 判断label是否隐藏
            if ( self.m_arrangementsTextView.text.length != 0 ) {
                
                self.m_anpaiLabel.hidden = YES;

            }else{
                
                self.m_anpaiLabel.hidden = NO;

            }
            if ( self.m_SpecialNoteTextVIew.text.length != 0 ) {
                
                self.m_noteLabel.hidden = YES;

            }else{
                
                self.m_noteLabel.hidden = NO;

            }
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        
    }];
    
    
}

- (IBAction)btnClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    self.m_pickerToolBar.hidden = NO;
    
    self.m_pickerView.hidden = NO;
    
    // 刷新pickerView
    [self.m_pickerView reloadAllComponents];
}

- (IBAction)mextStep:(id)sender {
    

    if ( self.m_onetextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择聚会分类"];
        
        return;
    }
    
    if ( self.m_partynameTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入聚会主题"];
        
        return;
    }
    
    if ( self.m_priceTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入预算费用"];
        
        return;
    }
    
    if ( self.m_arrangementsTextView.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入聚会安排"];
        
        return;
    }
    
    if ( self.m_SpecialNoteTextVIew.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入特别提示"];
        
        return;
    }
    
    // 存储数据
    [self.m_items setObject:self.m_classId forKey:@"classIDTxt"];
    [self.m_items setObject:self.m_partynameTextField.text forKey:@"activityName"];
    [self.m_items setObject:self.m_priceTextField.text forKey:@"fee"];
    [self.m_items setObject:self.m_arrangementsTextView.text forKey:@"content"];
    [self.m_items setObject:self.m_SpecialNoteTextVIew.text forKey:@"explain"];
    [self.m_items setObject:self.m_typeString forKey:@"typeString"];
        
    // 进入下一步的页面
    NextPartyViewController *VC = [[NextPartyViewController alloc]initWithNibName:@"NextPartyViewController" bundle:Nil];
    VC.m_typeString = @"1";
    VC.m_dic = self.m_items;
    [self.navigationController pushViewController:VC animated:YES];
    
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
    
    self.m_SpecialNoteTextVIew.inputAccessoryView = self.m_textToolBar;
    
    self.m_arrangementsTextView.inputAccessoryView = self.m_textToolBar;
    
}

//关闭键盘
- (void)removeKeyborad:(id)sender
{
	[self.view endEditing:YES];
}

#pragma mark -初始化显示地区的pickerView
- (void)initpickerView{
    UIWindow *window = self.navigationController.view.window;
	
	//  datePickerView初始化
	m_pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 216, WindowSizeWidth, 216)];
    m_pickerView.backgroundColor = [UIColor whiteColor];
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
    pickerBar.frame = CGRectMake(0, self.m_pickerView.frame.origin.y - 44, WindowSizeWidth, 44);
    [window addSubview:pickerBar];
    pickerBar.backgroundColor = [UIColor clearColor];
    self.m_pickerToolBar = pickerBar;
    
}

#pragma mark - PickerBar按钮
- (void)doPickerDone:(id)sender{
    
    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
    
    self.m_onetextField.text = [NSString stringWithFormat:@"%@-%@",self.m_categoryString1,self.m_projectString1];
    
    self.isSelected = NO;
    
    // 赋值
    self.m_categoryString = [NSString stringWithFormat:@"%@",self.m_onetextField.text];
    
    self.m_classId = [NSString stringWithFormat:@"%@",self.m_classId1];

    self.m_classId2 = [NSString stringWithFormat:@"%@",self.m_classId1];
    
}

- (void)doPickerCancel:(id)sender{
    
    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
   
    // 赋值
    self.m_onetextField.text = [NSString stringWithFormat:@"%@",self.m_categoryString];
    
    self.m_classId = [NSString stringWithFormat:@"%@",self.m_classId2];
    

}

#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if ( component == 0 ) {
    
        return self.m_oneArray.count;
        
    }else{
        
        return self.m_twoArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *titleResult = @"";
    
    if ( component == 0 ) {
        
        if ( self.m_oneArray.count > 0 ) {
            
            NSDictionary *dic = [self.m_oneArray objectAtIndex:row];
            
            titleResult = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
            
        }
        
    }else if ( component == 1 ){
        
        NSDictionary *dic = [self.m_twoArray objectAtIndex:row];
        
        titleResult = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        
    }else{
        
         titleResult = @"";
        
    }
    
    return titleResult;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.isSelected = YES;
    
    if ( component == 0 ) {
        
        NSDictionary *dic = [self.m_oneArray objectAtIndex:row];
        
        self.m_twoArray = [dbhelp queryProject:[dic objectForKey:@"code"]];
        
        self.m_categoryString1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        
        NSDictionary *dic1 = [self.m_twoArray objectAtIndex:0];
        
        self.m_projectString1 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"name"]];
        
        self.m_classId1 = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"code"]];
        
        // 刷新选择器
        [self.m_pickerView selectRow:0 inComponent:1 animated:YES];
        
    }else if ( component == 1 ){
        
        NSDictionary *dic = [self.m_twoArray objectAtIndex:row];
        
        self.m_projectString1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        
        self.m_classId1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];

    }
    
    for (int i=0; i<[pickerView numberOfComponents]; i++) {
        
        [self.m_pickerView reloadComponent:i];
        
    }
        
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
   
    if ( textField == self.m_partynameTextField || textField == self.m_priceTextField ) {
        
        [self hiddenNumPadDone:nil];
    }
    
    if ( !self.m_pickerView.hidden ) {
        
        self.m_pickerView.hidden = YES;
        
        self.m_pickerToolBar.hidden = YES;
    }
//    if ( textField == self.m_SpecialNoteTextField ) {
//        
//        NSTimeInterval animationDuration=0.30f;
//        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//        [UIView setAnimationDuration:animationDuration];
//        float width = self.view.frame.size.width;
//        float height = self.view.frame.size.height;
//        CGRect rect=CGRectMake(0.0f,-110,width,height);
//        self.view.frame=rect;
//        [UIView commitAnimations];
//        
//    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
//    if ( textField == self.m_SpecialNoteTextField ) {
//        
//        [self resumeView];
//    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if (textView == self.m_SpecialNoteTextVIew || textView == self.m_arrangementsTextView ) {
        
        [self hiddenNumPadDone:nil];
    }
    
    if ( !self.m_pickerView.hidden ) {
        
        self.m_pickerView.hidden = YES;
        
        self.m_pickerToolBar.hidden = YES;
    }
    
    if ( textView == self.m_arrangementsTextView ) {
        
        [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 800)];

        self.m_anpaiLabel.hidden = YES;
        
    }else{
        
        [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 800)];

        self.m_noteLabel.hidden = YES;
        
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    [textView resignFirstResponder];
    
    [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth, 700)];

    
    if ( textView == self.m_arrangementsTextView ) {
        
        if ( self.m_arrangementsTextView.text.length == 0 ) {
            
            self.m_anpaiLabel.hidden = NO;
            

        }else{
            
            
            
        }
    }else{
        
        if ( self.m_SpecialNoteTextVIew.text.length == 0 ) {
            
            self.m_noteLabel.hidden = NO;
            
        }else{
            
            
        }
    }
    
    
}

//恢复原始视图位置
-(void)resumeView {
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    float Y = 0.0f;
    CGRect rect=CGRectMake(0.0f,Y,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
}


@end
