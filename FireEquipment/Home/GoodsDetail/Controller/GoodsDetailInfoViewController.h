//
//  GoodsDetailInfoViewController.h
//  FireEquipment
//
//  Created by mc on 2017/11/24.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BaseViewController.h"

@interface GoodsDetailInfoViewController : BaseViewController
@property (nonatomic,strong) NSNumber *productIDNum;
@property (nonatomic,strong) NSArray *titleCountArr;
@property (nonatomic,copy) NSString *HomeOrProtocol;//区分首页进入还是协议供货进入
@end
