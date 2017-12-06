//
//  HH_MenuDetailViewController.m
//  HuiHui
//
//  Created by mac on 15-7-16.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HH_MenuDetailViewController.h"

#import "UIImageView+AFNetworking.h"

@interface HH_MenuDetailViewController ()<UIActionSheetDelegate> {

    UIImageView *sentImg;
    
}

@property (weak, nonatomic) IBOutlet UIControl *m_control;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;
// 显示数量
@property (weak, nonatomic) IBOutlet UILabel *m_countLabel;

// 点击北京时候删除view的显示
- (IBAction)tapClicked:(id)sender;

@end

@implementation HH_MenuDetailViewController

@synthesize m_menuList;

@synthesize m_index;

@synthesize m_dic;

@synthesize m_countList;

@synthesize m_type;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        m_menuList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_index = 0;
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_countList = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"点单"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 设置view的透明度
    self.m_control.backgroundColor = [UIColor blackColor];
    self.m_control.alpha = 0.8f;
    
    
    self.m_scrollerView.center = self.view.center;
    
    self.m_scrollerView.showsVerticalScrollIndicator = NO;
    self.m_scrollerView.showsHorizontalScrollIndicator = NO;
    // 设置坐标
    self.m_countLabel.frame = CGRectMake(self.m_countLabel.frame.origin.x, self.m_scrollerView.frame.origin.y + self.m_scrollerView.frame.size.height + 10, self.m_countLabel.frame.size.width, self.m_countLabel.frame.size.height);
    
    
    // 设置lable的圆角
    self.m_countLabel.layer.cornerRadius = 8.0f;
    self.m_countLabel.layer.masksToBounds = YES;
    
    // 初始化scrollerView
    [self initwithScroller];
    
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
   
    [self goBack];
    
}

- (IBAction)tapClicked:(id)sender {
    
    [self.view removeFromSuperview];
    
}

- (void)initwithScroller{
    
//    NSString *totalCount = [self.m_dic objectForKey:@"TotalCount"];
    
    for (int ii = 0; ii < self.m_menuList.count; ii++) {
        
        NSMutableDictionary *l_dic = [self.m_dic objectForKey:[NSString stringWithFormat:@"%d",ii]];
        
        if ( l_dic.count != 0 ) {
            
            NSString *amount = [l_dic objectForKey:@"amount"];
           
            [self.m_countList addObject:amount];

        }else{
            
            [self.m_countList addObject:@"0"];

            
        }
        
    }
    
    // 设置scrollerView 的滚动范围
    [self.m_scrollerView setContentSize:CGSizeMake(self.m_menuList.count * WindowSizeWidth, self.m_scrollerView.frame.size.height)];
    
    [self.m_scrollerView setPagingEnabled:YES];
    
    
    for (int i = 0; i < self.m_menuList.count; i++) {
        
        NSDictionary *dic = [self.m_menuList objectAtIndex:i];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10 + i * WindowSizeWidth, 0, WindowSizeWidth - 20, self.m_scrollerView.frame.size.height)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 5.0f;
        view.layer.masksToBounds = YES;
        
        
        // 设置显示菜单的图片
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 120)];
        imageView.backgroundColor = [UIColor purpleColor];
        
        [imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuImage"]]]]
                                placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                             
                                             imageView.image = image;
                                             
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                             
                                         }];
        
        
        [view addSubview:imageView];
        
        imageView.userInteractionEnabled = YES;
        
        UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(imglongTapClick:)];
        
        [imageView addGestureRecognizer:longTap];
        
        // 设置背景透明图片
        UIImageView *backImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, imageView.frame.size.height - 60, view.frame.size.width, 60)];
        backImgV.backgroundColor = [UIColor blackColor];
        backImgV.alpha = 0.6f;
        [view addSubview:backImgV];
        
        // 设置关闭的按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(view.frame.size.width - 35, 5, 30, 30);
        btn.backgroundColor = [UIColor blackColor];
        [btn setTitle:@"X" forState:UIControlStateNormal];
        btn.layer.cornerRadius = 15.0f;
        btn.alpha = 0.6f;
        [btn addTarget:self action:@selector(tapClicked:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];

        
        // 显示标题
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, backImgV.frame.origin.y, view.frame.size.width - 10, 60)];
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuName"]];
        label.font = [UIFont systemFontOfSize:17.0f];
        label.numberOfLines = 0;
        label.textColor = [UIColor whiteColor];
        [view addSubview:label];
        
        
        // 显示价格的label
        UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, imageView.frame.size.height, view.frame.size.width/2, 40)];
        priceLabel.backgroundColor = [UIColor clearColor];
        
        // 送货上门的模式下就显示打包费的字段，否则就不显示
        if ( [self.m_type isEqualToString:@"1"] ) {
            
            priceLabel.text = [NSString stringWithFormat:@"%@元(含打包费%@元)",[dic objectForKey:@"MenuPrice"],[dic objectForKey:@"PackingPrice"]];
            
        }else{
            
            priceLabel.text = [NSString stringWithFormat:@"%@元",[dic objectForKey:@"MenuPrice"]];
            
        }
        
        priceLabel.font = [UIFont systemFontOfSize:14.0f];
        priceLabel.textColor = [UIColor redColor];
        [view addSubview:priceLabel];
        
        
        NSString *countString = [NSString stringWithFormat:@"%@",[self.m_countList objectAtIndex:i]];
        
        
        // 设置按钮 - 加号
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.frame = CGRectMake(view.frame.size.width - 10 - 36, imageView.frame.size.height + 7, 36, 26);
        [addBtn setTitle:@"+" forState:UIControlStateNormal];
        [addBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [addBtn.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
        addBtn.tag = i;
        [addBtn addTarget:self action:@selector(addMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        // 减号
        UIButton *minuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        minuBtn.frame = CGRectMake(view.frame.size.width - 10 - 108, imageView.frame.size.height + 7, 36, 26);
        [minuBtn setTitle:@"-" forState:UIControlStateNormal];
        [minuBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [minuBtn.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
         minuBtn.tag = i;
        [minuBtn addTarget:self action:@selector(minuMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        // 数字label
        UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(view.frame.size.width - 10 - 72, imageView.frame.size.height + 7, 36, 26)];
        numLabel.tag = i + 1000;
        numLabel.text = [NSString stringWithFormat:@"%@",countString];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.textColor = [UIColor blackColor];
        numLabel.font = [UIFont systemFontOfSize:14.0f];
        
        
        // 设置按钮的边框颜色
        [addBtn.layer setBorderWidth:1.0]; //边框宽度
        [minuBtn.layer setBorderWidth:1.0]; //边框宽度
        [numLabel.layer setBorderWidth:1.0]; //边框宽度
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){190/255.0, 204/255.0, 205/255.0, 1 });
        [addBtn.layer setBorderColor:colorref];//边框颜色
        [minuBtn.layer setBorderColor:colorref];//边框颜色
        [numLabel.layer setBorderColor:colorref];//边框颜色
        
        [view addSubview:addBtn];
        [view addSubview:numLabel];
        [view addSubview:minuBtn];
        
        // 根据数据进行判断
        if ( [countString isEqualToString:@"0"] ) {
            
            minuBtn.hidden = YES;
            numLabel.hidden = YES;
            addBtn.hidden = NO;
            
        }else{
            
            minuBtn.hidden = NO;
            numLabel.hidden = NO;
            addBtn.hidden = NO;
        }

        
        
        // 显示商品描述的textView
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(10, imageView.frame.size.height + priceLabel.frame.size.height + 5, view.frame.size.width - 20, 70)];
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor blackColor];
        textView.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Description"]];
        textView.font = [UIFont systemFontOfSize:14.0f];
        textView.editable = NO;
        
        [view addSubview:textView];
        
        [self.m_scrollerView addSubview:view];
        
        
    }
    
    // 设置scrollerView的滚动的第几个
    [self.m_scrollerView setContentOffset:CGPointMake(self.m_scrollerView.frame.size.width * self.m_index, 0)];
    
    self.m_countLabel.text = [NSString stringWithFormat:@"%li/%lu",self.m_index + 1,(unsigned long)self.m_menuList.count];
    
}

-(void)imglongTapClick:(UILongPressGestureRecognizer *)gesture {

    if(gesture.state == UIGestureRecognizerStateBegan) {
    
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存到相册" otherButtonTitles:nil, nil];
        
        [sheet showInView:self.view];
        
        UIImageView *img = (UIImageView *)[gesture view];
        
        sentImg = img;
        
    }
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    switch (buttonIndex) {
        case 0:
        {
        
            UIImageWriteToSavedPhotosAlbum(sentImg.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
            
        }
            break;
            
        default:
            break;
    }
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo

{
    
    NSString *message = @"呵呵";
    
    if (!error) {
        
        message = @"成功保存到相册";
        
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        
        
        
    }else
        
    {
        
        message = [error description];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        
    }
    
}

- (void)refreshData{
    
    NSString *string = [NSString stringWithFormat:@"%@",[self.m_countList objectAtIndex:self.m_index]];
    
    // 设置了数量后进行对数据的重新处理
    for (id view in self.m_scrollerView.subviews) {
        
        if ( [view isKindOfClass:[UIView class]] ) {
            
            UIView *l_view = (UIView *)view;
            
            for (id label in l_view.subviews) {
                
                if ( [label isKindOfClass:[UILabel class]] ) {
                    
                    UILabel *l_label = (UILabel *)label;
                    
                    if ( l_label.tag == self.m_index + 1000 ) {
                        
                        if ( [string isEqualToString:@"0"] ) {
                            
                            l_label.hidden = YES;
                            
                            l_label.text = [NSString stringWithFormat:@"%@",string];
                            
                        }else{
                            
                            l_label.hidden = NO;
                            
                            l_label.text = [NSString stringWithFormat:@"%@",string];
                            
                        }
                    }
                }
            }
            
            for (id btn in l_view.subviews) {
                
                if ( [btn isKindOfClass:[UIButton class]] ) {
                    
                    UIButton *l_btn = (UIButton *)btn;
                    
                    if ( l_btn.tag == 2000 + self.m_index ) {
                        
                        if ( [string isEqualToString:@"0"] ) {
                            
                            l_btn.hidden = YES;
                            
                        }else{
                            
                            l_btn.hidden = NO;
                        }
                    }
                }
            }
        }
    }
}

- (void)addMenuClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSLog(@"btn.tag111111 = %i",btn.tag);

    
//    UIButton *btn = (UIButton *)sender;
//    
//    NSString *countString = [NSString stringWithFormat:@"%@",[self.m_countList objectAtIndex:btn.tag]];
//    
//    int count = [countString intValue];
//  
//    count ++;
//    
//    // 替换数组里面的值
//    [self.m_countList replaceObjectAtIndex:btn.tag withObject:[NSString stringWithFormat:@"%i",count]];
//    
//    // 刷新数据
//    [self refreshData];
//    
//    
//    NSString *indexString = [NSString stringWithFormat:@"%i",btn.tag];
//    
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:countString,@"amount",indexString,@"index", nil];
//    
//    NSLog(@"dic = %@",dic);
   
    // 返回上一级执行代理方法
    if ( self.delegate && [self.delegate respondsToSelector:@selector(menuDetailgetIndex:)] ) {
        
        
//        [self.delegate performSelector:@selector(menuDetailgetIndex:) withObject:dic];
        [self.delegate performSelector:@selector(menuDetailgetIndex:) withObject:btn];
      
        
    }
    
      [self.view removeFromSuperview];
    
}

- (void)minuMenuClicked:(id)sender{
 
    UIButton *btn = (UIButton *)sender;

    NSLog(@"btn.tag2222222 = %i",btn.tag);

    
//    UIButton *btn = (UIButton *)sender;
//    
//    NSString *countString = [NSString stringWithFormat:@"%@",[self.m_countList objectAtIndex:btn.tag - 2000]];
//    
//    int count = [countString intValue];
//    
//    if ( count != 0 ) {
//        
//        count --;
//
//    }else{
//        
//        count = 0;
//
//    }
//    
//    // 替换数组里面的值
//    [self.m_countList replaceObjectAtIndex:btn.tag - 2000 withObject:[NSString stringWithFormat:@"%i",count]];
//    
//    // 刷新数据
//    [self refreshData];
//    
//    NSString *indexString = [NSString stringWithFormat:@"%i",btn.tag - 2000];
//    
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:countString,@"amount",indexString,@"index", nil];
    
    // 返回上一级执行代理方法
    if ( self.delegate && [self.delegate respondsToSelector:@selector(minuMenuClicked:)] ) {
        
        
        [self.delegate performSelector:@selector(minuMenuClicked:) withObject:btn];
        
        
    }
    
    [self.view removeFromSuperview];

 
}

#pragma mark - UIScrollerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   
    self.m_index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 赋值
    self.m_countLabel.text = [NSString stringWithFormat:@"%i/%i",self.m_index + 1,self.m_menuList.count];
    
}


@end

