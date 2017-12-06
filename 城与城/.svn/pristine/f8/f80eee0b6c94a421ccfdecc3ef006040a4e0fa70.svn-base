//
//  HH_CustomMenuViewController.m
//  HuiHui
//
//  Created by mac on 15-7-14.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HH_CustomMenuViewController.h"

#import "AddBCMenuTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "CardMenuOrderCell.h"
#import "HH_CustomMenuCell.h"

@interface HH_CustomMenuViewController ()


@property (nonatomic,strong) NSMutableArray         *m_shopList;

@property (nonatomic, strong) NSMutableDictionary   *m_imagDic;

@property (strong, nonatomic) IBOutlet UIView       *m_footerView;

@property (weak, nonatomic) IBOutlet UITableView    *m_tableView;


@property (weak, nonatomic) IBOutlet UITextField *m_menuName;

@property (weak, nonatomic) IBOutlet UITextField *m_menuPrice;

@property (weak, nonatomic) IBOutlet UITextField *m_shopName;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageVIew;

@property (weak, nonatomic) IBOutlet UIButton *m_btn;

@property (strong, nonatomic) IBOutlet UIView *m_headerView;

@property (weak, nonatomic) IBOutlet UIImageView *m_backImgV;

@property (weak, nonatomic) IBOutlet UITextView *m_textView;

@property (weak, nonatomic) IBOutlet UILabel *m_tipLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@property (weak, nonatomic) IBOutlet UIView *m_countView;

@property (weak, nonatomic) IBOutlet UITextField *m_totalTextView;

@property (weak, nonatomic) IBOutlet UITextField *m_usedTextView;

// 开关
@property (weak, nonatomic) IBOutlet UISwitch *m_segment1;

@property (weak, nonatomic) IBOutlet UISwitch *m_segment2;

@property (weak, nonatomic) IBOutlet UISwitch *m_segment3;

// 开关触发的事件
- (IBAction)segmentChanage:(id)sender;

// 选择照片按钮触发的事件
- (IBAction)choosePhotoClicked:(id)sender;
// 店铺选择
- (IBAction)shopClicked:(id)sender;
// 保存菜单
- (IBAction)saveMenuClicked:(id)sender;

// 添加自定义菜单
- (IBAction)addMenuCategory:(id)sender;


@end

@implementation HH_CustomMenuViewController

@synthesize m_menuClassId;
@synthesize m_imagDic;
@synthesize m_type;
@synthesize m_dic;
@synthesize m_isChange;
@synthesize m_SectionsSet;
@synthesize m_shopList;
@synthesize m_menuList;
@synthesize delegate;


static HH_CustomMenuViewController *VC = nil;

+ (HH_CustomMenuViewController *)shareobject;//保证只有一个；
{
    
    // 根据不同的值来进行不同的处理
    NSString *string = [CommonUtil getValueByKey:@"Custom_menu_Key"];
    
    NSLog(@"string = %@",string);
    
    if ( [string isEqualToString:@"1"] ) {
        
        if (VC == nil)
        {
            VC = [[HH_CustomMenuViewController alloc]init];
        }
        
    }else{
        
        VC = [[HH_CustomMenuViewController alloc]init];

    }
  
    
    return VC;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        m_imagDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_shopList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_SectionsSet = [[NSMutableSet alloc]init];
        
        m_menuList = [[NSMutableArray alloc]initWithCapacity:0];
        
        clickedIndex = 0;

        deleteIndex = 0;
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    [self setTitle:@"自定义参数设置"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithNormalImage:@"add.png" action:@selector(addMenuCategory:)];
    
    // 编辑状态下的时候进行赋值
    if ( [self.m_type isEqualToString:@"2"] ) {
        
        // 对数组进行赋值
        [self.m_menuList addObjectsFromArray:[self.m_dic objectForKey:@"AttributeList"] ];
        
        [self.m_tableView reloadData];
        
    }
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.m_tableView addGestureRecognizer:gestureRecognizer];
    
    // 设置tableView的头和尾
    self.m_footerView.frame = CGRectMake(self.m_footerView.frame.origin.x, self.m_footerView.frame.origin.y, self.m_footerView.frame.size.width, 80);
   
//    self.m_tableView.tableFooterView = self.m_footerView;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
//    NSMutableArray *arr = [self.m_dic objectForKey:@"AttributeList"];
//    
//    if ( arr.count != self.m_menuList.count ) {
//        
//        [SVProgressHUD showErrorWithStatus:@"您修改了自定义参数，请先保存"];
//       
//        return;
//    }
//    
//    [self goBack];


    [self.view endEditing:YES];
    
    NSString *customMenuString = @"";
    
    
    if ( self.m_menuList.count != 0 ) {
        
        NSString *ll_string = @"";
        
        
        for (int i = 0; i < self.m_menuList.count; i++) {
            
            NSDictionary *dic = [self.m_menuList objectAtIndex:i];
            
            NSString *menuName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"AttributeName"]];
            
            NSArray *arr = [dic objectForKey:@"ValueList"];
            
            NSString *l_string = @"";
            
            NSString *l_AttributeID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"AttributeID"]];
            
            NSString *AttributeID = @"";
            
            if ( [l_AttributeID isEqualToString:@"(null)"] || l_AttributeID.length == 0 ) {
                
                AttributeID = @"";
                
            }else{
                
                AttributeID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"AttributeID"]];
            }
            
            
            for (int ii = 0; ii < arr.count; ii++) {
                
                NSDictionary *l_dic = [arr objectAtIndex:ii];
                
                NSString *menu_name = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"Value"]];
                
                NSString *l_ValueID = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"ValueID"]];
                
                NSString *ValueID = @"";
                
                if ( [l_ValueID isEqualToString:@"(null)"] || l_ValueID.length == 0 ) {
                    
                    ValueID = @"";
                    
                }else{
                    
                    ValueID = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"ValueID"]];
                    
                }
                
                // 赋值
                if ( ii != arr.count - 1 ) {
                    
                    l_string = [l_string stringByAppendingString:[NSString stringWithFormat:@"{\"ValueID\":\"%@\",\"Value\":\"%@\"},",ValueID,menu_name]];
                    
                }else{
                    
                    l_string = [l_string stringByAppendingString:[NSString stringWithFormat:@"{\"ValueID\":\"%@\",\"Value\":\"%@\"}",ValueID,menu_name]];
                    
                }
                
                
            }
            
            
            
            l_string = [NSString stringWithFormat:@"\"ValueList\":[%@]",l_string];
            
            
            // 赋值
            if ( i != self.m_menuList.count - 1 ) {
                
                ll_string = [ll_string stringByAppendingString:[NSString stringWithFormat:@"{\"AttributeID\":\"%@\",\"AttributeName\":\"%@\",%@},",AttributeID,menuName,l_string]];
                
            }else{
                
                ll_string = [ll_string stringByAppendingString:[NSString stringWithFormat:@"{\"AttributeID\":\"%@\",\"AttributeName\":\"%@\",%@}",AttributeID,menuName,l_string]];
                
                
            }
            
            
        }
        
        customMenuString = [NSString stringWithFormat:  @"\{\"Attributelist\":[%@]}",ll_string];
        
        
        
        
    }else{
        
        customMenuString = @"";
    }
    
    NSLog(@"customMenuString = %@",customMenuString);
    
    // 执行代理方法
    if ( self.delegate && [self.delegate respondsToSelector:@selector(getCustomMenuName:)] ) {
        
        [self.delegate performSelector:@selector(getCustomMenuName:) withObject:customMenuString];
        
        [self goBack];
        
    }




}

- (IBAction)addMenuCategory:(id)sender{
    
    [CommonUtil addValue:@"1" andKey:@"Custom_menu_Key"];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
    
    [dic setObject:@"" forKey:@"AttributeName"];
    [dic setObject:arr forKey:@"ValueList"];
    
    [self.m_menuList addObject:dic];
    
    // 刷新列表
    [self.m_tableView reloadData];
    
}
/*
// 刷新数据
- (void)refreshData{
    
  
    
    // 判断是新增还是编辑
    if ( [self.m_type isEqualToString:@"1"] ) {
        
        self.m_btn.hidden = NO;
        self.m_imageVIew.hidden = YES;
        
        if ([self.m_imagDic objectForKey:@"menuImage"]) {
            
            [self.m_btn setImage:[UIImage imageWithData:[self.m_imagDic objectForKey:@"menuImage"]] forState:UIControlStateNormal];
            
        }else{
            
            [self.m_btn setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] forState:UIControlStateNormal];
            
        }
        
    }else{
        
        if ( [self.m_isChange isEqualToString:@"0"] ) {
            
            self.m_btn.hidden = NO;
            self.m_imageVIew.hidden = NO;
            self.m_btn.backgroundColor = [UIColor clearColor];
            
            [self.m_btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            
            
            // 表示直接赋值图片地址
            [self.m_imageVIew setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[self.m_dic objectForKey:@"MenuImage"]]]
                                 placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                          success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                              self.m_imageVIew.image = image;// [CommonUtil scaleImage:image toSize:CGSizeMake(70, 105)];
                                              //                                     self.m_imageView.contentMode = UIViewContentModeScaleAspectFit;
                                              //                                             [self.imageCache addImage:self.m_imageView.image andUrl:imagePath];
                                              
                                          }
                                          failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                              
                                          }];
            
        }else if ( [self.m_isChange isEqualToString:@"1"] ){
            
            self.m_imageVIew.hidden = YES;
            self.m_btn.hidden = NO;
            
            // 表示直接赋值选择的图片
            if ([self.m_imagDic objectForKey:@"menuImage"]) {
                
                [self.m_btn setImage:[UIImage imageWithData:[self.m_imagDic objectForKey:@"menuImage"]] forState:UIControlStateNormal];
                
            }else{
                
                [self.m_btn setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"] forState:UIControlStateNormal];
                
            }
            
        }
        
    }
    
}
*/
/*
#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    [self hiddenNumPadDone:nil];
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    [textView resignFirstResponder];
    
    
    if (textView.text.length == 0) {
        
        self.m_tipLabel.text = @"请输入商品描述";
        
    }else{
        
        self.m_tipLabel.text = @"";
        
    }
    
    // 赋值
    self.m_textView.text = [NSString stringWithFormat:@"%@",textView.text];
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        
        self.m_tipLabel.text = @"请输入商品描述";
        
    }else{
        
        self.m_tipLabel.text = @"";
        
    }
}

*/
/*
#pragma mark - UITextFieldDelegate
#define myDotNumbers     @"0123456789.\n"
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if (textField.tag != 202) {
//        return YES;
//    }
    if ( textField.tag == 202 ) {
        
        //输入字符限制
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers]invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if (filtered.length == 0) {
            //支持删除键
            return [string isEqualToString:@""];
        }
        if (textField.text.length == 0) {
            return ![string isEqualToString:@"."];
        }
        //第一位为0，只能输入.
        else if (textField.text.length == 1){
            if ([textField.text isEqualToString:@"0"]) {
                return [string isEqualToString:@"."];
            }
        }
        else{//只能输入一个.
            if ([textField.text rangeOfString:@"."].length) {
                if ([string isEqualToString:@"."]) {
                    return NO;
                }
                //两位小数
                NSArray *ary =  [textField.text componentsSeparatedByString:@"."];
                if (ary.count == 2) {
                    if ([ary[1] length] == 2) {
                        return NO;
                    }
                }
            }
        }
        
    }
    
    return YES;
}*/

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ( textField.tag == 11 ){
        
        [self showNumPadDone:nil];

    }else if ( textField.tag == 22 ){
        
        [self showNumPadDone:nil];
        
    }else{
        
        [self hiddenNumPadDone:nil];
        
        // 根据点击的位置来设置tableView的滚动位置
        if ( textField.tag < 2000 ) {

            
            
        }else{
            
            // 点击的时候滚动到固定的某一行
            NSInteger index = 0;
            
            NSInteger section = 0;
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0&&[[[UIDevice currentDevice] systemVersion] floatValue]<8.0) {
                //获取Cell的indexpath.row
                index = [self.m_tableView indexPathForCell:((HH_CustomMenuCell*)[[[textField   superview]superview] superview])].row;
                
                section = [self.m_tableView indexPathForCell:((HH_CustomMenuCell*)[[[textField   superview]superview] superview])].section;
                
                
            }else
            {
                //获取Cell的indexpath.row
                index = [self.m_tableView indexPathForCell:((HH_CustomMenuCell*)[[textField   superview]superview])].row;
                
                section = [self.m_tableView indexPathForCell:((HH_CustomMenuCell*)[[textField   superview]superview])].section;
                
            }
          
            // 获取所点目录对应的indexPath值
            NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:index inSection:section];
            // 让table滚动到对应的indexPath位置
            [self.m_tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            
        }
        
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if ( textField.tag == 201 ) {
    
        menunamestring = textField.text;
        
        self.m_menuName.text = [NSString stringWithFormat:@"%@",menunamestring];

    }else if ( textField.tag == 202 ){
        
        pricestring = textField.text;
        
        self.m_menuPrice.text = [NSString stringWithFormat:@"%@",pricestring];
    
    }else if ( textField.tag == 11 ){
        
        // 总份数
         m_totalString = textField.text;
       
        self.m_totalTextView.text = [NSString stringWithFormat:@"%@",textField.text];
        
    }else if ( textField.tag == 22 ){
        
        // 可使用份数
        m_usedString = textField.text;
        
        self.m_usedTextView.text = [NSString stringWithFormat:@"%@",textField.text];
        
    }else{
        
        
        if ( textField.tag < 2000 ) {
            // 表示点击的是区上面的textField
            if ( self.m_menuList.count != 0 ) {
                
                NSMutableDictionary *dic = [self.m_menuList objectAtIndex:textField.tag];
                
                [dic setObject:[NSString stringWithFormat:@"%@",textField.text] forKey:@"AttributeName"];
                
            }
            
            
            
        }else{
            
            NSInteger index = 0;
            
            NSInteger section = 0;
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0&&[[[UIDevice currentDevice] systemVersion] floatValue]<8.0) {
                //获取Cell的indexpath.row
                index = [self.m_tableView indexPathForCell:((HH_CustomMenuCell*)[[[textField   superview]superview] superview])].row;
                
                section = [self.m_tableView indexPathForCell:((HH_CustomMenuCell*)[[[textField   superview]superview] superview])].section;
                
                
            }else
            {
                //获取Cell的indexpath.row
                index = [self.m_tableView indexPathForCell:((HH_CustomMenuCell*)[[textField   superview]superview])].row;
                
                section = [self.m_tableView indexPathForCell:((HH_CustomMenuCell*)[[textField   superview]superview])].section;
                
            }
            
            // 将值存放字典里
            if ( self.m_menuList.count != 0 ) {
        
                NSMutableDictionary *dic = [self.m_menuList objectAtIndex:section];
                
                NSMutableArray *arr = [dic objectForKey:@"ValueList"];
                
                if ( arr.count != 0 ) {
                    
                    NSMutableDictionary *l_dic = [arr objectAtIndex:index];
                    
                    [l_dic setObject:[NSString stringWithFormat:@"%@",textField.text] forKey:@"Value"];
                    
                    [self.m_tableView reloadData];
                    
                }

            }
            
            
        }
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)hideKeyboard{
    
    [self.view endEditing:YES];
    
}

- (void)lastView{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.m_menuList.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    BOOL expand = [self isSection:section];
    
    if ( !expand ) {
        
        NSMutableDictionary *dic = [self.m_menuList objectAtIndex:section];
        
        NSMutableArray *arr = [dic objectForKey:@"ValueList"];
        
        return arr.count;
        
        
    }else {
        
        return 0;
        
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"HH_CustomMenuCellIdentifier";
    
    HH_CustomMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HH_CustomMenuCell" owner:self options:nil];
        
        cell = (HH_CustomMenuCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    // 赋值
    
    cell.m_textField.delegate = self;
    
    cell.m_textField.tag = indexPath.row + 2000;
  
    if ( self.m_menuList.count != 0 ) {
        
        NSMutableDictionary *dic = [self.m_menuList objectAtIndex:indexPath.section];
        
        NSMutableArray *arr = [dic objectForKey:@"ValueList"];
        
        if ( arr.count != 0 ) {
            
            NSMutableDictionary *l_dic = [arr objectAtIndex:indexPath.row];
            
            NSString *menu_name = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"Value"]];
            
            if ( ![menu_name isEqualToString:@"(null)"] ) {
                
                if ( menu_name.length != 0 ) {
                    
                    cell.m_textField.text = menu_name;
                    
                }else{
                    
                    cell.m_textField.text = @"";
                    
                }
                
            }else{
                
                cell.m_textField.text = @"";
            }
            
            cell.m_deleteBtn.tag = indexPath.row;
            
            [cell.m_deleteBtn addTarget:self action:@selector(deleteCustomMenu:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
    }
    
    return cell;

    
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if ( self.m_menuList.count != 0 ) {
    
//        NSMutableDictionary *dic = [self.m_addDic objectForKey:[NSString stringWithFormat:@"%li",(long)section]];
        
        NSMutableDictionary *dic = [self.m_menuList objectAtIndex:section];
        
//        NSMutableArray *arr = [dic objectForKey:@"ValueList"];
        
        UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 44)];
        tempView.backgroundColor = [UIColor whiteColor];
        
        // 添加种类的按钮
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(WindowSizeWidth - 80, 0,40, 44);
        btn1.backgroundColor = [UIColor clearColor];
        [btn1 setTitle:@"+" forState:UIControlStateNormal];
        [btn1.titleLabel setFont:[UIFont systemFontOfSize:30.0f]];
        [btn1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(addMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn1.tag = section;
        [tempView addSubview:btn1];
        
        // 删除的按钮
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(WindowSizeWidth - 120, 0,40, 44);
        btn2.backgroundColor = [UIColor clearColor];
        [btn2 setTitle:@"-" forState:UIControlStateNormal];
        [btn2.titleLabel setFont:[UIFont systemFontOfSize:30.0f]];
        [btn2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(deleteMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn2.tag = section;
        [tempView addSubview:btn2];
        
        // 输入框
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, btn2.frame.origin.x - 20, 34)];
        textField.backgroundColor = [UIColor clearColor];
        textField.textColor = RGBACKTAB;
        textField.font = [UIFont systemFontOfSize:14.0f];
        NSString *menuName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"AttributeName"]];
        
        textField.placeholder = @"请输入参数名称(如 口味)";

        if ( menuName.length != 0 ) {
            
            textField.text = menuName;
            
        }else{
            
            textField.text = @"";

        }
        
        textField.tag = section;
        textField.delegate = self;
        [tempView addSubview:textField];
     
        // 添加按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(WindowSizeWidth - 40, 0,40, 44);
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(headerClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = section;
        [tempView addSubview:btn];
        
        // 添加箭头变化的图片
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(WindowSizeWidth - 30, 20, 16, 10)];
        
        BOOL expand = [self isSection:section];
        
        // 判断是展开还是闭合
        if ( expand ) {
            
            imgV.image = [UIImage imageNamed:@"arrow_L_up.png"];
            
        } else {
            
            imgV.image = [UIImage imageNamed:@"arrow_L_down.png"];
            
        }
        
        [tempView addSubview:imgV];
        
        return tempView;
        
    }else{
        
        return nil;
    
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
    
}

// 判断是否展开
- (BOOL)isSection:(NSInteger)section{
    
    BOOL result = NO;
    
    if ( [self.m_SectionsSet containsObject:[NSNumber numberWithInteger:section]] ) {
        
        result = YES;
        
    }
    
    return result;
}

// 展开的section保存到expandedSectionsSet里面
- (void)setSection:(int)section expand:(BOOL)expand{
    
    if ( expand ) {
        
        if ( ![self.m_SectionsSet containsObject:[NSNumber numberWithInteger:section]] ) {
            // 首先是只显示一个点击展开的列表-即删除数据
            //            [self.m_SectionsSet removeAllObjects];
            //
            //            [self.m_SectionsSet addObject:[NSNumber numberWithInteger:section]];
            
            // 如果展开全部的数据则写下面这行代码
            [self.m_SectionsSet addObject:[NSNumber numberWithInteger:section]];
            
        }
        
    }else{
        // 如果展开全部的数据则写下面这行代码
        [self.m_SectionsSet removeObject:[NSNumber numberWithInteger:section]];
        
        // 首先是只显示一个点击展开的列表-即删除数据
        //        [self.m_SectionsSet removeAllObjects];
        
    }
    
}

#pragma mark - btnClicked
- (void)headerClicked:(id)sender{
    
    // button的tag值
    UIButton *btn = (UIButton *)sender;
    
    //    sectionIndex = btn.tag;
    
    // bool值判断哪个section是展开还是合起来的
    BOOL expand = [self isSection:btn.tag];
    
    [self setSection:btn.tag expand:!expand];
    
    // 刷新tableView 展开全部的列表的话则就刷新某一行
    //    [self.m_tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationNone];
    
    [self.m_tableView reloadData];
    
    
}

- (void)addMenuClicked:(id)sender{
    
    [self.view endEditing:YES];
    
    UIButton *btn = (UIButton *)sender;

    // 增加值
    NSMutableDictionary *dic = [self.m_menuList objectAtIndex:btn.tag];
    
    NSMutableArray *arr = [dic objectForKey:@"ValueList"];
    
    NSMutableDictionary *l_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    [arr addObject:l_dic];
    
    // 刷新列表
    [self.m_tableView reloadData];
    
}

- (void)deleteMenuClicked:(id)sender{
    
    [self.view endEditing:YES];
    
    // 删除自定义的参数
    UIButton *btn = (UIButton *)sender;
 
    if ( self.m_menuList.count > btn.tag ) {
        
        [self.m_menuList removeObjectAtIndex:btn.tag];

    }
    
    // 刷新列表
    [self.m_tableView reloadData];
    
}

- (void)deleteCustomMenu:(id)sender{
    
    [self.view endEditing:YES];

    // 删除自定义的参数-小分类
    UIButton *btn = (UIButton *)sender;
    
    NSInteger index = 0;
    
    NSInteger section = 0;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0&&[[[UIDevice currentDevice] systemVersion] floatValue]<8.0) {
        //获取Cell的indexpath.row
        index = [self.m_tableView indexPathForCell:((HH_CustomMenuCell*)[[[btn superview]superview] superview])].row;
        
        section = [self.m_tableView indexPathForCell:((HH_CustomMenuCell*)[[[btn superview]superview] superview])].section;
        
    }else
    {
        //获取Cell的indexpath.row
        index = [self.m_tableView indexPathForCell:((HH_CustomMenuCell*)[[btn superview]superview])].row;
        
        section = [self.m_tableView indexPathForCell:((HH_CustomMenuCell*)[[btn superview]superview])].section;
        
    }

    NSMutableDictionary *dic = [self.m_menuList objectAtIndex:section];
    
    NSMutableArray *arr = [dic objectForKey:@"ValueList"];
    
    if ( arr.count > index ) {
        
        [arr removeObjectAtIndex:index];
    }

    
    // 刷新列表
    [self.m_tableView reloadData];
    
    
}


- (IBAction)saveMenuClicked:(id)sender {
    
    [self.view endEditing:YES];
    
    NSString *customMenuString = @"";
    

    if ( self.m_menuList.count != 0 ) {
        
        NSString *ll_string = @"";
        
        
        for (int i = 0; i < self.m_menuList.count; i++) {
            
            NSDictionary *dic = [self.m_menuList objectAtIndex:i];
            
            NSString *menuName = [NSString stringWithFormat:@"%@",[dic objectForKey:@"AttributeName"]];
            
            NSArray *arr = [dic objectForKey:@"ValueList"];
            
            NSString *l_string = @"";
            
            NSString *l_AttributeID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"AttributeID"]];
            
            NSString *AttributeID = @"";
            
            if ( [l_AttributeID isEqualToString:@"(null)"] || l_AttributeID.length == 0 ) {
                
                AttributeID = @"";
                
            }else{
                
                AttributeID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"AttributeID"]];
            }
            
            
            for (int ii = 0; ii < arr.count; ii++) {
                
                NSDictionary *l_dic = [arr objectAtIndex:ii];
                
                NSString *menu_name = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"Value"]];
                
                NSString *l_ValueID = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"ValueID"]];
                
                NSString *ValueID = @"";
                
                if ( [l_ValueID isEqualToString:@"(null)"] || l_ValueID.length == 0 ) {
                    
                    ValueID = @"";
                    
                }else{
                    
                    ValueID = [NSString stringWithFormat:@"%@",[l_dic objectForKey:@"ValueID"]];
                    
                }
                
                // 赋值
                if ( ii != arr.count - 1 ) {
                    
                    l_string = [l_string stringByAppendingString:[NSString stringWithFormat:@"{\"ValueID\":\"%@\",\"Value\":\"%@\"},",ValueID,menu_name]];
                    
                }else{
                    
                    l_string = [l_string stringByAppendingString:[NSString stringWithFormat:@"{\"ValueID\":\"%@\",\"Value\":\"%@\"}",ValueID,menu_name]];
                    
                }
                
                
            }
            
            
            
            l_string = [NSString stringWithFormat:@"\"ValueList\":[%@]",l_string];
            
            
            // 赋值
            if ( i != self.m_menuList.count - 1 ) {
                
                ll_string = [ll_string stringByAppendingString:[NSString stringWithFormat:@"{\"AttributeID\":\"%@\",\"AttributeName\":\"%@\",%@},",AttributeID,menuName,l_string]];
                
            }else{
                
                ll_string = [ll_string stringByAppendingString:[NSString stringWithFormat:@"{\"AttributeID\":\"%@\",\"AttributeName\":\"%@\",%@}",AttributeID,menuName,l_string]];
                
                
            }
            
            
        }
        
        customMenuString = [NSString stringWithFormat:  @"\{\"Attributelist\":[%@]}",ll_string];
        

        
        
    }else{
        
        customMenuString = @"";
    }
    
   
    
    // 执行代理方法
    if ( self.delegate && [self.delegate respondsToSelector:@selector(getCustomMenuName:)] ) {
        
        [self.delegate performSelector:@selector(getCustomMenuName:) withObject:customMenuString];
        
        [self goBack];
        
    }

}


/*
- (IBAction)choosePhotoClicked:(id)sender {
 
    [self.view endEditing:YES];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择封面"
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"拍照",@"从相册中选择", nil];
    actionSheet.tag = 1009;
    [actionSheet showInView:self.view];
    
}

- (IBAction)shopClicked:(id)sender {
    
    [self.view endEditing:YES];
    // 进入店铺选择的页面
    HH_shopListViewController *VC = [[HH_shopListViewController alloc]initWithNibName:@"HH_shopListViewController" bundle:nil];
    VC.delegate = self;
    VC.m_shopArray = self.m_shopList;
    
    [self.navigationController pushViewController:VC animated:YES];

}


- (IBAction)segmentChanage:(id)sender {
    
    UISwitch *switcher = (UISwitch *)sender;
    
    if ( switcher.tag == 11 ) {
        
        if ( [self.m_segment1 isOn] ) {
            
            [self.m_segment1 setOn:YES];
            
        }else{
            
            [self.m_segment1 setOn:NO];

        }
        
    }else if ( switcher.tag == 22 ){
        
        if ( [self.m_segment2 isOn] ) {
            
            [self.m_segment2 setOn:YES];
            
        }else{
            
            [self.m_segment2 setOn:NO];
            
        }
        
    }else if ( switcher.tag == 33 ){
        
        if ( [self.m_segment3 isOn] ) {
            
            [self.m_segment3 setOn:YES];
            
            // 设置view的隐藏与显示
            self.m_countView.hidden = NO;
            
            self.m_scrollerView.frame = CGRectMake(self.m_scrollerView.frame.origin.x, 196, self.m_scrollerView.frame.size.width, self.m_scrollerView.frame.size.height);
            
            
        }else{
            
            [self.m_segment3 setOn:NO];
            
              self.m_countView.hidden = YES;
            
            self.m_scrollerView.frame = CGRectMake(self.m_scrollerView.frame.origin.x, 152, self.m_scrollerView.frame.size.width, self.m_scrollerView.frame.size.height);

        }
        
         self.m_headerView.frame = CGRectMake(self.m_headerView.frame.origin.x, self.m_headerView.frame.origin.y, self.m_headerView.frame.size.width, self.m_scrollerView.frame.size.height + self.m_scrollerView.frame.origin.y);
        
        
        self.m_tableView.tableHeaderView = self.m_headerView;

        
    }
    
}
 
 */

@end
