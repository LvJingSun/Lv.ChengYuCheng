//
//  SceneryOutListViewController.m
//  HuiHui
//
//  Created by mac on 15-1-29.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SceneryOutListViewController.h"

#import "SceneryOutpeopleCell.h"

#import "SEditTravellerViewController.h"

@interface SceneryOutListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

// 添加旅客
- (IBAction)addTravellerClicked:(id)sender;

@end

static SceneryOutListViewController *vc = nil;

@implementation SceneryOutListViewController

@synthesize m_count;

@synthesize realNameIndex;

@synthesize m_list;

@synthesize delegate;

@synthesize m_selectedDic;

@synthesize m_travellerList;


// 保证筛选只初始化一次
+ (SceneryOutListViewController *)shareobject;
{
    if (vc == nil)
    {
        vc = [[SceneryOutListViewController alloc]init];
        
    }
    
    return vc;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_list = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_selectedDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_travellerList = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"出行人列表"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    self.m_tableView.hidden = YES;
    
    self.m_emptyLabel.hidden = YES;
    
    // 将多余的分割线去掉
    [self setExtraCellLineHidden:self.m_tableView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // 请求数据
    [self PeopleRequest];
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

- (void)addTraveller{
    
    if ( self.realNameIndex == 1 || self.realNameIndex == 3 ) {
        // 多个
        if ( self.m_travellerList.count < self.m_count ) {
            
            int count = self.m_count - (int)self.m_travellerList.count;
            
            [self alertWithMessage:[NSString stringWithFormat:@"您还需选择%i个旅客哦",count]];
            
            return;
            
        }
        
    }else if ( self.realNameIndex == 2 || self.realNameIndex == 4 ){
        
        // 1个
        if ( self.m_travellerList.count < 1 ) {
            
            [self alertWithMessage:@"您还需选择1个旅客哦"];
            
            return;
            
        }
        
    }else{
        
        
    }

    
    
    
    if ( delegate && [delegate respondsToSelector:@selector(SceneryTraveller:)] ) {
        
        [delegate performSelector:@selector(SceneryTraveller:) withObject:self.m_travellerList];
        
    }
    
    [self goBack];
 
    
}


- (IBAction)addTravellerClicked:(id)sender {
    
    // 添加游玩人的信息
    SceneryOutPViewController *VC = [[SceneryOutPViewController alloc]initWithNibName:@"SceneryOutPViewController" bundle:nil];
    VC.delegate = self;
    VC.realNameIndex = self.realNameIndex;
    VC.m_count = m_count;
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - SceneryOutPeopleDelegate
- (void)SceneryOutPeople:(NSDictionary *)dic{
    
    
}

#pragma mark - NetWork
- (void)PeopleRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    AppHttpClient* httpClient = [AppHttpClient scenerySharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    NSLog(@"parma = %@",param);
    
    [httpClient requestScenery:@"Scenery/GetTravellerList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            self.m_list = [json valueForKey:@"travellerList"];
            
            if ( self.m_list.count != 0 ) {
                
                self.m_tableView.hidden = NO;
                
                self.m_emptyLabel.hidden = YES;
                
                // 添加导航栏右按钮
                [self setRightButtonWithTitle:@"确定" action:@selector(addTraveller)];

                
                // 刷新列表
                [self.m_tableView reloadData];
                
            }else{
                
                self.m_tableView.hidden = YES;
                
                self.m_emptyLabel.hidden = NO;
                
                // 设置导航栏右按钮为空
                self.navigationItem.rightBarButtonItem = nil;

            }
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.m_list.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"SceneryOutInfoCellIdentifier";
    
    SceneryOutInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SceneryOutpeopleCell" owner:self options:nil];
        
        cell = (SceneryOutInfoCell *)[nib objectAtIndex:2];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    
    if ( self.m_list.count != 0 ) {
        
        cell.m_lineImgV.hidden = YES;
        
        NSDictionary *dic = [self.m_list objectAtIndex:indexPath.row];
        
        if ( realNameIndex == 1 || realNameIndex == 2 ) {
            // 显示身份证和姓名信息 赋值
            cell.m_cardKey.text = @"身份证：";

            cell.m_outName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Name"]];
            
            cell.m_cardId.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CardNum"]];
            
            if ( cell.m_cardId.text.length == 0 || [cell.m_cardId.text isEqualToString:@"(null)"] ) {
                
                cell.m_cardId.text = @"身份证信息不完善";
                
            }

        }else{
            
            // 显示身份证和姓名信息 赋值
            cell.m_cardKey.text = @"手机号：";
            
            cell.m_outName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Name"]];
            
            cell.m_cardId.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MobilePhone"]];
            
            if ( cell.m_cardId.text.length == 0 || [cell.m_cardId.text isEqualToString:@"(null)"] ) {
                
                cell.m_cardId.text = @"手机号信息不完善";
                
            }
        }
        
        // 按钮添加事件
        cell.m_gouBtn.tag = indexPath.row;
        cell.m_editBtn.tag = indexPath.row;
        
        [cell.m_gouBtn addTarget:self action:@selector(chooseTraveller:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.m_editBtn addTarget:self action:@selector(editTraveller:) forControlEvents:UIControlEventTouchUpInside];
        
        // 根据类型来判断按钮的显示图标
        NSString *valueString = [NSString stringWithFormat:@"%@",[self.m_selectedDic objectForKey:[NSString stringWithFormat:@"%li",(long)indexPath.row]]];
        
        if ( [valueString isEqualToString:@"1"] ) {
            
            [cell.m_gouBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
            
            
        }else{
            
            [cell.m_gouBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];

        }
        
        
        
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 56.0f;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
}

#pragma mark - btnClicked
- (void)chooseTraveller:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSDictionary *dic = [self.m_list objectAtIndex:btn.tag];
    
    // 根据类型来判断是否信息完善，不完善的话要跳出提示
    if ( self.realNameIndex == 1 || self.realNameIndex == 2 ) {
       
        // 要填写取票人的姓名、手机号和身份证-需要身份证
        NSString *cardId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"CardNum"]];
        
        if ( cardId.length == 0 || [cardId isEqualToString:@"(null)"] ) {
            
            [SVProgressHUD showErrorWithStatus:@"请先完善该信息"];
            
            return;
            
        }
        
    }
    
    
    
    // 选择后将该标记记录到字典里用于刷新列表用  1表示选中，0表示未选中
    NSString *valueString = [NSString stringWithFormat:@"%@",[self.m_selectedDic objectForKey:[NSString stringWithFormat:@"%ld",(long)btn.tag]]];
    
    if ( [valueString isEqualToString:@"1"] ) {
        
        [self.m_selectedDic setObject:@"0" forKey:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
        
        // 删除某个旅客信息
        if ( self.m_travellerList.count != 0 ) {
            
            [self.m_travellerList removeObject:dic];
        }

    }else{
        
        
        if ( self.realNameIndex == 1 || self.realNameIndex == 3 ) {
            // 多个
            // 根据个数来判断是否要选择多个旅客
            if ( self.m_travellerList.count >= self.m_count ) {
                
                [self alertWithMessage:[NSString stringWithFormat:@"您最多只能选择%i个旅客哦",self.m_count]];
                
            }else{
                
                // 添加某个旅客信息
                [self.m_travellerList addObject:dic];
                
                [self.m_selectedDic setObject:@"1" forKey:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
            }

            
        }else if ( self.realNameIndex == 2 || self.realNameIndex == 4 ){
            
            // 1个
            
            // 根据个数来判断是否要选择多个旅客
            if ( self.m_travellerList.count >= 1 ) {
                
                [self alertWithMessage:@"您最多只能选择1个旅客哦"];
                
            }else{
                
                // 添加某个旅客信息
                [self.m_travellerList addObject:dic];
                
                [self.m_selectedDic setObject:@"1" forKey:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
            }

            
        }else{
            
            
        }

    }

    
    // 刷新列表
    [self.m_tableView reloadData];
   
}

- (void)editTraveller:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dic = [self.m_list objectAtIndex:btn.tag];
    
    // 编辑旅客信息
    SEditTravellerViewController *VC = [[SEditTravellerViewController alloc]initWithNibName:@"SEditTravellerViewController" bundle:nil];
    VC.m_dic = dic;
    [self.navigationController pushViewController:VC animated:YES];
    
}

@end
