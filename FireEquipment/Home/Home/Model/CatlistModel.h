//
//  CatlistModel.h
//  FireEquipment
//
//  Created by mc on 2017/11/21.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BaseModel.h"

@interface CatlistModel : BaseModel
@property (nonatomic,copy) NSString *catName;
@property (nonatomic,strong) NSNumber *catID;
@property (nonatomic,copy) NSString *thumb;

@end
