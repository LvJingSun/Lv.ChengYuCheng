//
//  Z_SearchViewController.m
//  HuiHui
//
//  Created by mac on 2017/7/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Z_SearchViewController.h"
#import "RedHorseHeader.h"
#import "Z_SearchModel.h"
#import "Z_SearchFrame.h"
#import "Z_SearchCell.h"

@interface Z_SearchViewController () <UITableViewDelegate,UITableViewDataSource,Z_Search_FieldDelegate,UITextFieldDelegate>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *inPutArray;

@end

@implementation Z_SearchViewController

-(NSArray *)inPutArray {

    if (_inPutArray == nil) {
        
        Z_SearchModel *model = [[Z_SearchModel alloc] init];
        
        Z_SearchFrame *frame = [[Z_SearchFrame alloc] init];
        
        frame.searchModel = model;
        
        NSMutableArray *mut = [NSMutableArray array];
        
        [mut addObject:frame];
        
        _inPutArray = mut;
        
    }
    
    return _inPutArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTitle:@"转账"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.view.backgroundColor = RH_ViewBGColor;
    
    [self allocWithTableview];

}

- (void)leftClicked{
    
    [self goBack];
    
}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableviewClick)];
    
    [tableview addGestureRecognizer:tap];
    
    [self.view addSubview:tableview];
    
}

- (void)tableviewClick {

    [self hideKeyboard];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    
    return  NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.inPutArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    Z_SearchCell *cell = [[Z_SearchCell alloc] init];
    
    Z_SearchFrame *frame = self.inPutArray[indexPath.row];
    
    cell.frameModel = frame;
    
    cell.delegate = self;
    
    return cell;
    
}

- (void)PhoneFieldChange:(UITextField *)field {

    for (Z_SearchFrame *frame in self.inPutArray) {
        
        frame.searchModel.searchPhone = field.text;
        
        [self checkPhone];
        
    }
    
}


- (void)checkPhone {

    Z_SearchFrame *frame = self.inPutArray[0];
    
    if (frame.searchModel.searchPhone.length == 11) {
     
        frame.searchModel.isPhoneNumber = @"1";

        [self.tableview reloadData];
        
    }else if (frame.searchModel.searchPhone.length == 0) {
    
        frame.searchModel.isPhoneNumber = @"0";
        
        [self.tableview reloadData];
        
    }
    
}

-(BOOL)isValidateMobile:(NSString *)mobile
{
    //手机号以13，14，15，17，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|17[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
    
}

- (void)hideKeyboard {
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    Z_SearchFrame *frame = self.inPutArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
