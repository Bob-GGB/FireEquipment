//
//  UIColor+ColoChange.h
//  FireEquipment
//
//  Created by mc on 2017/11/20.
//  Copyright © 2017年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColoChange)
// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;
@end
