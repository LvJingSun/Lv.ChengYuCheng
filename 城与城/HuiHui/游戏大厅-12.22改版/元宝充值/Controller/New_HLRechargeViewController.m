//
//  New_HLRechargeViewController.m
//  HuiHui
//
//  Created by mac on 2017/12/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "New_HLRechargeViewController.h"
#import "LJConst.h"
#import "New_HL_GameInfoModel.h"
#import "New_HL_GameInfoFrame.h"
#import "New_HL_GameInfoCell.h"
#import "New_HL_CountModel.h"
#import "NEW_HL_CountFrame.h"
#import "New_HL_CountCell.h"
#import "New_HL_OtherModel.h"
#import "New_HL_OtherFrame.h"
#import "New_HL_OtherCell.h"
#import "New_HL_PriceModel.h"
#import "New_HL_PriceFrame.h"
#import "New_HL_PriceCell.h"
#import "New_HL_YuanBaoRechargeSectionView.h"

@interface New_HLRechargeViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,OtherPriceFieldDelegate> {
    
    BOOL isOther;//是否显示其他数量输入框
    
}

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *gameInfoArray;//存储游戏ID和充值类型的数组

@property (nonatomic, strong) NSArray *countArray;//存储充值数量的数组

@property (nonatomic, strong) NSArray *otherCountArray;//存储其他充值数量的数组

@property (nonatomic, strong) NSArray *priceArray;//存储价格的数组

@end

@implementation New_HLRechargeViewController

static NSString *const InfoCellID = @"InfoCellID";
static NSString *const CountCellID = @"CountCellID";
static NSString *const OtherCountCellID = @"OtherCountCellID";
static NSString *const PriceCellID = @"PriceCellID";
static NSString *const SectionHeaderId = @"SectionHeaderId";

-(NSArray *)gameInfoArray {
    
    if (_gameInfoArray == nil) {
        
        New_HL_GameInfoModel *model = [[New_HL_GameInfoModel alloc] init];
        
        model.type = self.type;
        
        model.gameID = self.userID;
        
        model.gameTypeID = self.gameID;
        
        New_HL_GameInfoFrame *frame = [[New_HL_GameInfoFrame alloc] init];
        
        frame.model = model;
        
        NSMutableArray *mut = [NSMutableArray array];
        
        [mut addObject:frame];
        
        _gameInfoArray = mut;
        
    }
    
    return _gameInfoArray;
    
}

- (void)requestForCountData {
    
    NSDictionary *dic = [NSDictionary dictionary];
    
    AppHttpClient *http = [AppHttpClient sharedHuLa];
    
    [http HuLarequest:@"GameAccount/Count.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {

            NSArray *arr = [json valueForKey:@"numList"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in arr) {
                
                New_HL_CountModel *model = [[New_HL_CountModel alloc] init];
                
                model.title = [NSString stringWithFormat:@"%@",dd[@"numName"]];
                
                model.num = [NSString stringWithFormat:@"%@",dd[@"num"]];
                
                model.isChoose = NO;
                
                NEW_HL_CountFrame *frame = [[NEW_HL_CountFrame alloc] init];
                
                frame.model = model;
                
                [mut addObject:frame];
                
            }
            
            NEW_HL_CountFrame *frame0 = mut[0];
            
            frame0.model.isChoose = YES;
                
            self.countArray = mut;
            
            New_HL_PriceModel *pricemodel = [[New_HL_PriceModel alloc] init];
            
            pricemodel.price = frame0.model.num;
            
            New_HL_PriceFrame *priceframe = [[New_HL_PriceFrame alloc] init];
            
            priceframe.model = pricemodel;
            
            NSMutableArray *pricemut = [NSMutableArray array];
            
            [pricemut addObject:priceframe];
            
            self.priceArray = pricemut;
            
            [self.collectionView reloadData];
            
        }else {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

-(NSArray *)otherCountArray {
    
    if (_otherCountArray == nil) {
            
        New_HL_OtherModel *model = [[New_HL_OtherModel alloc] init];
        
        New_HL_OtherFrame *frame = [[New_HL_OtherFrame alloc] init];
        
        frame.model = model;
        
        NSMutableArray *mut = [NSMutableArray array];
        
        [mut addObject:frame];
        
        _otherCountArray = mut;
        
    }
    
    return _otherCountArray;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    isOther = NO;
    
    [self setTitle:@"游戏充值"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self allocWithCollectionView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self requestForCountData];

}

#pragma mark 键盘出现
- (void)keyboardWillShow:(NSNotification *)note {
    
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
    
}
#pragma mark 键盘消失
- (void)keyboardWillHide:(NSNotification *)note {
    
    self.collectionView.contentInset = UIEdgeInsetsZero;
    
}

- (void)allocWithCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

    //这个是横向滑动
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, _WindowViewWidth, _WindowViewHeight - 64) collectionViewLayout:layout];
    
    self.collectionView = collection;
    
    collection.backgroundColor = [UIColor whiteColor];
    
    collection.dataSource = self;
    
    collection.delegate = self;
    
    [self.view addSubview:collection];
    
    [collection registerClass:[New_HL_GameInfoCell class] forCellWithReuseIdentifier:InfoCellID];
    
    [collection registerClass:[New_HL_CountCell class] forCellWithReuseIdentifier:CountCellID];
    
    [collection registerClass:[New_HL_OtherCell class] forCellWithReuseIdentifier:OtherCountCellID];
    
    [collection registerClass:[New_HL_PriceCell class] forCellWithReuseIdentifier:PriceCellID];

    [collection registerClass:[New_HL_YuanBaoRechargeSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SectionHeaderId];
    
}

//分组数量
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 4;
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        New_HL_YuanBaoRechargeSectionView *headview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:SectionHeaderId forIndexPath:indexPath];
        
        if (headview == nil) {
            
            headview = [[New_HL_YuanBaoRechargeSectionView alloc] init];
            
        }
        
        headview.titleLab.text = @"面额";
        
        return headview;
        
    }
    
    return nil;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        
        New_HL_YuanBaoRechargeSectionView *headview = [[New_HL_YuanBaoRechargeSectionView alloc] init];
        
        return headview.size;
        
    }
    
    return CGSizeMake(0, 0);
    
}

//每组cell的数量
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {

        return self.gameInfoArray.count;

    }else if (section == 1) {
        
        return self.countArray.count;
        
    }else if (section == 2) {
        
        if (isOther) {
        
            return self.otherCountArray.count;
            
        }else {

            return 0;

        }
    
    }else if (section == 3) {
        
        return self.priceArray.count;
        
    }
    
    return 0;
    
}

//设置cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {

        New_HL_GameInfoFrame *frame = self.gameInfoArray[indexPath.row];

        New_HL_GameInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:InfoCellID forIndexPath:indexPath];

        cell.frameModel = frame;

        return cell;

    }else if (indexPath.section == 1) {
        
        NEW_HL_CountFrame *frame = self.countArray[indexPath.row];
        
        New_HL_CountCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CountCellID forIndexPath:indexPath];
        
        cell.frameModel = frame;
        
        cell.countBlock = ^{
            
            if (!frame.model.isChoose) {
                
                for (NEW_HL_CountFrame *ff in self.countArray) {
                    
                    if ([ff isEqual:frame]) {
                        
                        ff.model.isChoose = YES;
                        
                        if ([ff.model.num isEqualToString:@"其他数额"]) {

                            isOther = YES;
                            
                            New_HL_PriceFrame *priceframe = self.priceArray[0];
                            
                            priceframe.model.price = @"0";

                        }else {

                            isOther = NO;
                            
                            New_HL_PriceFrame *priceframe = self.priceArray[0];
                            
                            priceframe.model.price = ff.model.num;
                            
                            [self hideKeyboard];

                        }
                        
                    }else {
                        
                        ff.model.isChoose = NO;
                        
                    }
                    
                }
                
                [collectionView reloadData];
                
            }
            
        };
        
        return cell;
        
    }else if (indexPath.section == 2) {
        
        New_HL_OtherFrame *frame = self.otherCountArray[indexPath.row];
        
        New_HL_OtherCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OtherCountCellID forIndexPath:indexPath];
        
        cell.frameModel = frame;
        
        cell.delegate = self;
        
        return cell;
        
    }else if (indexPath.section == 3) {
        
        New_HL_PriceFrame *frame = self.priceArray[indexPath.row];
        
        New_HL_PriceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PriceCellID forIndexPath:indexPath];
        
        cell.frameModel = frame;
        
        cell.rechargeBlock = ^{
            
            if ([frame.model.price floatValue] <= 0) {
                
                [SVProgressHUD showErrorWithStatus:@"请输入充值数量！"];
                
            }else {
                
                [self requestForRecharge];
                
            }
            
        };
        
        return cell;
        
    }
    
    return nil;
    
}

- (void)requestForRecharge {
    
    New_HL_PriceFrame *frame = self.priceArray[0];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         [CommonUtil getValueByKey:MEMBER_ID],@"memberId",
                         self.gameID,@"gameCategoryId",
                         frame.model.price,@"count",
                         self.type,@"type",
                         @"",@"targetGameId",
                         nil];
    
    AppHttpClient *http = [AppHttpClient sharedHuLa];
    
    [SVProgressHUD showWithStatus:@"充值中..."];
    
    [http HuLarequest:@"Game/Recharge.ashx" parameters:dic success:^(NSJSONSerialization *json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",[json valueForKey:@"msg"]]];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];
    
}

- (void)hideKeyboard {
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self hideKeyboard];
    
}

- (void)OtherPriceFieldChange:(UITextField *)field {
    
    for (New_HL_OtherFrame *frame in self.otherCountArray) {
        
        frame.model.count = [NSString stringWithFormat:@"%@",field.text];
        
    }
    
    for (New_HL_PriceFrame *frame in self.priceArray) {
        
        frame.model.price = [NSString stringWithFormat:@"%@",field.text];
        
    }
    
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
    
    [self.collectionView reloadSections:indexSet];
    
}

//设置cell的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {

        New_HL_GameInfoFrame *frame = self.gameInfoArray[indexPath.row];

        return frame.size;

    }else if (indexPath.section == 1) {
        
        NEW_HL_CountFrame *frame = self.countArray[indexPath.row];
        
        return frame.size;
        
    }else if (indexPath.section == 2) {
        
        New_HL_OtherFrame *frame = self.otherCountArray[indexPath.row];
        
        return frame.size;
        
    }else if (indexPath.section == 3) {
        
        New_HL_PriceFrame *frame = self.priceArray[indexPath.row];
        
        CGSize size = [frame getCellSize];
        
        return size;
        
    }
    
    return CGSizeMake(0, 0);
    
}

//cell点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

//设置cell之间的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    if (section == 1) {
        
        return UIEdgeInsetsMake(10, 10, 10, 10);
        
    }
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (void)leftClicked {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
