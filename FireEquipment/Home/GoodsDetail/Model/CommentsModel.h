//
//  CommentsModel.h
//  FireEquipment
//
//  Created by mc on 2017/11/27.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BaseModel.h"


/*
 content = "\U597d\U8bc4\U5982\U6f6e";
 thumb = "http://qc-product-image.oss-cn-hangzhou.aliyuncs.com/userPhoto.png";
 time = "2017-11-17 15:51";
 userName = "\U6e29\U5dde\U6d88\U9632\U652f\U961f";
 */

@interface CommentsModel : BaseModel
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *thumb;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *addtime;
@property (nonatomic,copy) NSString *userName;




@end
