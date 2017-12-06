//
//  RH_ChooseCarModelView.m
//  HuiHui
//
//  Created by mac on 2017/6/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_ChooseCarModelView.h"
#import "RedHorseHeader.h"
#import "RH_CarBrandModel.h"
#import "RH_ChildCarFrame.h"
#import "RH_ChildCarCell.h"

@interface RH_ChooseCarModelView () <UITableViewDelegate,UITableViewDataSource> {
    
    UIView *_contentView;
    
    CGFloat viewWidth;
    
}

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation RH_ChooseCarModelView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64);
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        if (_contentView == nil) {
            
            _contentView = [[UIView alloc] init];
            
            viewWidth = ScreenWidth * 0.7;
            
            _contentView.frame = CGRectMake(ScreenWidth - viewWidth, 0, viewWidth, ScreenHeight - 64);
            
            _contentView.backgroundColor = [UIColor whiteColor];
            
            UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, ScreenHeight - 64)];
            
            self.tableview = tableview;
            
            tableview.delegate = self;
            
            tableview.dataSource = self;
            
            tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            tableview.backgroundColor = [UIColor whiteColor];
            
            [_contentView addSubview:tableview];
            
            [self addSubview:_contentView];
            
            UIButton *disbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - viewWidth, ScreenHeight - 64)];
            
            [disbtn addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:disbtn];
            
        }
        
    }
    
    return self;
    
}

-(void)setBrandModel:(RH_CarBrandModel *)brandModel {

    _brandModel = brandModel;
    
    [self requestForDataWithID:brandModel.CheID];
    
}

- (void)requestForDataWithID:(NSString *)cheID {

    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"1", @"Level",
                           cheID,@"CheID",
                           nil];
    
    [httpClient horserequest:@"GetCarModel.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *arr = [json valueForKey:@"ListTwo"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in arr) {
                
                RH_CarBrandModel *model = [[RH_CarBrandModel alloc] initWithDict:dd];
                
                RH_ChildCarFrame *frame = [[RH_ChildCarFrame alloc] init];
                
                frame.brandmodel = model;
                
                [mut addObject:frame];
                
            }

            self.dataArray = mut;
            
            [self.tableview reloadData];
            
        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"请求失败，请稍后再试"];
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    RH_ChildCarCell *cell = [[RH_ChildCarCell alloc] init];
    
    RH_ChildCarFrame *frame = self.dataArray[indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    RH_ChildCarFrame *frame = self.dataArray[indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RH_ChildCarFrame *frame = self.dataArray[indexPath.row];
    
    self.brandcar(self.brandModel, frame.brandmodel);
    
    [self disMissView];
    
}

- (void)returnChildCar:(ChooseChildCar)block {

    self.brandcar = block;
    
}

//展示从底部向上弹出的UIView（包含遮罩）
- (void)showInView:(UIView *)view
{
    if (!view)
    {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:_contentView];
    
    [_contentView setFrame:CGRectMake(ScreenWidth, 0, viewWidth, ScreenHeight - 64)];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 1.0;
        
        [_contentView setFrame:CGRectMake(ScreenWidth - viewWidth, 0, viewWidth, ScreenHeight - 64)];
        
    } completion:nil];
    
}

//移除从上向底部弹下去的UIView（包含遮罩）
- (void)disMissView
{
    [_contentView setFrame:CGRectMake(ScreenWidth - viewWidth, 0, viewWidth, ScreenHeight - 64)];
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         self.alpha = 0.0;
                         
                         [_contentView setFrame:CGRectMake(ScreenWidth, 0, viewWidth, ScreenHeight - 64)];
                         
                     }
                     completion:^(BOOL finished){
                         
                         [self removeFromSuperview];
                         
                         [_contentView removeFromSuperview];
                         
                     }];
    
}

@end
