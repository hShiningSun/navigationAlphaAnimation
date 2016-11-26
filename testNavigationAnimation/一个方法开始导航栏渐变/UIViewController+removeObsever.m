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
        SEL originalSEL1 = @selector(viewWillAppear:);
        SEL SwizzledSEL1 = @selector(hViewWillAppear:);
        
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

        
        // 选择器
        SEL originalSEL2 = @selector(viewDidAppear:);
        SEL SwizzledSEL2 = @selector(hViewDidAppear:);
        
        // 方法
        Method originalMethod2 = class_getInstanceMethod(class, originalSEL2);//class_getClassMethod(class, originalSEL);备注的是获取静态方法
        Method SwizzledMethod2 = class_getInstanceMethod(class, SwizzledSEL2);//class_getClassMethod(class, SwizzledSEL);
        
        // 方法的实现
        IMP originalIMP2 = method_getImplementation(originalMethod2);//class_getMethodImplementation(class, originalSEL);
        IMP SwizzledIMP2 = method_getImplementation(SwizzledMethod2);//class_getMethodImplementation(class, SwizzledSEL);
        
        
        // 是否添加成功方法:添加了初始方法，实现内容指向目标方法体
        BOOL isSuccess2 = class_addMethod(class, originalSEL2, SwizzledIMP2, method_getTypeEncoding(SwizzledMethod2));
        
        if (isSuccess2) {
            // 初始指向目标，那么把目标的内容指向初始
            class_replaceMethod(class, SwizzledSEL2, originalIMP2, method_getTypeEncoding(originalMethod2));
        }
        else{
            // 没有添加成功说明已经存在，就交换
            // 注意，这里交换的是IMP 实现
            method_exchangeImplementations(originalMethod2, SwizzledMethod2);
        }

        
        
        // 选择器
        SEL originalSEL3 = @selector(dismissViewControllerAnimated:completion:);
        SEL SwizzledSEL3 = @selector(hDismissViewControllerAnimated:completion:);
        
        // 方法
        Method originalMethod3 = class_getInstanceMethod(class, originalSEL3);//class_getClassMethod(class, originalSEL);备注的是获取静态方法
        Method SwizzledMethod3 = class_getInstanceMethod(class, SwizzledSEL3);//class_getClassMethod(class, SwizzledSEL);
        
        // 方法的实现
        IMP originalIMP3 = method_getImplementation(originalMethod3);//class_getMethodImplementation(class, originalSEL);
        IMP SwizzledIMP3 = method_getImplementation(SwizzledMethod3);//class_getMethodImplementation(class, SwizzledSEL);
        
        
        // 是否添加成功方法:添加了初始方法，实现内容指向目标方法体
        BOOL isSuccess3 = class_addMethod(class, originalSEL3, SwizzledIMP3, method_getTypeEncoding(SwizzledMethod3));
        
        if (isSuccess3) {
            // 初始指向目标，那么把目标的内容指向初始
            class_replaceMethod(class, SwizzledSEL3, originalIMP3, method_getTypeEncoding(originalMethod3));
        }
        else{
            // 没有添加成功说明已经存在，就交换
            // 注意，这里交换的是IMP 实现
            method_exchangeImplementations(originalMethod3, SwizzledMethod3);
        }

        
        
        // 选择器
        SEL originalSEL4 = @selector(presentViewController:animated:completion:);
        SEL SwizzledSEL4 = @selector(hPresentViewController:animated:completion:);
        
        // 方法
        Method originalMethod4 = class_getInstanceMethod(class, originalSEL4);//class_getClassMethod(class, originalSEL);备注的是获取静态方法
        Method SwizzledMethod4 = class_getInstanceMethod(class, SwizzledSEL4);//class_getClassMethod(class, SwizzledSEL);
        
        // 方法的实现
        IMP originalIMP4 = method_getImplementation(originalMethod4);//class_getMethodImplementation(class, originalSEL);
        IMP SwizzledIMP4 = method_getImplementation(SwizzledMethod4);//class_getMethodImplementation(class, SwizzledSEL);
        
        
        // 是否添加成功方法:添加了初始方法，实现内容指向目标方法体
        BOOL isSuccess4 = class_addMethod(class, originalSEL4, SwizzledIMP4, method_getTypeEncoding(SwizzledMethod4));
        
        if (isSuccess4) {
            // 初始指向目标，那么把目标的内容指向初始
            class_replaceMethod(class, SwizzledSEL4, originalIMP4, method_getTypeEncoding(originalMethod4));
        }
        else{
            // 没有添加成功说明已经存在，就交换
            // 注意，这里交换的是IMP 实现
            method_exchangeImplementations(originalMethod4, SwizzledMethod4);
        }

        
    });
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
