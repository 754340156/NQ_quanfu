//
//  AddressPickerView.m
//  MeiYiQuan
//
//  Created by 任强宾 on 16/9/28.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "AddressPickerView.h"

#define AddressPickerView_animationDuration   0.3 //动画周期

#define kAddressPickerBackgroundColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
#define kAddressPickerTopViewColor [UIColor whiteColor]


@interface AddressPickerView()

@property (nonatomic, assign) AddressViewType style;
@property (nonatomic, assign) NSInteger columnCount;

@property (nonatomic, copy) AdressBlock block;
@property (nonatomic, strong) AddressModel *addressModel;

@property (nonatomic, strong) UIButton *bgBtn;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIPickerView *pickerView;

@end

//定义弹出高度
static const CGFloat kPickerViewHeight = 210;
static const CGFloat kTopViewHeight = 40;

@implementation AddressPickerView
{
    NSArray   *_provinces;
    NSArray   *_citys;
    NSArray   *_regions;
    
    Province  *_currentProvince;
    City      *_currentCity;
    Region    *_currentRegion;
}

//自定义初始化方法，内部事件通过block传递出来
- (instancetype)initWithStyle:(AddressViewType)style columnCount:(NSInteger)columnCount block:(AdressBlock)block
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        self.block = block;
        self.style = style;
        if (columnCount < 1)
        {
            self.columnCount = 1;
        }
        else if (columnCount > 3)
        {
            self.columnCount = 3;
        }
        else
        {
            self.columnCount = columnCount;
        }
        
        [self initData];  //数据初始化
        [self createView];//创建子视图
    }
    return self;
}

//数据初始化
- (void)initData
{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"address.json" ofType:nil];
    
    NSString *jsonString = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
    
    self.addressModel = [AddressModel mj_objectWithKeyValues:jsonString];
    
    //所有的省
    _provinces = self.addressModel.provinces;
    //第一个省
    _currentProvince = _provinces[0];
    
    //第一个省分对应的全部市
    _citys = _currentProvince.citys;
    //第一个省份对应的第一个市
    _currentCity = _citys[0];
    
    // 第一个省份对应的第一个市对应的所有区
    _regions = _currentCity.regions;
    // 第一个省份对应的第一个市对应的第一个区
    _currentRegion = _regions[0];
}

//创建子视图
- (void)createView
{
    // 弹出的整个视图
    self.bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bgBtn.frame = self.bounds;
    _bgBtn.backgroundColor = kAddressPickerBackgroundColor;
    [_bgBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    _bgBtn.enabled = NO;
    [self addSubview:_bgBtn];
    
    CGFloat topViewHeight = (self.style == AddressViewTypeHaveBtn) ? kTopViewHeight : 0.0;
    
    //创建底部父视图
    CGFloat bgViewHeight = kPickerViewHeight + topViewHeight;
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, bgViewHeight)];
    _bgView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_bgView];
    [_bgView showEffectViewWithStyle:UIBlurEffectStyleLight alpha:1.0];
    
    if (self.style == AddressViewTypeHaveBtn)
    {
        //头部按钮视图
        self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _bgView.bounds.size.width, kTopViewHeight)];
        _topView.backgroundColor = kAddressPickerTopViewColor;
        [_bgView addSubview:_topView];
        
        NSArray *buttonTitleArray = @[@"取消", @"确定"];
        for (int i = 0; i < buttonTitleArray.count ; i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.titleLabel.font = [UIFont systemFontOfSize:16.0];
            button.frame = CGRectMake(i * (_topView.bounds.size.width - 60), 0, 60, topViewHeight);
            [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
            [_topView addSubview:button];
            
            button.tag = 101 + i;
            [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    [_topView addBottomLine];
    
    // 初始化pickerView
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, topViewHeight,  _bgView.bounds.size.width, kPickerViewHeight)];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [_bgView addSubview:_pickerView];
    
}

- (void)buttonEvent:(UIButton *)button
{
    // 点击确定回调block
    if (button.tag == 102)
    {
        if (_block)
        {
            _block(_currentProvince, _currentCity, _currentRegion);
        }
    }
    
    [self dismiss];
}


#pragma mark - handle action
//设置顶部的按钮Bar的颜色  和  按钮标题的颜色
- (void)setBtnBarColor:(UIColor *)barColor btnTitleColor:(UIColor *)btnTitleColor
{
    if (barColor)
    {
        _topView.backgroundColor = barColor;
    }
    
    for (int i = 0; i < 2; i++)
    {
        UIButton *btn = [_topView viewWithTag:101 + i];
        [btn setTitleColor:btnTitleColor forState:UIControlStateNormal];
    }
}

//显示
- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:AddressPickerView_animationDuration animations:^{
        
        CGFloat bgViewHeight = (self.style == AddressViewTypeHaveBtn) ? (kPickerViewHeight + kTopViewHeight) : kPickerViewHeight;
        _bgView.frame = CGRectMake(0, self.bounds.size.height - bgViewHeight, self.bounds.size.width, bgViewHeight);
        
        _bgBtn.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        
        _bgBtn.enabled = YES;
        
    }];
}

//移除
- (void)dismiss
{
    _bgBtn.enabled = NO;
    
    [UIView animateWithDuration:AddressPickerView_animationDuration animations:^{
        
        CGFloat bgViewHeight = (self.style == AddressViewTypeHaveBtn) ? (kPickerViewHeight + kTopViewHeight) : kPickerViewHeight;
        _bgView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, bgViewHeight);
        
        self.bgBtn.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _columnCount;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
            return [_provinces count];
            break;
        case 1:
            return [_citys count];
            break;
        case 2:
            return [_regions count];
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
            return ((Province *)_provinces[row]).name;
            break;
        case 1:
            return ((City *)_citys[row]).name;
            break;
        case 2:
            return ((Region *)_regions[row]).name;
            break;
        default:
            return  @"";
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerView selectRow:row inComponent:component animated:NO];
    
    switch (component)
    {
        case 0:
        {
            _currentProvince = _provinces[row];
            _citys = _currentProvince.citys;
            _currentCity = _citys[0];
            _regions = _currentCity.regions;
            _currentRegion = _regions[0];
            
            if (_columnCount > 1)
            {
                [pickerView selectRow:0 inComponent:1 animated:NO];
                [pickerView reloadComponent:1];
            }
            
            if (_columnCount > 2)
            {
                [_pickerView selectRow:0 inComponent:2 animated:NO];
                [_pickerView reloadComponent:2];
            }
        }
            break;
            
        case 1:
        {
            _currentCity = _citys[row];
            _regions = _currentCity.regions;
            _currentRegion = _regions[0];
            if (_columnCount > 2)
            {
                [_pickerView selectRow:0 inComponent:2 animated:NO];
                [_pickerView reloadComponent:2];
            }
        }
            break;
            
        case 2:
        {
            _currentRegion = _regions[row];
        }
            break;
            
        default:
            break;
    }
    
    if (self.style == AddressViewTypeNormal)
    {
        if (_block) {
            _block(_currentProvince, _currentCity, _currentRegion);
        }
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setFont:[UIFont systemFontOfSize:15]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}

#pragma mark 默认绑定设置
//绑定默认值 省名 市名 区名
- (void)configDataProvinceName:(NSString *)provinceName cityName:(NSString *)cityName regionName:(NSString *)regionName
{
    NSString *provinceStr = provinceName;
    NSString *cityStr = cityName;
    NSString *regionStr = regionName;
    
    int oneColumn = 0, twoColumn = 0, threeColum = 0;
    
    //省份
    BOOL isHaveProvince = NO;
    for (int i = 0; i < _addressModel.provinces.count; i++)
    {
        Province *province = _addressModel.provinces[i];
        if ([provinceStr isEqualToString:province.name])
        {
            oneColumn = i;
            isHaveProvince = YES;
            break;
        }
    }
    
    if (isHaveProvince)
    {
        // 用来记录是某个省下的所有市
        BOOL ishaveCity = NO;
        Province *province = _addressModel.provinces[oneColumn];
        // 市
        for (int j = 0; j < province.citys.count; j++)
        {
            City *city = province.citys[j];
            if ([cityStr isEqualToString:city.name])
            {
                twoColumn = j;
                ishaveCity = YES;
                break;
            }
        }
        
        if (ishaveCity)
        {
            City *city = province.citys[twoColumn];
            // 区
            for (int k = 0; k < city.regions.count ; k++)
            {
                Region *region = city.regions[k];
                if ([regionStr isEqualToString:region.name])
                {
                    threeColum = k;
                    break;
                }
            }
        }
    }
    
    
    [self pickerView:_pickerView didSelectRow:oneColumn inComponent:0];
    [self pickerView:_pickerView didSelectRow:twoColumn inComponent:1];
    [self pickerView:_pickerView didSelectRow:threeColum inComponent:2];
}

//绑定默认值 省码 市码 区码
- (void)configDataProvinceCode:(NSString *)provinceCode cityCode:(NSString *)cityCode regionCode:(NSString *)regionCode
{
    NSString *provinceStr = provinceCode;
    NSString *cityStr = cityCode;
    NSString *regionStr = regionCode;
    
    int oneColumn = 0, twoColumn = 0, threeColum = 0;
    
    //省份
    BOOL isHaveProvince = NO;
    for (int i = 0; i < _addressModel.provinces.count; i++)
    {
        Province *province = _addressModel.provinces[i];
        if ([provinceStr isEqualToString:province.code])
        {
            oneColumn = i;
            isHaveProvince = YES;
            break;
        }
    }
    
    if (isHaveProvince)
    {
        // 用来记录是某个省下的所有市
        BOOL ishaveCity = NO;
        Province *province = _addressModel.provinces[oneColumn];
        // 市
        for (int j = 0; j < province.citys.count; j++)
        {
            City *city = province.citys[j];
            if ([cityStr isEqualToString:city.code])
            {
                twoColumn = j;
                ishaveCity = YES;
                break;
            }
        }
        
        if (ishaveCity)
        {
            City *city = province.citys[twoColumn];
            // 区
            for (int k = 0; k < city.regions.count ; k++)
            {
                Region *region = city.regions[k];
                if ([regionStr isEqualToString:region.code])
                {
                    threeColum = k;
                    break;
                }
            }
        }
    }
    
    
    [self pickerView:_pickerView didSelectRow:oneColumn inComponent:0];
    [self pickerView:_pickerView didSelectRow:twoColumn inComponent:1];
    [self pickerView:_pickerView didSelectRow:threeColum inComponent:2];
}

@end
