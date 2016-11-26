//
//  UIViewController+removeObsever.h
//  HomeForPets
//
//  Created by Admin on 2016/11/26.
//  Copyright © 2016年 侯迎春. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^viewDidDisApperBlock)();
typedef void(^viewWillApperBlock)();
typedef void(^viewDidApperBlock)();
@interface UIViewController (removeObsever)

/**
 *  当这个页面消失的时候 回调
 *
 */

@property (nonatomic, copy) viewDidDisApperBlock viewDidDisApperBlock;


/**
 *  快显示时回调
 *
 */
@property (nonatomic, copy) viewWillApperBlock viewWillApperBlock;

/**
 *  已经显示回调
 *
 */

@property (nonatomic, copy) viewDidApperBlock viewDidApperBlock;

//滑动的初始值
@property (nonatomic, strong) NSString *originalYString;

//记录这个页面的导航alpha值
@property (nonatomic, strong) NSString *alphaString;

//页面是怎么消失的，是pop消失的 还是push走的
@property (nonatomic,strong)NSString * dismisType;

//界面开始显示,效果才正式开启，不然，界面没有显示，scroller。contoffset的y也在变化
@property (nonatomic, strong)NSString * open;

//注册kvo的键值
@property (nonatomic,strong)NSString *keyContent;
@end
