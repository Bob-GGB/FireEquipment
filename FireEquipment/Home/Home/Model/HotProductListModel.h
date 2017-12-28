//
//  HotProductListModel.h
//  FireEquipment
//
//  Created by mc on 2017/11/20.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BaseModel.h"

@interface HotProductListModel : BaseModel
@property (nonatomic, copy) NSString *productName;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) NSInteger productID;

@property (nonatomic, assign) NSInteger sellerID;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *sellerName;
@end
