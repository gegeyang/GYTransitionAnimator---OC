//
//  SecondViewController.m
//  转场动画
//
//  Created by GeYang on 2017/1/18.
//  Copyright © 2017年 GeYang. All rights reserved.
//

#import "SecondViewController.h"

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH  [UIScreen mainScreen].bounds.size.width

@interface SecondViewController ()
@property (nonatomic, strong) UIImageView *imview;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    
    UIImageView *imview = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imview.image = [UIImage imageNamed:@"header.jpg"];
    imview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(go)];
    [imview addGestureRecognizer: tap];
    [self.view addSubview: imview];
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(30, 70, 100, 100)];
    lb.text = @"这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字";
    lb.numberOfLines = 0;
    lb.textColor = [UIColor redColor];
//    [self.view addSubview: lb];
    
    
    
}


- (void)go{
    [self dismissViewControllerAnimated:YES completion:nil];
}























@end
