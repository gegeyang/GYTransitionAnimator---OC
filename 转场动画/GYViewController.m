//
//  GYViewController.m
//  转场动画
//
//  Created by GeYang on 2017/2/6.
//  Copyright © 2017年 GeYang. All rights reserved.
//

#import "GYViewController.h"
#import "ViewController.h"

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH  [UIScreen mainScreen].bounds.size.width

@interface GYViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *nameArr;
@end

@implementation GYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转场动画";
    _nameArr = @[@"渐变", @"缩放", @"层次", @"圆形扩散"];
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.tableFooterView = [[UIView alloc]init];
    [self.view addSubview: _tableview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = _nameArr[indexPath.row];
    cell.accessoryType = 1;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableview deselectRowAtIndexPath:indexPath animated:YES];
    ViewController *vc = [[ViewController alloc]init];
    vc.style = [NSString stringWithFormat:@"%ld", (long)indexPath.row + 1];
    [self.navigationController pushViewController:vc animated:YES];
}
















@end
