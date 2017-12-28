//
//  BoughtInfoBtnTableViewCell.h
//  FireEquipment
//
//  Created by mc on 2017/11/30.
//  Copyright © 2017年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PPBadgeView.h"
@interface BoughtInfoBtnTableViewCell : UIView
@property (nonatomic,strong) PPBadgeLabel *badgeLabel;
@property (nonatomic,strong) UIButton *Btn;


-(instancetype)initWithTitleArr:(NSArray *)titleArr andImageArr:(NSArray *)imageArr andBadgeArr:(NSArray *)badgeArr ;
@end
