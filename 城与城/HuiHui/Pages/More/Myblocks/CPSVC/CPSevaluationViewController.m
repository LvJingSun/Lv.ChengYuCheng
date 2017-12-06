//
//  CPSevaluationViewController.m
//  HuiHui
//
//  Created by fenghq on 15/9/22.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "CPSevaluationViewController.h"
#import "CPSTakeOrderTableViewCell.h"
#import "HCSStarRatingView.h"
#import "SegmentView.h"
#import "PullTableView.h"


@interface CPSevaluationViewController ()<PullTableViewDelegate,SegmentViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet PullTableView *S_tableview;
    NSMutableArray *ScoreListArray;
    NSInteger PageIndex;
    NSInteger ScoreType;//（0全部，1好评，2中评，3差评
    BOOL IsHaveDesc;
    
    NSString *AvgScore;//平均分
    NSString *Score;//商品
    NSString *WLScore;//物流
    
    NSString *AllCount;//全部
    NSString *HPCount;//好评
    NSString *ZPCount;//中评
    NSString *CPCount;//差评
    
    SegmentView *SegmentV;

}
// 存放请求数据的shopId
@property (nonatomic, strong) NSString                      *m_shopId;
@end

@implementation CPSevaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    S_tableview.delegate = self;
    S_tableview.dataSource = self;
    S_tableview.separatorStyle = NO;
    [S_tableview setPullDelegate:self];
    S_tableview.pullBackgroundColor = [UIColor whiteColor];
    S_tableview.useRefreshView = YES;
    S_tableview.useLoadingMoreView = YES;
    PageIndex=1;
    IsHaveDesc=NO;
    ScoreType=0;
    ScoreListArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    [self GetMerchantShopScore];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//上个界面传过来传赋值
- (void)setXBParamdic:(NSMutableDictionary *)XBParamdic
{
    _XBParamdic = XBParamdic;
    NSDictionary *dic = [[XBParamdic objectForKey:@"m_shopList"] objectAtIndex:0];
    self.m_shopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopID"]];
}

#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return ScoreListArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    static NSString *cellIdentifier = @"CPSTakeOrderTableViewCell4";
    CPSTakeOrderTableViewCell4 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CPSTakeOrderTableViewCell" owner:self options:nil];
        cell = (CPSTakeOrderTableViewCell4 *)[nib objectAtIndex:4];
    }
    cell.WLScore.text = [NSString stringWithFormat:@"%.1f",[WLScore floatValue]];
    cell.AvgScore.text = [NSString stringWithFormat:@"%.1f",[AvgScore floatValue]];
    cell.Score.text = [NSString stringWithFormat:@"%.1f",[Score floatValue]];
    if (IsHaveDesc) {
        [cell.ScoreTypeBtn setImage:[UIImage imageNamed:@"login_gouxuan1.png"] forState:UIControlStateNormal];
    }else{
        [cell.ScoreTypeBtn setImage:[UIImage imageNamed:@"login_gouxuan2.png"] forState:UIControlStateNormal];
    }
    [cell.ScoreTypeBtn addTarget:self action:@selector(changeIsHaveDesc) forControlEvents:UIControlEventTouchUpInside];

    SegmentV = [[SegmentView alloc]initWithTitles:@[[NSString stringWithFormat:@"全部(%@)",AllCount],[NSString stringWithFormat:@"好评(%@)",HPCount],[NSString stringWithFormat:@"中评(%@)",ZPCount],[NSString stringWithFormat:@"差评(%@)",CPCount]] withFram:CGRectMake(5, 2, WindowSizeWidth-10, 35) withBtnWidth:kBtnWidth andSelected:YES];
    SegmentV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    SegmentV.delegate = self;
    [SegmentV segemtBtnChange:(int)ScoreType];
    [cell.segmentView addSubview:SegmentV];
    SegmentV.layer.cornerRadius = 2;  // 将图层的边框设置为圆脚
    SegmentV.layer.masksToBounds = YES; // 隐藏边界
    SegmentV.layer.borderWidth = 1;  // 给图层添加一个有色边框
    SegmentV.layer.borderColor = RGBA(213, 213, 213, 1).CGColor;
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *cellIdentifier = @"CPSTakeOrderTableViewCell1";
    CPSTakeOrderTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CPSTakeOrderTableViewCell" owner:self options:nil];
        cell = (CPSTakeOrderTableViewCell1 *)[nib objectAtIndex:1];
    }
    
    if (ScoreListArray.count) {
    
        NSDictionary *dic = [ScoreListArray objectAtIndex:indexPath.row];
        [cell setMactLogImagePath:[NSString stringWithFormat:@"%@",[dic objectForKey:@"PhotoMidUrl"]]];
        cell.ScoreWLScore.text = [NSString stringWithFormat:@"菜品:%.1f|送货%.1f",[[NSString stringWithFormat:@"%@",[dic objectForKey:@"Score"]] floatValue],[[NSString stringWithFormat:@"%@",[dic objectForKey:@"WLScore"]] floatValue]];
        cell.NickName.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"NickName"]];
        cell.CreateDate.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"CreateDate"]];
        cell.Description.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Description"]];
        
        cell.Description.frame = CGRectMake(cell.Description.frame.origin.x, cell.Description.frame.origin.y, cell.Description.frame.size.width, [self heightForBubbleWithObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Description"]] andTextWidth:247]>30?[self heightForBubbleWithObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Description"]] andTextWidth:247]:30.f);
        
    }
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 170.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSDictionary *dic = [ScoreListArray objectAtIndex:indexPath.row];
    
    return [self heightForBubbleWithObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Description"]] andTextWidth:247]>30?71+[self heightForBubbleWithObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"Description"]] andTextWidth:247]:101.f;    

}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma segmentView代理
- (void)segmentView:(SegmentView *)segmentView didSelectedSegmentAtIndex:(int)index
{
    ScoreType = index;
    [self GetMerchantShopScore];
}


#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView {
    PageIndex=1;
    [self performSelector:@selector(GetMerchantShopScore) withObject:nil];
    
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView {
    PageIndex++;
    [self performSelector:@selector(GetMerchantShopScore) withObject:nil];
    
}

-(void)GetMerchantShopScore
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"MemberID",
                           key,   @"key",
                           [NSString stringWithFormat:@"%ld",(long)PageIndex],@"pageIndex",
                           @"10",@"PageSize",
                           [NSString stringWithFormat:@"%ld",(long)ScoreType],@"ScoreType",
                           IsHaveDesc==YES?@"1":@"0",@"IsHaveDesc",
                           self.m_shopId,@"MerchantShopID",
                           [NSString stringWithFormat:@"%ld",(long)ScoreType],@"ScoreType",
                           nil];
    NSLog(@"%@",param);
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:[NSString stringWithFormat:@"GetMerchantShopScore.ashx"] parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSMutableArray *metchantShop = [json valueForKey:@"ScoreList"];
            NSLog(@"%@",json);
            AvgScore =[json valueForKey:@"AvgScore"];
            Score =[json valueForKey:@"Score"];
            WLScore =[json valueForKey:@"WLScore"];
            HPCount =[json valueForKey:@"HPCount"];
            ZPCount =[json valueForKey:@"ZPCount"];
            CPCount =[json valueForKey:@"CPCount"];
            AllCount =[json valueForKey:@"AllCount"];

            if (PageIndex == 1) {
                if (metchantShop == nil || metchantShop.count == 0) {
                    [ScoreListArray removeAllObjects];
                    [SVProgressHUD showErrorWithStatus:@"暂无评价数据"];
                    [S_tableview reloadData];
                    return;
                } else {
                    ScoreListArray = metchantShop;
                }
            } else {
                if (metchantShop == nil || metchantShop.count == 0) {
                    PageIndex--;
                } else {
                    [ScoreListArray addObjectsFromArray:metchantShop];
                }
            }
            [S_tableview reloadData];
            
        } else {
            if (PageIndex > 1) {
                PageIndex--;
            }
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        S_tableview.pullLastRefreshDate = [NSDate date];
        S_tableview.pullTableIsRefreshing = NO;
        S_tableview.pullTableIsLoadingMore = NO;
    } failure:^(NSError *error) {
        if (PageIndex > 1) {
            PageIndex--;
        }
        //self.tableView.pullLastRefreshDate = [NSDate date];
        [SVProgressHUD showErrorWithStatus:@"请求失败,请稍后再试"];
        S_tableview.pullTableIsRefreshing = NO;
        S_tableview.pullTableIsLoadingMore = NO;
    }];
    
}

- (void)changeIsHaveDesc{
    IsHaveDesc =!IsHaveDesc;
    [S_tableview reloadData];
    [self GetMerchantShopScore];
}

//计算文本高度
-(CGFloat)heightForBubbleWithObject:(NSString *)object andTextWidth:(CGFloat)Width
{
    CGSize textBlockMinSize = {247, CGFLOAT_MAX};
    CGSize size;
    static float systemVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
    if (systemVersion >= 7.0) {
        size = [object boundingRectWithSize:textBlockMinSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    }else{
        size = [object sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:textBlockMinSize lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    return  size.height;
}


@end
