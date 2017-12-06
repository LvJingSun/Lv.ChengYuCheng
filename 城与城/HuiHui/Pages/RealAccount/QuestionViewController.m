//
//  QuestionViewController.m
//  baozhifu
//
//  Created by mac on 13-9-8.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "QuestionViewController.h"

#import "AppHttpClient.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

@interface QuestionViewController ()

@property (weak, nonatomic) IBOutlet UITableView *questionTable;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@end

@implementation QuestionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.questionTable setDelegate:self];
    [self.questionTable setDataSource:self];
    
    [self  setTitle:@"请选择问题"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
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
    
    [self goBack];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.questions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    //初始化cell并指定其类型，也可自定义cell
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    NSUInteger row = [indexPath row];
    NSDictionary *item = [self.questions objectAtIndex:row];
    cell.textLabel.text = [item objectForKey:@"Question"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    NSUInteger row = [indexPath row];
    NSDictionary *item = [self.questions objectAtIndex:row];
    self.txtQuestion.text = [item objectForKey:@"Question"];
    //NSLog(@"@%d,%@", row, item);
    
    if ( [self.m_delegate respondsToSelector:@selector(getValueId:)] ) {
        
        [self.m_delegate getValueId:[item objectForKey:@"QuestionValue"]];
    }
        
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getValueId:(NSString *)valueId{
    
    
}


@end
