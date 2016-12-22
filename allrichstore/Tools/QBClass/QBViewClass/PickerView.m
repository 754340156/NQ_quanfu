//
//  PickerView.m
//  MeiYiQuan
//
//  Created by 任强宾 on 16/9/28.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "PickerView.h"

#define PickerView_animationDuration   0.3 //动画周期

#define PickerBackgroundColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
#define PickerTopViewColor [UIColor whiteColor]

@interface PickerView()

@property (nonatomic, strong) UIView *superView;
@property (nonatomic, assign) PickerViewType style;
@property (nonatomic, copy) PickerViewBlock block;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) CGFloat pickerViewHeight;

@property (nonatomic, strong) UIButton *bgBtn;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSMutableArray *selectedArray;

@end

static const CGFloat kTopViewHeight = 40;

@implementation PickerView

/**
 *  自定义初始化方法
 *
 *  @param style     类型
 *  @param dataArray 数组嵌套数组的形式传进来
 *  @param block     内部事件通过block传递出来
 */
- (instancetype)initWithStyle:(PickerViewType)style dataArray:(NSArray *)dataArray pickerViewHeight:(CGFloat)pickerViewHeight inView:(UIView *)view block:(PickerViewBlock)block
{
    self = [super initWithFrame:CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height)];
    if (self)
        
    {   self.superView = view;
        self.style = style;
        self.dataArray = dataArray;
        self.pickerViewHeight = pickerViewHeight;
        self.block = block;
        [self initData];
        [self createView];
    }
    return self;
}


//数据初始化
- (void)initData
{
    self.selectedArray = [NSMutableArray array];
    
    for (int i = 0; i < _dataArray.count; i++)
    {
        [_selectedArray addObject:_dataArray[i][0]];
    }
}

//创建子视图
- (void)createView
{
    // 弹出的整个视图
    self.bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bgBtn.frame = self.bounds;
    _bgBtn.backgroundColor = PickerBackgroundColor;
    [_bgBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    _bgBtn.enabled = NO;
    [self addSubview:_bgBtn];
    
    CGFloat topViewHeight = (self.style == PickerViewTypeHaveBtn) ? kTopViewHeight : 0.0;
    
    //创建底部父视图
    CGFloat bgViewHeight = _pickerViewHeight + topViewHeight;
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, bgViewHeight)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bgView];
    
    if (self.style == AddressViewTypeHaveBtn)
    {
        //头部按钮视图
        self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _bgView.bounds.size.width, kTopViewHeight)];
        _topView.backgroundColor = PickerTopViewColor;
        [_bgView addSubview:_topView];
        
        NSArray *buttonTitleArray = @[@"取消", @"确定"];
        for (int i = 0; i < buttonTitleArray.count ; i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:16.0];
            button.frame = CGRectMake(i * (_topView.bounds.size.width - 50), 0, 50, topViewHeight);
            [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
            [_topView addSubview:button];
            
            button.tag = 101 + i;
            [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    // 初始化pickerView
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, topViewHeight,  _bgView.bounds.size.width, _pickerViewHeight)];
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
            _block(_selectedArray);
        }
    }
    
    [self dismiss];
}


#pragma mark - handle action
//显示
- (void)show
{
    [self.superView addSubview:self];
    
    [UIView animateWithDuration:PickerView_animationDuration animations:^{
        
        CGFloat bgViewHeight = (self.style == PickerViewTypeHaveBtn) ? (_pickerViewHeight + kTopViewHeight) : _pickerViewHeight;
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
    
    [UIView animateWithDuration:PickerView_animationDuration animations:^{
        
        CGFloat bgViewHeight = (self.style == AddressViewTypeHaveBtn) ? (_pickerViewHeight + kTopViewHeight) : _pickerViewHeight;
        _bgView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, bgViewHeight);
        
        self.bgBtn.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _dataArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_dataArray[component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _dataArray[component][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerView selectRow:row inComponent:component animated:NO];
    [_selectedArray replaceObjectAtIndex:component withObject:_dataArray[component][row]];
    
    if (self.style == AddressViewTypeNormal)
    {
        if (_block) {
            _block(_selectedArray);
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
        [pickerLabel setFont:[UIFont systemFontOfSize:16]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}

#pragma mark - 绑定默认值
//绑定默认值
- (void)configDataFromArray:(NSArray *)array
{
    NSInteger count = (array.count < _dataArray.count) ? array.count : _dataArray.count;
    for (int i = 0; i < count; i++)
    {
        NSArray *tempArray = _dataArray[i];
        NSInteger row = 0;
        for (int j = 0; j < tempArray.count; j++)
        {
            if ([array[i] equalsString:tempArray[j]])
            {
                row = j;
                break;
            }
        }
        
        [self pickerView:_pickerView didSelectRow:row inComponent:i];
    }
}

@end
