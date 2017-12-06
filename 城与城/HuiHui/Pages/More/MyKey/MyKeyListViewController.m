//
//  MyKeyListViewController.m
//  HuiHui
//
//  Created by mac on 13-11-20.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//


#import "MyKeyListViewController.h"
#import "CommonUtil.h"
#import "AppHttpClient.h"
#import "SVProgressHUD.h"
#import "MyKeyCell.h"
#import "MyKeyDetailViewController.h"
#import "Other_keyDetailViewController.h"


@interface MyKeyListViewController ()

@property (weak, nonatomic) IBOutlet PullTableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *btnServiceKey;

@property (weak, nonatomic) IBOutlet UIButton *btnActivityKey;

@property (weak, nonatomic) IBOutlet UIButton *m_buyKey;

@property (weak, nonatomic) IBOutlet UIView *m_btnView;

@property (weak, nonatomic) IBOutlet UIView *m_emptyView;

@property (weak, nonatomic) IBOutlet UIButton *m_typeBtn;

@property (weak, nonatomic) IBOutlet UIButton *btnOtherKey;


-(IBAction)changeType:(id)sender;

// 去购买
- (IBAction)gotoShopping:(id)sender;

@end

@implementation MyKeyListViewController

@synthesize keyItems;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        keyItems = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"我的KEY值"];
    
     [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.m_emptyView.hidden = YES;
    
    self.tableView.hidden = NO;
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setPullDelegate:self];
    self.tableView.pullBackgroundColor = [UIColor whiteColor];
    self.tableView.useRefreshView = YES;
    //self.tableView.useLoadingMoreView= YES;
    
    // 设置默认的选中第一个
    self.btnServiceKey.userInteractionEnabled = NO;
    self.btnActivityKey.userInteractionEnabled = YES;
    
    [self.btnServiceKey setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
    [self.btnServiceKey setTitleColor:[CommonUtil selectTabBarTitleColor] forState:UIControlStateNormal];
    
    //self.refreshControl = [[UIRefreshControl alloc] init];
    //[self.tableView addSubview:self.refreshControl];
    //self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    //[self.refreshControl addTarget:self action:@selector(refreshViewControlEventValueChanged) forControlEvents:UIControlEventValueChanged];

    self.itemType = KEY_TYPE_SERVICE;
    
    // 读取存在NSUserDefault里面的数组
    NSData *saveMenulistDaate = [CommonUtil getValueByKey:[NSString stringWithFormat:@"%@_myKeyList_%@",[CommonUtil getValueByKey:MEMBER_ID],self.itemType]];
    
    self.keyItems = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulistDaate];
    
    NSLog(@"key Iten = %@",self.keyItems);
    
    [self.tableView reloadData];
    
    // 请求数据接口

    [self loadData];
    
    
    
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
    
    // 读取plist里面的数据 - 默认网络不好时先从plist里面读取数据
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *finalPath = [documentDirectory stringByAppendingPathComponent:@"myKeyList.plist"];
    self.keyItems = [NSMutableArray arrayWithContentsOfFile:finalPath];
    
    NSLog(@"%@",finalPath);
    
    NSLog(@"key Iten = %@",self.keyItems);
    
    NSLog(@"key Iten = %@",[[NSMutableArray alloc]initWithContentsOfFile:finalPath]);
    
    [self goBack];
}

- (void)loadData {
    
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
                           self.itemType,   @"keyType",
                           nil];
    
    NSLog(@"param = %@",param);
    

    // 当数组没有值的时候显示加载数据的标志
    if ( self.keyItems.count == 0 ) {
        
        [SVProgressHUD showWithStatus:@"数据加载中"];

    }
    
    [httpClient request:@"MyKeyList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            
            NSLog(@"json = %@",json);
            NSLog(@"self.keyItems = %@",[json valueForKey:@"myKeysList"]);

            
            self.keyItems = [json valueForKey:@"myKeysList"];
            
            [self DidSavePlist];
                        // 将数组存储起来
            NSData *encodemenulist = [NSKeyedArchiver archivedDataWithRootObject:self.keyItems];
            
            [CommonUtil addValue:encodemenulist andKey:[NSString stringWithFormat:@"%@_myKeyList_%@",[CommonUtil getValueByKey:MEMBER_ID],self.itemType]];

            if ( self.keyItems.count != 0 ) {
                
                self.m_emptyView.hidden = YES;
                
                self.tableView.hidden = NO;
                
                [self.tableView reloadData];
                
            }else{
                
                self.m_emptyView.hidden = NO;
                
                self.tableView.hidden = YES;
                
                if ( self.itemType == KEY_TYPE_SERVICE ) {
                    
                     self.m_emptylabel.text = @"您还未购买过商品";
                    
                    [self.m_typeBtn setTitle:@"去购买" forState:UIControlStateNormal];
                    
                }else if ( self.itemType == KEY_TYPE_ACTIVITY ){
                    
                   self.m_emptylabel.text = @"您还未参加过活动";
                    
                    [self.m_typeBtn setTitle:@"去报名" forState:UIControlStateNormal];

                    
                }else if( self.itemType == KEY_TYPE_BUY ){
                    
                   self.m_emptylabel.text = @"您还未抢购过商品";
                    
                    [self.m_typeBtn setTitle:@"去抢购" forState:UIControlStateNormal];

                    
                }else{
                    
                    self.m_emptylabel.text = @"您还没有其他KEY";
                    
                    [self.m_typeBtn setTitle:@"去参与" forState:UIControlStateNormal];

                    
                }
                
            }
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        self.tableView.pullLastRefreshDate = [NSDate date];
        self.tableView.pullTableIsRefreshing = NO;
        //self.tableView.pullTableIsLoadingMore = NO;
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        self.tableView.pullTableIsRefreshing = NO;
        //self.tableView.pullTableIsLoadingMore = NO;
    }];
    
}


-(void)DidSavePlist
{

//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *finalPath = [documentDirectory stringByAppendingPathComponent:@"myKeyList.plist"];

    NSLog(@"%@",self.keyItems);
    
    // 把字典中的数据写入到文件中
    [self.keyItems writeToFile:finalPath atomically:YES];
    
}





-(IBAction)changeType:(id)sender {

    [self.btnServiceKey setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.btnServiceKey setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnActivityKey setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.btnActivityKey setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.m_buyKey setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.m_buyKey setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.btnOtherKey setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.btnOtherKey setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    if (sender == self.btnServiceKey) {
        
        self.btnServiceKey.userInteractionEnabled = NO;
        self.btnActivityKey.userInteractionEnabled = YES;
        self.m_buyKey.userInteractionEnabled = YES;
        self.btnOtherKey.userInteractionEnabled = YES;
        
        
        [self.btnServiceKey setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        [self.btnServiceKey setTitleColor:[CommonUtil selectTabBarTitleColor] forState:UIControlStateNormal];
        self.itemType = KEY_TYPE_SERVICE;
    }
    if (sender == self.btnActivityKey) {
        
        self.btnServiceKey.userInteractionEnabled = YES;
        self.btnActivityKey.userInteractionEnabled = NO;
        self.m_buyKey.userInteractionEnabled = YES;
        self.btnOtherKey.userInteractionEnabled = YES;

        [self.btnActivityKey setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        [self.btnActivityKey setTitleColor:[CommonUtil selectTabBarTitleColor] forState:UIControlStateNormal];
        self.itemType = KEY_TYPE_ACTIVITY;
    }
    
    if (sender == self.m_buyKey) {
        
        self.btnServiceKey.userInteractionEnabled = YES;
        self.btnActivityKey.userInteractionEnabled = YES;
        self.m_buyKey.userInteractionEnabled = NO;
        self.btnOtherKey.userInteractionEnabled = YES;

        [self.m_buyKey setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        [self.m_buyKey setTitleColor:[CommonUtil selectTabBarTitleColor] forState:UIControlStateNormal];
        self.itemType = KEY_TYPE_BUY;
    }
    
    if (sender == self.btnOtherKey) {
        
        self.btnServiceKey.userInteractionEnabled = YES;
        self.btnActivityKey.userInteractionEnabled = YES;
        self.m_buyKey.userInteractionEnabled = YES;
        self.btnOtherKey.userInteractionEnabled = NO;
        
        [self.btnOtherKey setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateNormal];
        [self.btnOtherKey setTitleColor:[CommonUtil selectTabBarTitleColor] forState:UIControlStateNormal];
        self.itemType = KEY_TYPE_OTHER;
    }
    
    
    // 读取存在NSUserDefault里面的数组-先从保存的NSUserDefault里面读取数据，然后再请求网络数据进行刷新
    NSData *saveMenulistDaate = [CommonUtil getValueByKey:[NSString stringWithFormat:@"%@_myKeyList_%@",[CommonUtil getValueByKey:MEMBER_ID],self.itemType]];
    
    NSLog(@"type = %@",[NSString stringWithFormat:@"%@_myKeyList_%@",[CommonUtil getValueByKey:MEMBER_ID],self.itemType]);
    
    self.keyItems = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:saveMenulistDaate];
    
    NSLog(@"key Iten = %@",self.keyItems);
    
    [self.tableView reloadData];
    

    [self loadData];

    
}

- (IBAction)gotoShopping:(id)sender {
    
    // 去购买
    Appdelegate.isSelectgoShopping = YES;
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

/*
 -(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
 return 1;
 }
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.keyItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    //初始化cell并指定其类型，也可自定义cell
    MyKeyCell *cell = (MyKeyCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyKeyCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 添加分割线
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 99, WindowSizeWidth, 1)];
        
        imgV.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
        
        [cell addSubview:imgV];
        
    }
    
    if ( self.keyItems.count != 0 ) {
        
        NSUInteger row = [indexPath row];
        NSDictionary *item = [self.keyItems objectAtIndex:row];
        [cell setValue:item];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    
    
    NSLog(@"itemType = %@",self.itemType);
    
    NSUInteger row = [indexPath row];
    NSDictionary *item = [self.keyItems objectAtIndex:row];
  
    if ( self.itemType == KEY_TYPE_OTHER ) {
        // 进入其他KEY值的详情
        Other_keyDetailViewController *VC = [[Other_keyDetailViewController alloc]initWithNibName:@"Other_keyDetailViewController" bundle:nil];
        VC.item = item;
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        // 普通的key值详情
        MyKeyDetailViewController *viewController = [[MyKeyDetailViewController alloc] initWithNibName:@"MyKeyDetailViewController" bundle:nil];
        viewController.item = item;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    [self performSelector:@selector(loadData) withObject:nil];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    [self performSelector:@selector(loadData) withObject:nil];
}

- (void)viewDidUnload {
    [self setM_buyKey:nil];
    [super viewDidUnload];
}
@end

