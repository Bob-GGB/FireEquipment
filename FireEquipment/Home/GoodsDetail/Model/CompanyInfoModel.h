//
//  CompanyInfoModel.h
//  FireEquipment
//
//  Created by mc on 2017/11/27.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BaseModel.h"

@interface CompanyInfoModel : BaseModel
@property (nonatomic, copy) NSString *sellerName;

@property (nonatomic, assign) CGFloat logistics;

@property (nonatomic, assign) CGFloat similarity;

@property (nonatomic, assign) CGFloat attitude;

@property (nonatomic, assign) NSInteger sellerID;

@property (nonatomic, copy) NSString *logo;

@property (nonatomic, assign) CGFloat shipping;
@property (nonatomic, assign) CGFloat rate;
@end
