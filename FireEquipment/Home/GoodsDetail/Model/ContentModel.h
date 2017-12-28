//
//  ContentModel.h
//  FireEquipment
//
//  Created by mc on 2017/11/24.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BaseModel.h"
/*
 "productID": 131,
 "exist": 1,
 "productName": "生命探测仪",
 "price": "300.00",
   "approve": "http://qc-product-image.oss-cn-hangzhou.aliyuncs.com/1510714185认证1.jpg",
 */
@interface ContentModel : BaseModel
@property (nonatomic,strong) NSNumber*productID;
@property (nonatomic,strong) NSNumber *exist;
@property (nonatomic,copy) NSString *productName;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *approve;
@property (nonatomic,strong) NSArray *titleImage;
@property (nonatomic,strong) NSArray *details;
@property (nonatomic,strong) NSArray *comMsg;
@property (nonatomic,assign) NSInteger total;




@end
