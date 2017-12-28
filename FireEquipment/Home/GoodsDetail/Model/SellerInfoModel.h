//
//  SellerInfoModel.h
//  FireEquipment
//
//  Created by mc on 2017/11/28.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BaseModel.h"

/*
 address = "\U5e7f\U4e1c\U7701\U5e7f\U5dde\U5e02\U5929\U6cb3\U533a\U5e78\U798f\U885712\U53f7";
 contactman = "\U9ad8\U5173\U5b9d";
 logo = "http://qc-product-image.oss-cn-hangzhou.aliyuncs.com/1508751912timg (1).jpeg";
 mobile = 15738773695;
 sellerID = 41;
 sellerName = "\U5e7f\U5dde\U53cc\U7ffc\U6d88\U9632\U5668\U6750\U6709\U9650\U516c\U53f8";

 */
@interface SellerInfoModel : BaseModel
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *contactman;
@property (nonatomic,copy) NSString *logo;
@property (nonatomic,assign) NSInteger mobile;
@property (nonatomic,strong) NSNumber *sellerID;
@property (nonatomic,copy) NSString *sellerName;






@end
