//
//  QuanquanViewController.m
//  HuiHui
//
//  Created by mac on 15-2-11.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "QuanquanViewController.h"

#import "HHCouponCell.h"

#import "HHQuanDetailViewController.h"

@interface QuanquanViewController ()

@property (weak, nonatomic) IBOutlet PullTableView *m_tableView;

@property (weak, nonatomic) IBOutlet UIControl *m_alphaView;

@property (weak, nonatomic) IBOutlet UIButton *m_fenleiBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_areaBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_priceBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_distanceBtn;

// 点击遮罩的view触发的事件
- (IBAction)alphaTapClicked:(id)sender;
// 类别按钮触发的事件
- (IBAction)fenleiClicked:(id)sender;
// 地区按钮触发的事件
- (IBAction)areaClicked:(id)sender;
// 价格按钮触发的事件
- (IBAction)priceClicked:(id)sender;
// 距离按钮触发的事件
- (IBAction)distanceClicked:(id)sender;

@end

@implementation QuanquanViewController

@synthesize m_couponList;

@synthesize RightArray;

@synthesize m_fenleiList;

@synthesize m_areaList;

@synthesize m_priceList;

@synthesize m_area1List;

@synthesize m_area2List;

@synthesize m_feileiId;

@synthesize m_priceId;

@synthesize m_distanceId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_couponList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_fenleiList = [[NSMutableArray alloc]initWithCapacity:0];

        m_areaList = [[NSMutableArray alloc]initWithCapacity:0];

        m_area1List = [[NSMutableArray alloc]initWithCapacity:0];

        m_area2List = [[NSMutableArray alloc]initWithCapacity:0];

        m_priceList = [[NSMutableArray alloc]initWithCapacity:0];

        RightArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        dbhelp = [[DBHelper alloc] init];

//        [self.m_fenleiList addObject:@"全部分类"];
//        [self.m_fenleiList addObject:@"美食"];
//        [self.m_fenleiList addObject:@"电影"];
//        [self.m_fenleiList addObject:@"酒店"];
//        [self.m_fenleiList addObject:@"丽人"];
        
//        [self.m_areaList addObject:@"全城"];
//        [self.m_areaList addObject:@"苏州"];
//        [self.m_areaList addObject:@"上海"];
//        [self.m_areaList addObject:@"北京"];
        
//        [self.m_priceList addObject:@"0-99"];
//        [self.m_priceList addObject:@"100-299"];
//        [self.m_priceList addObject:@"300-499"];
//        [self.m_priceList addObject:@"500-1000"];
//        [self.m_priceList addObject:@"1000以上"];

//        [self.RightArray addObject:@"1公里"];
//        [self.RightArray addObject:@"2公里"];
//        [self.RightArray addObject:@"10公里"];
//        [self.RightArray addObject:@"30公里"];
        
        
        m_pageIndex = 1;

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"券券总动员"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"我的券券" action:@selector(myCouponClicked)];
    
    //默认不下拉
    fenleiOpened = NO;
    areaOpened = NO;
    areaOpened1 = NO;
    areaOpened2 = NO;
    priceOpened = NO;
    rightOpened = NO;
    
    
    // 赋值地区数组
    self.m_areaList = [dbhelp queryCity];
    
    [self.m_areaBtn setTitle:@"全城" forState:UIControlStateNormal];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"全城",@"name",@"",@"code", nil];
    
    [self.m_areaList insertObject:dic atIndex:0];
    
    NSLog(@"areaList = %@", self.m_areaList);
    
    // 默认赋值为空
    cityId = areaId = districtId = @"";

    self.m_feileiId = self.m_priceId = self.m_distanceId = @"";
    
    // 请求券券分类类别的数据
    [self quanquanCategoryRequest];
    
    // 设置遮罩的view的透明度
    self.m_alphaView.alpha = 0;
    
    // 设置代理
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_tableView setPullDelegate:self];
    self.m_tableView.pullBackgroundColor = [UIColor whiteColor];
    self.m_tableView.useRefreshView = YES;
    self.m_tableView.useLoadingMoreView = YES;
    
    
    // 请求圈圈列表数据
    [self quanquanRequestSubmit];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    fenleiOpened = NO;
    areaOpened = NO;
    areaOpened1 = NO;
    areaOpened2 = NO;
    priceOpened = NO;
    rightOpened = NO;
    
    self.m_fenleiTableView.hidden = YES;
    self.m_areaTableView.hidden = YES;
    self.m_area1TableView.hidden = YES;
    self.m_area2TableView.hidden = YES;
    self.m_priceTableView.hidden = YES;
    self.m_distanceTableView.hidden = YES;
    
    CGRect frame1 = self.m_fenleiTableView.frame;
    frame1 = CGRectMake(0, 40, 320, 0);
    [self.m_fenleiTableView setFrame:frame1];
    
    
    CGRect frame2 = self.m_areaTableView.frame;
    frame2 = CGRectMake(0, 40, 106, 0);
    [self.m_areaTableView setFrame:frame2];
    
    CGRect frame5 = self.m_area1TableView.frame;
    frame5 = CGRectMake(106, 40, 107, 0);
    [self.m_area1TableView setFrame:frame5];
    
    CGRect frame6 = self.m_area2TableView.frame;
    frame6 = CGRectMake(213, 40, 106, 0);
    [self.m_area2TableView setFrame:frame6];
    
    
    CGRect frame3 = self.m_priceTableView.frame;
    frame3 = CGRectMake(0, 40, 320, 0);
    [self.m_priceTableView setFrame:frame3];
    
    
    CGRect frame4 = self.m_distanceTableView.frame;
    frame4 = CGRectMake(0, 40, 320, 0);
    [self.m_distanceTableView setFrame:frame4];

    
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

- (void)myCouponClicked{
    // 进入我的券券
    
    
}

// 筛选按钮触发的事件
- (void)filterClicked{

    
    
}


- (void)citySelectarea
{
    
    NSMutableArray *areas = [dbhelp queryArea:cityId];
    
    [self loadcelldata2:areas];
    
}

- (void)areaSelectmerchant
{
    
    NSMutableArray *areas = [dbhelp queryMerchant:areaId];
    
    [self loadcelldatatwo2:areas];
}

- (void)loadcelldata2:(NSArray*)datalist
{
//    [self.LeftArrayID2 removeAllObjects];
    
    if (datalist == nil) {
        return;
    }
    
    // 先清空数据再重新赋值
    [self.m_area1List removeAllObjects];

    [self.m_area1List addObjectsFromArray:datalist];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"全部",@"name",@"",@"code", nil];
    
    [self.m_area1List insertObject:dic atIndex:0];
    
    
    // 初始化第二个地区的tableView
    [self areaDataTotableview1];
    
    [self.m_area1TableView reloadData];

    
//    [self.LeftArray2 addObject:@"全城"];
//    [self.LeftArrayID2 addObject:@""];
//    
//    for (NSDictionary *data in datalist)
//    {
//        [self.LeftArray2 addObject:[data objectForKey:@"name"]];
//        
//        [self.LeftArrayID2 addObject:[data objectForKey:@"code"]];
//    }
    
}

- (void)loadcelldatatwo2:(NSArray*)datalist
{
    
    if (datalist == nil) {
        return;
    }
    
    // 先清空数据再重新赋值
    [self.m_area2List removeAllObjects];

    [self.m_area2List addObjectsFromArray:datalist];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"全部",@"name",@"",@"code", nil];
    
    [self.m_area2List insertObject:dic atIndex:0];
    
    
    // 初始化第三个地区的tableView
    [self areaDataTotableview2];
    
    [self.m_area2TableView reloadData];

//    [self.MiddleArrayID2 removeAllObjects];
//    if (datalist == nil) {
//        return;
//    }
//    [self.MiddleArray2 addObject:@"全部"];
//    [self.MiddleArrayID2 addObject:@""];
//    for (NSDictionary *data in datalist)
//    {
//        [self.MiddleArray2 addObject:[data objectForKey:@"name"]];
//        
//        [self.MiddleArrayID2 addObject:[data objectForKey:@"code"]];
//    }
}

- (IBAction)distanceClicked:(id)sender {
    
    if (rightOpened) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.m_distanceTableView.frame;
            
            frame.size.height = 0;
            
//            [self.m_distanceTableView setFrame:CGRectMake(160, self.m_btnView.frame.origin.y - frame.size.height, frame.size.width, frame.size.height)];

            [self.m_distanceTableView setFrame:CGRectMake(0, 40 - frame.size.height, frame.size.width, frame.size.height)];

            
            self.m_alphaView.alpha = 0;
            
            
        } completion:^(BOOL finished){
            
            rightOpened = NO;
        }];
    }else{
        
        self.m_distanceTableView.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.m_distanceTableView.frame;
            
            int fr = self.RightArray.count * 44;
           
            if (fr > 300) {
                frame.size.height = 300;
            }else
            {
                frame.size.height = fr;
            }
            
//            [self.m_distanceTableView setFrame:CGRectMake(160, self.m_btnView.frame.origin.y - frame.size.height, frame.size.width, frame.size.height)];
            
            [self.m_distanceTableView setFrame:CGRectMake(0, 40, frame.size.width, frame.size.height)];
            
            self.m_alphaView.alpha = 0.3;
            
            
        } completion:^(BOOL finished){
            
            rightOpened = YES;
            
        }];
        
    }
    
}

//排序赋值
- (void) distanceDataTotableview
{
    
    [self.m_distanceTableView initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count = self.RightArray.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         RightCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RightCell"];
         
         if (!cell)
         {
             cell = [[[NSBundle mainBundle]loadNibNamed:@"RightCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         
         if ( self.RightArray.count != 0 ) {
             
             NSDictionary *dic = [self.RightArray objectAtIndex:indexPath.row];
             
             [cell.MctName setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"DistanceValue"]]];

         }
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         m_pageIndex = 1;
         
         NSDictionary *dic = [self.RightArray objectAtIndex:indexPath.row];
         
         [self.m_distanceBtn setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"DistanceValue"]] forState:UIControlStateNormal];

         self.m_distanceId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"DistancesID"]];
         
         [self alphaTapClicked:nil];
         
         
         // 请求数据
         [self quanquanRequestSubmit];
         
         
     }];
    
    [self.m_distanceTableView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.m_distanceTableView.layer setBorderWidth:0];
    
}

- (IBAction)alphaTapClicked:(id)sender {
    
//    self.m_alphaView.hidden = YES;
    
    fenleiOpened = YES;
    areaOpened = YES;
    areaOpened1 = YES;
    areaOpened2 = YES;
    priceOpened = YES;
    rightOpened = YES;
    
    [self fenleiClicked:nil];
    [self areaClicked:nil];
    [self priceClicked:nil];
    [self distanceClicked:nil];
    [self areaOpenBtn];
    [self areaOpenBtn2];
    
}

- (IBAction)fenleiClicked:(id)sender {
    
    
    if (fenleiOpened) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.m_fenleiTableView.frame;
            
            frame.size.height = 0;
            
            //            [self.m_distanceTableView setFrame:CGRectMake(160, self.m_btnView.frame.origin.y - frame.size.height, frame.size.width, frame.size.height)];
            
            [self.m_fenleiTableView setFrame:CGRectMake(0, 40 - frame.size.height, frame.size.width, frame.size.height)];
            
            
            self.m_alphaView.alpha = 0;
            
            
            
        } completion:^(BOOL finished){
            
            fenleiOpened = NO;
        }];
    }else{
        
        self.m_fenleiTableView.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.m_fenleiTableView.frame;
            
            int fr = self.m_fenleiList.count * 44;
            
            if (fr > 300) {
                frame.size.height = 300;
            }else
            {
                frame.size.height = fr;
            }
            
            //            [self.m_distanceTableView setFrame:CGRectMake(160, self.m_btnView.frame.origin.y - frame.size.height, frame.size.width, frame.size.height)];
            
            [self.m_fenleiTableView setFrame:CGRectMake(0, 40, frame.size.width, frame.size.height)];
            
            self.m_alphaView.alpha = 0.3;
            
        } completion:^(BOOL finished){
            
            fenleiOpened = YES;
            
        }];
        
    }
    
}

- (IBAction)areaClicked:(id)sender {
    
    if (areaOpened) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.m_areaTableView.frame;
            
            frame.size.height = 0;
            
            //            [self.m_distanceTableView setFrame:CGRectMake(160, self.m_btnView.frame.origin.y - frame.size.height, frame.size.width, frame.size.height)];
            
            [self.m_areaTableView setFrame:CGRectMake(0, 40 - frame.size.height, frame.size.width, frame.size.height)];
            
            
                        self.m_alphaView.alpha = 0;
            
//            self.m_alphaView.hidden = YES;
            
            
        } completion:^(BOOL finished){
            
            areaOpened = NO;
        }];
    }else{
        
        self.m_areaTableView.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.m_areaTableView.frame;
            
            int fr = self.m_areaList.count * 44;
            
            if (fr > 300) {
                frame.size.height = 300;
            }else
            {
                frame.size.height = fr;
            }
            
            //            [self.m_distanceTableView setFrame:CGRectMake(160, self.m_btnView.frame.origin.y - frame.size.height, frame.size.width, frame.size.height)];
            
            [self.m_areaTableView setFrame:CGRectMake(0, 40, frame.size.width, frame.size.height)];
            
            self.m_alphaView.alpha = 0.3;
            
            //默认打开上次二级
            if ([NeedOpenTwo2 isEqualToString:@"NeedOpenTwo"]) {
                
                areaOpened1 = NO;
                [self areaOpenBtn];
                
            }else if ([NeedOpenTwo2 isEqualToString:@"NeedOpenTwo2"]) {
                
                areaOpened1 = NO;
                [self areaOpenBtn];
                
                areaOpened2 = NO;
                [self areaOpenBtn2];
                
            }

            
            
        } completion:^(BOOL finished){
            
            areaOpened = YES;
            
        }];
        
    }

}

- (void)areaOpenBtn {
    
    if (areaOpened1) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.m_area1TableView.frame;
            
            frame.size.height = 0;
            
            [self.m_area1TableView setFrame:frame];
            
        } completion:^(BOOL finished){
            
            areaOpened1 = NO;
        }];
    }else{
        
        self.m_area1TableView.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.m_area1TableView.frame;
            
            
            int fr = self.m_area1List.count * 44;
            if (fr > 300) {
                frame.size.height = 300;
            }else
            {
                frame.size.height = fr;
            }
            [self.m_area1TableView setFrame:frame];
            
        } completion:^(BOOL finished){
            
            areaOpened1 = YES;
            
            
        }];
    }
    
}

- (void)areaOpenBtn2 {
    
    if (areaOpened2) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.m_area2TableView.frame;
            
            frame.size.height = 0;
            
            [self.m_area2TableView setFrame:frame];
            
        } completion:^(BOOL finished){
            
            areaOpened2 = NO;
        }];
    }else{
        
        self.m_area2TableView.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.m_area2TableView.frame;
            
            
            int fr = self.m_area2List.count * 44;
            if (fr > 300) {
                frame.size.height = 300;
            }else
            {
                frame.size.height = fr;
            }
            [self.m_area2TableView setFrame:frame];
            
        } completion:^(BOOL finished){
            
            areaOpened2 = YES;
            
            
        }];
    }
    
}

- (IBAction)priceClicked:(id)sender {
    
    if (priceOpened) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.m_priceTableView.frame;
            
            frame.size.height = 0;
            
            //            [self.m_distanceTableView setFrame:CGRectMake(160, self.m_btnView.frame.origin.y - frame.size.height, frame.size.width, frame.size.height)];
            
            [self.m_priceTableView setFrame:CGRectMake(0, 40 - frame.size.height, frame.size.width, frame.size.height)];
            
            self.m_alphaView.alpha = 0;
            
            
        } completion:^(BOOL finished){
            
            priceOpened = NO;
        }];
    }else{
        
        self.m_priceTableView.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect frame = self.m_priceTableView.frame;
            
            int fr = self.m_priceList.count * 44;
            
            if (fr > 300) {
                frame.size.height = 300;
            }else
            {
                frame.size.height = fr;
            }
            
            
            [self.m_priceTableView setFrame:CGRectMake(0, 40, frame.size.width, frame.size.height)];

            self.m_alphaView.alpha = 0.3;
            
            
        } completion:^(BOOL finished){
            
            priceOpened = YES;
            
        }];
        
    }

}

// 分类tableView赋值
- (void) fenleiDataTotableview
{
    
    [self.m_fenleiTableView initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count = self.m_fenleiList.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         RightCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RightCell"];
         
         if (!cell)
         {
             cell = [[[NSBundle mainBundle]loadNibNamed:@"RightCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         
         if ( self.m_fenleiList.count != 0 ) {
             
             NSDictionary *dic = [self.m_fenleiList objectAtIndex:indexPath.row];
             
             [cell.MctName setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"TypeName"]]];

         }
         
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         RightCell *cell = (RightCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         //         [self.m_paixuBtn setTitle:cell.MctName.text forState:UIControlStateNormal];
         //
         //         pageIndex=1;
         //
         //         m_pageIndex = 1;
         
         
         NSDictionary *dic = [self.m_fenleiList objectAtIndex:indexPath.row];

         NSLog(@"TypesID = %@",[dic objectForKey:@"TypesID"]);
         
         [self.m_fenleiBtn setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"TypeName"]] forState:UIControlStateNormal];
         
         self.m_feileiId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"TypesID"]];
        
         
         [self alphaTapClicked:nil];
         
         
         // 请求数据
         [self quanquanRequestSubmit];
         
     }];
    
    [self.m_fenleiTableView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.m_fenleiTableView.layer setBorderWidth:0];
    
}

//地区一赋值
-(void) areaDataTotableview
{
    
    [self.m_areaTableView initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count = self.m_areaList.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         LeftCell *cell=[tableView dequeueReusableCellWithIdentifier:@"LeftCell"];
         
         
         if (!cell)
             
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"LeftCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
             
             if (indexPath.row == 0) {
             }else{
                 cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
             }
         }
        
         if ( self.m_areaList.count != 0 ) {
             
             NSDictionary *dic = [self.m_areaList objectAtIndex:indexPath.row];
             
             [cell.MctName setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
             
         }

         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         //        LeftCell *cell=(LeftCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         m_pageIndex = 1;
         
         if (indexPath.row == 0) {
             
             NeedOpenTwo2 = @"";
             
             [self.m_areaBtn setTitle:@"全城" forState:UIControlStateNormal];
             
            cityId = areaId = districtId =  @"";
             
             
            [self alphaTapClicked:nil];
             
             // 请求数据
             [self quanquanRequestSubmit];
             
             
         }else{
             
             NeedOpenTwo2 = @"NeedOpenTwo";
             
             NSDictionary *dic = [self.m_areaList objectAtIndex:indexPath.row];
             
             cityId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
             
             // btn赋值
             [self.m_areaBtn setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
             
             [self citySelectarea];
        
             areaOpened1 = NO;
             
             [self areaOpenBtn];
             
         }
         
     }];
    
    [self.m_areaTableView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.m_areaTableView.layer setBorderWidth:0];
    
}


-(void) areaDataTotableview1
{
    
    [self.m_area1TableView initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count = self.m_area1List.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         MiddleCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MiddleCell"];
         
         if (!cell)
             
         {
             cell=[[[NSBundle mainBundle]loadNibNamed:@"MiddleCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
             
             if (indexPath.row == 0) {
             }else{
                 cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
             }
         }
         
         if ( self.m_area1List.count != 0 ) {
             
             NSDictionary *dic = [self.m_area1List objectAtIndex:indexPath.row];
             
             [cell.MctName setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
             
         }
         
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         //        LeftCell *cell=(LeftCell*)[tableView cellForRowAtIndexPath:indexPath];
       
         m_pageIndex = 1;
         
         if (indexPath.row == 0) {
             
             NeedOpenTwo2 = @"NeedOpenTwo";
             
//             [self.m_areaBtn setTitle:@"全部" forState:UIControlStateNormal];
             
             // 选择了区的全部时，显示为城市的名称
             for (int i = 0; i < self.m_areaList.count; i++) {
               
                 NSDictionary *dic = [self.m_areaList objectAtIndex:i];
                 
                 if ([cityId isEqualToString:[dic objectForKey:@"code"]]) {
                     
                     [self.m_areaBtn setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
                     
                     break;
                 }
                 
                 areaId = districtId = @"";
                 
                 [self alphaTapClicked:nil];

                 // 请求数据
                 [self quanquanRequestSubmit];
                 
             }
             
         }else{
             
             NeedOpenTwo2 = @"NeedOpenTwo2";

             
             NSDictionary *dic = [self.m_area1List objectAtIndex:indexPath.row];
             
             areaId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
             
             // btn赋值
             [self.m_areaBtn setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
             
             [self areaSelectmerchant];
             
             areaOpened2 = NO;
             
             [self areaOpenBtn2];
             
         }
         
     }];
    
    [self.m_area1TableView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.m_area1TableView.layer setBorderWidth:0];
    
}

// 地区tableView赋值
- (void) areaDataTotableview2
{
    
    [self.m_area2TableView initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count = self.m_area2List.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         MiddleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MiddleCell"];
         
         if (!cell)
         {
             cell = [[[NSBundle mainBundle]loadNibNamed:@"MiddleCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         
         if ( self.m_area2List.count != 0 ) {
             
             NSDictionary *dic = [self.m_area2List objectAtIndex:indexPath.row];
             
             [cell.MctName setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];

         }
         
         
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
      
         m_pageIndex = 1;

         if (indexPath.row == 0) {
             
             // 选择了区的全部时，显示为城市的名称
             for (int i = 0; i < self.m_area1List.count; i++) {
                 
                 NSDictionary *dic = [self.m_area1List objectAtIndex:i];
                 
                 if ([areaId isEqualToString:[dic objectForKey:@"code"]]) {
                     
                     [self.m_areaBtn setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
                     
                     break;
                 }
                 
                 districtId = @"";
                 
             }
             
             [self alphaTapClicked:nil];
             
         }else{
             
             NSDictionary *dic = [self.m_area2List objectAtIndex:indexPath.row];
             
             districtId  = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
             
             [self.m_areaBtn setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
             
             
             NSLog(@"districtId = %@",districtId);
             
             
             [self alphaTapClicked:nil];
             
         }
         
         // 请求数据
         [self quanquanRequestSubmit];

     }];
    
    [self.m_area2TableView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.m_area2TableView.layer setBorderWidth:0];
    
}

#pragma mark - NetWork

// 请求券券分类的数据
- (void)quanquanCategoryRequest{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    [httpClient request:@"VouTypePriceDistanceList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        NSLog(@"json = %@",json);
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            // 赋值
            self.m_fenleiList = [json valueForKey:@"VouTypeList"];
            
            self.m_priceList = [json valueForKey:@"VouPriceList"];
            
            self.RightArray = [json valueForKey:@"VouDistanceList"];
            
//            // 在数组前面加上全部的类型
//            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"全部",@"TypeName",@"",@"TypesID", nil];
//           
//            NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"全部",@"PriceValue",@"",@"PricesID", nil];
//            
//            NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"全部",@"DistanceValue",@"",@"DistancesID", nil];
//            
//            
//            if ( self.m_fenleiList.count != 0 ) {
//                
//                [self.m_fenleiList insertObject:dic atIndex:0];
//            }
//            
//            if ( self.m_priceList.count != 0 ) {
//                
//                [self.m_priceList insertObject:dic1 atIndex:0];
//            }
//            
//            if ( self.RightArray.count != 0 ) {
//                
//                [self.RightArray insertObject:dic2 atIndex:0];
//            }
            
            // 加载刷新tableView
            [self fenleiDataTotableview];
            [self areaDataTotableview];
            [self priceDataTotableview];
            
            [self distanceDataTotableview];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
    
}

- (void)quanquanRequestSubmit{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSLog(@"m_feileiId = %@,m_priceId = %@,m_distanceId = %@",self.m_feileiId,self.m_priceId,self.m_distanceId);
    
    
    // 获取memberId
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];

    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,@"memberId",
                           key,@"key",
                           [NSString stringWithFormat:@"%@",cityId],@"cityId",
                           [NSString stringWithFormat:@"%@",areaId],@"areaId",
                           [NSString stringWithFormat:@"%@",districtId],@"districtId",
                           [NSString stringWithFormat:@"%@",self.m_feileiId],@"typeId",
                           [NSString stringWithFormat:@"%@",self.m_priceId],@"priceId",
                           [NSString stringWithFormat:@"%@",self.m_distanceId],@"distanceId",
                           @"",@"mapX",
                           @"",@"mapY",
                           [NSString stringWithFormat:@"%i",m_pageIndex],@"pageIndex",
                           
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    NSLog(@"params = %@",param);
    
    [httpClient request:@"VocherList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        NSLog(@"json = %@",json);
        
        // status 0表示有数据 其他表示错误
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if ( success ) {
            
            [SVProgressHUD dismiss];
            
            NSMutableArray *couponList = [json valueForKey:@"VoucherList"];
            
            if (m_pageIndex == 1) {
                
                if (couponList == nil || couponList.count == 0) {
                    
                    [self.m_couponList removeAllObjects];
                    
                    [self.m_tableView reloadData];
                    
                    self.m_tableView.hidden = YES;
                    
                    return;
                    
                } else {
                    
                    self.m_couponList = couponList;
                    
                    
                    self.m_tableView.hidden = NO;
                    
                }
            } else {
                
                self.m_tableView.hidden = NO;
                
                if (couponList == nil || couponList.count == 0) {
                    
                    m_pageIndex--;
                    
                } else {
                    
                    [self.m_couponList addObjectsFromArray:couponList];
                }
            }
            
            [self.m_tableView reloadData];
            
        } else {
            
            if (m_pageIndex > 1) {
                m_pageIndex--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        self.m_tableView.pullLastRefreshDate = [NSDate date];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
        
    } failure:^(NSError *error) {
        if (m_pageIndex > 1) {
            m_pageIndex--;
        }
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        self.m_tableView.pullTableIsRefreshing = NO;
        self.m_tableView.pullTableIsLoadingMore = NO;
    }];
    
}


// 价格赋值
- (void) priceDataTotableview
{
    
    [self.m_priceTableView initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section)
     {
         NSInteger count = self.m_priceList.count;
         return count;
         
     } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         RightCell *cell=[tableView dequeueReusableCellWithIdentifier:@"RightCell"];
         
         if (!cell)
         {
             cell = [[[NSBundle mainBundle]loadNibNamed:@"RightCell" owner:self options:nil]objectAtIndex:0];
             [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
         }
         
         if ( self.m_priceList.count != 0 ) {
             
             NSDictionary *dic = [self.m_priceList objectAtIndex:indexPath.row];
             
             NSLog(@"PriceValue = %@",[dic objectForKey:@"PriceValue"]);
             
             [cell.MctName setText:[NSString stringWithFormat:@"%@",[dic objectForKey:@"PriceValue"]]];

         }
         return cell;
     } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath)
     {
         RightCell *cell = (RightCell*)[tableView cellForRowAtIndexPath:indexPath];
         
         //         [self.m_paixuBtn setTitle:cell.MctName.text forState:UIControlStateNormal];
         //
         //         pageIndex=1;
         //
         //         m_pageIndex = 1;
         
         
         NSDictionary *dic = [self.m_priceList objectAtIndex:indexPath.row];

         NSLog(@"PricesID = %@",[dic objectForKey:@"PricesID"]);
         
         [self.m_priceBtn setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"PriceValue"]] forState:UIControlStateNormal];
         
         self.m_priceId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"PricesID"]];

         [self alphaTapClicked:nil];
         
         // 请求数据
         [self quanquanRequestSubmit];
         
     }];
    
    [self.m_priceTableView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.m_priceTableView.layer setBorderWidth:0];
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.m_couponList.count % 2 == 0 ? [self.m_couponList count] / 2 : [self.m_couponList count] / 2 + 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"HHCouponCellIdentifier";
    
    HHCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HHCouponCell" owner:self options:nil];
        
        cell = (HHCouponCell *)[nib objectAtIndex:0];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    cell.m_leftView.hidden = NO;
    cell.m_rightView.hidden = NO;
    
    // 设置图片圆角
    cell.m_leftView.m_imagV.layer.masksToBounds = YES;
    cell.m_leftView.m_imagV.layer.cornerRadius = 10.0f;
    
    cell.m_rightView.m_imagV.layer.masksToBounds = YES;
    cell.m_rightView.m_imagV.layer.cornerRadius = 10.0f;
    
    if ( self.m_couponList.count != 0 ) {
        
        if (indexPath.row * 2 + 0 <= [self.m_couponList count] - 1 ) {
            
            NSDictionary *dic = [self.m_couponList objectAtIndex:indexPath.row * 2 + 0];
            
            NSString *imagePath = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ImgUrl"]];
            
            [cell setImageLeft:imagePath];
            
            [cell.m_leftView.m_imagV setContentMode:UIViewContentModeScaleAspectFit];
            
            if (indexPath.row * 2 + 1 > [self.m_couponList count] - 1) {
                
                cell.m_rightView.hidden = YES;
                
            }
            
            cell.m_leftView.tag = indexPath.row * 2 + 0;
            cell.m_leftView.m_btn.tag = indexPath.row * 2 + 0;
            
            // 添加按钮点击事件
            [cell.m_leftView.m_btn addTarget:self action:@selector(couponBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            // 赋值
            cell.m_leftView.m_mctName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Title"]];
            
            cell.m_leftView.m_subTitle.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Description"]];
            
            cell.m_leftView.m_sPrice.text = [NSString stringWithFormat:@"最高可省%@",[dic objectForKey:@"Price"]];
            
            NSLog(@"%@",[dic objectForKey:@"Description"]);

            
        }
        
        
        if (indexPath.row * 2 + 1 <=  [self.m_couponList count] - 1) {
            
            NSDictionary *dic = [self.m_couponList objectAtIndex:indexPath.row * 2 + 1];
            
            NSString *imagePath = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ImgUrl"]];
            
            [cell setImageRight:imagePath];
            
            [cell.m_rightView.m_imagV setContentMode:UIViewContentModeScaleAspectFit];
            
            cell.m_rightView.tag = indexPath.row * 2 + 1;
            cell.m_rightView.m_btn.tag = indexPath.row * 2 + 1;
            
            // 添加按钮点击事件
            [cell.m_rightView.m_btn addTarget:self action:@selector(couponBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            
            // 赋值
            cell.m_rightView.m_mctName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Title"]];
            
            cell.m_rightView.m_subTitle.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Description"]];
            
            cell.m_rightView.m_sPrice.text = [NSString stringWithFormat:@"最高可省%@",[dic objectForKey:@"Price"]];
            
        }

    }
    
    
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 170.0f;
    
}

- (void)couponBtnClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSDictionary *dic = [self.m_couponList objectAtIndex:btn.tag];
    
    // 进入券券详情的页面
    HHQuanDetailViewController *VC = [[HHQuanDetailViewController alloc]initWithNibName:@"HHQuanDetailViewController" bundle:nil];
    VC.m_counponId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"VouchersID"]];
    [self.navigationController pushViewController:VC animated:YES];
    
    
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    m_pageIndex = 1;
    [self performSelector:@selector(quanquanRequestSubmit) withObject:nil];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    m_pageIndex++;
    [self performSelector:@selector(quanquanRequestSubmit) withObject:nil];
}


@end
