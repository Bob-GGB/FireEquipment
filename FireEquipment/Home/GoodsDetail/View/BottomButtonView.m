//
//  BottomButtonView.m
//  FireEquipment
//
//  Created by mc on 2017/12/5.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "BottomButtonView.h"
#import "UIButton+ImageTitleSpacing.h"
@implementation BottomButtonView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        
        [self creatAllUI];
    }
    return self;
}

-(void)creatAllUI{
    
    NSArray *imageArr=@[@"gongyinshang.png",@"dianpu.png",@"gouwuche1.png",@"shoucang1.png"];
//    NSArray *titleArr=@[@"供货商",@"店铺",@"购物车",@"立即购买"];
    CGFloat buttonSpace=15;
    CGFloat buttonWidth=(kScreenWidth-5*buttonSpace-120)/4;
    for (int i=0; i<4; i++) {
        UIButton *bootomBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        bootomBtn.tag=i+100;
        bootomBtn.frame=CGRectMake((buttonWidth+buttonSpace)*i+buttonSpace, 10, buttonWidth, 40);
       
        [bootomBtn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
//        [self.bottomBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:10];
        [bootomBtn addTarget:self action:@selector(bottomBtnDidPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bootomBtn];
    }
    
    //立即购买按钮
        self.buyButton=[UIButton buttonWithType:UIButtonTypeCustom];
        self.buyButton.frame=CGRectMake(kScreenWidth-120, 0, 120, self.frame.size.height-60);
        [self.buyButton setBackgroundColor:[UIColor colorWithHexString:@"#c8996b"]];
        [self.buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [self.buyButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [self.buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.buyButton addTarget:self action:@selector(buyButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.buyButton];
}



-(void)bottomBtnDidPress:(UIButton *)sender{
    if (sender.tag==100) {
        if (self.sendController) {
            self.sendController();
        }
    }
    
}

-(void)buyButtonDidPress:(UIButton *)sender{
    
    
}

@end
