//
//  GoodsParameterView.m

//
//

#import "GoodsParameterView.h"
#import "ParameterModel.h"
@interface GoodsParameterViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *name1Label;

@end

@implementation GoodsParameterViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    _name1Label = [[UILabel alloc] init];
//    _name1Label.backgroundColor=[UIColor redColor];
    _name1Label.textColor = [UIColor colorWithHexString:@"#777777"];
    _name1Label.font = [UIFont systemFontOfSize:16];
    _name1Label.textAlignment = NSTextAlignmentLeft;
     [self addSubview:self.name1Label];
    [self.name1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@(10));
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/3, self.contentView.frame.size.height));
    }];
    
    _nameLabel = [[UILabel alloc] init];
//    _nameLabel.backgroundColor=[UIColor greenColor];
    _nameLabel.textColor = [UIColor colorWithHexString:@"#282828"];
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
//    self.nameLabel.frame=CGRectMake(150, 0, kScreenWidth/3, self.contentView.frame.size.height);
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(self.name1Label.mas_right).offset(40);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-(kScreenWidth/3-50), self.contentView.frame.size.height));
    }];
}

@end


@interface GoodsParameterView ()

@property (nonatomic, assign) BOOL showCloseButton;//是否显示关闭按钮
@property (nonatomic, strong) UIView *alertView;//弹框视图
@property (nonatomic, strong) UITableView *selectTableView;//选择列表
@property (nonatomic,strong) NSMutableArray *parameterArr;
//@property (nonatomic,strong) NSNumber *productIDnum;
@end

@implementation GoodsParameterView
{
    float alertHeight;//弹框整体高度，默认250
    float buttonHeight;//按钮高度，默认40
}

+ (GoodsParameterView *)showWithTitle:(NSString *)title
                        ProductID:(NSNumber *)productIDnum
                   selectIndex:(SelectIndex)selectIndex
                   selectValue:(SelectValue)selectValue
               showCloseButton:(BOOL)showCloseButton {
    GoodsParameterView *alert = [[GoodsParameterView alloc] initWithTitle:title ProductID:productIDnum selectIndex:selectIndex selectValue:selectValue showCloseButton:showCloseButton];
    return alert;
}


#pragma mark ========== 获取服务器商品参数数据==========

-(void)getGoodsParametersFromSeverWithUrl:(NSString *)URL withProductID:(NSNumber *)productID{
    NSNumber * nums = @([@":" integerValue]);
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setValue:productID forKey:@"productID"];
    [HTTPRequest POST:URL getToken:nums paramentDict:dict success:^(id responseObj) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"%@",dict);
        [self.parameterArr removeAllObjects];
        NSArray *arr=dict[@"content"][@"parameter"];
        for (NSDictionary *obj in arr) {
            ParameterModel *model=[[ParameterModel alloc] initWithDict:obj];
            [self.parameterArr addObject:model];
        }
         NoDataView *dataView=[[NoDataView alloc] init];
        if (self.parameterArr.count==0) {
           
            [self.selectTableView addSubview:dataView];
        }
        else{
            [dataView removeFromSuperview];
        }
        
        [self.selectTableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
}
-(NSMutableArray *)parameterArr{
    if (_parameterArr==nil) {
        _parameterArr =[NSMutableArray array];
        
    }
    return _parameterArr;
}



- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#282828"];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
//        _alertView.layer.cornerRadius = 8;
//        _alertView.layer.masksToBounds = YES;
    }
    return _alertView;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.backgroundColor = [UIColor colorWithHexString:@"#c8996b"];
        [_closeButton setTitle:@"完成" forState:UIControlStateNormal];
        _closeButton.layer.cornerRadius = 5;
        _closeButton.layer.masksToBounds = YES;
        [_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _closeButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UITableView *)selectTableView {
    if (!_selectTableView) {
        _selectTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _selectTableView.delegate = self;
        _selectTableView.dataSource = self;
        _selectTableView.estimatedRowHeight = 0;
        _selectTableView.estimatedSectionHeaderHeight = 0;
        _selectTableView.estimatedSectionFooterHeight = 0;
//        [_selectTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _selectTableView.backgroundColor=[UIColor whiteColor];
    }
    return _selectTableView;
}

- (instancetype)initWithTitle:(NSString *)title ProductID:(NSNumber *)productIDnum selectIndex:(SelectIndex)selectIndex selectValue:(SelectValue)selectValue showCloseButton:(BOOL)showCloseButton {
    if (self = [super init]) {
         self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
        alertHeight = [UIScreen mainScreen].bounds.size.height-(Is_Iphone_X ? 88 : 64)-(Is_Iphone_X ? 34 : 0);
        buttonHeight = 50;
        
        self.titleLabel.text = title;
        _selectIndex = [selectIndex copy];
        _selectValue = [selectValue copy];
        _showCloseButton = showCloseButton;
        [self addSubview:self.alertView];
        [self.alertView addSubview:self.titleLabel];
        [self.alertView addSubview:self.selectTableView];
        if (_showCloseButton) {
            [self.alertView addSubview:self.closeButton];
        }
        [self initUI];
        [self getGoodsParametersFromSeverWithUrl:@"http://equipmentapp.qianchengwl.cn/api/show/getParameter" withProductID:productIDnum];
        
        [self show];
    }
    return self;
}

- (void)show {
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.alertView.alpha = 0.0;
    [UIView animateWithDuration:0.05 animations:^{
        self.alertView.alpha = 1;
    }];
}

- (void)initUI {
    self.alertView.frame = CGRectMake(0, Is_Iphone_X ? 88 : 64, [UIScreen mainScreen].bounds.size.width, alertHeight);
    self.titleLabel.frame = CGRectMake(0, 0, _alertView.frame.size.width, buttonHeight);
    float reduceHeight = buttonHeight;
    if (_showCloseButton) {
        self.closeButton.frame = CGRectMake(20, _alertView.frame.size.height-80, _alertView.frame.size.width-40, buttonHeight);
        reduceHeight = buttonHeight*2;
    }
    self.selectTableView.frame = CGRectMake(0, buttonHeight, _alertView.frame.size.width, _alertView.frame.size.height-reduceHeight-buttonHeight);
}


#pragma UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    
    return _parameterArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float real = (alertHeight - buttonHeight)/(float)_parameterArr.count;
    if (_showCloseButton) {
        real = (alertHeight - buttonHeight*2)/(float)_parameterArr.count;
    }
    return real<=40?40:real;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsParameterViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectcell"];
    if (!cell) {
        cell = [[GoodsParameterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectcell"];
    }
    ParameterModel *model=_parameterArr[indexPath.row];
     cell.nameLabel.text=model.name1;
    cell.name1Label.text=model.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (self.selectIndex) {
        self.selectIndex(indexPath.row);
    }
    if (self.selectValue) {
        self.selectValue(_titles[indexPath.row]);
    }
    
//    [self closeAction];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    if (!CGRectContainsPoint([self.alertView frame], pt) && !_showCloseButton) {
        [self closeAction];
    }
}

- (void)closeAction {
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dealloc {
//    NSLog(@"GoodsParameterView被销毁了");
}

@end
