//
//  SimModel.h
//  FireEquipment
//
//  Created by mc on 2017/11/27.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BaseModel.h"


/*
 "productID": 90,
 "price": "820.00",
 "productName": "吉海仕 生命探测仪",
 "titleImage": "http://qc-product-image.oss-cn-hangzhou.aliyuncs.com/1508984443a1.jpg"
 */
@interface SimModel : BaseModel
@property (nonatomic,strong) NSNumber *productID;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *productName;
@property (nonatomic,copy) NSString *titleImage;



@end
