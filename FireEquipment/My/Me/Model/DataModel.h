//
//  DataModel.h
//  FireEquipment
//
//  Created by mc on 2017/12/1.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BaseModel.h"

/* 准入商
 checkFailProduct = 1;
 checkSuccessProduct = 3;
 name = "\U6d59\U6c5f\U56fd\U6e90\U6d88\U9632\U79d1\U6280\U6709\U9650\U516c\U53f8";
 roleID = 1;
 status = 1;
 uncheckProduct = 0;
 warehousing = 0;
 */



/*供应商
 bargain = 0;
 bookOrder = 0;
 checkFailProduct = 1;
 checkSuccessProduct = 2;
 evaluate = 0;
 exist = 0;
 name = "\U676d\U5dde\U5b9d\U5f3a\U6d88\U9632\U79d1\U6280\U6709\U9650\U516c\U53f8";
 roleID = 2;
 status = 1;
 unEvaluate = 0;
 unRecieve = 0;
 unSend = 0;
 uncheckProduct = 0;
 warehousing = 0;
 */
@interface DataModel : BaseModel

@property (nonatomic, assign) NSInteger checkFailProduct;//审核失败商品数
@property (nonatomic, assign) NSInteger checkSuccessProduct;//审核成功商品数
@property (nonatomic,copy) NSString *name;//公司名称
@property (nonatomic,strong) NSNumber *roleID;
@property (nonatomic,strong) NSNumber *status;
@property (nonatomic, assign) NSInteger uncheckProduct;//待审核商品数
@property (nonatomic, assign) NSInteger warehousing;//已入库商品数


@property (nonatomic, assign) NSInteger bargain;  //议价中商品数量
@property (nonatomic, assign) NSInteger bookOrder;//生成合同商品数量
@property (nonatomic, assign) NSInteger evaluate; //已评价商品数量
@property (nonatomic,strong) NSNumber * exist;
@property (nonatomic, assign) NSInteger unEvaluate; //待评价商品数量
@property (nonatomic, assign) NSInteger unRecieve; //待收货商品数量
@property (nonatomic, assign) NSInteger unSend; //待发货商品数量

@end
