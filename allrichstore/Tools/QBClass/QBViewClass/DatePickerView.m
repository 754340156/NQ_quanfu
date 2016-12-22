//
//  DatePickerView.m
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/8.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "DatePickerView.h"


#define DatePickerView_animationDuration   0.3 //动画周期

#define DatePickerBackgroundColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
#define DatePickerTopViewColor [UIColor whiteColor]

#define DatePickerSplitColor [UIColor colorWithWhite:0.90 alpha:1.0]
#define DatePickerLabelTextColor [UIColor colorWithWhite:0.1 alpha:1.0]

#define DatePicker_caption_age @"滚动时间，系统自动计算年龄"
#define DatePicker_caption_age_constellation @"滚动时间，系统自动计算年龄，星座"

@interface DatePickerView ()

@property (nonatomic, assign) DatePickerViewType style;

@property (nonatomic, copy) DatePickerViewBlock block;

@property (nonatomic, strong) NSDate *inDate;

@property (nonatomic, strong) UIButton *bgBtn;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) UILabel *ageTextLabel;
@property (nonatomic, strong) UILabel *constellationTextLabel;


@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) NSString *constellation;
@property (nonatomic, assign) NSInteger age;


@end

//定义弹出高度
static const CGFloat kDatePickerHeight = 200;
static const CGFloat kTopViewHeight = 40;

static const CGFloat kCaptionHeight = 40;
static const CGFloat kCellHeight = 40;

@implementation DatePickerView

- (instancetype)initWithStyle:(DatePickerViewType)style date:(NSDate *)date block:(DatePickerViewBlock)block
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    if (self)
    {
        self.style = style;
        self.block = block;
        self.inDate = date;
        [self createView];  //创建子视图
    }
    return self;
}

//创建子视图
- (void)createView
{
    // 弹出的整个视图
    self.bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bgBtn.frame = self.bounds;
    _bgBtn.backgroundColor = DatePickerBackgroundColor;
    [_bgBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    _bgBtn.enabled = NO;
    [self addSubview:_bgBtn];
    
    CGFloat bgViewHeight = kDatePickerHeight;
    
    //创建底部父视图
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, bgViewHeight)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bgView];
    
    switch (_style)
    {
        case DatePickerViewTypeNormal:
        {
            bgViewHeight = kDatePickerHeight;
            _bgView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, bgViewHeight);
            
            break;
        }
        case DatePickerViewTypeHaveBtn:
        {
            bgViewHeight = kDatePickerHeight + kTopViewHeight;
            _bgView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, bgViewHeight);
            
            //头部按钮视图
            self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _bgView.bounds.size.width, kTopViewHeight)];
            _topView.backgroundColor = DatePickerTopViewColor;
            [_bgView addSubview:_topView];
            [_topView addBottomLine];
            
            NSArray *buttonTitleArray = @[@"取消", @"确定"];
            for (int i = 0; i < buttonTitleArray.count ; i++)
            {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                
                button.titleLabel.font = [UIFont systemFontOfSize:16.0];
                button.frame = CGRectMake(i * (_topView.bounds.size.width - 50), 0, 50, kTopViewHeight);
                [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                [_topView addSubview:button];
                
                button.tag = 101 + i;
                [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            break;
        }
        case DatePickerViewTypeAutoComputeAge:
        {
            bgViewHeight = kDatePickerHeight + kCaptionHeight + kCellHeight;
            _bgView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, bgViewHeight);
            
            //创建文字说明标签
            UILabel *message = [[UILabel alloc] init];
            message.frame = CGRectMake(0, 0, _bgView.bounds.size.width, kCaptionHeight);
            message.textAlignment = NSTextAlignmentCenter;
            message.font = [UIFont systemFontOfSize:14.0];
            message.textColor = [UIColor grayColor];
            
            message.text = DatePicker_caption_age;
            [_bgView addSubview:message];
            
            //创建分隔条1
            UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, message.bottom - 0.8, _bgView.width, 0.8)];
            lineView1.backgroundColor = DatePickerSplitColor;
            [_bgView addSubview:lineView1];
            
            CGFloat ageLabelMargin = 16;
            
            //创建岁数Label
            UILabel *ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(ageLabelMargin, message.bottom, _bgView.width - ageLabelMargin * 2.0, kCellHeight)];
            ageLabel.textAlignment = NSTextAlignmentLeft;
            ageLabel.text = @"年龄：";
            ageLabel.textColor = DatePickerLabelTextColor;
            [_bgView addSubview:ageLabel];
            
            _ageTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(ageLabelMargin, message.bottom, _bgView.width - ageLabelMargin * 2.0, kCellHeight)];
            _ageTextLabel.textAlignment = NSTextAlignmentRight;
            _ageTextLabel.text = @"";
            _ageTextLabel.textColor = DatePickerLabelTextColor;
            [_bgView addSubview:_ageTextLabel];
            
            //创建分隔条2
            UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, ageLabel.bottom - 0.8, _bgView.width, 0.8)];
            lineView2.backgroundColor = DatePickerSplitColor;
            [_bgView addSubview:lineView2];
            
            break;
        }
        case DatePickerViewTypeAutoComputeConstellation:
        {
            bgViewHeight = kDatePickerHeight + kCaptionHeight + kCellHeight;
            _bgView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, bgViewHeight);
            
            //创建文字说明标签
            UILabel *message = [[UILabel alloc] init];
            message.frame = CGRectMake(0, 0, _bgView.bounds.size.width, kCaptionHeight);
            message.textAlignment = NSTextAlignmentCenter;
            message.font = [UIFont systemFontOfSize:14.0];
            message.textColor = [UIColor grayColor];
            
            message.text = DatePicker_caption_age_constellation;
            [_bgView addSubview:message];
            
            //创建分隔条1
            UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, message.bottom - 0.8, _bgView.width, 0.8)];
            lineView1.backgroundColor = DatePickerSplitColor;
            [_bgView addSubview:lineView1];
            
            CGFloat ageLabelMargin = 16;
            
            //创建 星座
            UILabel *constellationLabel = [[UILabel alloc] initWithFrame:CGRectMake(ageLabelMargin, lineView1.bottom, _bgView.width - ageLabelMargin * 2.0, kCellHeight)];
            constellationLabel.textAlignment = NSTextAlignmentLeft;
            constellationLabel.text = @"星座：";
            constellationLabel.textColor = DatePickerLabelTextColor;
            [_bgView addSubview:constellationLabel];
            
            _constellationTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(ageLabelMargin, lineView1.bottom, _bgView.width - ageLabelMargin * 2.0, kCellHeight)];
            _constellationTextLabel.textAlignment = NSTextAlignmentRight;
            _constellationTextLabel.text = @"";
            _constellationTextLabel.textColor = BlackTextColor;
            [_bgView addSubview:_constellationTextLabel];
            
            //创建分隔条3
            UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, constellationLabel.bottom - 0.8, _bgView.width, 0.8)];
            lineView2.backgroundColor = BlackTextColor;
            [_bgView addSubview:lineView2];
            
            break;
        }
        case DatePickerViewTypeAutoComputeAgeAndConstellation:
        {
            bgViewHeight = kDatePickerHeight + kCaptionHeight + kCellHeight * 2.0;
            _bgView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, bgViewHeight);
            
            //创建文字说明标签
            UILabel *message = [[UILabel alloc] init];
            message.frame = CGRectMake(0, 0, _bgView.bounds.size.width, kCaptionHeight);
            message.textAlignment = NSTextAlignmentCenter;
            message.font = [UIFont systemFontOfSize:14.0];
            message.textColor = [UIColor grayColor];
            
            message.text = DatePicker_caption_age_constellation;
            [_bgView addSubview:message];
            
            //创建分隔条1
            UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, message.bottom - 0.8, _bgView.width, 0.8)];
            lineView1.backgroundColor = DatePickerSplitColor;
            [_bgView addSubview:lineView1];
            
            CGFloat ageLabelMargin = 16;
            
            //创建岁数Label
            UILabel *ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(ageLabelMargin, message.bottom, _bgView.width - ageLabelMargin * 2.0, kCellHeight)];
            ageLabel.textAlignment = NSTextAlignmentLeft;
            ageLabel.text = @"年龄：";
            ageLabel.textColor = DatePickerLabelTextColor;
            [_bgView addSubview:ageLabel];
            
            _ageTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(ageLabelMargin, message.bottom, _bgView.width - ageLabelMargin * 2.0, kCellHeight)];
            _ageTextLabel.textAlignment = NSTextAlignmentRight;
            _ageTextLabel.text = @"";
            _ageTextLabel.textColor = DatePickerLabelTextColor;
            [_bgView addSubview:_ageTextLabel];
            
            //创建分隔条2
            UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, ageLabel.bottom - 0.8, _bgView.width, 0.8)];
            lineView2.backgroundColor = DatePickerSplitColor;
            [_bgView addSubview:lineView2];
            
            
            //创建 星座
            UILabel *constellationLabel = [[UILabel alloc] initWithFrame:CGRectMake(ageLabelMargin, ageLabel.bottom, _bgView.width - ageLabelMargin * 2.0, kCellHeight)];
            constellationLabel.textAlignment = NSTextAlignmentLeft;
            constellationLabel.text = @"星座：";
            constellationLabel.textColor = DatePickerLabelTextColor;
            [_bgView addSubview:constellationLabel];
            
            _constellationTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(ageLabelMargin, ageLabel.bottom, _bgView.width - ageLabelMargin * 2.0, kCellHeight)];
            _constellationTextLabel.textAlignment = NSTextAlignmentRight;
            _constellationTextLabel.text = @"";
            _constellationTextLabel.textColor = BlackTextColor;
            [_bgView addSubview:_constellationTextLabel];
            
            //创建分隔条3
            UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, constellationLabel.bottom - 0.8, _bgView.width, 0.8)];
            lineView3.backgroundColor = DatePickerSplitColor;
            [_bgView addSubview:lineView3];
            
            break;
        }
    }
    
    
    // 初始化pickerView
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, bgViewHeight - kDatePickerHeight, _bgBtn.bounds.size.width, kDatePickerHeight)];
    _datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_datePicker setDatePickerMode:UIDatePickerModeDate];//选择date的显示模式
    //设置最小日期值
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //设置当前显示
    NSDate *date = [dateFormatter dateFromString:@"1990-01-01"];
    if (_inDate)
    {
        date = _inDate;
    }
    
    [_datePicker setDate:date];
    //设置最大日期值
    [_datePicker setMaximumDate:[NSDate date]];
    
    NSDate *minDate = [dateFormatter dateFromString:@"1900-01-01"];
    [_datePicker setMinimumDate:minDate];
    
    //设置时区
    NSLocale *locale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [_datePicker setLocale:locale];
    
    [self configViewWithDate:date];
    
    ////当值发生改变的时候调用的方法
    [_datePicker addTarget:self action:@selector(datePickerDateChanged:) forControlEvents:UIControlEventValueChanged];
    [_bgView addSubview:_datePicker];
    
}

//根据时间给视图赋值
- (void)configViewWithDate:(NSDate *)date
{
    //年龄
    NSCalendar *greCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitYear fromDate:date toDate:[NSDate date] options:0];
    
    _age = dateComponents.year;
    _selectedDate = date;
    _constellation = [date formatToConstellation];
    
    if (_ageTextLabel)
    {
        _ageTextLabel.text = [NSString stringWithFormat:@"%ld岁", _age];
    }
    
    if (_constellationTextLabel)
    {
        //生肖
        _constellationTextLabel.text = _constellation;
    }
}

#pragma mark - handle action
- (void)datePickerDateChanged:(UIDatePicker *)datePicker
{
    NSDate *date = [_datePicker date];
    [self configViewWithDate:date];
    
    _block(_selectedDate, _age, _constellation);
}

- (void)buttonEvent:(UIButton *)button
{
    // 点击确定回调block
    if (button.tag == 102)
    {
        if (_block)
        {
            _block(_selectedDate, _age, _constellation);
        }
    }
    
    [self dismiss];
}


//显示
- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:DatePickerView_animationDuration animations:^{
        
        CGFloat bgViewHeight = _bgView.bounds.size.height;
        
        _bgView.frame = CGRectMake(0, self.bounds.size.height - bgViewHeight, self.bounds.size.width, bgViewHeight);
        
        _bgBtn.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        
        _bgBtn.enabled = YES;
        
    }];
}

//隐藏
- (void)dismiss
{
    _bgBtn.enabled = NO;
    
    [UIView animateWithDuration:DatePickerView_animationDuration animations:^{
        
        CGFloat bgViewHeight = _bgView.bounds.size.height;
        
        _bgView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, bgViewHeight);
        
        self.bgBtn.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

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

@end
