//
//  OneCellView.h
//  FireEquipment
//
//  Created by mc on 2017/11/29.
//  Copyright © 2017年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneCellView : UIView
@property (nonatomic,strong) UIButton *shopCarButton;

@property (nonatomic , strong) void(^sendViewController)(UIViewController * controller);
-(instancetype)initWithRoleID:(NSNumber *)roleIDNum;

@end
