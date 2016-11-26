//
//  UINavigationBar+hiddnBar.m
//  HomeForPets
//
//  Created by Admin on 2016/11/25.
//  Copyright © 2016年 侯迎春. All rights reserved.
//

#import "UINavigationBar+hiddnBar.h"

@implementation UINavigationBar (hiddnBar)

static char *_handleWenSetHiddn = "_handleWenSetHiddn";

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        // 选择器
        SEL originalSEL = @selector(setHidden:);
        SEL SwizzledSEL = @selector(hSetHiddn:);
        
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
        
    });
    
}

- (void)hSetHiddn:(BOOL)hiddn{
    [self hSetHiddn:hiddn];
    
    if (self.handleWenSetHiddn) {
        self.handleWenSetHiddn(hiddn);
    }
}

- (handleWenSetHiddn)handleWenSetHiddn{
    return  objc_getAssociatedObject(self, _handleWenSetHiddn);
}

- (void)setHandleWenSetHiddn:(handleWenSetHiddn)handleWenSetHiddn{
    
    
    /*
     OBJC_ASSOCIATION_ASSIGN;            //assign策略
     OBJC_ASSOCIATION_COPY_NONATOMIC;    //copy策略
     OBJC_ASSOCIATION_RETAIN_NONATOMIC;  // retain策略
     
     OBJC_ASSOCIATION_RETAIN;
     OBJC_ASSOCIATION_COPY;
     */
    /*
     * id object 给哪个对象的属性赋值
     const void *key 属性对应的key
     id value  设置属性值为value
     objc_AssociationPolicy policy  使用的策略，是一个枚举值，和copy，retain，assign是一样的，手机开发一般都选择NONATOMIC
     objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
     */
    objc_setAssociatedObject(self, _handleWenSetHiddn, handleWenSetHiddn,OBJC_ASSOCIATION_COPY_NONATOMIC);
}




@end









