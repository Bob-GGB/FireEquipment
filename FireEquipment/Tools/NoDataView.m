//
//  NoDataView.m
//  LouYu
//
//  Created by barby on 2017/8/19.
//  Copyright © 2017年 barby. All rights reserved.
//

#import "NoDataView.h"

@implementation NoDataView

-(instancetype)init{

    self=[super init];
    if (self) {
//        [self setBackgroundColor:KRGB(255, 255, 255, 1.0)];
        
        UIImageView *imageView   = [[UIImageView alloc] init];
        CGRect frame = imageView.frame;
        frame.size = CGSizeMake(80, 80);
        imageView.frame = frame;
        CGPoint center = imageView.center;
        center.x = kScreenWidth / 2;
        center.y = kScreenHeight / 3;
        imageView.center = center;
        [imageView setImage:[UIImage imageNamed:@"nodata"]];
//        imageView.center=CGPointMake(kScreenWidth/2, kScreenHeight/2);

           imageView.clipsToBounds  = YES;
        [self addSubview:imageView];
    }
    return self;
}

@end
