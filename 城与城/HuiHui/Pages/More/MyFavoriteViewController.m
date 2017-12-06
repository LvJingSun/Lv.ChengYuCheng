//
//  MyFavoriteViewController.m
//  HuiHui
//
//  Created by mac on 14-9-10.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "MyFavoriteViewController.h"

#import "LocationCell.h"

#import "FavoriteCell.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "ProductDetailViewController.h"

#import "Chat_MerViewController.h"


@interface MyFavoriteViewController ()

@property (weak, nonatomic) IBOutlet UIButton *m_leftBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_rightBtn;

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

@property (weak, nonatomic) IBOutlet PullTableView *m_merchantTableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

- (IBAction)btnClicked:(id)sender;

- (void)setLeft:(BOOL)isLeft withRight:(BOOL)isRight;


@end

@implementation MyFavoriteViewController

@synthesize m_favoriteList;
@synthesize m_merchantList;
@synthesize m_typeString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_favoriteList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_merchantList = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"我的收藏"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    // 默认隐藏控件
    self.m_emptyLabel.hidden = YES;
  
    
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView = NO;
    
    [self.m_merchantTableView setDelegate:self];
    [self.m_merchantTableView setDataSource:self];
    [self.m_merchantTableView setPullDelegate:self];
    self.m_merchantTableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_merchantTableView.useRefreshView = YES;
    self.m_merchantTableView.useLoadingMoreView = NO;
    
    
    
    // 默认选中第一个
    [self setLeft:YES withRight:NO];
    
    
    // 默认收藏状态
    m_viewType = FavoritesReadOnly;
    
    [self loadButtonItemByType:m_viewType];
    
   

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
    
    [self.m_tableView setEditing:NO];
    
    [self.m_merchantTableView setEditing:NO];
    
    [self goBack];
}

- (IBAction)btnClicked:(id)sender {
   
    UIButton *btn = (UIButton *)sender;
    if ( btn.tag == 100 ) {
        
        [self setLeft:YES withRight:NO];
        
    }else{
        
        [self setLeft:NO withRight:YES];
        
    }
}


- (void)setLeft:(BOOL)isLeft withRight:(BOOL)isRight{
    
    self.m_leftBtn.selected = isLeft;
    
    self.m_rightBtn.selected = isRight;
    
    // 如果是编辑状态的话则修改为不编辑的状态
    if ( m_viewType == FavoritesEdit ) {
        
        [self.m_tableView setEditing:NO];
        
        [self.m_merchantTableView setEditing:NO];
        
        m_viewType = FavoritesReadOnly;
        
        [self loadButtonItemByType:m_viewType];
        
    }
    
    
    if ( isLeft ) {
        
        self.m_leftBtn.userInteractionEnabled = NO;
        self.m_rightBtn.userInteractionEnabled = YES;
        
        self.m_typeString = @"1";
        
        if ( self.m_favoriteList.count == 0 ) {
            
            // 请求数据
            [self favoriteSubmit];
            
        }else{
            self.m_emptyLabel.hidden = YES;
            self.m_tableView.hidden = NO;
            self.m_merchantTableView.hidden = YES;
        }
        
    }else{
        
        self.m_leftBtn.userInteractionEnabled = YES;
        self.m_rightBtn.userInteractionEnabled = NO;
        
        self.m_typeString = @"2";
        
        // 如果数组为空的话则请求服务端的数据
        if ( self.m_merchantList.count == 0 ) {
            
            // 请求数据
            [self favoriteMerchantSubmit];
            
        }else{
            
            self.m_emptyLabel.hidden = YES;
            self.m_tableView.hidden = YES;
            self.m_merchantTableView.hidden = NO;
        }
        
    }
    
}

// 加载导航栏上的button
- (void)loadButtonItemByType:(FavoritesViewType)aViewType{
    
    if ( aViewType == FavoritesEdit ) {
      
        [self setRightButtonWithTitle:@"完成" action:@selector(EnterEditorModel)];
   
    }else if ( aViewType == FavoritesReadOnly ) {
       
        [self setRightButtonWithTitle:@"编辑" action:@selector(EnterEditorModel)];
   
    }
}

// 两种状态的切换
- (void)EnterEditorModel{
    
    NSLog(@"lvjing5");
    
    if ( m_viewType == FavoritesReadOnly ) {
        
        m_viewType = FavoritesEdit;

        if ( [self.m_typeString isEqualToString:@"1"] ) {
            
            [self.m_tableView setEditing:YES];

        }else{
            
            [self.m_merchantTableView setEditing:YES];
        }
       
        
        
    }else {
        
        m_viewType = FavoritesReadOnly;
   
        if ( [self.m_typeString isEqualToString:@"1"] ) {

            [self.m_tableView setEditing:NO];

        }else{
            
            [self.m_merchantTableView setEditing:NO];

        }
    }
    
    [self loadButtonItemByType:m_viewType];

}

// 收藏的商品数据请求
- (void)favoriteSubmit{
    
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
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"FavSvcList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
           
//            NSString *msg = [json valueForKey:@"msg"];
          
//            [SVProgressHUD showSuccessWithStatus:msg];
            
            [SVProgressHUD dismiss];
            // 删除数组里的值
            if ( self.m_favoriteList.count != 0 ) {
                
                [self.m_favoriteList removeAllObjects];
            }
            
            self.m_favoriteList = [json valueForKey:@"serviceList"];
            // 隐藏收藏商户所在的view
            self.m_merchantTableView.hidden = YES;
            
            if ( self.m_favoriteList.count != 0 ) {
                
                [self.m_tableView reloadData];
                
                self.m_emptyLabel.hidden = YES;
                
                self.m_tableView.hidden = NO;
           
            }else{
                
                self.m_emptyLabel.hidden = NO;
                
                self.m_tableView.hidden = YES;
                
                
                // 如果是编辑状态的话则修改为不编辑的状态
                if ( m_viewType == FavoritesEdit ) {
                    
                    [self.m_tableView setEditing:NO];
                    
                    [self.m_merchantTableView setEditing:NO];
                    
                    m_viewType = FavoritesReadOnly;
                    
                    [self loadButtonItemByType:m_viewType];
                    
                }
              
            }
         
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
        self.m_tableView.pullLastRefreshDate = [NSDate date];
        self.m_tableView.pullTableIsRefreshing = NO;
        
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        self.m_tableView.pullTableIsRefreshing = NO;
        
    }];

}

// 商户收藏的数据请求数据
- (void)favoriteMerchantSubmit{
    
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
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"FavMerchantShopList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
//            NSString *msg = [json valueForKey:@"msg"];
//            
//            [SVProgressHUD showSuccessWithStatus:msg];

            [SVProgressHUD dismiss];

            NSLog(@"json = %@",json);
            
            // 删除数组里的值
            if ( self.m_merchantList.count != 0 ) {
                
                [self.m_merchantList removeAllObjects];
            }
            
            self.m_merchantList = [json valueForKey:@"merchantShop"];
            
            // 隐藏收藏商品所在的view
            self.m_tableView.hidden = YES;

            if ( self.m_merchantList.count != 0 ) {
                
                [self.m_merchantTableView reloadData];
                
                self.m_emptyLabel.hidden = YES;
                
                self.m_merchantTableView.hidden = NO;
                
            }else{
                
                self.m_emptyLabel.hidden = NO;
                
                self.m_merchantTableView.hidden = YES;
                
                
                // 如果是编辑状态的话则修改为不编辑的状态
                if ( m_viewType == FavoritesEdit ) {
                    
                    [self.m_tableView setEditing:NO];
                    
                    [self.m_merchantTableView setEditing:NO];
                    
                    m_viewType = FavoritesReadOnly;
                    
                    [self loadButtonItemByType:m_viewType];
                    
                }
                
            }
            

            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
        self.m_merchantTableView.pullLastRefreshDate = [NSDate date];
        self.m_merchantTableView.pullTableIsRefreshing = NO;
        
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        self.m_merchantTableView.pullTableIsRefreshing = NO;

    }];
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ( tableView == self.m_tableView ) {
        
        return self.m_favoriteList.count;
        
    }else{
        
        return self.m_merchantList.count;
        
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( tableView == self.m_tableView ) {
        
        static NSString *cellIdentifier = @"LocationCellIdentifier";
        
        LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LocationCell" owner:self options:nil];
            
            cell = (LocationCell *)[nib objectAtIndex:0];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
        }
        
        if ( self.m_favoriteList.count != 0 ) {
            
            NSMutableDictionary *dic  = [self.m_favoriteList objectAtIndex:indexPath.row];
            
            // 设置图片
            [cell setImageView:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ServicePic"]]];
            // 设置cell上面的评分
            [cell setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Rank"]]];
            
            // 赋值
            cell.m_productName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceName"]];
            cell.m_infoLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Detail"]];
            cell.m_priceLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Price"]];
            cell.m_orignLabel.text = [NSString stringWithFormat:@"￥%@",[dic objectForKey:@"OriginalPrice"]];;
            
            // 计算label的大小坐标
            CGSize size = [cell.m_priceLabel.text sizeWithFont:[UIFont systemFontOfSize:18.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
            
            CGSize size1 = [cell.m_orignLabel.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
            
            
            cell.m_priceLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x, cell.m_priceLabel.frame.origin.y, size.width, 21);
            
            cell.m_orignLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x + size.width + 5, cell.m_orignLabel.frame.origin.y, size1.width + 2, 21);
            
            cell.m_lineLabel.frame = CGRectMake(cell.m_priceLabel.frame.origin.x + size.width + 7, cell.m_lineLabel.frame.origin.y, size1.width + 3, 1);
            
            cell.m_distanceLabel.hidden = YES;

        }
        
        return cell;

    }else{
        
        static NSString *cellIdentifier = @"FavoriteCellIdentifier";
        
        FavoriteCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FavoriteCell" owner:self options:nil];
            
            cell = (FavoriteCell *)[nib objectAtIndex:0];
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
        }
        
//        cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"merchant_list_bg.png"]];
        
        if ( self.m_merchantList.count != 0 ) {
            
            NSDictionary *dic = [self.m_merchantList objectAtIndex:indexPath.row];
            
            //赋值
            [cell setImageView:[NSString stringWithFormat:@"%@",[dic objectForKey:@"LogoSmlUrl"]]];
            
            cell.m_merchantName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ShopName"]];
            cell.m_phoneLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Phone"]];
            cell.m_timeLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"OpeningHours"]];
            cell.m_addressLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Address"]];

        }
        
        return cell;

    }
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 100.0f;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( tableView == self.m_tableView ) {
        
        if ( self.m_favoriteList.count != 0 ) {
            
            NSDictionary *dic = [self.m_favoriteList objectAtIndex:indexPath.row];
            
            // 将商品的图片保存起来用于立即购买页面的显示
            [CommonUtil addValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ServicePic"]] andKey:@"productImage"];
            
            // 点击进入商品详情
            ProductDetailViewController *VC = [[ProductDetailViewController alloc]initWithNibName:@"ProductDetailViewController" bundle:nil];
            
            VC.m_productId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceId"]];
            VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MerchantShopId"]];
            
            [self.navigationController pushViewController:VC animated:YES];
        }
    }else{
        
        if ( self.m_merchantList.count != 0 ) {
            
            NSMutableDictionary *dic = [self.m_merchantList objectAtIndex:indexPath.row];

//            Send_merchantViewController *VC = [[Send_merchantViewController alloc]initWithNibName:@"Send_merchantViewController" bundle:nil];
//            VC.m_items = dic;
//            VC.m_typeString = @"1";
//            VC.m_xiaoxiString = @"2";
//            [self.navigationController pushViewController:VC animated:YES];
            
            
            Chat_MerViewController *chatVC = [[Chat_MerViewController alloc]initWithChatter:nil isGroup:NO];
            chatVC.m_items = dic;
            [self.navigationController pushViewController:chatVC animated:YES];
            
        }
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;

}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return UITableViewCellEditingStyleDelete;

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        
        m_selectedIndex = indexPath.row;
        
        UIAlertView *deleAlert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"确定要删除?"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定", nil];
        deleAlert.tag = 1000;
        [deleAlert show];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"to delete:%d", indexPath.row);
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 1000 ) {
        if ( buttonIndex == 1 ) {
            
            NSLog(@"m_selectedIndex = %i",m_selectedIndex);

            NSLog(@"m_typeString = %@",self.m_typeString);
            
            if ( [self.m_typeString isEqualToString:@"1"] ) {
                
                NSDictionary *dic = [self.m_favoriteList objectAtIndex:m_selectedIndex];
                
                // 取消收藏商品请求数据
                [self cancelFavorite:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ServiceId"]]];
                
            }else if ( [self.m_typeString isEqualToString:@"2"] ){
                
                NSDictionary *dic = [self.m_merchantList objectAtIndex:m_selectedIndex];

                // 取消收藏商户请求数据
                [self cancelFavoriteMerchant:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MerchantShopId"]]];
                
                
            }else{
                
                
            }

        }
    }
    
    
}


#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
   
    // 请求数据
    if ( pullTableView == self.m_tableView ) {
        
        [self favoriteSubmit];
        
    }else{
        
        [self favoriteMerchantSubmit];
    }
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
   

}

- (void)cancelFavorite:(NSString *)aServiceId{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    //  optionType	0：取消；1：收藏； 商户ID默认：0
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [NSString stringWithFormat:@"%@",aServiceId],@"serviceId",
                           @"0",@"merchantId",
                           @"0",@"merchantShopId",
                           @"0",@"optionType",
                           nil];
    
    NSLog(@"param = %@",param);

    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"Favorites.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 请求数据重新刷新数据
            [self favoriteSubmit];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

// 取消商户收藏
- (void)cancelFavoriteMerchant:(NSString *)aShopId{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    //  optionType	0：取消；1：收藏； 商户ID默认：0
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           @"0",@"serviceId",
                           @"0",@"merchantId",
                           aShopId,@"merchantShopId",
                           @"0",@"optionType",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"Favorites.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
      
            // 请求数据重新刷新数据
            [self favoriteMerchantSubmit];
            
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
