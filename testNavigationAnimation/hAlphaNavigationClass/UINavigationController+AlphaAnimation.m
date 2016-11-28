//
//  UINavigationController+AlphaAnimation.m
//  HomeForPets
//
//  Created by Admin on 2016/11/26.
//  Copyright © 2016年 侯迎春. All rights reserved.
//



#import "UINavigationController+AlphaAnimation.h"
#import "UIViewController+removeObsever.h"
#import <Foundation/Foundation.h>
#import "BaseNavigationController.h"

@implementation UINavigationController (AlphaAnimation)

static char * _alphaDistance = "_alphaDistance";
static char * _scrollArray = "_scrollArray";
static char * _userVCArray = "_userVCArray";

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        // 选择器
        SEL originalSEL = @selector(pushViewController:animated:);
        SEL SwizzledSEL = @selector(hPushViewController:animated:);
        [UINavigationController exchange:originalSEL two:SwizzledSEL class:class];
        
        
        
        // 选择器
        SEL originalSEL1 = @selector(popViewControllerAnimated:);
        SEL SwizzledSEL1 = @selector(hPopViewControllerAnimated:);
        [UINavigationController exchange:originalSEL1 two:SwizzledSEL1 class:class];
    });
}


+ (void)exchange:(SEL)one two:(SEL)two class:(Class)class{
    // 选择器
    SEL originalSEL = one;
    SEL SwizzledSEL = two;
    
    // 方法
    Method originalMethod = class_getInstanceMethod(class, originalSEL);//class_getClassMethod(class, originalSEL);备注的是获取静态方法
    Method SwizzledMethod = class_getInstanceMethod(class, SwizzledSEL);//class_getClassMethod(class, SwizzledSEL);
    
    // 方法的实现
    IMP originalIMP = method_getImplementation(originalMethod);//class_getMethodImplementation(class, originalSEL);
    IMP SwizzledIMP = method_getImplementation(SwizzledMethod);//class_getMethodImplementation(class, SwizzledSEL);
    
    
    // 是否添加成功方法:添加了初始方法，实现内容指向目标方法体
    BOOL isSuccess = class_addMethod(class, originalSEL, SwizzledIMP, method_getTypeEncoding(SwizzledMethod));
    
    if (isSuccess) {
        // 初始指向目标，那么把目标的内容指向初始
        class_replaceMethod(class, SwizzledSEL, originalIMP, method_getTypeEncoding(originalMethod));
    }
    else{
        // 没有添加成功说明已经存在，就交换
        // 注意，这里交换的是IMP 实现
        method_exchangeImplementations(originalMethod, SwizzledMethod);
    }
    
}

#pragma mark- 检查传入的状态
- (void)checkChangeStatus:(BOOL)isChangeStatus isChangeTitle:(BOOL)isChangeTitle vc:(UIViewController *)vc{
    if (isChangeTitle) {
        vc.isChangeTitle = @"openChange";
        vc.savetitle = vc.title;
        vc.title = @"";
    }
    else{
        vc.isChangeTitle = nil;
    }
    
    
    if (isChangeStatus) {
        vc.isChangeStatus = @"openChange";
    }
    else{
        vc.isChangeStatus = nil;
    }
}

#pragma mark --  功能入口导航栏渐变动画
- (void) openNavigationBarAlphaAnimationWithTarget:(id)target scrollerName:(NSString*)scrollerName isChangeStatus:(BOOL)isChangeStatus isChangeTitle:(BOOL)isChangeTitle alphaDistance:(CGFloat)alphaDistance{
    
    UIViewController *currentViewControl = (UIViewController *)target;
    UIScrollView *currentScroller = (UIScrollView *)[target valueForKeyPath:scrollerName];
    
    if (!currentScroller) return;
    [self initArray];
    //添加vc改变栈的顺序
    [self checkVCadd:currentViewControl];
    //添加scroll改变栈的顺序
    [self checkSCROLLadd:currentScroller];
    
    
    //栈中的位置
    int index = [self getVcIndex:currentViewControl];
    UIViewController * currentVC = (UIViewController*)self.userVCArray[index];
    
    //检查是否改变状态
    [self checkChangeStatus:isChangeStatus isChangeTitle:isChangeTitle vc:currentViewControl];
    //检查alpha值  如果以前是push走的，回来接着处理alpha值
    [self checkAlphaNum:[currentViewControl.alphaString floatValue] vc:currentViewControl];
    
    //更新此页的alpha值，如果有并且push走的
    if (currentVC.alphaString) {
        [self hGetAlphaView].alpha = [currentVC.alphaString floatValue];
    }
    
    //注册此页的生命周期回调
    [self registeredLifeCycleBlockWithController:currentVC];
    
    self.alphaDistance = [NSString stringWithFormat:@"%f",alphaDistance];
}

#pragma mark --  生命周期回调
- (void)registeredLifeCycleBlockWithController:(UIViewController*)currentViewControl
{
    
    __weak typeof(self) weak_self = self;
    
    
    //就是从viewwillAppear启动的
    int index = [self getVcIndex:currentViewControl];
    if (currentViewControl.keyContent == nil) {
        currentViewControl.keyContent = [self getCurrentTime];
    }
    [self.scrollArray[index] addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(currentViewControl.keyContent)];
    
    
    
    
    //已经显示
    currentViewControl.viewDidApperBlock = ^{
        UIView *alphaView = [weak_self hGetAlphaView];
        alphaView.alpha = 0;
        
        //如果以前就有alpha值
        UIViewController *didShowViewController = (UIViewController*)[weak_self.userVCArray lastObject];
        if (didShowViewController.alphaString) {
            alphaView.alpha = [didShowViewController.alphaString floatValue];
        }
        else{
            //新人报道
            didShowViewController.alphaString = @"0";
        }
        
        didShowViewController.open = @"open";
    };
    
    
    //将要消失
    __block UIViewController*willDisShowViewController = currentViewControl;
    currentViewControl.viewWillDisApperBlock = ^{
        willDisShowViewController.open = nil;
        if (willDisShowViewController.isChangeTitle) {
            willDisShowViewController.title = willDisShowViewController.savetitle;
        }
    };
    
    
    
    //已经消失
    currentViewControl.viewDidDisApperBlock = ^{
        NSUInteger index = [weak_self.userVCArray count] - 2;
        index = [weak_self.userVCArray count] == 1 ? 0 : index;
        
        UIViewController * disShowViewController = [weak_self.userVCArray objectAtIndex:index];
        
        disShowViewController.open = nil;
        
        [[self.scrollArray objectAtIndex:index] removeObserver:self forKeyPath:@"contentOffset" context:(__bridge void * _Nullable)(disShowViewController.keyContent)];//先移除对象注册，再删除对象，不然栈顺序错了
        
        
        if ([disShowViewController.alphaString floatValue]>=1 && disShowViewController.isChangeStatus) {
            [weak_self changeStatus];
        }
        
        if (disShowViewController.isChangeTitle) {
            disShowViewController.title = disShowViewController.savetitle;
        }
        
        if ([disShowViewController.dismisType isEqualToString:@"pop"]) {
            [weak_self.userVCArray removeObjectAtIndex:index];
            [weak_self.scrollArray removeObjectAtIndex:index];
        }
    };

}

#pragma mark - KVO事件
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    int index = [self getScrollIndex:(UIScrollView*)object];
    UIViewController * currentVC = (UIViewController*)self.userVCArray[index];
    if (context == CFBridgingRetain(currentVC.keyContent)) {
        
        CGPoint point = [(UIScrollView *)object contentOffset];
        UIView *alphaView = [self hGetAlphaView];
        //没有渐变view 失败
        if (!alphaView) {
            return;
        }
        
        //初始的滑动值
        float originalY = [self checkFirstHaveValue:point.y];
        //渐变距离
        float alphaDistance =  [self.alphaDistance floatValue];
        alphaView.alpha = 0;
        
        //差距值 只有比初始值大，才代表往上滑动，才开始记录
        if (point.y > originalY) {
            if ( currentVC.open&&[currentVC.open isEqualToString:@"open"]) {
                //滑动的距离
                float spaceY = point.y - originalY;
                
                float alphaNum =  1.0/alphaDistance * spaceY;
                
                [self checkAlphaNum:alphaNum vc:currentVC];
                
                //渐变距离内渐变
                alphaView.alpha =  alphaNum;
                
                currentVC.alphaString = [NSString stringWithFormat:@"%.2f",alphaNum];
            }
            else{
                if (currentVC.alphaString) {
                    alphaView.alpha = [currentVC.alphaString floatValue];
                }
            }
        }
    }
}
#pragma mark - 根据alpha值判断是否应该改变状态、标题
- (void)checkAlphaNum:(float)alphaNumber vc:(UIViewController*)vc{
    if (alphaNumber>=1) {
        
        if (vc.isChangeTitle) {
            vc.title = vc.savetitle;
        }
        
        if (vc.isChangeStatus && [vc.isChangeStatus  isEqualToString:@"openChange"]) {
            vc.isChangeStatus = @"closeChange";
            [self changeStatus];
        }
    }
    else{
        
        if (vc.isChangeTitle) {
            vc.title = @"";
        }
        
        if (vc.isChangeStatus &&[vc.isChangeStatus isEqualToString:@"closeChange"]) {
            vc.isChangeStatus = @"openChange";
            [self changeStatus];
        }
    }
}

#pragma mark - 改变状态栏
- (void) changeStatus{
    UIStatusBarStyle stype = [[UIApplication sharedApplication]statusBarStyle];
    if (stype == UIStatusBarStyleDefault) {
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    else if (stype == UIStatusBarStyleLightContent){
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    }
}



#pragma mark 初始化数组
- (void) initArray{
    if (!self.scrollArray) {
        self.scrollArray = [NSMutableArray array];
    }
    if (!self.userVCArray) {
        self.userVCArray = [NSMutableArray array];
    }
}

#pragma mark -- 检查栈
//检查栈里有没有scroller
- (void)checkSCROLLadd:(UIScrollView*)scroll{
    BOOL isHave = NO;
    int index = -1;//-1默认无效
    for (UIScrollView*scro in self.scrollArray) {
        index ++;
        if (scro == scroll) {
            isHave = YES;
            break;
        }
    }
    
    if (isHave) {
        //有就换到栈的顶端
        [self.scrollArray exchangeObjectAtIndex:index withObjectAtIndex:[self.scrollArray count]-1];
    }
    else{
        //没有就添加
        [self.scrollArray addObject:scroll];
    }
}

//检查栈里有没有这个vc
- (void)checkVCadd:(UIViewController *)vc{
    BOOL isHave = NO;
    int index = -1;//-1默认无效
    for (UIViewController*viewController in self.userVCArray) {
        index ++;
        if (viewController == vc) {
            isHave = YES;
            break;
        }
    }
    
    if (isHave) {
        //有就换到栈的顶端
        [self.userVCArray exchangeObjectAtIndex:index withObjectAtIndex:[self.userVCArray count]-1];
    }
    else{
        //没有就添加
        [self.userVCArray addObject:vc];
    }
}

#pragma mark - pop and  push
- (UIViewController *)hPopViewControllerAnimated:(BOOL)animated{
    
    //pop 的时候当前vc还没有消失
    UIViewController *vc = (UIViewController*)[self.userVCArray lastObject];
    vc.dismisType = @"pop";
    
    return  [self hPopViewControllerAnimated:animated];
}

- (void)hPushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //push 的时候当前vc还没有消失
    UIViewController *vc = (UIViewController*)[self.userVCArray lastObject];
    vc.dismisType = @"push";
    [self hPushViewController:viewController animated:animated];
}

#pragma mark - 第一次进来
- (float)checkFirstHaveValue:(float)value{
    float originalValue;
    UIViewController *vc = (UIViewController*)[self.userVCArray lastObject];
    if (!vc.originalYString) {
        vc.originalYString = [NSString stringWithFormat:@"%f",value];
        
    }
    
    originalValue = [vc.originalYString floatValue];
    
    return originalValue;
}

#pragma mark --获取当前时间
- (NSString *)getCurrentTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];//创建日期格式对象
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:SS"];//为对象设置日期的格式
    NSString *st = [formatter stringFromDate:date];
    return st;
}
#pragma mark --获取alphaVIew
- (UIView *)hGetAlphaView{
    UIView *alphaView;
    //取到渐变view
    if([self isKindOfClass:[BaseNavigationController class]]){
        alphaView = [self valueForKeyPath:@"alphaView"];
    }
    return alphaView;
}

#pragma mark --获取scroll下标
- (int)getScrollIndex:(UIScrollView*)scroll{
    int index = -1;//-1默认无效
    for (UIScrollView*scro in self.scrollArray) {
        index ++;
        if (scro == scroll) {
            break;
        }
    }
    return index;
}
#pragma mark --获取vc的下标
- (int)getVcIndex:(UIViewController*)vc{
    int index = -1;//-1默认无效
    for (UIViewController*viewController in self.userVCArray) {
        index ++;
        if (viewController == vc) {
            break;
        }
    }
    return index;
}
#pragma mark - 属性 GET  SET
- (NSMutableArray *)userVCArray{
    return objc_getAssociatedObject(self, _userVCArray);
}
- (void)setUserVCArray:(NSMutableArray *)userVCArray{
    objc_setAssociatedObject(self, _userVCArray, userVCArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)alphaDistance{
    return objc_getAssociatedObject(self, _alphaDistance);
}

- (void)setAlphaDistance:(NSString *)alphaDistance{
    objc_setAssociatedObject(self, _alphaDistance, alphaDistance, OBJC_ASSOCIATION_RETAIN);
}

-(NSMutableArray *)scrollArray{
    return  objc_getAssociatedObject(self, _scrollArray);
}
- (void)setScrollArray:(NSMutableArray *)scrollArray{
    objc_setAssociatedObject(self, _scrollArray, scrollArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end




