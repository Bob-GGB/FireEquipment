//
//  FirstClassModel.m
//  FireEquipment
//
//  Created by mc on 2017/12/8.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "FirstClassModel.h"

@implementation FirstClassModel
-(void) setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"list"]) {
        self.list = [NSMutableArray array];
        [value enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            SecendClassModel *model = [[SecendClassModel alloc] initWithDict:obj];
            [self.list addObject:model];
        }];
    }
    else{
        [super setValue:value forKey:key];
    }
    
}


@end
