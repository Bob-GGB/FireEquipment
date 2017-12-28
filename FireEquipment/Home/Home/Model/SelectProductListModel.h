//
//  SelectProductListModel.h
//  FireEquipment
//
//  Created by mc on 2017/11/21.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BaseModel.h"

@interface SelectProductListModel : BaseModel
@property (nonatomic, assign) NSInteger productID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *titleImage;
@end
