//
//  BrandListViewController.h
//  FireEquipment
//
//  Created by mc on 2017/11/22.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BaseViewController.h"

@interface BrandListViewController : BaseViewController
@property (nonatomic,strong) NSNumber *CatID;
@property (nonatomic,copy) NSString *HomeOrProtocol;//区分首页进入还是协议供货进入
@end
