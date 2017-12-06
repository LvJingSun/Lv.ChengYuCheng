//
//  SceneryDetailViewController.m
//  HuiHui
//
//  Created by mac on 15-1-13.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "SceneryDetailViewController.h"

#import "SceneryDetailCell.h"

@interface SceneryDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@end

@implementation SceneryDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
      
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"景点信息"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
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


#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.row == 0 ) {
        
        static NSString *cellIdentifier = @"SceneryDetailCellIdentifier";
        
        SceneryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if ( cell == nil ) {
            
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SceneryDetailCell" owner:self options:nil];
            
            cell = (SceneryDetailCell *)[nib objectAtIndex:0];
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
        }
        
        
        return cell;
        
    }else{
        
        return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"0"];
    }
   
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.row == 0 ) {
        
        return 240.0f;
        
    }else{
        
        return 0.0f;
    }
}

@end
