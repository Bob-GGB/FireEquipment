//
//  ProductListModel.h
//  FireEquipment
//
//  Created by mc on 2017/11/22.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BaseModel.h"

@interface ProductListModel : BaseModel
@property (nonatomic, copy) NSString *price;

@property (nonatomic, strong) NSNumber *productID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *titleImage;

@property (nonatomic, copy) NSString *sellerName;
@end
