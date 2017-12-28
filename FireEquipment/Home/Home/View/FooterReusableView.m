//
//  L_ServiceFooterReusableView.m
//  Looktm
//
//  Created by mengqingzheng on 2017/5/12.
//  Copyright © 2017年 北京聚集科技有限公司. All rights reserved.
//

#import "FooterReusableView.h"

@implementation FooterReusableView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
        
        self.imgView = [[UIImageView alloc]init];
        self.imgView.contentMode = UIViewContentModeCenter;
        [self addSubview:self.imgView];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.and.right.equalTo(@0);
           make.size.mas_equalTo(CGSizeMake(kScreenWidth, kBaseLine(30)));
        }];
    }
    return self;
}

@end
