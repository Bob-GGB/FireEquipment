//
//  BaseModel.m
//  FireEquipment
//
//  Created by mc on 2017/10/31.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    
    self=[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}




- (void) setValue:(id)value forKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        [super setValue:value forKey:@"id_"];
    }
    
    else if([key isEqualToString:@"description"]){
        
        [super setValue:value forKey:@"desc"];
        
    }
    
    
    [super setValue:value forKey:key];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
    
}
@end
