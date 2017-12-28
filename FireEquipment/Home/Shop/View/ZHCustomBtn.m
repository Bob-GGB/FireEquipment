//
//  ZHCustomBtn.m
//  CloudCast
//
//  Created by XT on 15/8/24.
//  Copyright (c) 2015年  xiaotu. All rights reserved.
//

#import "ZHCustomBtn.h"


@implementation ZHCustomBtn

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
       
        self.titleLabel = [[UILabel alloc] init];


        
    
        [self addSubview:self.titleLabel];
        
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = [UIColor darkGrayColor];
        self.titleLabel.backgroundColor=[UIColor colorWithHexString:@"#eeeeee"];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnDidSelected:)];
        [self addGestureRecognizer:tap];
        
       self.btnSelected = NO;
    }
    return self;
}

- (void)btnDidSelected:(UITapGestureRecognizer *)tap {
    ZHCustomBtn *btn = (ZHCustomBtn *)tap.view;
    if (self.btnOnClick) {
        self.btnOnClick(btn);
    }
}

- (void)setBtnSelected:(BOOL)btnSelected {
    _btnSelected = btnSelected;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    // 图片高度跟字体的高度一致
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
  
#pragma clang diagnostic pop
 
    self.titleLabel.frame = CGRectMake(10 ,
                                       0,
                                       self.frame.size.width - 10,
                                       self.frame.size.height);
   
}

@end
