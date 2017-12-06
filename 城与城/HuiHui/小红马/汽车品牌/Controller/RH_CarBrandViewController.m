//
//  RH_CarBrandViewController.m
//  HuiHui
//
//  Created by mac on 2017/6/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_CarBrandViewController.h"
#import "RedHorseHeader.h"
#import "RH_CarBrandModel.h"
#import "RH_CarBrandFrame.h"
#import "RH_CarBrandCell.h"
#import "ChineseString.h"

#import "RH_ChooseCarModelView.h"

@interface RH_CarBrandViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableview;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) NSMutableArray *indexArray;

@end

@implementation RH_CarBrandViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"选择品牌";
    
    self.navigationItem.leftBarButtonItem = [self SetNavigationBarImage:@"RH_HomeBack.png" andaction:@selector(dismissRH_BrandView)];
    
    [self allocWithTableview];
    
    [self requestForCarBrand];

}

- (void)allocWithTableview {
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
    
    self.tableview = tableview;
    
    tableview.delegate = self;
    
    tableview.dataSource = self;
    
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.backgroundColor = RH_ViewBGColor;
    
    tableview.sectionIndexBackgroundColor = [UIColor clearColor];
    
    [self.view addSubview:tableview];
    
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {

    return self.indexArray;
    
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {

    return index;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.array.count;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    return self.indexArray[section];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.array objectAtIndex:section] count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RH_CarBrandCell *cell = [[RH_CarBrandCell alloc] init];
    
    RH_CarBrandFrame *frame = [[self.array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.frameModel = frame;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RH_CarBrandFrame *frame = [[self.array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return frame.height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RH_CarBrandFrame *frame = [[self.array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    RH_ChooseCarModelView *alert = [[RH_ChooseCarModelView alloc] init];
    
    alert.brandModel = frame.brandmodel;
    
    alert.brandcar = ^(RH_CarBrandModel *mainBrand, RH_CarBrandModel *childCar) {
        
        self.popCar(mainBrand, childCar);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    };
    
    [alert showInView:self.view];
    
}

- (void)popWithCar:(popCarBlock)block {

    self.popCar = block;
    
}

//请求品牌数据
- (void)requestForCarBrand {
    
    AppHttpClient* httpClient = [AppHttpClient sharedRedHorse];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"0", @"Level",
                           nil];
    
    [httpClient horserequest:@"GetCarModel.ashx" parameters:param success:^(NSJSONSerialization* json) {
        
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            NSArray *arr = [json valueForKey:@"ListTwo"];
            
            NSMutableArray *mut = [NSMutableArray array];
            
            for (NSDictionary *dd in arr) {
                
                RH_CarBrandModel *model = [[RH_CarBrandModel alloc] initWithDict:dd];
                
                RH_CarBrandFrame *frame = [[RH_CarBrandFrame alloc] init];
                
                frame.brandmodel = model;
                
                [mut addObject:frame];
                
            }
            
            self.indexArray = [ChineseString IndexArray:mut];
            
//            self.array = [ChineseString SortArray:mut];
            
            self.array = [ChineseString LetterSortArray:mut];
            
//            NSLog(@"%@",mm);
            
            [self.tableview reloadData];
            
        }else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"请求失败，请稍后再试"];
        
    }];
    
}

- (void)dismissRH_BrandView {

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
