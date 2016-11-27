//
//  nextViewController2.m
//  testNavigationAnimation
//
//  Created by Admin on 2016/11/27.
//  Copyright © 2016年 asd. All rights reserved.
//

#import "nextViewController2.h"
#import "navigationAnimation.h"


@interface nextViewController2 ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *asdfgg;

@end

@implementation nextViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.title = @"第三页测试";
    self.asdfgg = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.asdfgg];
    
    self.view.backgroundColor = [UIColor blueColor];
    self.asdfgg.backgroundColor = [UIColor yellowColor];
    
    
    self.asdfgg.delegate = self;
    self.asdfgg.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController openNavigationBarAlphaAnimationWithTarget:self scrollerName:@"asdfgg" isChangeStatus:YES isChangeTitle:NO alphaDistance:100];
    //[self.navigationController openNavigationBarAlphaAnimationWithTarget:self scrollerName:@"asdfgg" alphaDistance:100.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    cell.backgroundColor = [UIColor redColor];
    return cell;
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
