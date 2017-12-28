//
//  UINavigationController+StatusBar.m
//  FireEquipment
//
//  Created by mc on 2017/12/18.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "UINavigationController+StatusBar.h"

@implementation UINavigationController (StatusBar)
- (UIStatusBarStyle)preferredStatusBarStyle {
    return [[self topViewController] preferredStatusBarStyle];
}
@end
