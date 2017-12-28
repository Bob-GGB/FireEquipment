//
//  OneCellView.m
//  FireEquipment
//
//  Created by mc on 2017/11/29.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "OneCellView.h"
#import "UIButton+ImageTitleSpacing.h"
#import "ProtocolAvailabilityViewController.h"
@interface OneCellView()

@property(nonatomic,strong)NSNumber *roleIDnum;
@end

@implementation OneCellView

-(instancetype)initWithRoleID:(NSNumber *)roleIDNum{
    
    self=[super init];
    
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        if ([roleIDNum isEqualToNumber:@1]||[roleIDNum isEqualToNumber:@2]) {//准入商和供应商
           [self CreatAllUITowbutton];
        }
        else if([roleIDNum isEqualToNumber:@4]||[roleIDNum isEqualToNumber:@5]){//支队和总队
             [self CreatAllUI];
            
        }
        
    }
    return self;
    
}





-(void)CreatAllUITowbutton{
    NSArray *arr=@[@"gonghuoshang.png",@"shoucangjia.png"];
    NSArray *titleArr=@[@"协议供货",@"收藏夹"];
    CGFloat space=-5;
    for (int i=0; i<2; i++) {
        _shopCarButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _shopCarButton.tag=100+i;
        [_shopCarButton setImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
        _shopCarButton.frame=CGRectMake((60+120)*i+40, 10, 120, 50);
        [_shopCarButton setTitle:titleArr[i] forState:UIControlStateNormal];
        _shopCarButton.titleLabel.font=[UIFont systemFontOfSize:14];
        //        [_shopCarButton setBackgroundColor:[UIColor redColor]];
        [_shopCarButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:space];
        [_shopCarButton setTitleColor:[UIColor colorWithHexString:@"#9e9e9e"] forState:UIControlStateNormal];
        [_shopCarButton addTarget:self action:@selector(twoButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_shopCarButton];
        
    }
    
}
-(void)twoButtonDidPress:(UIButton *)sender{
    ProtocolAvailabilityViewController *protocolVC=[[ProtocolAvailabilityViewController alloc] init];
    if (sender.tag==100) {
        if (self.sendViewController) {
            self.sendViewController(protocolVC);
        }
    }
    
}


-(void)CreatAllUI{
    
    NSArray *arr=@[@"gouwuche.png",@"gonghuoshang.png",@"shoucangjia.png"];
    NSArray *titleArr=@[@"购物车",@"协议供货",@"收藏夹"];
    CGFloat buttonWidth=kScreenWidth/9;
    CGFloat space=-5;
    for (int i=0; i<3; i++) {
        _shopCarButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _shopCarButton.tag=100+i;
        [_shopCarButton setImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
        _shopCarButton.frame=CGRectMake((3*buttonWidth)*i, 10, 120, 50);
        [_shopCarButton setTitle:titleArr[i] forState:UIControlStateNormal];
        _shopCarButton.titleLabel.font=[UIFont systemFontOfSize:14];
        //        [_shopCarButton setBackgroundColor:[UIColor redColor]];
        [_shopCarButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:space];
        [_shopCarButton setTitleColor:[UIColor colorWithHexString:@"#9e9e9e"] forState:UIControlStateNormal];
        [_shopCarButton addTarget:self action:@selector(buttonDidPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_shopCarButton];
        
    }
    
}

-(void)buttonDidPress:(UIButton *)sender{
    ProtocolAvailabilityViewController *protocolVC=[[ProtocolAvailabilityViewController alloc] init];
    if (sender.tag==101) {
        if (self.sendViewController) {
            self.sendViewController(protocolVC);
        }
    }
    
}

@end
