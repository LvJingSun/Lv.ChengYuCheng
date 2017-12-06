//
//  BindCardViewController.m
//  HuiHui
//
//  Created by 冯海强 on 14-6-24.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "BindCardViewController.h"

#import "BindCardTableViewCell.h"
#import "Chat_MerViewController.h"

@interface BindCardViewController ()

@property (strong, nonatomic) NSMutableArray *ShopArray;

@end

@implementation BindCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.ShopArray = [[NSMutableArray alloc]initWithCapacity:0];
        self.m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];


    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    isClosed = YES;
    
    [self setTitle:@"成为会员"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
//    cololabel.layer.masksToBounds = YES;
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cololabel.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = cololabel.bounds;
//    maskLayer.path = maskPath.CGPath;
//    cololabel.layer.mask = maskLayer;

    addbtn.layer.masksToBounds = YES;
    addbtn.layer.cornerRadius = 5.0;
    
    //按钮选中颜色
    [addbtn setBackgroundImage:[self imageWithColor:RGBA(230, 130, 65, 1)] forState:UIControlStateHighlighted];
    
    [self didloadview];
}


-(void)didloadview
{
    self.ShopArray = [self.m_dic objectForKey:@"ShopList"];
    namelabel.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"AllName"]];
    CardTitle.text =[NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"CardTitle"]];
    NSString *Description = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Description"]];
    heightsize = [Description sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(284, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
}



- (void)leftClicked{
    
    [self goBack];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self.view endEditing:YES];
    
    return YES;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 5;
            break;
            case 1:
            if (isClosed) {
                return 1;
            }
            return self.ShopArray.count + 1;
        default:
            break;
    }
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    return 20;
                    break;
                case 1:
                    return heightsize.height > 80 ? heightsize.height+30 : 80;
                    break;
                case 2:
                    return 20;
                    break;
                case 3:
                    return 40;
                    break;
                case 4:
                    return 20;
                    break;
                    
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    return 40;
                    break;
                default:
                    return 50;
                    break;
            }
            break;
        default:
            break;
    }

    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if ( section == 0 ) {
        
        return Addview;
        
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 100;
        
    }
    return 0;
}



#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    cell = [self tableView0:tableView cellForRowAtIndexPath:indexPath];
                    break;
                case 1:
                    cell = [self tableView2:tableView cellForRowAtIndexPath:indexPath];
                    break;
                case 2:
                    cell = [self tableView0:tableView cellForRowAtIndexPath:indexPath];
                    break;
                case 3:
                    cell = [self tableView3:tableView cellForRowAtIndexPath:indexPath];
                    break;
                case 4:
                    cell = [self tableView0:tableView cellForRowAtIndexPath:indexPath];
                    break;
                    
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell = [self tableView1:tableView cellForRowAtIndexPath:indexPath];

                    break;
                default:
                    cell = [self tableView4:tableView cellForRowAtIndexPath:indexPath];
                    break;
            }
            break;
        default:
            break;
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 0&& indexPath.row ==3) {
        if (self.ShopArray.count) {
            Chat_MerViewController *chatVC = [[Chat_MerViewController alloc]initWithChatter:nil isGroup:NO];
            chatVC.m_items = [self.ShopArray objectAtIndex:0];;
            [self.navigationController pushViewController:chatVC animated:YES];
        }
        
    }else if (indexPath.section ==1 && indexPath.row ==0) {
        if (isClosed) {
            isClosed = NO;
        }else{
            isClosed = YES;
        }
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中状态。。
    
}

- (UITableViewCell *)tableView0:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    BindCardTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"BindCardTableViewCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:0];
        
    }
    return cell;
}

- (UITableViewCell *)tableView1:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    BindCardTableViewCell1*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"BindCardTableViewCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:1];
        
    }
    if (isClosed) {
        cell.upview.hidden = YES;
        cell.downview.hidden = NO;
    }else{
        cell.upview.hidden = NO;
        cell.downview.hidden = YES;
    }
    return cell;
}


- (UITableViewCell *)tableView2:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    BindCardTableViewCell2*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"BindCardTableViewCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:2];
        
    }
    
    cell.Carddescribe.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Description"]];
    
    return cell;
    
    
}

- (UITableViewCell *)tableView3:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    BindCardTableViewCell3*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"BindCardTableViewCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:3];
        
    }
    
    [cell setImageView:[NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"LogoMidUrl"]]];
    return cell;
    
}

- (UITableViewCell *)tableView4:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    BindCardTableViewCell4*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray*cellarray=[[NSBundle mainBundle]
                           loadNibNamed:@"BindCardTableViewCell" owner:self options:nil];
        cell =[cellarray objectAtIndex:4];
        
    }
    
    NSDictionary *dic = [self.ShopArray objectAtIndex:indexPath.row -1];
    
    cell.ShopName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ShopName"]];
    cell.disrictName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"disrictName"]];

    
    return cell;
    
}

- (IBAction)SubmitAddCard:(id)sender{
    
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  memberId,@"memberId",
                                  [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"VipCardID"]],@"vipCardId",
                                  nil];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [self showHudInView:self.view hint:@"数据加载中..."];
    [httpClient request:@"GetCards.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        [self hideHud];
        NSString *msg = [json valueForKey:@"msg"];
        if (success) {
            [SVProgressHUD showSuccessWithStatus:msg];
            
            [CommonUtil addValue:@"1" andKey:@"MyCardRequestSubmit_Notification"];

            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(Gotwoback) userInfo:nil repeats:NO];

        } else {
    
            [SVProgressHUD showErrorWithStatus:msg];
        }

    } failure:^(NSError *error) {
        [self hideHud];
        [SVProgressHUD showErrorWithStatus:@"添加失败，请稍后再试"];
    }];
    
}

-(void)Gotwoback
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
}







@end
