//
//  UINavigationController+AlphaAnimation.h
//  HomeForPets
//
//  Created by Admin on 2016/11/26.
//  Copyright © 2016年 侯迎春. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UINavigationController (AlphaAnimation)

/**
 *  一个方法开启导航渐变效果
 *
 *  @param target
 *  需要实现的ViewController  例如在需要的vc  填self
 *
 *  @param scrollerName
 *  作为对比的scroller属性名字  例如 MytableView
 *
 */
- (void) openNavigationBarAlphaAnimationWithTarget:(id)target scrollerName:(NSString*)scrollerName alphaDistance:(CGFloat)alphaDistance;

//渐变的距离,距离顶部多少范围内渐变
@property (nonatomic,assign) NSString* alphaDistance;

//使用渐变的scroll数组
@property (nonatomic,strong) NSMutableArray *scrollArray;

//使用过动画的数组vc
@property (nonatomic,strong) NSMutableArray *userVCArray;

@end
