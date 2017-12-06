//
//  QuanShopListViewController.m
//  HuiHui
//
//  Created by mac on 15-5-12.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "QuanShopListViewController.h"

#import "MapViewController.h"

#import "ShopListCell.h"

@interface QuanShopListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@end

@implementation QuanShopListViewController

@synthesize m_shopList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        m_shopList = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self setTitle:@"支持的店铺"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 去掉多余的分割线
    [self setExtraCellLineHidden:self.m_tableView];
    

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear: animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.m_shopList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifer = @"ShopListCellIdentifier";
    
    ShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ShopListCell" owner:self options:nil];
        
        cell = (ShopListCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if ( self.m_shopList.count != 0 ) {
        
        NSMutableDictionary *dic = [self.m_shopList objectAtIndex:indexPath.row];
        
        
        // 赋值
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopName"]];
        cell.m_timeLable.text = [NSString stringWithFormat:@"营业时间：%@",[dic objectForKey:@"MctShopOpeningHours"]];
        cell.m_phoneLabel.text = [NSString stringWithFormat:@"咨询电话：%@",[dic objectForKey:@"MctShopPhone"]];
        
        cell.m_addressLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopAdress"]];
        
        
        cell.m_phoneBtn.tag = indexPath.row;
        
        cell.m_addressBtn.tag = indexPath.row;
        
        [cell.m_phoneBtn addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
        [cell.m_addressBtn addTarget:self action:@selector(mapClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 108.0f;
}

#pragma mark - BtnClicked
- (void)callPhone:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dic = [self.m_shopList objectAtIndex:btn.tag];
    
    // 判断设备是否支持
    if([[[UIDevice currentDevice] model] rangeOfString:@"iPhone Simulator"].location != NSNotFound) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"该设备暂不支持电话功能"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];
        
    }else{
        
        self.m_webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        
        [self.m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [dic objectForKey:@"MctShopPhone"]]]]];

    }
    
}

- (void)mapClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSMutableDictionary *dic = [self.m_shopList objectAtIndex:btn.tag];

    NSMutableDictionary *l_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    [l_dic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopName"]] forKey:@"ShopName"];
    [l_dic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopAdress"]] forKey:@"Address"];
    [l_dic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopOpeningHours"]] forKey:@"OpeningHours"];
    [l_dic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopPhone"]] forKey:@"Phone"];
    [l_dic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopMapY"]] forKey:@"MapY"];
    [l_dic setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MctMapX"]] forKey:@"MapX"];

    // 进入地图展示的页面
    MapViewController *VC = [[MapViewController alloc]initWithNibName:@"MapViewController" bundle:nil];
    VC.item = l_dic;
    VC.m_shopString = @"1";
    VC.m_FromDPId = @"2";
    
    [self.navigationController pushViewController:VC animated:YES];
    
}


@end
