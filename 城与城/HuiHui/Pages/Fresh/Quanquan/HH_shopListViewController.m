//
//  HH_shopListViewController.m
//  HuiHui
//
//  Created by mac on 15-3-20.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HH_shopListViewController.h"

#import "hh_shopListCell.h"

@interface HH_shopListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UIButton *m_selectedBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_mctName;

// 全选按钮触发的事件
- (IBAction)chooseAllShop:(id)sender;

@end

@implementation HH_shopListViewController

@synthesize m_shopList;

@synthesize delegate;

@synthesize m_selectedDic;

@synthesize isSelected;

@synthesize m_chooseShopList;

@synthesize m_shopArray;

//+ (HH_shopListViewController *)shareobject{
//    
//    static HH_shopListViewController *VC = nil;
//    
//    if ( VC == nil){
//        
//        VC = [[HH_shopListViewController alloc]init];
//        
//    }
//    
//    return VC;
//    
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        m_shopList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_shopArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_chooseShopList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_selectedDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        isSelected = NO;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"店铺列表选择"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"确定" action:@selector(sureChooseClicked)];
    
    // 去掉tableView多余的分割线
    [self setExtraCellLineHidden:self.m_tableView];
    
    // 请求数据
    [self shopListRequest];
    
    NSLog(@"m_shopArray = %@",self.m_shopArray);
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
    
}

- (void)sureChooseClicked{
    
    if ( self.m_chooseShopList.count == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择店铺"];
        
        return;
    }
    
    
    if ( delegate && [delegate respondsToSelector:@selector(getShopList:)] ) {
        
        [delegate performSelector:@selector(getShopList:) withObject:self.m_chooseShopList];
    }
    
    [self goBack];
    
}

// 店铺数据请求数据
- (void)shopListRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           merchantId,@"merchantId",
                           
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"VoucherMerchantShops.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            self.m_shopList = [json valueForKey:@"ShopModelList"];
            
            NSLog(@"json = %@",json);
            
            
            // 判断是否选中某个的dic
            for (int i = 0; i < self.m_shopList.count; i++) {
                
                // 默认全部不选，状态为0
                [self.m_selectedDic setObject:@"0" forKey:[NSString stringWithFormat:@"%i",i]];
                
            }
            
            // 选择存放店铺的数据如果有值的话则先清空数据
            if ( self.m_chooseShopList.count != 0 ) {
                
                [self.m_chooseShopList removeAllObjects];
            }
            
            NSLog(@"self.m_shopArray = %@",self.m_shopArray);
            
            
            // 判断如果选择的数组包含在请求店铺数组里面的话，则直接设置值，默认选中状态
            for (int i = 0; i < self.m_shopArray.count; i++) {
                
                NSDictionary *dic = [self.m_shopArray objectAtIndex:i];
                
                NSLog(@"dic = %@",dic);
                
                if ( [self.m_shopList containsObject:dic] ) {
                    
                    NSInteger index = [self.m_shopList indexOfObject:dic];
                    
                    [self.m_selectedDic setObject:@"1" forKey:[NSString stringWithFormat:@"%li",(long)index]];
                    
                    [self.m_chooseShopList addObject:dic];
                    
                }
                
                
            }
            
            // 设置全部选中的按钮的显示
            [self setAllSelectedBtn];
            
            
            NSLog(@"self.m_selectedDic = %@",self.m_selectedDic);
            
            
            // 赋值
            self.m_mctName.text = [NSString stringWithFormat:@"%@",[json valueForKey:@"MctAllName"]];
            
            // 刷新列表数据
            [self.m_tableView reloadData];
            
        } else {
            
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)setAllSelectedBtn{
    
    // 根据选择的情况来判断是否全选
    if ( self.m_chooseShopList.count == self.m_shopList.count ) {
        
        // 表示全部选中，则设置全选的按钮
        [self.m_selectedBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
        
        self.isSelected = YES;
        
    }else{
        
        // 表示未全部选中，则设置全选的按钮
        [self.m_selectedBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
        
        self.isSelected = NO;
        
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_shopList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"hh_shopListCellIdentifier";

    hh_shopListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"hh_shopListCell" owner:self options:nil];
        
        cell = (hh_shopListCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    // 赋值
    if ( self.m_shopList.count != 0 ) {
        
        NSDictionary *dic = [self.m_shopList objectAtIndex:indexPath.row];
        
        cell.m_shopName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopName"]];
    }
    
    
    cell.m_btn.tag = indexPath.row;
    [cell.m_btn addTarget:self action:@selector(addShopName:) forControlEvents:UIControlEventTouchUpInside];
    
    // 状态为0时表示未选择  1表示已经选择
    NSString *status = [NSString stringWithFormat:@"%@",[self.m_selectedDic objectForKey:[NSString stringWithFormat:@"%li",(long)indexPath.row]]];
    
    if ( [status isEqualToString:@"1"] ) {
        
        [cell.m_btn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
        
    }else{
        
        [cell.m_btn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];

    }
    
    
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *status = [self.m_selectedDic objectForKey:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
    
    // 根据状态来判断是选择了店铺还是未选择
    if ( [status isEqualToString:@"1"] ) {
        
        [self.m_selectedDic setObject:@"0" forKey:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
        
        // 将选择的数据从数组中删除
        NSDictionary *dic = [self.m_shopList objectAtIndex:indexPath.row];
        
        [self.m_chooseShopList removeObject:dic];
        
    }else{
        
        [self.m_selectedDic setObject:@"1" forKey:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
        
        // 将选择的数据加入数组
        NSDictionary *dic = [self.m_shopList objectAtIndex:indexPath.row];
        
        [self.m_chooseShopList addObject:dic];
        
    }
    
    
    // 刷新选择的某一行
    [self.m_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
    
    // 根据选择的情况来判断是否全选
    [self setAllSelectedBtn];
    
}

- (void)addShopName:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSString *status = [self.m_selectedDic objectForKey:[NSString stringWithFormat:@"%li",(long)btn.tag]];
    
    // 根据状态来判断是选择了店铺还是未选择
    if ( [status isEqualToString:@"1"] ) {
    
        [self.m_selectedDic setObject:@"0" forKey:[NSString stringWithFormat:@"%li",(long)btn.tag]];
        
        // 将选择的数据从数组中删除
        NSDictionary *dic = [self.m_shopList objectAtIndex:btn.tag];
        
        [self.m_chooseShopList removeObject:dic];
        
    }else{
        
        [self.m_selectedDic setObject:@"1" forKey:[NSString stringWithFormat:@"%li",(long)btn.tag]];

        // 将选择的数据加入数组
        NSDictionary *dic = [self.m_shopList objectAtIndex:btn.tag];
        
        [self.m_chooseShopList addObject:dic];

    }
    
    
    // 刷新选择的某一行
    [self.m_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:btn.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
    
    // 根据选择的情况来判断是否全选
    [self setAllSelectedBtn];
}

- (IBAction)chooseAllShop:(id)sender {

    self.isSelected = !self.isSelected;
    
    if ( self.isSelected ) {
        
        if ( self.m_chooseShopList.count != 0 ) {
            
            [self.m_chooseShopList removeAllObjects];
        }
        
        // 全选
        if ( self.m_shopList.count != 0 ) {
            
            [self.m_chooseShopList addObjectsFromArray:self.m_shopList];
        }
        
        for (int i = 0; i < self.m_shopList.count; i++) {
            
            [self.m_selectedDic setObject:@"1" forKey:[NSString stringWithFormat:@"%i",i]];
            
        }
        
        [self.m_selectedBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
        
    }else{
        
        // 全不选
        for (int i = 0; i < self.m_shopList.count; i++) {
            
            if ( self.m_chooseShopList.count != 0 ) {
                
                [self.m_chooseShopList removeAllObjects];
            }
            
            [self.m_selectedDic setObject:@"0" forKey:[NSString stringWithFormat:@"%i",i]];
            
        }
        
        
        [self.m_selectedBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];

        
        
    }
    
    
    // 刷新列表
    [self.m_tableView reloadData];
    
    
}


@end
