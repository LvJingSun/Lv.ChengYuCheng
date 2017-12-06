//
//  AddFriendsViewController.m
//  HuiHui
//
//  Created by mac on 13-11-21.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "AddFriendsViewController.h"

#import "SVProgressHUD.h"

@interface AddFriendsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *name;

@property (weak, nonatomic) IBOutlet UITextField *sex;

@property (weak, nonatomic) IBOutlet UITextField *phone;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

// 提交
- (IBAction)submit:(id)sender;
// 选择性别
- (IBAction)selectSex:(id)sender;
// 调用手机通讯录
- (IBAction)selectPhone:(id)sender;
// 规则
- (IBAction)showRole:(id)sender;

@end

@implementation AddFriendsViewController

@synthesize m_dic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_dic = [[NSDictionary alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"添加好友"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self.name setDelegate:self];
    [self.sex setDelegate:self];
    [self.phone setDelegate:self];
    
   
    // 邀请好友
    self.phone.text = @"";
    
    self.sex.text = @"";
    
    self.name.text = @"";
    
    // 设置scrollerView的滚动范围
    [self.m_scrollerView setContentSize:CGSizeMake(320, 480)];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
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


-(IBAction)submit:(id)sender {
    
    
    NSString *name = self.name.text;
    if (name.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
        return;
    }
    
    NSString *sex = self.sex.text;
    if (sex.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择性别"];
        return;
    } else {
        if ([@"男" isEqualToString:sex]) {
            sex = @"Male";
        } else if ([@"女" isEqualToString:sex]) {
            sex = @"Female";
        }
    }
    
    NSString *phone = self.phone.text;
    if (phone.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入电话号码"];
        return;
    } else {
        //phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
  
}

-(IBAction)selectSex:(id)sender {
    [self.name resignFirstResponder];
    [self.phone resignFirstResponder];
    UIActionSheet *chooseImageSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                  delegate:self
                                                         cancelButtonTitle:@"取消"
                                                    destructiveButtonTitle:nil
                                                         otherButtonTitles:@"男",@"女", nil];
    // 解决sheetAction不能点击的问题
    [chooseImageSheet showInView:[UIApplication sharedApplication].keyWindow];
    
}

-(IBAction)selectPhone:(id)sender {
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark UIActionSheetDelegate Method
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            self.sex.text = @"男";
            
            [self resumeView];
            break;
            
        case 1:
            self.sex.text = @"女";
            
            [self resumeView];
            
            break;
        case 2:
            
            [self resumeView];
            
            break;
            
        default:
            break;
    }
}

#pragma mark ABPeoplePickerNavigationControllerDelegate Method
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)peoplePickerNavigationController: (ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    NSString *personName = @"";
    //读取lastname
    NSString *lastname = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
    if(lastname != nil)
        personName = [personName stringByAppendingFormat:@"%@",lastname];
    
    //读取middlename
    NSString *middlename = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonMiddleNameProperty));
    if(middlename != nil)
        personName = [personName stringByAppendingFormat:@"%@",middlename];
    
    //读取firstname
    NSString *firstname = (NSString*)CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    
    if(personName != nil){
        
        if ( firstname.length != 0 ) {
            personName = [personName stringByAppendingFormat:@"%@",firstname];
            
        }
    }
    self.name.text = personName;
    
    //获取联系人电话
    ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSMutableArray *phones = [[NSMutableArray alloc] init];
    for (int i = 0; i < ABMultiValueGetCount(phoneMulti); i++) {
        NSString *aPhone = (NSString*)CFBridgingRelease(ABMultiValueCopyValueAtIndex(phoneMulti, i));
        NSString *aLabel = (NSString*)CFBridgingRelease(ABMultiValueCopyLabelAtIndex(phoneMulti, i));
        if([aLabel isEqualToString:@"_$!<Mobile>!$_"]) {
            [phones addObject:aPhone];
        }
    }
    if([phones count]>0) {
        NSString *mobileNo = [phones objectAtIndex:0];
        if (mobileNo != nil) {
            mobileNo = [mobileNo stringByReplacingOccurrencesOfString:@"-" withString:@""];
            mobileNo = [mobileNo stringByReplacingOccurrencesOfString:@"+86" withString:@""];
            self.phone.text = mobileNo;
        }
    }
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    return NO;
}

- (IBAction)showRole:(id)sender {
    
//    SettingDetailViewController *viewController = [[SettingDetailViewController alloc] initWithNibName:@"SettingDetailViewController" bundle:nil];
//    //viewController.title = @"推荐规划";
//    viewController.infoKey = 56;
//    [self.navigationController pushViewController:viewController animated:YES];
}


//隐藏键盘的方法
-(void)hidenKeyboard {
    [self.name resignFirstResponder];
    [self.sex resignFirstResponder];
    [self.phone resignFirstResponder];
    [self resumeView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    [self hidenKeyboard];
    return YES;
}

//UITextField的协议方法，当开始编辑时监听
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ( textField == self.phone ) {
        
//        [self showNumPadDone:nil];
        
    }else if ( textField == self.name ){
        
//        [self hiddenNumPadDone:nil];
    }
    
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    CGRect rect=CGRectMake(0.0f,-120.0f,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
    return YES;
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
