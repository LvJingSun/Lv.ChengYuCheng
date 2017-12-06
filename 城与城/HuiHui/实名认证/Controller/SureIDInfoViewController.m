//
//  SureIDInfoViewController.m
//  HuiHui
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "SureIDInfoViewController.h"
#import "AuthenticationModel.h"
#import "SureIDInfoFrame.h"
#import "SureIDInfoCell.h"
#import "LJConst.h"

@interface SureIDInfoViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *array;

@end

@implementation SureIDInfoViewController

-(NSArray *)array {

    if (_array == nil) {
        
        NSMutableArray *mut = [NSMutableArray array];
        
        SureIDInfoFrame *frame = [[SureIDInfoFrame alloc] init];
        
        frame.authModel = self.authModel;
        
        [mut addObject:frame];
        
        _array = mut;
        
    }
    
    return _array;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"身份证信息";
    
    [self allocWithTableview];
    
}

- (void)allocWithTableview {

    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = FSB_ViewBGCOLOR;
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.array.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    SureIDInfoCell *cell = [[SureIDInfoCell alloc] init];
    
    SureIDInfoFrame *frame = self.array[indexPath.row];
    
    cell.frameModel = frame;
    
    cell.sureBlock = ^{
        
        [self upLoadData];
        
    };
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    SureIDInfoFrame *frame = self.array[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (NSData *)getImageData:(UIImage *)image {

    return UIImageJPEGRepresentation(image, 0.3);
    
}

- (void)upLoadData {

    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           self.authModel.name,   @"realName",
                           self.authModel.num,   @"iDNumber",
                           nil];
    
    NSDictionary *files = [NSDictionary dictionaryWithObjectsAndKeys:
                           [self getImageData:self.authModel.faceImg],   @"iDCardPositive",
                           [self getImageData:self.authModel.backImg],   @"iDCardNegative",
                           nil];
    
    [SVProgressHUD showWithStatus:@"信息提交中"];
    
    [httpClient multiRequest:@"RealAttestationReq.ashx" parameters:param files:files success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            NSMutableDictionary *realAccountData = [json valueForKey:@"realAttestation"];
            
            [CommonUtil addValue:[realAccountData objectForKey:@"VldStatus"] andKey:USER_REALAUSTATUS];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
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
