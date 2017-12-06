//
//  Home_FenLeiViewController.m
//  HuiHui
//
//  Created by mac on 2017/9/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Home_FenLeiViewController.h"
#import "RedHorseHeader.h"
#import "Home_FenLeiModel.h"
#import "Home_FenLeiFrame.h"
#import "Home_FenLeiCell.h"
#import "FenLei_Section_HeadView.h"

#import "Ca_productListViewController.h"
#import "RH_HomeViewController.h"
#import "RH_NavViewController.h"
#import "RH_NoMemberShipViewController.h"
#import "FSB_GameViewController.h"
#import "FSB_GameNAVController.h"
#import "TrainwebViewController.h"
#import "Fl_webViewController.h"
#import "Hotel_webViewController.h"
#import "Sec_webViewController.h"
#import "FSB_NewHomeViewController.h"
#import "GreenLifeViewController.h"

@interface Home_FenLeiViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *zuijinArray;

@property (nonatomic, strong) NSArray *allArray;

@end

@implementation Home_FenLeiViewController

// 注意const的位置
static NSString *const cellId = @"cellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";

- (void)requestForData {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID", nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [http request:@"IndexIconMore.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *zuijin = [json valueForKey:@"listIcon"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dic in zuijin) {
                
                Home_FenLeiModel *model = [[Home_FenLeiModel alloc] initWithDict:dic];
                
                Home_FenLeiFrame *frame = [[Home_FenLeiFrame alloc] init];
                
                frame.fenleiModel = model;
                
                [mut addObject:frame];
                
            }
            
            self.zuijinArray = mut;
            
            NSArray *tuijian = [json valueForKey:@"AllListIcon"];
            
            NSMutableArray *tuijianmut = [NSMutableArray array];
            
            for (NSDictionary *dic in tuijian) {
                
                Home_FenLeiModel *model = [[Home_FenLeiModel alloc] initWithDict:dic];
                
                Home_FenLeiFrame *frame = [[Home_FenLeiFrame alloc] init];
                
                frame.fenleiModel = model;
                
                [tuijianmut addObject:frame];
                
            }
            
            self.allArray = tuijianmut;
            
            [self.collectionView reloadData];
            
        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"请求失败，请稍后再试"];
        
    }];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setTitle:@"更多"];

    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self allocWithCollectionView];
    
    [self requestForData];
    
    [self requestForZuiJinClick];
    
}

- (void)requestForZuiJinClick {
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                         @"11",@"Type",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [http request:@"ClickIconRecord.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)allocWithCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 1;
    //最小两行之间的间距
    layout.minimumLineSpacing = 1;
    //这个是横向滑动
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;

    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) collectionViewLayout:layout];
    
    self.collectionView = collection;
    
    collection.backgroundColor = [UIColor whiteColor];
    
    collection.dataSource = self;
    
    collection.delegate = self;
    
    [self.view addSubview:collection];
    
    [collection registerClass:[Home_FenLeiCell class] forCellWithReuseIdentifier:cellId];
    
    [collection registerClass:[FenLei_Section_HeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];

    [collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 2;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return self.zuijinArray.count;
        
    }else if (section == 1) {
    
        return self.allArray.count;
        
    }else {
    
        return 0;
        
    }

}

- (void)pushToProductViewControllerWithMenuType:(NSString *)menuID withViewType:(NSString *)viewID WithName:(NSString *)titleName {
    
    Ca_productListViewController *VC = [[Ca_productListViewController alloc]initWithNibName:@"Ca_productListViewController" bundle:nil];
    VC.TwoID = [NSString stringWithFormat:@"%@",viewID];
    VC.m_titleString = [NSString stringWithFormat:@"%@",titleName];
    [self.navigationController pushViewController:VC animated:YES];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"MemberID",
                         menuID,@"Type",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedClient];
    
    [http request:@"ClickIconRecord.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        Home_FenLeiFrame *frame = self.zuijinArray[indexPath.row];
        
        if ([frame.fenleiModel.Type isEqualToString:@"4"]) {
            
            //养车宝
            if ([self.YCBType isEqualToString:@"2"]) {
                
                //是会员
                RH_HomeViewController *vc = [[RH_HomeViewController alloc] init];
                
                RH_NavViewController *nav = [[RH_NavViewController alloc] initWithRootViewController:vc];
                
                [self presentViewController:nav animated:YES completion:nil];
                
            }else {
                
                //不是会员
                RH_NoMemberShipViewController *vc = [[RH_NoMemberShipViewController alloc] init];
                
                RH_NavViewController *nav = [[RH_NavViewController alloc] initWithRootViewController:vc];
                
                [self presentViewController:nav animated:YES completion:nil];
                
            }
            
        }else if ([frame.fenleiModel.Type isEqualToString:@"5"]) {
            
            //游戏
            FSB_GameViewController *vc = [[FSB_GameViewController alloc] init];
            
            FSB_GameNAVController *gameNav = [[FSB_GameNAVController alloc] initWithRootViewController:vc];
            
            [self presentViewController:gameNav animated:YES completion:nil];
            
        }else if ([frame.fenleiModel.Type isEqualToString:@"6"]) {
            
            //车票
            TrainwebViewController *VC = [[TrainwebViewController alloc]initWithNibName:@"TrainwebViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if ([frame.fenleiModel.Type isEqualToString:@"7"]) {
            
            //机票
            Fl_webViewController *VC = [[Fl_webViewController alloc]initWithNibName:@"Fl_webViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:NO];
            
        }else if ([frame.fenleiModel.Type isEqualToString:@"8"]) {
            
            //酒店
            Hotel_webViewController *VC = [[Hotel_webViewController alloc]initWithNibName:@"Hotel_webViewController" bundle:nil];
            [self.navigationController  pushViewController:VC animated:YES];
            
        }else if ([frame.fenleiModel.Type isEqualToString:@"9"]) {
            
            //景点
            Sec_webViewController *VC = [[Sec_webViewController alloc]initWithNibName:@"Sec_webViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if ([frame.fenleiModel.Type isEqualToString:@"10"]) {
            
            //绿生网
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [CommonUtil getValueByKey:MEMBER_ID],@"Memberid", nil];
            
            AppHttpClient *http = [AppHttpClient sharedGreen];
            
            [http Greenrequest:@"LoginByMemberID.ashx" parameters:dict success:^(NSJSONSerialization *json) {
                
                GreenLifeViewController *vc = [[GreenLifeViewController alloc] init];
                
                vc.loadStr = [NSString stringWithFormat:@"%@?memberId=%@&cityId=%@",frame.fenleiModel.LinkUrl,[CommonUtil getValueByKey:MEMBER_ID],[CommonUtil getValueByKey:CITYID]];
                
                [self presentViewController:vc animated:YES completion:nil];
                
            } failure:^(NSError *error) {
                
            }];
            
        }else if ([frame.fenleiModel.Type isEqualToString:@"12"]) {
            
            //粉丝宝
            FSB_NewHomeViewController *vc = [[FSB_NewHomeViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else {
            
            [self pushToProductViewControllerWithMenuType:frame.fenleiModel.Type withViewType:frame.fenleiModel.LinkUrl WithName:frame.fenleiModel.Title];
            
        }
        
    }else if (indexPath.section == 1) {
        
        Home_FenLeiFrame *frame = self.allArray[indexPath.row];
        
        if ([frame.fenleiModel.Type isEqualToString:@"4"]) {
            
            //养车宝
            if ([self.YCBType isEqualToString:@"2"]) {
                
                //是会员
                RH_HomeViewController *vc = [[RH_HomeViewController alloc] init];
                
                RH_NavViewController *nav = [[RH_NavViewController alloc] initWithRootViewController:vc];
                
                [self presentViewController:nav animated:YES completion:nil];
                
            }else {
                
                //不是会员
                RH_NoMemberShipViewController *vc = [[RH_NoMemberShipViewController alloc] init];
                
                RH_NavViewController *nav = [[RH_NavViewController alloc] initWithRootViewController:vc];
                
                [self presentViewController:nav animated:YES completion:nil];
                
            }
            
        }else if ([frame.fenleiModel.Type isEqualToString:@"5"]) {
            
            //游戏
            FSB_GameViewController *vc = [[FSB_GameViewController alloc] init];
            
            FSB_GameNAVController *gameNav = [[FSB_GameNAVController alloc] initWithRootViewController:vc];
            
            [self presentViewController:gameNav animated:YES completion:nil];
            
        }else if ([frame.fenleiModel.Type isEqualToString:@"6"]) {
            
            //车票
            TrainwebViewController *VC = [[TrainwebViewController alloc]initWithNibName:@"TrainwebViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if ([frame.fenleiModel.Type isEqualToString:@"7"]) {
            
            //机票
            Fl_webViewController *VC = [[Fl_webViewController alloc]initWithNibName:@"Fl_webViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:NO];
            
        }else if ([frame.fenleiModel.Type isEqualToString:@"8"]) {
            
            //酒店
            Hotel_webViewController *VC = [[Hotel_webViewController alloc]initWithNibName:@"Hotel_webViewController" bundle:nil];
            [self.navigationController  pushViewController:VC animated:YES];
            
        }else if ([frame.fenleiModel.Type isEqualToString:@"9"]) {
            
            //景点
            Sec_webViewController *VC = [[Sec_webViewController alloc]initWithNibName:@"Sec_webViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
        }else if ([frame.fenleiModel.Type isEqualToString:@"10"]) {
            
            //绿生网
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [CommonUtil getValueByKey:MEMBER_ID],@"Memberid", nil];
            
            AppHttpClient *http = [AppHttpClient sharedGreen];
            
            [http Greenrequest:@"LoginByMemberID.ashx" parameters:dict success:^(NSJSONSerialization *json) {
                
                GreenLifeViewController *vc = [[GreenLifeViewController alloc] init];
                
                vc.loadStr = [NSString stringWithFormat:@"%@?memberId=%@&cityId=%@",frame.fenleiModel.LinkUrl,[CommonUtil getValueByKey:MEMBER_ID],[CommonUtil getValueByKey:CITYID]];
                
                [self presentViewController:vc animated:YES completion:nil];
                
            } failure:^(NSError *error) {
                
            }];
            
        }else if ([frame.fenleiModel.Type isEqualToString:@"12"]) {
            
            //粉丝宝
            FSB_NewHomeViewController *vc = [[FSB_NewHomeViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else {
            
            [self pushToProductViewControllerWithMenuType:frame.fenleiModel.Type withViewType:frame.fenleiModel.LinkUrl WithName:frame.fenleiModel.Title];
            
        }
        
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        Home_FenLeiFrame *frame = self.zuijinArray[indexPath.row];
        
        Home_FenLeiCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        
        cell.frameModel = frame;
        
        return cell;
        
    }else if (indexPath.section == 1) {
    
        Home_FenLeiFrame *frame = self.allArray[indexPath.row];
        
        Home_FenLeiCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        
        cell.frameModel = frame;
        
        return cell;
        
    }else {
    
        return nil;
        
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        Home_FenLeiFrame *frame = self.zuijinArray[indexPath.row];
        
        return frame.size;
        
    }else if (indexPath.section == 1) {
    
        Home_FenLeiFrame *frame = self.allArray[indexPath.row];
        
        return frame.size;
        
    }else {
    
        return CGSizeMake(0, 0);
        
    }

}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        FenLei_Section_HeadView *headview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        
        if (headview == nil) {
            
            headview = [[FenLei_Section_HeadView alloc] init];
            
        }
     
        if (indexPath.section == 0) {
            
            headview.title.text = @"最近使用";
            
        }else if (indexPath.section == 1) {
        
            headview.title.text = @"推荐使用";
            
        }

        return headview;
        
    }
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        
        UICollectionReusableView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
        
        if (footview == nil) {
            
            footview = [[UICollectionReusableView alloc] init];
            
        }
        
        footview.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
        
        return footview;
        
    }
    
    return nil;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    FenLei_Section_HeadView *head = [[FenLei_Section_HeadView alloc] init];
    
    return head.size;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return (CGSize){ScreenWidth,1};
    
}

- (void)leftClicked {

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
