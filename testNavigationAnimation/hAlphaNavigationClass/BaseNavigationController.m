//
//  BaseNavigationController.m
//  HomeForPets
//
//  Created by 侯迎春 on 15/5/22.
//  Copyright (c) 2015年 侯迎春. All rights reserved.
//

#import "BaseNavigationController.h"

#import "UINavigationBar+hiddnBar.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

-(id)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self setNavigationBarLucency];
        self.delegate = self;
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    if (!self.alphaView) {
        [self setNavigationBarLucency];
    }
    
}
/**
 *  设置导航透明
 *  说清导航栏的关系
 *  导航栏上面3部分 naviBar NaviItem line  [导航栏 addSubView  naviBar]  [naviBar addsubview  各种NaviItem] [naviBar addsubview line]
 *  由上面看出 导航bar 是导航控件的主体
 *  只将导航的bar透明了就好 ,将导航的bar 背景颜色设置为clear，将导航bar的背景图片设置为 全透明图片(让UI做一个)
 *  item比如back title  right就不用透明 毕竟要用啊
 */
- (void) setNavigationBarLucency{
    //去掉返回按钮的文字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -100) forBarMetrics:UIBarMetricsDefault];
    
    //将背景清空
    self.navigationBar.backgroundColor = [UIColor clearColor];
    //背景图片清空
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"tran"] forBarMetrics:UIBarMetricsDefault];
    //将原生的导航分割线清除
    [self.navigationBar.layer setMasksToBounds:YES];
    
    //设计需要渐变效果怎么办，原生的你要设置alpha item也alpha了，所以在原生的下面加一个可以控制的透明VIew
    //原生的导航栏坐标 (0,0,屏幕宽,64)  插入到原生的下面去，原生清空了的，还可以看到下面的那个它
    self.alphaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 64)];
    [self.alphaView setBackgroundColor:[UIColor whiteColor]];
    [self.alphaView setAlpha:1];//默认不透明
    [self.view insertSubview:self.alphaView belowSubview:self.navigationBar];
    
    
    //原生的分割线没有属性可以更改位置 裁减掉后需要重新设置一个
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, [[UIScreen mainScreen]bounds].size.width, 0.5)];
    [lineView setBackgroundColor:[UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1]];//设置你需要的颜色
    [self.alphaView addSubview:lineView];
    
    self.navigationBar.handleWenSetHiddn = ^(BOOL hiddn){
        [self setAlphaBarHiddn:hiddn];
    };
}



// 隐藏假的导航
- (void) setAlphaBarHiddn:(BOOL)hiddn{
    [self.alphaView setHidden:hiddn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end


