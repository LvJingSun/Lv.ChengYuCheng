//
//  MyKeyDetailViewController.m
//  baozhifu
//
//  Created by mac on 13-6-16.
//  Copyright (c) 2013年 mac. All rights reserved.
//
#import "MyKeyDetailViewController.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "RTLabel.h"
#import "KeyInfoCell.h"
#import "MyKeyQRCodeViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MyKeyDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *txt_key_merchant;

@property (weak, nonatomic) IBOutlet UILabel *txt_key_number;

@property (weak, nonatomic) IBOutlet UILabel *txt_resource_price;

@property (weak, nonatomic) IBOutlet UILabel *txt_detail_activity;

@property (weak, nonatomic) IBOutlet UITableView *table_key_list;

@property (weak, nonatomic) IBOutlet UIImageView *checkImage;

@property (weak, nonatomic) IBOutlet UIImageView *logoView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@property (weak, nonatomic) IBOutlet UIView *m_titleVIew;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UIView *m_iseView;

- (IBAction)selectKeys:(id)sender;

- (IBAction)selectUse:(id)sender;

@end

@implementation MyKeyDetailViewController

@synthesize m_SelectIndex;

@synthesize mDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = @"KEY值详情";
        keys = [[NSMutableArray alloc] init];
        isChecked = NO;
        
        m_SelectIndex = 0;
        
        mDic = [[NSMutableDictionary alloc]initWithCapacity:0];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.navigationController setNavigationBarHidden:NO];
    //[self.txt_detail_activity setFont:[UIFont systemFontOfSize:12.0]];
    
    [self setTitle:@"KEY值详情"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.m_emptyLabel.hidden = YES;
    
    self.table_key_list.hidden = YES;
    
    [self.table_key_list setDelegate:self];
    [self.table_key_list setDataSource:self];
    [self.table_key_list setSeparatorColor:[UIColor clearColor]];
    [self reflashView];
    
    // 请求数据
    [self loadData];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)reflashView {
    NSString *url = [self.item objectForKey:@"log"];
    if (url) {
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
//        self.logoView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
        
        
//        NSString *path = [self.item objectForKey:@"log"];
        
        [self.logoView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]]
                             placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                      success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                          self.logoView.image = image;//[CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                          
                                          self.logoView.contentMode = UIViewContentModeScaleAspectFit;
                                          
                                      }
                                      failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                          
                                      }];

        
        
    }
    self.txt_key_merchant.text = [NSString stringWithFormat:@"消费商户：%@", [self.item objectForKey:@"allName"]];
    self.txt_resource_price.text = [NSString stringWithFormat:@"资源单价：%.2f", [[self.item objectForKey:@"price"] doubleValue]];
    self.txt_key_number.text = [NSString stringWithFormat:@"KEY数量：%d", [[self.item objectForKey:@"keyNum"] intValue]];
    NSString *keyType = [self.item objectForKey:@"keyType"];
    if ([KEY_TYPE_SERVICE isEqualToString:keyType]) {
        self.txt_detail_activity.text = [NSString stringWithFormat:@"%@", [self.item objectForKey:@"svcName"]];
    } else if ([KEY_TYPE_ACTIVITY isEqualToString:keyType]){
        self.txt_detail_activity.text = [NSString stringWithFormat:@"%@", [self.item objectForKey:@"activityName"]];
    }else{
        
        self.txt_detail_activity.text = [NSString stringWithFormat:@"%@", [self.item objectForKey:@"goodName"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *keyType = [self.item objectForKey:@"keyType"];
    id keyId;
    if ([KEY_TYPE_SERVICE isEqualToString:keyType]) {
        keyId = [self.item objectForKey:@"serviceId"];
    } else if ([KEY_TYPE_ACTIVITY isEqualToString:keyType]){
        keyId = [self.item objectForKey:@"activityId"];
    }else{
        
        keyId = [self.item objectForKey:@"panicBuyGoodID"];
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberid",
                           key,   @"key",
                           keyType,   @"keyType",
                           keyId,   @"resId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MyKeys.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableDictionary *myKeys = [json valueForKey:@"myKeys"];
            [myKeys setObject:[self.item objectForKey:@"keyType"] forKey:@"keyType"];
            [myKeys setObject:[self.item objectForKey:@"serviceId"] forKey:@"serviceId"];
            [myKeys setObject:[self.item objectForKey:@"activityId"] forKey:@"activityId"];
            [myKeys setObject:[self.item objectForKey:@"panicBuyGoodID"] forKey:@"panicBuyGoodID"];
            
            self.item = myKeys;
            keyDictList = [self.item objectForKey:@"mkey"];
            [self reflashView];
            self.table_key_list.hidden = NO;
            
            
            for (int i = 0; i < keyDictList.count; i ++) {
                
                NSDictionary *key = [keyDictList objectAtIndex:i];
                
                [self.mDic setObject:@"0" forKey:[NSString stringWithFormat:@"%@",[key objectForKey:@"memberKeysId"]]];
                
                
            }
            
            [self.table_key_list reloadData];
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [keyDictList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    if (!nib) {
        nib = [UINib nibWithNibName:@"KeyInfoCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
        //NSLg(@"cell load from xib: %d", [indexPath row]);
    }
    KeyInfoCell *cell = (KeyInfoCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mykey_list_bg"]];
    cell.rootViewController = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSUInteger row = [indexPath row];
    NSDictionary *key = [keyDictList objectAtIndex:row];
    
    cell.btnSelect.tag = [[key objectForKey:@"memberKeysId"] intValue];
    
    cell.m_dic = self.mDic;
    
    // 选中的状态
    NSString *string = [self.mDic valueForKey:[NSString stringWithFormat:@"%@",[key objectForKey:@"memberKeysId"]]];
    
    if ( [string isEqualToString:@"1"] ) {
        
        [cell.btnSelect setBackgroundImage:[UIImage imageNamed:@"mykey_btn_selected"] forState:UIControlStateNormal];
        [cell.btnSelect setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }else{
        
        [cell.btnSelect setBackgroundImage:nil forState:UIControlStateNormal];
        [cell.btnSelect setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    // 对cell进行赋值
    [cell setValue:key withItems:self.item];
    
    // 判断退款的按钮是否显示
    cell.btnRefund.tag = indexPath.row;
    
    [cell.btnRefund addTarget:self action:@selector(btnRefundClicked:) forControlEvents:UIControlEventTouchUpInside];

    
    return cell;
}

- (void)btnRefundClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    self.m_SelectIndex = btn.tag;
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"您确定申请退款？"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    alertView.tag = 112209;
    [alertView show];
    
}

- (void)useKey:(NSString *)key {
    MyKeyQRCodeViewController *viewController = [[MyKeyQRCodeViewController alloc] initWithNibName:@"MyKeyQRCodeViewController" bundle:nil];
    viewController.keys = [NSArray arrayWithObject:key];
    [self.navigationController pushViewController:viewController animated:YES];
}



- (void)selectKey:(NSString *)key andAdd:(BOOL)needAdd withDic:(NSMutableDictionary *)dic {
    
    if (needAdd) {
        
        [keys addObject:key];
        
    } else {
        
        [keys removeObject:key];
    }
    
    // 对选中的btn进行存储赋值
    self.mDic = dic;
    
}

- (IBAction)selectUse:(id)sender {
    isChecked = !isChecked;
    if (isChecked) {
        NSMutableArray *useArray = [[NSMutableArray alloc] init];
        NSArray *array = [self.item objectForKey:@"mkey"];
        for (NSDictionary *obj in array) {
            NSInteger status = [[obj objectForKey:@"keyStatus"] intValue];
            if (status == 0) {
                [useArray addObject:obj];
            }
        }
        keyDictList = useArray;
        self.checkImage.image = [UIImage imageNamed:@"comm_check_box_selected.png"];
    } else {
        keyDictList = [self.item objectForKey:@"mkey"];
        self.checkImage.image = [UIImage imageNamed:@"comm_check_box_def.png"];
    }
    
    if ( keyDictList.count != 0 ) {
        
        self.m_emptyLabel.hidden = YES;
        
        self.table_key_list.hidden = NO;
        
        [self.table_key_list reloadData];
        
    }else{
        
        self.m_emptyLabel.hidden = NO;
        
        self.table_key_list.hidden = YES;
        
    }
}

- (IBAction)selectKeys:(id)sender {
    if (keys.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择有效的KEY"];
        return;
    }
    MyKeyQRCodeViewController *viewController = [[MyKeyQRCodeViewController alloc] initWithNibName:@"MyKeyQRCodeViewController" bundle:nil];
    viewController.keys = keys;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 112209 ) {
        
        if ( buttonIndex == 1 ) {
            
            NSDictionary *key = [keyDictList objectAtIndex:self.m_SelectIndex];
            
            // 请求申请退款的接口
            [self RefundRequestSubmit:[NSString stringWithFormat:@"%@",[key objectForKey:@"memberKeysId"]]];
            
        }else{
            
            
        }
    }else if ( alertView.tag == 112210 ){
        
        if ( buttonIndex == 0 ) {
            
            // 请求数据刷新列表
            [self loadData];
            
        }else{
            
            
        }
    }
    
}

- (void)RefundRequestSubmit:(NSString *)keyId{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [NSString stringWithFormat:@"%@",keyId],   @"memberKeysID",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MyKeyReturned_1.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSString *msg = [json valueForKey:@"msg"];
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                               message:msg
                                                              delegate:self
                                                     cancelButtonTitle:nil
                                                     otherButtonTitles:@"确定", nil];
            alertView.tag = 112210;
            [alertView show];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

@end
