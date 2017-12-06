//
//  T_ContactsViewController.m
//  HuiHui
//
//  Created by mac on 2017/3/31.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "T_ContactsViewController.h"
#import <AddressBook/AddressBook.h>
#import "Add_ContactModel.h"
#import "Add_ContactFrame.h"
#import "Add_ContactCell.h"

#define TabBGCOLOR [UIColor colorWithRed:244/255. green:244/255. blue:244/255. alpha:1.]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface T_ContactsViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *allData;

@property (nonatomic, strong) NSArray *contactsArr;

@end

@implementation T_ContactsViewController

-(NSArray *)contactsArr {

    if (_contactsArr == nil) {
        
        NSMutableArray *mut = [NSMutableArray array];
        
        for (NSDictionary *dd in self.allData) {
            
            Add_ContactModel *model = [[Add_ContactModel alloc] initWithDict:dd];
            
            Add_ContactFrame *frame = [[Add_ContactFrame alloc] init];
            
            model.iconUrl = @"icon1.JPG";
            
            model.isFriend = NO;
            
            model.nick = @"小鬼";
            
            frame.add_contact = model;
            
            [mut addObject:frame];
            
        }
        
        _contactsArr = mut;
        
    }
    
    return _contactsArr;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"手机通讯录";

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self obtainPhoneAllContact];
    
    [self initWithTableview];
    
}

- (void)initWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = TabBGCOLOR;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.contactsArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    Add_ContactCell *cell = [[Add_ContactCell alloc] init];
    
    Add_ContactFrame *frame = self.contactsArr[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    Add_ContactFrame *frame = self.contactsArr[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)obtainPhoneAllContact {
    
    //这个变量用于记录授权是否成功，即用户是否允许我们访问通讯录
    int   __block tip=0;
    
    //声明一个通讯簿的引用
    ABAddressBookRef addBook =nil;
    
    //因为在IOS6.0之后和之前的权限申请方式有所差别，这里做个判断
    if   ([[UIDevice currentDevice].systemVersion floatValue]>=6.0) {
        
        //创建通讯簿的引用
        addBook=ABAddressBookCreateWithOptions(NULL, NULL);
        
        //创建一个出事信号量为0的信号
        dispatch_semaphore_t sema=dispatch_semaphore_create(0);
        
        //申请访问权限
        ABAddressBookRequestAccessWithCompletion(addBook, ^( bool   greanted, CFErrorRef error)        {
            
            //greanted为YES是表示用户允许，否则为不允许
            if   (!greanted) {
                
                tip=1;
                
            }
            
            //发送一次信号
            dispatch_semaphore_signal(sema);
            
        });
        
        //等待信号触发
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
    } else {
        
        //IOS6之前
        addBook = ABAddressBookCreate();
        
    }
    
    if   (tip) {
        
        //做一个友好的提示
        UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的通讯录" delegate:self cancelButtonTitle:@"确定"   otherButtonTitles:nil, nil];
        
        [alart show];
        
        return ;
        
    }
    
    //获取所有联系人的数组
    CFArrayRef allLinkPeople = ABAddressBookCopyArrayOfAllPeople(addBook);
    
    //获取联系人总数
    CFIndex number = ABAddressBookGetPersonCount(addBook);
    
    self.allData = [NSMutableArray array];
    
    //进行遍历
    for   (NSInteger i=0; i<number; i++) {
        
        
        
        //获取联系人对象的引用
        ABRecordRef  people = CFArrayGetValueAtIndex(allLinkPeople, i);
        
        //获取当前联系人名字
        NSString *firstName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty));
        
        //获取当前联系人姓氏
        NSString *lastName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonLastNameProperty));
        
        if (lastName == NULL) {
            
            lastName = @"";
            
        }else if (firstName == NULL) {
            
            firstName = @"";
            
        }
        
        
        
        ABMultiValueRef phones= ABRecordCopyValue(people, kABPersonPhoneProperty);
        
        for   (NSInteger j = 0; j < ABMultiValueGetCount(phones); j ++) {
            
            NSString *mutStr = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, j));
            
            NSMutableDictionary *dic= [NSMutableDictionary dictionary];
            
            [dic setValue:[NSString stringWithFormat:@"%@%@",lastName,firstName] forKey:@"name"];
            
            [dic setValue:mutStr forKey:@"phone"];
            
            [self.allData addObject:dic];
            
        }
        
    }
    
    NSLog(@"%@",self.allData);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
