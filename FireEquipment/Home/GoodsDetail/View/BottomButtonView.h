//
//  BottomButtonView.h
//  FireEquipment
//
//  Created by mc on 2017/12/5.
//  Copyright © 2017年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomButtonView : UIView
@property (nonatomic,strong) UIButton *buyButton;
@property (nonatomic , strong) void(^sendController)(void);
@end
