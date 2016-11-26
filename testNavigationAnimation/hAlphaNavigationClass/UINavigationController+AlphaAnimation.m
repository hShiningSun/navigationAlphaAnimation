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
        
        
        
        // 选择器
        SEL originalSEL1 = @selector(popViewControllerAnimated:);
        SEL SwizzledSEL1 = @selector(hPopViewControllerAnimated:);
        
        // 方法
        Method originalMethod1 = class_getInstanceMethod(class, originalSEL1);//class_getClassMethod(class, originalSEL);备注的是获取静态方法
        Method SwizzledMethod1 = class_getInstanceMethod(class, SwizzledSEL1);//class_getClassMethod(class, SwizzledSEL);
        
        // 方法的实现
        IMP originalIMP1 = method_getImplementation(originalMethod1);//class_getMethodImplementation(class, originalSEL);
        IMP SwizzledIMP1 = method_getImplementation(SwizzledMethod1);//class_getMethodImplementation(class, SwizzledSEL);
        
        
        // 是否添加成功方法:添加了初始方法，实现内容指向目标方法体
        BOOL isSuccess1 = class_addMethod(class, originalSEL1, SwizzledIMP1, method_getTypeEncoding(SwizzledMethod1));
        
        if (isSuccess1) {
            // 初始指向目标，那么把目标的内容指向初始
            class_replaceMethod(class, SwizzledSEL1, originalIMP1, method_getTypeEncoding(originalMethod1));
        }
        else{
            // 没有添加成功说明已经存在，就交换
            // 注意，这里交换的是IMP 实现
            method_exchangeImplementations(originalMethod1, SwizzledMethod1);
        }

    });
}
   
        
                  
                  

#pragma mark --  功能入口导航栏渐变动画
- (void) openNavigationBarAlphaAnimationWithTarget:(id)target scrollerName:(NSString*)scrollerName alphaDistance:(CGFloat)alphaDistance{
    
    UIViewController *currentViewControl = (UIViewController *)target;
    UIScrollView *currentScroller = (UIScrollView *)[target valueForKeyPath:scrollerName];
    
    if (!currentScroller) return;
    [self initArray];
    //添加vc
    [self checkVCadd:currentViewControl];
    //添加scroll
    [self checkSCROLLadd:currentScroller];
 
    
    int index = [self getVcIndex:currentViewControl];
    UIViewController * currentVC = (UIViewController*)self.userVCArray[index];
    
    if (currentVC.alphaString) {
        [self hGetAlphaView].alpha = [currentVC.alphaString floatValue];
    }
    
    
    //获取注册kvo的关键key
    if (!currentVC.keyContent) {
        currentVC.keyContent = [self getCurrentTime];
    }
    
    // 注册
    [self.scrollArray[index] addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:(__bridge void * _Nullable)(currentVC.keyContent)];

    //移除
    __weak typeof(self) weak_self = self;
   
    currentVC.viewDidDisApperBlock = ^{
        NSUInteger index = [weak_self.userVCArray count] - 2;
        UIViewController * vc = [weak_self.userVCArray objectAtIndex:index];//-1最后一个，-2倒数第二个
        vc.open = nil;
        NSLog(@"\n%@---走了====%.2f",vc.title,[vc.alphaString floatValue]);
        [[weak_self.scrollArray objectAtIndex:index] removeObserver:self forKeyPath:@"contentOffset" context:(__bridge void * _Nullable)(vc.keyContent)];
        
        if ([vc.dismisType isEqualToString:@"pop"]) {
            [weak_self.userVCArray removeObjectAtIndex:index];
            [weak_self.scrollArray removeObjectAtIndex:index];
        }
    };

    [self firstLoadAnimation:currentViewControl];
    
    self.alphaDistance = [NSString stringWithFormat:@"%f",alphaDistance];
}

#pragma mark --  第一次加载动画设置透明
- (void)firstLoadAnimation:(UIViewController*)currentViewControl{

    __weak typeof(self) weak_self = self;
    currentViewControl.viewDidApperBlock = ^{
        UIView *alphaView;
        //取到渐变view
        if([weak_self isKindOfClass:[BaseNavigationController class]]){
            alphaView = [weak_self valueForKeyPath:@"alphaView"];
        }
        
        //没有渐变view 失败
        if (!alphaView) {
            return;
        }
        alphaView.alpha = 0;
        
        //如果以前就有alpha值
        UIViewController *vc = (UIViewController*)[weak_self.userVCArray lastObject];
        if (vc.alphaString) {
            NSLog(@"\n%@---回来了====%.2f",vc.title,[vc.alphaString floatValue]);
            alphaView.alpha = [vc.alphaString floatValue];
        }
        else{
            //新人报道
            vc.alphaString = @"0";
        }
        
        vc.open = @"open";
    };
    
    __block UIViewController*vc = currentViewControl;
    currentViewControl.viewWillDisApperBlock = ^{
        vc.open = nil;
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
                //渐变距离内渐变
                alphaView.alpha = 1.0/alphaDistance * spaceY;
                //记录 alpha值
                //有才设置，没有说明是第一次进来，第一次进来先去firstLoadAnimation 报道
                currentVC.alphaString = [NSString stringWithFormat:@"%.2f",1.0/alphaDistance * spaceY];
                
                NSLog(@"\n%@---在变化====%.2f",currentVC.title,[currentVC.alphaString floatValue]);
            }
            else{
                if (currentVC.alphaString) {
                   alphaView.alpha = [currentVC.alphaString floatValue];
                }
            }
        }
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




