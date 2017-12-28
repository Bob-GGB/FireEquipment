//
//  MBPHudView.h
//  FireEquipment
//
//  Created by mc on 2017/10/27.
//  Copyright © 2017年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBPHudView : NSObject
+ (void) showHUDWithText:(NSString *)message;
+ (void) showHUDAndView:(UIView *)View completionBlock:(void(^)(void))completionBlock;

@end
