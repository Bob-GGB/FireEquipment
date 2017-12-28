//
//  MenuCollectionViewCell.m
//  FireEquipment
//
//  Created by mc on 2017/10/20.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "MenuCollectionViewCell.h"

@implementation MenuCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
//        ViewBorder(self, 0.5, COLOR(235, 235, 235));
        
        self.label = [[UILabel alloc]init];
        self.label.textColor = COLOR(51, 51, 51);
        self.label.font = [UIFont systemFontOfSize:13];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
        
        
        self.imgView = [[UIImageView alloc]init];
        [self addSubview:self.imgView];
        
        
//        CGSize size = [@"商标注册" sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize: 13]}];
        CGFloat top = kBaseLine(10);
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(top);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kBaseLine(40), kBaseLine(40)));
        }];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgView.mas_bottom).offset(kBaseLine(8));
            make.centerX.width.equalTo(self);
            
        }];
        self.label.text = @"商标注册";
        self.imgView.image = [UIImage imageNamed:@"ser_zl02"];
    }
    return self;
}

@end
