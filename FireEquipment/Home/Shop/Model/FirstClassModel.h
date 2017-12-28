//
//  FirstClassModel.h
//  FireEquipment
//
//  Created by mc on 2017/12/8.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BaseModel.h"
#import "SecendClassModel.h"
@interface FirstClassModel : BaseModel


@property (nonatomic,strong) NSNumber *catID;
@property (nonatomic,copy) NSString *catName;
@property (nonatomic,strong) NSMutableArray *list;

@end
