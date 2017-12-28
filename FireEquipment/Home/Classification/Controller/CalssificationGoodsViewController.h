//
//  CalssificationGoodsViewController.h
//  FireEquipment
//
//  Created by mc on 2017/12/14.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BaseViewController.h"

@interface CalssificationGoodsViewController : BaseViewController
@property (nonatomic,assign) NSInteger sellerIDNum;
@property (nonatomic, copy) NSString *sellerNameStr;
@property (nonatomic,copy) NSString *HomeOrProtocol;//区分首页进入还是协议供货进入
@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,strong) NSNumber *catIDNum;
@property (nonatomic,assign) NSInteger indexPathRow;//接收协议供货二级分类cell的下标
@end
