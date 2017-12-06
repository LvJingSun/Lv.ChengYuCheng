//
//  MyCardViewController.m
//  HuiHui
//
//  Created by 冯海强 on 14-6-24.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "MyCardViewController.h"
#import "MyCardCell.h"
#import "CardlistViewController.h"
#import "MyCarddetailViewController.h"

@interface MyCardViewController ()

@property (nonatomic,strong)NSMutableArray *MyCardsArray;

@end

@implementation MyCardViewController

@synthesize m_isZD;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.MyCardsArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_index = 0;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [CommonUtil addValue:@"0" andKey:@"MyCardRequestSubmit_Notification"];

    [self setTitle:@"我的卡"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    [self setRightButtonWithNormalImage:@"add.png" action:@selector(rightClicked:)];

    [self setExtraCellLineHidden:self.MC_tableview];
    
    self.MC_tableview.hidden = YES;
    self.MC_simpleview.hidden = YES;
    [self.MC_tableview setDelegate:self];
    [self.MC_tableview setDataSource:self];
    [self.MC_tableview setPullDelegate:self];
    self.MC_tableview.pullBackgroundColor = [UIColor whiteColor];
    self.MC_tableview.useRefreshView = YES;
//    self.MC_tableview.useLoadingMoreView = YES;
    
    m_pageIndex = 1;
    
    [self CardRequestSubmit];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
    if ([[CommonUtil getValueByKey:@"MyCardRequestSubmit_Notification"] isEqualToString:@"1"]) {
        [CommonUtil addValue:@"0" andKey:@"MyCardRequestSubmit_Notification"];
        [self requestCards];
    }
    
}


-(void)viewDidAppear:(BOOL)animated{
    [CommonUtil addValue:@"YES" andKey:MycardViewcurrentBool];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MycardViewcurrentBoolRefish) name:MycardViewcurrentBool object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [CommonUtil addValue:nil andKey:MycardViewcurrentBool];
    [self hideTabBar:NO];
    
}

- (void)leftClicked{
    
    [self goBack];
}

- (IBAction)rightClicked:(id)sender
{
    [CommonUtil addValue:@"0" andKey:@"MyCardRequestSubmit_Notification"];
    
    CardlistViewController * VC = [[CardlistViewController alloc]initWithNibName:@"CardlistViewController" bundle:nil];
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

-(void)requestCards
{
    m_pageIndex = 1;
    
    [self performSelector:@selector(CardRequestSubmit) withObject:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.MyCardsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    MyCardCell1*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"MyCardCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }

    
//    cell.Cololabel.layer.masksToBounds = YES;
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.Cololabel.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = cell.Cololabel.bounds;
//    maskLayer.path = maskPath.CGPath;
//    cell.Cololabel.layer.mask = maskLayer;
    
    if ( self.MyCardsArray.count != 0 ) {
        
        NSDictionary *dic = [self.MyCardsArray objectAtIndex:indexPath.row];
        
        [cell setImageView:[NSString stringWithFormat:@"%@",[dic objectForKey:@"logoBigUrl"]]];
        cell.Businessname.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"allName"]];
        cell.Cardname.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"cardTitle"]];
        
        [cell.BusinessImage.layer setMasksToBounds:YES];
        [cell.BusinessImage.layer setCornerRadius:5.0];

        
    }

    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    m_index = indexPath.row;
    // 保存商户的logo
//    NSDictionary *dic = [self.MyCardsArray objectAtIndex:indexPath.row];
//    
//    self.m_isZD = [NSString stringWithFormat:@"%@",[dic objectForKey:@"IsZD"]];
//    
//    NSLog(@"IsZD = %@",self.m_isZD);
//    // 根据是否置顶来判断显示取消置顶还是设置置顶
//    NSString *string = @"";
//   
//    if ( [self.m_isZD isEqualToString:@"1"] ) {
//        
//        // 表示是已经是置顶 - 可设置为取消置顶
//        string = @"取消置顶";
//        
//    }else{
//        
//        // 表示不置顶 - 可设置为置顶
//        string = @"设置置顶";
//        
//    }
//    
//    
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
//                                                       message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"cardTitle"]]
//                                                      delegate:self
//                                             cancelButtonTitle:nil
//                                             otherButtonTitles:@"查看详情",string,@"删除",@"取消", nil];
//    alertView.tag = 90342;
//    [alertView show];

    // 查看详情
    
    
    
    NSDictionary *dic = [self.MyCardsArray objectAtIndex:m_index];
    NSString *image = [NSString stringWithFormat:@"%@",[dic objectForKey:@"logoBigUrl"]];
    
    // 保存商户的图标在付款的页面进行赋值
    [CommonUtil addValue:image andKey:@"MarchantImageKey"];
    
    [CommonUtil addValue:[dic objectForKey:@"YHDescription"] andKey:YHDESCRIPTION];
    [CommonUtil addValue:[dic objectForKey:@"Man"] andKey:MANKEY];
    [CommonUtil addValue:[dic objectForKey:@"Jian"] andKey:JIANKEY];
    
    
    
    MyCarddetailViewController *VC = [[MyCarddetailViewController alloc]initWithNibName:@"MyCarddetailViewController" bundle:nil];
    VC.delegate = self;
    VC.m_dic = [self.MyCardsArray objectAtIndex:m_index];
    VC.m_isZD = [NSString stringWithFormat:@"%@",[dic objectForKey:@"IsZD"]];
    VC.m_cardId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"vipCardRecordId"]];
    VC.isWaimai = [NSString stringWithFormat:@"%@",[dic objectForKey:@"IsZCWaiMai"]];
    [self.navigationController pushViewController:VC animated:YES];

    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中状态。。
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 90342 ) {
        
        if ( buttonIndex == 0 ) {
            
            // 查看详情
            NSDictionary *dic = [self.MyCardsArray objectAtIndex:m_index];
            NSString *image = [NSString stringWithFormat:@"%@",[dic objectForKey:@"logoBigUrl"]];
            
            [CommonUtil addValue:image andKey:@"MarchantImageKey"];
            
            [CommonUtil addValue:[dic objectForKey:@"YHDescription"] andKey:YHDESCRIPTION];
            [CommonUtil addValue:[dic objectForKey:@"Man"] andKey:MANKEY];
            [CommonUtil addValue:[dic objectForKey:@"Jian"] andKey:JIANKEY];
            
            // =======
            
            MyCarddetailViewController *VC = [[MyCarddetailViewController alloc]initWithNibName:@"MyCarddetailViewController" bundle:nil];
            VC.delegate = self;
            VC.m_dic = [self.MyCardsArray objectAtIndex:m_index];
            VC.m_isZD = [NSString stringWithFormat:@"%@",[dic objectForKey:@"IsZD"]];
            VC.m_cardId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"vipCardRecordId"]];
            VC.isWaimai = [NSString stringWithFormat:@"%@",[dic objectForKey:@"IsZCWaiMai"]];

            
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if ( buttonIndex == 1 ){
            
            // 设置置顶
            if ( [self.m_isZD isEqualToString:@"1"] ) {
                
                // 取消置顶
                NSDictionary *dic = [self.MyCardsArray objectAtIndex:m_index];

                [self cancelZDrequest:[NSString stringWithFormat:@"%@",[dic objectForKey:@"vipCardRecordId"]]];
                
            }else{
                
                // 设置置顶
                NSDictionary *dic = [self.MyCardsArray objectAtIndex:m_index];
                
                [self zdRequestSubmit:[NSString stringWithFormat:@"%@",[dic objectForKey:@"vipCardRecordId"]]];
                
            }
            
        }else if ( buttonIndex == 2 ){
            
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                               message:@"您确定删除该会员卡？"
                                                              delegate:self
                                                     cancelButtonTitle:@"取消"
                                                     otherButtonTitles:@"确定", nil];
            alertView.tag = 90341;
            [alertView show];
            
           
            
        }else{
            
            
            
        }
        
        
    }else if ( alertView.tag == 90341 ){
        
        if ( buttonIndex == 1 ) {
            
            // 删除
            NSDictionary *dic = [self.MyCardsArray objectAtIndex:m_index];
           
            [self deleteCardRequestSubmit:[NSString stringWithFormat:@"%@",[dic objectForKey:@"vipCardRecordId"]]];
           
        }
    }
    
    
}

// 设置置顶的数据请求
- (void)zdRequestSubmit:(NSString *)vipCardRecordId{
    
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];

    AppHttpClient* httpClient = [AppHttpClient sharedClient];

    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,@"memberId",
                                  key,@"key",
                                  vipCardRecordId,@"vipCardRecordId",
                                  nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];

    [httpClient request:@"SetTopVIPCard.ashx" parameters:param success:^(NSJSONSerialization* json) {
       
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            m_pageIndex = 1;
            
            // 刷新数据
            [self CardRequestSubmit];
           
            
        } else {
          
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
       
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
     
    }];

    
}

// 取消置顶的数据请求
- (void)cancelZDrequest:(NSString *)vipCardRecordId{
    
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,@"memberId",
                                  key,@"key",
                                  vipCardRecordId,@"vipCardRecordId",
                                  nil];
    
    NSLog(@"params = %@",param);
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"CancelTopVIPCard.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            m_pageIndex = 1;
            
            // 刷新数据
            [self CardRequestSubmit];
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

// 删除会员卡的数据请求
- (void)deleteCardRequestSubmit:(NSString *)vipCardRecordId{
    
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,@"memberId",
                                  key,@"key",
                                  vipCardRecordId,@"vipCardRecordId",
                                  nil];
    
    NSLog(@"params = %@",param);
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"DeleteVIPCard.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            m_pageIndex = 1;
            
            // 刷新数据
            [self CardRequestSubmit];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

}

//请求卡列表
- (void)CardRequestSubmit{
    
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,@"memberId",
                                  [NSString stringWithFormat:@"%d",m_pageIndex],@"pageIndex",
                                  @"20",@"pageSize",
                                  @"",@"keyword",
                                  nil];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    if (self.MyCardsArray.count == 0) {
        [SVProgressHUD showWithStatus:@"数据加载中..."];
    }
    //MyVIPCardList_1.ashx MyVIPCardList.ashx
    
    NSLog(@"params = %@",param);
    
//      MyVIPCardList_1
    
    [httpClient request:@"MyVIPCardList_2.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
                        
            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [json valueForKey:@"cardList"];
            
            if (m_pageIndex == 1) {
                if (metchantShop == nil || metchantShop.count == 0) {
                    [self.MyCardsArray removeAllObjects];
                    self.MC_tableview.hidden = YES;
                    self.MC_simpleview.hidden = NO;
                    return;
                    
                } else {
                    
                    self.MyCardsArray = metchantShop;
                    self.MC_simpleview.hidden = YES;
                    self.MC_tableview.hidden = NO;
                    
                }
            } else {
                
                self.MC_tableview.hidden = NO;
                
                if (metchantShop == nil || metchantShop.count == 0) {
                    m_pageIndex--;
                } else {
                    [self.MyCardsArray addObjectsFromArray:metchantShop];
                }
            }
            [self.MC_tableview reloadData];
            
        } else {
            if (m_pageIndex > 1) {
                m_pageIndex--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.MC_tableview.pullLastRefreshDate = [NSDate date];
        self.MC_tableview.pullTableIsRefreshing = NO;
//        self.MC_tableview.pullTableIsLoadingMore = NO;
        
        
        
    } failure:^(NSError *error) {
        if (m_pageIndex > 1) {
            m_pageIndex--;
        }
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        self.MC_tableview.pullTableIsRefreshing = NO;
//        self.MC_tableview.pullTableIsLoadingMore = NO;
    }];
    
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    
    m_pageIndex = 1;
    
    [self performSelector:@selector(CardRequestSubmit) withObject:nil];
    
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    
//    m_pageIndex++;
//    
//    [self performSelector:@selector(CardRequestSubmit) withObject:nil];
    
}

//刷新我的卡列表
-(void)MycardViewcurrentBoolRefish
{
    
    m_pageIndex = 1;
    
    [self performSelector:@selector(CardRequestSubmit) withObject:nil];
    
}

- (void)RefistCardlist;
{
    [self MycardViewcurrentBoolRefish];
}


@end
