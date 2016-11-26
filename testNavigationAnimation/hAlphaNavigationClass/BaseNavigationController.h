//
//  BaseNavigationController.h
//  HomeForPets
//
//  Created by 侯迎春 on 15/5/22.
//  Copyright (c) 2015年 侯迎春. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "testNavigationAnimation-swift.h"

@interface BaseNavigationController : UINavigationController<UINavigationControllerDelegate>

@property(nonatomic, retain)UIView *alphaView;

@end
