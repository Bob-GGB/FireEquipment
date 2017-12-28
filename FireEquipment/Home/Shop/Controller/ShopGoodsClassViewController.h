//
//  ShopGoodsClassViewController.h
//  FireEquipment
//
//  Created by mc on 2017/12/8.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BaseViewController.h"

@interface ShopGoodsClassViewController : BaseViewController
@property (nonatomic,assign) NSInteger sellerIDNum;
@property (nonatomic,copy) NSString *HomeOrProtocol;//区分首页进入还是协议供货进入
@property (nonatomic,copy)void(^catIDBlock)(NSNumber *catIDnum);
@end
