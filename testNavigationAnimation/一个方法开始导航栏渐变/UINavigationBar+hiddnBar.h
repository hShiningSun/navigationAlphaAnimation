//
//  UINavigationBar+hiddnBar.h
//  HomeForPets
//
//  Created by Admin on 2016/11/25.
//  Copyright © 2016年 侯迎春. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void(^handleWenSetHiddn)(BOOL hiddn);
@interface UINavigationBar (hiddnBar)

/**
 *  有子类在设置 hiddn 属性时 回调
 *
 */

@property (nonatomic, copy) handleWenSetHiddn handleWenSetHiddn;


@end
