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
 *  @param isChangeStatus
 *  是否需要改变状态栏
 *
 *  @param isChangeTitle
 *  是否改变title
 *
 *  @param alphaDistance
 *  超过这个值就不透明了
 */
- (void) openNavigationBarAlphaAnimationWithTarget:(id)target scrollerName:(NSString*)scrollerName isChangeStatus:(BOOL)isChangeStatus isChangeTitle:(BOOL)isChangeTitle alphaDistance:(CGFloat)alphaDistance;

//渐变的距离,距离顶部多少范围内渐变
@property (nonatomic,assign) NSString* alphaDistance;

//使用渐变的scroll数组
@property (nonatomic,strong) NSMutableArray *scrollArray;

//使用过动画的数组vc
@property (nonatomic,strong) NSMutableArray *userVCArray;

@end
