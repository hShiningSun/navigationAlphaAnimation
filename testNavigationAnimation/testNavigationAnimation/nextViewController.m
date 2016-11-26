//
//  nextViewController.m
//  testNavigationAnimation
//
//  Created by Admin on 2016/11/26.
//  Copyright © 2016年 asd. All rights reserved.
//

#import "nextViewController.h"

#import "navigationAnimation.h"
#import "nextViewController2.h"

@interface nextViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation nextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"第二页测试";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height) style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor blueColor];
    self.tableView.backgroundColor = [UIColor orangeColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController openNavigationBarAlphaAnimationWithTarget:self scrollerName:@"tableView" alphaDistance:100];
}




///高度
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height =44;
    
    
    return height;
}
///多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger num=50;
    
    
    
    return num;
}

///多少区域
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

///cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = @"点击进入下一个测试页面";
    cell.backgroundColor = [UIColor darkGrayColor];
    return cell;
}

///点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    nextViewController2 *vc = [[nextViewController2 alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
