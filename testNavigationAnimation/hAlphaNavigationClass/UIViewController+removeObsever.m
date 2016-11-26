//
//  UIViewController+removeObsever.m
//  HomeForPets
//
//  Created by Admin on 2016/11/26.
//  Copyright © 2016年 侯迎春. All rights reserved.
//

#import "UIViewController+removeObsever.h"
#import "UINavigationController+AlphaAnimation.h"


@implementation UIViewController (removeObsever)

static char *_viewDidDisApperBlock = "_viewDidDisApperBlock";
static char *_viewWillApperBlock = "_viewWillApperBlock";
static char *_viewDidApperBlock = "_viewDidApperBlock";
static char *_viewWillDisApperBlock = "_viewWillDisApperBlock";

static char *_originalYString = "_originalYString";
static char *_alphaString  = "_alphaString";
static char *_dismisType = "_dismisType";
static char *_open = "_open";
static char *_keyContent = "_keyContent";

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        // 选择器
        SEL originalSEL = @selector(viewDidDisappear:);
        SEL SwizzledSEL = @selector(hViewDidDisappear:);
        [UIViewController exchange:originalSEL two:SwizzledSEL class:class];
        
        // 选择器
        SEL originalSEL1 = @selector(viewWillAppear:);
        SEL SwizzledSEL1 = @selector(hViewWillAppear:);
        [UIViewController exchange:originalSEL1 two:SwizzledSEL1 class:class];
        
        
        // 选择器
        SEL originalSEL2 = @selector(viewDidAppear:);
        SEL SwizzledSEL2 = @selector(hViewDidAppear:);
        [UIViewController exchange:originalSEL2 two:SwizzledSEL2 class:class];
        
        // 选择器
        SEL originalSEL3 = @selector(dismissViewControllerAnimated:completion:);
        SEL SwizzledSEL3 = @selector(hDismissViewControllerAnimated:completion:);
        [UIViewController exchange:originalSEL3 two:SwizzledSEL3 class:class];
        
        // 选择器
        SEL originalSEL4 = @selector(presentViewController:animated:completion:);
        SEL SwizzledSEL4 = @selector(hPresentViewController:animated:completion:);
        [UIViewController exchange:originalSEL4 two:SwizzledSEL4 class:class];
        
        // 选择器
        SEL originalSEL5 = @selector(viewWillDisappear:);
        SEL SwizzledSEL5 = @selector(hViewWillDisappear:);
        [UIViewController exchange:originalSEL5 two:SwizzledSEL5 class:class];

        
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

- (void)hViewWillDisappear:(BOOL)animated{
    [self hViewWillDisappear:animated];
    if (self.viewWillDisApperBlock) {
        self.viewWillDisApperBlock();
        self.viewWillDisApperBlock = nil;
    }
}


- (void)hDismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    self.dismisType = @"pop";
    [self hDismissViewControllerAnimated:flag completion:completion];
}

- (void)hPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    self.dismisType = @"push";
    [self hPresentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)hViewDidAppear:(BOOL)animated;{
    [self hViewDidAppear:animated];
    if (self.viewDidApperBlock != nil) {
        self.viewDidApperBlock();
        self.viewDidApperBlock = nil;
    }
}

- (void)hViewWillAppear:(BOOL)animated;{
    [self hViewWillAppear:animated];
    if (self.viewWillApperBlock != nil) {
        self.viewWillApperBlock();
        self.viewWillApperBlock = nil;
    }
}

- (void)hViewDidDisappear:(BOOL)animated;{
    if (self.viewDidDisApperBlock) {
        self.viewDidDisApperBlock();
        self.viewDidDisApperBlock = nil;
    }
    [self hViewDidDisappear:animated];

}



- (viewWillDisApperBlock)viewWillDisApperBlock{
    return objc_getAssociatedObject(self, _viewWillDisApperBlock);
}


- (void)setViewWillDisApperBlock:(viewWillDisApperBlock)viewWillDisApperBlock{
    objc_setAssociatedObject(self, _viewWillDisApperBlock, viewWillDisApperBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (viewWillApperBlock)viewWillApperBlock{
    return  objc_getAssociatedObject(self, _viewWillApperBlock);

}

- (void)setViewWillApperBlock:(viewWillApperBlock)viewWillApperBlock{
    objc_setAssociatedObject(self, _viewWillApperBlock, viewWillApperBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (viewDidApperBlock)viewDidApperBlock{
    return  objc_getAssociatedObject(self, _viewDidApperBlock);
    
}

- (void)setViewDidApperBlock:(viewWillApperBlock)viewDidApperBlock{
    objc_setAssociatedObject(self, _viewDidApperBlock, viewDidApperBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (viewDidDisApperBlock)viewDidDisApperBlock{
    return  objc_getAssociatedObject(self, _viewDidDisApperBlock);
}

- (void)setViewDidDisApperBlock:(viewDidDisApperBlock)viewDidDisApperBlock{
    
    objc_setAssociatedObject(self, _viewDidDisApperBlock, viewDidDisApperBlock,OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)originalYString{
    return objc_getAssociatedObject(self, _originalYString);
}
- (void)setOriginalYString:(NSString *)originalYString{
    objc_setAssociatedObject(self, _originalYString, originalYString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)alphaString{
    return objc_getAssociatedObject(self, _alphaString);
}

- (void)setAlphaString:(NSString *)alphaString{
    objc_setAssociatedObject(self, _alphaString, alphaString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)dismisType{
    return  objc_getAssociatedObject(self, _dismisType);
}
- (void)setDismisType:(NSString *)dismisType{
    objc_setAssociatedObject(self, _dismisType, dismisType, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)open{
    return objc_getAssociatedObject(self, _open);
}
- (void)setOpen:(NSString *)open{
    objc_setAssociatedObject(self, _open, open, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)keyContent{
    return objc_getAssociatedObject(self, _keyContent);
}
- (void)setKeyContent:(NSString *)keyContent{
    objc_setAssociatedObject(self, _keyContent, keyContent, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
