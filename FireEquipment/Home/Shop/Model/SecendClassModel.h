//
//  SecendClassModel.h
//  FireEquipment
//
//  Created by mc on 2017/12/8.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BaseModel.h"
/*
 "catID":40,"catName":"水质分析仪","parentID":2
 */
@interface SecendClassModel : BaseModel
@property (nonatomic,strong) NSNumber *catID;
@property (nonatomic,strong) NSNumber *parentID;
@property (nonatomic,copy) NSString *catName;

@end
