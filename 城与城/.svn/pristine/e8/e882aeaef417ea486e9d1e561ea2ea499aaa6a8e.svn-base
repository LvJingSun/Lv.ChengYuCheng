//
//  HomeCell.m
//  HuiHui
//
//  Created by mac on 14-7-28.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "HomeCell.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

@implementation HomeCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImageView:(NSDictionary *)dic{
    
    NSString *path = [dic objectForKey:@"AdMidLeftImg"];

    NSString *path1 = [dic objectForKey:@"AdMidRighImg"];

    
//    UIImage *reSizeImage = [self.imageCache getImage:path];
//   
//    if (reSizeImage != nil) {
//        self.m_imagV1.image = reSizeImage;
//        return;
//    }
    
    //NSLog(@"AFImage load path: %@", path);
//    __weak HomeCell *weakCell = self;
//    [self.m_imagV1 setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]
//                         placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
//                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
//                                      
//                                      self.m_imagV1.image = image;
//
////                                      self.m_imagV1.image = [CommonUtil scaleImage:image toSize:CGSizeMake(140, 40)];
//                                      self.m_imagV1.contentMode = UIViewContentModeScaleToFill;
//                                      [weakCell setNeedsLayout];
//                                    
//                                      [self.imageCache addImage:self.m_imagV1.image andUrl:path];
//                                  }
//                                  failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
//                                      
//                                  }];
    [self.m_imagV1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",path]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
    [self.m_imagV2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",path1]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];


    
//    [self.m_imagV2 setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path1]]
//                         placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
//                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
//                                      
////                                      self.m_imagV2.image = [CommonUtil scaleImage:image toSize:CGSizeMake(140, 40)];
//                                      self.m_imagV2.image = image;
//
//                                      self.m_imagV2.contentMode = UIViewContentModeScaleToFill;
//                                      [weakCell setNeedsLayout];
//                                      
//                                      [self.imageCache addImage:self.m_imagV2.image andUrl:path1];
//                                  }
//                                  failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
//                                      
//                                  }];

    
}

@end


@implementation HomeAdvCell

@synthesize delegate;

- (void)awakeFromNib
{
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setImage:(NSMutableArray *)aInfoList{
    
    
    [self.m_scrollerView setContentSize:CGSizeMake(WindowSizeWidth * aInfoList.count,60)];
    
    self.m_scrollerView.pagingEnabled = YES;
    
    self.m_scrollerView.delegate = self;
    
    self.m_scrollerView.showsHorizontalScrollIndicator = NO;
    
    self.m_scrollerView.showsVerticalScrollIndicator = NO;
    
    for (int i = 0; i < aInfoList.count; i ++) {
        
        NSDictionary *dic = [aInfoList objectAtIndex:i];
        
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(i * WindowSizeWidth, 0, WindowSizeWidth, 60)];
        imgV.backgroundColor = [UIColor clearColor];
        NSString *imagePath = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Thumbnails"]];
        
        // 赋值图片
//        [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
//                    placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
//                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
//                                 imgV.image = image;//[CommonUtil scaleImage:image toSize:CGSizeMake(WindowSizeWidth, 60)];
//                                 //                                      self.m_imagV.contentMode = UIViewContentModeCenter;
//                                 //                                         [weakCell setNeedsLayout];
//                                 //                                         [self.imageCache addImage:self.m_imagV.image andUrl:imagePath];
//                             }
//                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
//                                 
//                             }];
        [imgV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imagePath]] placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];

        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * WindowSizeWidth, 0, WindowSizeWidth, 60);
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = i;
        [btn addTarget:self action:@selector(imageClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.m_scrollerView addSubview:imgV];
        [self.m_scrollerView addSubview:btn];
    }
    
    // 初始化pageControl
    CGRect pageControlFrame = CGRectMake(0, 50, WindowSizeWidth, 10);
    self.m_pageControl = [[GrayPageControl alloc]initWithFrame:pageControlFrame];
    self.m_pageControl.backgroundColor = [UIColor clearColor];//背景
    self.m_pageControl.inactiveImage = [UIImage imageNamed:@"white.png"];
    self.m_pageControl.activeImage = [UIImage imageNamed:@"blue.png"];
    
    self.m_pageControl.userInteractionEnabled = NO;
    self.m_pageControl.numberOfPages = aInfoList.count;
    
    self.m_pageControl.currentPage = 0;
    
    
    for(GrayPageControl *page in self.subviews)
    {
        
        if([page isKindOfClass:[GrayPageControl class]])
        {
            
            [page removeFromSuperview];
        }
    }

    [self addSubview:self.m_pageControl];


}

- (void)imageClicked:(id)sender{
    
    if ( delegate && [delegate respondsToSelector:@selector(imageClicked:)] ) {
        
        [delegate performSelector:@selector(imageClicked:) withObject:sender];
        
    }
    
    
}

#pragma mark - UIScrollerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.m_scrollerView) {
        CGFloat pageWidth = WindowSizeWidth;
        int page = floor((self.m_scrollerView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.m_pageControl.currentPage = page;
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.m_scrollerView) {
        CGFloat pageWidth = scrollView.frame.size.width;
		int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		if (page != self.m_pageControl.currentPage)
		{
            if (page <= self.m_pageControl.numberOfPages) {
                self.m_pageControl.currentPage = page;
                
            }
		}
    }
}


@end


@implementation CategoryCell

@synthesize delegate;

- (void)awakeFromNib
{
    // Initialization code
    
    self.m_btn1.layer.cornerRadius = 25.0;
    
    self.m_btn2.layer.cornerRadius = 25.0;
    
    self.m_btn3.layer.cornerRadius = 25.0;
    
    self.m_btn4.layer.cornerRadius = 25.0;
    
    self.m_btn5.layer.cornerRadius = 25.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

/*- (void)setBtnImage:(NSMutableArray *)array{
        
    NSDictionary *dic1 = [array objectAtIndex:0];
    NSString *path1 = [dic1 objectForKey:@"ThumbnailsBig"];
    
    UIImage *reSizeImage = [self.imageCache getImage:path1];
    
    if (reSizeImage != nil) {
        self.m_imagV1.image = reSizeImage;
        return;
    }
    
    //NSLog(@"AFImage load path: %@", path);
    __weak CategoryCell *weakCell = self;
    [self.m_imagV1 setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path1]]
                         placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                      
                                      self.m_imagV1.image = [CommonUtil scaleImage:image toSize:CGSizeMake(100, 100)];
                                      self.m_imagV1.contentMode = UIViewContentModeScaleToFill;
                                      [weakCell setNeedsLayout];
                                      
                                      [self.imageCache addImage:self.m_imagV1.image andUrl:path1];
                                  }
                                  failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                      
                                  }];
    
    self.m_label1.text = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"ClassName"]];
    self.m_btn1.tag = [[dic1 objectForKey:@"ClassId"] integerValue];
    
    
    
    NSDictionary *dic2 = [array objectAtIndex:1];
    NSString *path2 = [dic2 objectForKey:@"ThumbnailsMid"];

    [self.m_imagV2 setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path2]]
                         placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                      
                                      self.m_imagV2.image = [CommonUtil scaleImage:image toSize:CGSizeMake(100, 100)];
                                      self.m_imagV2.contentMode = UIViewContentModeScaleToFill;
                                      [weakCell setNeedsLayout];
                                      
                                      [self.imageCache addImage:self.m_imagV2.image andUrl:path2];
                                  }
                                  failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                      
                                  }];
    
    self.m_label2.text = [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"ClassName"]];
    self.m_btn2.tag = [[dic2 objectForKey:@"ClassId"] integerValue];
    
    
    NSDictionary *dic3 = [array objectAtIndex:2];
    NSString *path3 = [dic3 objectForKey:@"ThumbnailsMid"];
    
    [self.m_imagV3 setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path3]]
                         placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                      
                                      self.m_imagV3.image = [CommonUtil scaleImage:image toSize:CGSizeMake(100, 100)];
                                      self.m_imagV3.contentMode = UIViewContentModeScaleToFill;
                                      [weakCell setNeedsLayout];
                                      
                                      [self.imageCache addImage:self.m_imagV3.image andUrl:path3];
                                  }
                                  failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                      
                                  }];
    
    self.m_label3.text = [NSString stringWithFormat:@"%@",[dic3 objectForKey:@"ClassName"]];
    self.m_btn3.tag = [[dic3 objectForKey:@"ClassId"] integerValue];

    
    
    
    NSDictionary *dic4 = [array objectAtIndex:3];
    NSString *path4 = [dic4 objectForKey:@"ThumbnailsMid"];
    

    [self.m_imagV4 setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path4]]
                         placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                      
                                      self.m_imagV4.image = [CommonUtil scaleImage:image toSize:CGSizeMake(100, 100)];
                                      self.m_imagV4.contentMode = UIViewContentModeScaleToFill;
                                      [weakCell setNeedsLayout];
                                      
                                      [self.imageCache addImage:self.m_imagV4.image andUrl:path4];
                                  }
                                  failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                      
                                  }];
    
    self.m_label4.text = [NSString stringWithFormat:@"%@",[dic4 objectForKey:@"ClassName"]];
    self.m_btn4.tag = [[dic4 objectForKey:@"ClassId"] integerValue];

    
    
    NSDictionary *dic5 = [array objectAtIndex:4];
    NSString *path5 = [dic5 objectForKey:@"ThumbnailsMid"];
    
  
    [self.m_imagV5 setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path5]]
                         placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                      
                                      self.m_imagV5.image = [CommonUtil scaleImage:image toSize:CGSizeMake(100, 100)];
                                      self.m_imagV5.contentMode = UIViewContentModeScaleToFill;
                                      [weakCell setNeedsLayout];
                                      
                                      [self.imageCache addImage:self.m_imagV5.image andUrl:path5];
                                  }
                                  failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                      
                                  }];
    
    self.m_label5.text = [NSString stringWithFormat:@"%@",[dic5 objectForKey:@"ClassName"]];
    self.m_btn5.tag = [[dic5 objectForKey:@"ClassId"] integerValue];
 
    
}*/

@end


@implementation HHFlightsHotelCell

- (void)awakeFromNib
{
    // Initialization code
    
    self.m_hotelView.frame = CGRectMake(self.m_hotelView.frame.origin.x, self.m_hotelView.frame.origin.y, (WindowSizeWidth - 20) / 2, self.m_hotelView.frame.size.height);
    
    self.m_flightView.frame = CGRectMake(self.m_hotelView.frame.size.width + 20 - self.m_hotelView.frame.origin.x, self.m_flightView.frame.origin.y, (WindowSizeWidth - 20) / 2, self.m_flightView.frame.size.height);

    self.m_quanquanView.frame = CGRectMake(self.m_quanquanView.frame.origin.x, self.m_quanquanView.frame.origin.y, (WindowSizeWidth - 20) / 2, self.m_quanquanView.frame.size.height);

    self.m_scneryView.frame = CGRectMake(self.m_quanquanView.frame.size.width + 20 - self.m_quanquanView.frame.origin.x, self.m_scneryView.frame.origin.y, (WindowSizeWidth - 20) / 2, self.m_scneryView.frame.size.height);
    
       
    self.m_hotel1view.frame = CGRectMake(self.m_hotel1view.frame.origin.x, self.m_hotel1view.frame.origin.y, (WindowSizeWidth - 20) / 2, self.m_hotel1view.frame.size.height);
    
    self.m_cardView.frame = CGRectMake(self.m_hotel1view.frame.size.width + 20 - self.m_hotel1view.frame.origin.x, self.m_cardView.frame.origin.y, (WindowSizeWidth - 20) / 2, self.m_cardView.frame.size.height);
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end

