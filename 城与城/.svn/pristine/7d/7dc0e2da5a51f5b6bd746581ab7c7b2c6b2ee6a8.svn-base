//
//  SceneryOutPViewController.m
//  HuiHui
//
//  Created by mac on 15-1-28.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SceneryOutPViewController.h"

#import "SceneryOutpeopleCell.h"

@interface SceneryOutPViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;


// 保存出行人信息
- (void)saveoutPeopleClicked:(id)sender;

@end

@implementation SceneryOutPViewController

@synthesize delegate;

@synthesize realNameIndex;

@synthesize m_infoDic;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_infoDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"出行人信息"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"保存" action:@selector(saveoutPeopleClicked:)];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
    
}

- (void)saveoutPeopleClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    // 根据类型判断
    if ( self.realNameIndex == 1 || self.realNameIndex == 2 ) {
        // 填写取票人的姓名、手机号和身份证
        [self.view endEditing:YES];
        
        SceneryCardIdCell *cell = (SceneryCardIdCell *)[self useCarTableView:self.m_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        
        NSString *name = [NSString stringWithFormat:@"%@",[self.m_infoDic objectForKey:[NSString stringWithFormat:@"%ld",(long)cell.m_name.tag]]];
        NSString *phone = [NSString stringWithFormat:@"%@",[self.m_infoDic objectForKey:[NSString stringWithFormat:@"%ld",(long)cell.m_phone.tag]]];

        NSString *cardId = [NSString stringWithFormat:@"%@",[self.m_infoDic objectForKey:[NSString stringWithFormat:@"%ld",(long)cell.m_cardId.tag]]];

        NSLog(@"name = %@,phone = %@,cardId = %@",name,phone,cardId);
        
        if ( name.length == 0 || [name isEqualToString:@"(null)"] ) {
            
            [SVProgressHUD showErrorWithStatus:@"请填写出行人姓名！"];
            
            return;
        }
        
        if ( cardId.length == 0 || [cardId isEqualToString:@"(null)"] ) {
            
            [SVProgressHUD showErrorWithStatus:@"请填写出行人身份证号！"];
            
            return;
        }
        
        
        if ( phone.length == 0 || [phone isEqualToString:@"(null)"] ) {
            
            [SVProgressHUD showErrorWithStatus:@"请填写出行人手机号！"];
            
            return;
        }
        
        if ( phone.length != 11 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请填写正确格式的手机号！"];
            
            return;
        }
        
        [self.m_infoDic setObject:[NSString stringWithFormat:@"%@",name] forKey:@"NameKey"];

        [self.m_infoDic setObject:[NSString stringWithFormat:@"%@",cardId] forKey:@"CardIdKey"];

        [self.m_infoDic setObject:[NSString stringWithFormat:@"%@",phone] forKey:@"PhoneKey"];
        
        
        // 请求数据
        [self AddPeopleRequest];
        

        
    }else if ( self.realNameIndex == 3 || self.realNameIndex == 4 ){
        // 填写每个取票人的姓名和手机号
        
        [self.view endEditing:YES];
        
        SceneryOutpeopleCell *cell = (SceneryOutpeopleCell *)[self realNameTableView:self.m_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        
        NSString *name = [NSString stringWithFormat:@"%@",[self.m_infoDic objectForKey:[NSString stringWithFormat:@"%ld",(long)cell.m_name.tag]]];
        NSString *phone = [NSString stringWithFormat:@"%@",[self.m_infoDic objectForKey:[NSString stringWithFormat:@"%ld",(long)cell.m_phone.tag]]];
        
        NSLog(@"name = %@,phone = %@",name,phone);
        
        if ( name.length == 0 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请填写出行人姓名！"];
            
            return;
        }
        
        
        if ( phone.length == 0 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请填写出行人手机号！"];
            
            return;
        }
        
        if ( phone.length != 11 ) {
            
            [SVProgressHUD showErrorWithStatus:@"请填写正确格式的手机号！"];
            
            return;
        }
        
        [self.m_infoDic setObject:[NSString stringWithFormat:@"%@",name] forKey:@"NameKey"];
        
        [self.m_infoDic setObject:[NSString stringWithFormat:@"%@",phone] forKey:@"PhoneKey"];
        
        
        // 请求数据
        [self AddPeopleRequest];

        
    }else{
        
        
        
        
    }

}

#pragma mark - NetWork
- (void)AddPeopleRequest{
    
    NSLog(@"infoDic = %@",self.m_infoDic);
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 当只填写手机号和姓名的时候判断身份证是否是空的值
    NSString *cardId = [NSString stringWithFormat:@"%@",[self.m_infoDic objectForKey:@"CardIdKey"]];
    
    if ( [cardId isEqualToString:@"(null)"] || cardId.length == 0 ) {
        
        cardId = @"";
        
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           [NSString stringWithFormat:@"%@",cardId],@"CardNum",
                           [NSString stringWithFormat:@"%@",[self.m_infoDic objectForKey:@"PhoneKey"]],@"mobilePhone",
                           [NSString stringWithFormat:@"%@",[self.m_infoDic objectForKey:@"NameKey"]],@"name",
                           
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    NSLog(@"parma = %@",param);
    
    [httpClient requestScenery:@"Scenery/AddTraveller.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        NSLog(@"json =%@",json);
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
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


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    
    if ( self.realNameIndex == 1 || self.realNameIndex == 2 ) {
        
        // 显示姓名、身份证、手机号的cell
        cell = [self useCarTableView:tableView cellForRowAtIndexPath:indexPath];
        
    }else {
        
        // 显示姓名、手机号的cell
        cell = [self realNameTableView:tableView cellForRowAtIndexPath:indexPath];
        
    }
    
    return cell;
    
}
#pragma mark - 身份证的cell
- (UITableViewCell *)useCarTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"SceneryCardIdCellIdentifier";
    
    SceneryCardIdCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SceneryOutpeopleCell" owner:self options:nil];
        
        cell = (SceneryCardIdCell *)[nib objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.m_name.delegate = self;
    cell.m_phone.delegate = self;
    cell.m_cardId.delegate = self;

    cell.m_name.tag = indexPath.section + 100;
    cell.m_cardId.tag = indexPath.section + 200;
    cell.m_phone.tag = indexPath.section + 300;
    
    cell.m_name.text = [self.m_infoDic objectForKey:[NSString stringWithFormat:@"%ld",(long)cell.m_name.tag]];
    cell.m_cardId.text = [self.m_infoDic objectForKey:[NSString stringWithFormat:@"%ld",(long)cell.m_cardId.tag]];
    cell.m_phone.text = [self.m_infoDic objectForKey:[NSString stringWithFormat:@"%ld",(long)cell.m_phone.tag]];
    
    
    
    
    return cell;
    
}
#pragma mark - 实名制的cell
- (UITableViewCell *)realNameTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"SceneryOutpeopleCellIdentifier";
    
    SceneryOutpeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SceneryOutpeopleCell" owner:self options:nil];
        
        cell = (SceneryOutpeopleCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.m_name.delegate = self;
    cell.m_phone.delegate = self;
    
    cell.m_name.tag = indexPath.section + 100;
    cell.m_phone.tag = indexPath.section + 200;
    
    cell.m_name.text = [self.m_infoDic objectForKey:[NSString stringWithFormat:@"%ld",(long)cell.m_name.tag]];
    
    cell.m_phone.text = [self.m_infoDic objectForKey:[NSString stringWithFormat:@"%ld",(long)cell.m_phone.tag]];
    
    
    return cell;

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( self.realNameIndex == 1 || self.realNameIndex == 2 ) {
        
        return 160.0f;
        
    }else {
     
        return 80.0f;
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{

    if ( self.realNameIndex == 3 || self.realNameIndex == 4 ) {
      
        // 显示姓名和手机号的情况
        if ( textField.tag == 100 ) {
            
            [self hiddenNumPadDone:nil];
            
        }else{
            
            [self showNumPadDone:nil];
            
        }

        
    }else{
       
        
        
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    if ( self.realNameIndex == 3 || self.realNameIndex == 4 ) {
        
        [self.m_infoDic setObject:[NSString stringWithFormat:@"%@",textField.text] forKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]];
        
    }else{
        
        [self.m_infoDic setObject:[NSString stringWithFormat:@"%@",textField.text] forKey:[NSString stringWithFormat:@"%ld",(long)textField.tag]];
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}



@end
