//
//  ViewController.m
//  testNavigationAnimation
//
//  Created by Admin on 2016/11/26.
//  Copyright © 2016年 asd. All rights reserved.
//

#import "ViewController.h"

#import "testNavigationAnimation-swift.h"       //项目中OC对Swift引用
#import "navigationAnimation.h"

#import "nextViewController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *testTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"往上滑动试试吧";
    
    //设置背景方便观察
    self.view.backgroundColor = [UIColor brownColor];
    self.testTableView.backgroundColor = [UIColor yellowColor];
    
    self.testTableView.delegate = self;
    self.testTableView.dataSource = self;
    
   // [self.testTableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //开启渐变效果
    [self.navigationController openNavigationBarAlphaAnimationWithTarget:self scrollerName:@"testTableView" alphaDistance:50.0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickNext:(id)sender {
    nextViewController *vc = [[nextViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
    return cell;
}

///点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    nextViewController *vc = [[nextViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
