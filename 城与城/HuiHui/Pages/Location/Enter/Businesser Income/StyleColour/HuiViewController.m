//
//  HuiViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 14-2-13.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import "HuiViewController.h"
#import "ColourViewController.h"
#import "FirstPhotoViewController.h"
#import "DowncellViewController.h"
#import "HH_advertListViewController.h"
#import "CustomerserviceListViewController.h"

@interface HuiViewController ()

@end

@implementation HuiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"城与城设置";
        self.chosearrayname = [[NSMutableArray alloc]initWithCapacity:0];
        self.chosearraycode = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideTabBar:YES];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self GetDataFromServer];
    
    // Do any additional setup after loading the view from its nib.
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 初始化pickerView
    [self initpickerView];
    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
    
    KEYlabel = [[UILabel alloc]initWithFrame:CGRectMake(60,self.m_pickerView.frame.origin.y - 44, 200, 44)];
    KEYlabel.text = @"请选择商户";
    KEYlabel.font = [UIFont systemFontOfSize:15];
    KEYlabel.lineBreakMode = UILineBreakModeWordWrap;
    KEYlabel.numberOfLines = 0;
    KEYlabel.textAlignment = UITextAlignmentCenter;
    KEYlabel.textColor = [UIColor whiteColor];
    KEYlabel.backgroundColor = [UIColor clearColor];
    [self.navigationController.view.window addSubview:KEYlabel];
    KEYlabel.hidden=YES;
    
}



- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.m_pickerToolBar.hidden = YES;
    
    self.m_pickerView.hidden = YES;
    
    KEYlabel.hidden=YES;

}

- (void)leftClicked{
    
    [self goBack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)GetDataFromServer
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           nil];
    
    [httpClient request:@"MerchantDrp.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            NSMutableArray *metchantShop = [json valueForKey:@"merchantDrpInfo"];
            if (metchantShop == nil || metchantShop.count == 0) {
                [self.chosearrayname removeAllObjects];
                [self.chosearraycode removeAllObjects];
                
                return;
                
            } else {
                
                if (metchantShop == nil) {
                    return;
                }
                NSLog(@"%@",metchantShop);
                for (NSDictionary *data in metchantShop)
                {
                    [self.chosearrayname addObject:[data objectForKey:@"AllName"]];
                    
                    [self.chosearraycode addObject:[data objectForKey:@"MerchantID"]];
                }
                [self.m_pickerView reloadAllComponents];
                

            }
            
        }
        else
        {
            return;
        }
    } failure:^(NSError *error) {
        
        return ;
    }];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([[UIDevice currentDevice].systemVersion doubleValue]>=7)
    {
        tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    }
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 50;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d", [indexPath section], [indexPath row]];//以indexPath来唯一确定cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //出列可重用的cell
    
    if (cell == nil) {

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    if (indexPath.section == 0)
    {
//        cell.textLabel.text=@"风格色彩";
        cell.textLabel.text = @"广告设置";
        
    }
    else if (indexPath.section == 1)
    {
        cell.textLabel.text=@"APP引导页";
    }
    else if (indexPath.section == 2)
    {
        cell.textLabel.text=@"指派客服";
    }
 
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //微网站选择商户
    if (indexPath.section==0)
    {
//        self.view.userInteractionEnabled = NO;
//        
//        [self.view endEditing:YES];
//        
//        self.m_typeString = @"color";
//        
//        self.m_pickerToolBar.hidden = NO;
//        
//        self.m_pickerView.hidden = NO;
//        KEYlabel.hidden=NO;
        
        // 进入首页广告设置的页面
        HH_advertListViewController *VC = [[HH_advertListViewController alloc]initWithNibName:@"HH_advertListViewController" bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];

    }
    //我的APP设置选择商户
    else if (indexPath.section==1)
    {

        self.view.userInteractionEnabled = NO;
        
        [self.view endEditing:YES];
        
        self.m_typeString = @"photo";
        
        self.m_pickerToolBar.hidden = NO;
        
        self.m_pickerView.hidden = NO;
        KEYlabel.hidden=NO;
        
        self.isSelected = YES;
        [self.m_pickerView reloadAllComponents];
        self.m_merchantString = [self.chosearrayname objectAtIndex:0];
        self.m_merchantID = [self.chosearraycode objectAtIndex:0];

    }else if (indexPath.section==2){
    
        CustomerserviceListViewController *VC = [[CustomerserviceListViewController alloc]initWithNibName:@"CustomerserviceListViewController" bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
    }
  
}

#pragma mark -初始化显示地区的pickerView
- (void)initpickerView{
    UIWindow *window = self.navigationController.view.window;
	
	//  datePickerView初始化
	self.m_pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 216, WindowSizeWidth, 216)];
    self.m_pickerView.backgroundColor = [UIColor whiteColor];
    self.m_pickerView.delegate = self;
    self.m_pickerView.dataSource = self;
    // 设置pickerView选择时的背景，默认的为NO
    self.m_pickerView.showsSelectionIndicator = YES;
	[window addSubview:self.m_pickerView];
    
	//添加 PickerView上面的左右按钮
    UIBarButtonItem *pickItemCancle = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(doPickerCancel:)];
    pickItemCancle.style = UIBarButtonItemStyleBordered;
    
    UIBarButtonItem *pickItemOK = [[UIBarButtonItem alloc]initWithTitle:@"确定"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(doPickerDone:)];
    pickItemOK.style = UIBarButtonItemStyleBordered;
    
    UIBarButtonItem *pickSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItem)UIBarButtonSystemItemFlexibleSpace
                                                                               target:self
                                                                               action:nil];
    // 自定义PickerView顶部的Toolbar，加载左右的取消和确定按钮
    UIToolbar *pickerBar = [[UIToolbar alloc] init];
    pickerBar.barStyle = UIBarStyleBlackTranslucent;
    NSArray *pickArray = [NSArray arrayWithObjects:pickItemCancle, pickSpace, pickItemOK,nil];
    [pickerBar setItems:pickArray animated:YES];
    pickerBar.frame = CGRectMake(0, self.m_pickerView.frame.origin.y - 44, WindowSizeWidth, 44);
    [window addSubview:pickerBar];
    pickerBar.backgroundColor = [UIColor clearColor];
    self.m_pickerToolBar = pickerBar;
    
}

#pragma mark - PickerBar按钮
- (void)doPickerDone:(id)sender{
    
    if (self.isSelected !=YES)
    {
        return;
    }else
    {
    
        self.view.userInteractionEnabled = YES;
    
        self.m_pickerView.hidden = YES;
    
        self.m_pickerToolBar.hidden = YES;
        KEYlabel.hidden=YES;

        self.isSelected = NO;
        if ([self.m_typeString isEqualToString:@"color"]) {
            ColourViewController *vc =[[ColourViewController alloc]initWithNibName:@"ColourViewController" bundle:nil];
            vc.CTitle = self.m_merchantString;
            vc.MemberchantID = self.m_merchantID;
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([self.m_typeString isEqualToString:@"photo"])
        {
            FirstPhotoViewController *vc =[[FirstPhotoViewController alloc]initWithNibName:@"FirstPhotoViewController" bundle:nil];
            vc.MemberchantID = self.m_merchantID;
            vc.MemberchantName = self.m_merchantString;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
}

- (void)doPickerCancel:(id)sender{
    
    self.view.userInteractionEnabled = YES;
    
    self.m_pickerView.hidden = YES;
    
    self.m_pickerToolBar.hidden = YES;
    KEYlabel.hidden=YES;

    
    
}


#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

        
        return 1;
  
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

        return self.chosearrayname.count;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    
    NSString * titleResult = [NSString stringWithFormat:@"%@",[self.chosearrayname objectAtIndex:row]];
        
    return titleResult;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
        self.isSelected = YES;
    
        self.m_merchantString= [self.chosearrayname objectAtIndex:row];
        self.m_merchantID = [self.chosearraycode objectAtIndex:row];
    
        for (int i=0; i<[pickerView numberOfComponents]; i++) {
        
        [self.m_pickerView reloadComponent:i];
        
        }
    
}



@end
