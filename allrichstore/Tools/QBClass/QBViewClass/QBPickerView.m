//
//  QBPickerView.m
//  allrichstore
//
//  Created by 任强宾 on 16/12/11.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "QBPickerView.h"

#define kPickerView_animationDuration   0.3 //动画周期

#define kPickerBackgroundColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
#define kPickerTopViewColor [UIColor whiteColor]

#define kPickerViewMinHeight    160.0 //最小高度
#define kPickerViewMaxHeight    210.0 //最大高度
#define kTopViewHeight          40.0  //按钮bar的高度

@implementation QBPickerView
{
    QBPickerViewType _style;
    NSInteger _columnCount;
    PickerActionBlock _actionBlock;
    NSArray *_dataArray;
    
    UIButton *_bgBtn;
    UIView *_topView;
    UIPickerView *_pickerView;
    
    CGFloat  _pickerViewHeight;
    
    NSArray *_firstArray;     //第一列数组
    NSArray *_secondArray;    //第二列数组
    NSArray *_thirdArray;     //第三列数组
    id       _firstCurrent;   //第一列当前选中
    id       _secondCurrent;  //第二列当前选中
    id       _thirdCurrent;   //第三列当前选中
}

//自定义初始化方法，内部事件通过block传递出来
- (instancetype)initWithStyle:(QBPickerViewType)style dataArray:(NSArray *)dataArray columnCount:(NSInteger)columnCount action:(PickerActionBlock)action
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        _actionBlock = action;
        _style = style;
        _dataArray = dataArray;
        if (columnCount < 1) {
            _columnCount = 1;
        } else if (columnCount > 3) {
            _columnCount = 3;
        } else {
            _columnCount = columnCount;
        }
        [self initData];  //数据初始化
        [self createView];//创建子视图
    }
    return self;
}

//数据初始化
- (void)initData
{
    //第一列
    _firstArray = _dataArray;
    _firstCurrent = _firstArray[0];
    //第二列
    if (_columnCount > 1) {
        id<QBPickerViewAble> obj = _dataArray[0];
        _secondArray = [obj subArray];
        _secondCurrent = _secondArray[0];
    }
    //第三列
    if (_columnCount > 2) {
        id<QBPickerViewAble> obj = _secondArray[0];
        _thirdArray = [obj subArray];
        _thirdCurrent = _thirdArray[0];
    }
}

//创建子视图
- (void)createView
{
    //背景btn
    _bgBtn = [UIButton new];
    _bgBtn.frame = self.bounds;
    _bgBtn.backgroundColor = kPickerBackgroundColor;
    [_bgBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    _bgBtn.enabled = NO;
    [self addSubview:_bgBtn];
    
    CGFloat topViewHeight = (_style == QBPickerViewTypeHaveBtn) ? kTopViewHeight : 0.0;
    
    if (_firstArray.count <= 3) {
        _pickerViewHeight = kPickerViewMinHeight;
    } else {
        _pickerViewHeight = _firstArray.count * 28 + 30;
        if (_pickerViewHeight > kPickerViewMaxHeight) {
            _pickerViewHeight = kPickerViewMaxHeight;
        }
    }
    
    //创建底部父视图
    CGFloat bgViewHeight = _pickerViewHeight + topViewHeight;
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, bgViewHeight)];
    _bgView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_bgView];
    [_bgView showEffectViewWithStyle:UIBlurEffectStyleLight alpha:1.0];
    
    if (_style == AddressViewTypeHaveBtn) {
        //头部按钮视图
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _bgView.bounds.size.width, kTopViewHeight)];
        _topView.backgroundColor = kPickerTopViewColor;
        [_bgView addSubview:_topView];
        
        NSArray *buttonTitleArray = @[@"取消", @"确定"];
        for (int i = 0; i < buttonTitleArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
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
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, topViewHeight,  _bgView.bounds.size.width, _pickerViewHeight)];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [_bgView addSubview:_pickerView];
}

#pragma mark - handle action
//按钮点击事件
- (void)buttonEvent:(UIButton *)button
{
    // 点击确定回调block
    if (button.tag == 102) {
        [self doActionBlock];   //执行外界block
    }
    [self dismiss];
}

//设置顶部的按钮Bar的颜色  和  按钮标题的颜色
- (void)setBtnBarColor:(UIColor *)barColor btnTitleColor:(UIColor *)btnTitleColor
{
    if (barColor) {
        _topView.backgroundColor = barColor;
    }
    
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [_topView viewWithTag:101 + i];
        [btn setTitleColor:btnTitleColor forState:UIControlStateNormal];
    }
}

//显示
- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:kPickerView_animationDuration animations:^{
        CGFloat bgViewHeight = (_style == AddressViewTypeHaveBtn) ? (_pickerViewHeight + kTopViewHeight) : _pickerViewHeight;
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
    
    [UIView animateWithDuration:kPickerView_animationDuration animations:^{
        
        CGFloat bgViewHeight = (_style == AddressViewTypeHaveBtn) ? (_pickerViewHeight + kTopViewHeight) : _pickerViewHeight;
        _bgView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, bgViewHeight);
        _bgBtn.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

//执行外界block
- (void)doActionBlock
{
    if (!_actionBlock)
    {
        return;
    }
    if (_columnCount == 1)
    {
        _actionBlock(@[_firstCurrent]);
    } else if (_columnCount == 2) {
        _actionBlock(@[_firstCurrent, _secondCurrent]);
        
    } else {
        _actionBlock(@[_firstCurrent, _secondCurrent, _thirdCurrent]);
    }
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
            return [_firstArray count];
            break;
        case 1:
            return [_secondArray count];
            break;
        case 2:
            return [_thirdArray count];
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
        {
            id obj = _firstArray[row];
            NSString *title;
            if ([obj isKindOfClass:[NSString class]]) {
                title = obj;
            } else {
                title = [obj pickerTitle];
            }
            return title;
        }
            break;
        case 1:
            return [_secondArray[row] pickerTitle];
            break;
        case 2:
            return [_thirdArray[row] pickerTitle];
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
            _firstCurrent = _firstArray[row];
            if (_columnCount > 1)
            {
                _secondArray = [_firstCurrent subArray];
                _secondCurrent = _secondArray[0];
                [pickerView selectRow:0 inComponent:1 animated:NO];
                [pickerView reloadComponent:1];
            }
            if (_columnCount > 2)
            {
                _thirdArray = [_secondCurrent subArray];
                _thirdCurrent = _thirdArray[0];
                [_pickerView selectRow:0 inComponent:2 animated:NO];
                [_pickerView reloadComponent:2];
            }
        }
            break;
        case 1:
        {
            _secondCurrent = _secondArray[row];
            if (_columnCount > 2)
            {
                _thirdArray = [_secondCurrent subArray];
                _thirdCurrent = _thirdArray[0];
                [_pickerView selectRow:0 inComponent:2 animated:NO];
                [_pickerView reloadComponent:2];
            }
        }
            break;
            
        case 2:
        {
            _thirdCurrent = _thirdArray[row];
        }
            break;
            
        default:
            break;
    }
    
    if (_style == AddressViewTypeNormal) {
        [self doActionBlock];   //执行外界block
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setFont:[UIFont systemFontOfSize:17]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

#pragma mark 默认绑定设置
//绑定默认值
- (void)selectIndexArray:(NSArray *)indexArray
{
    if (indexArray.count > 0) {
        [self pickerView:_pickerView didSelectRow:[indexArray[0] integerValue] inComponent:0];
    }
    if (indexArray.count > 1) {
        [self pickerView:_pickerView didSelectRow:[indexArray[1] integerValue] inComponent:1];
    }
    if (indexArray.count > 2) {
        [self pickerView:_pickerView didSelectRow:[indexArray[2] integerValue] inComponent:2];
    }
}

@end
