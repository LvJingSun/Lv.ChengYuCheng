//
//  CityViewController.m
//  HuiHui
//
//  Created by mac on 14-1-4.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "CityViewController.h"

#import "AreaCell.h"

@interface CityViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@end

@implementation CityViewController

@synthesize m_cityList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_cityList = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_cityList.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"AreaCellIdentifier";
    
    AreaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AreaCell" owner:self options:nil];
        
        cell = (AreaCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    
    if ( self.m_cityList.count != 0 ) {
        
        NSDictionary *dic = [self.m_cityList objectAtIndex:indexPath.row];
        
        cell.m_cityName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    //    if ( delegate && [delegate respondsToSelector:@selector(getAreaName:)] ) {
    //
    //        [delegate performSelector:@selector(getAreaName:) withObject:[self.m_cityList objectAtIndex:indexPath.row]];
    //    }
    //
    //    [self.navigationController popViewControllerAnimated:YES];

    
}


@end
