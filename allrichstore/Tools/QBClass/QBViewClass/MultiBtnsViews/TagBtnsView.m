//
//  TagBtnsView.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/18.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "TagBtnsView.h"     //按钮标签视图

//默认的设置
#define kMargin_top                 Adapted(0)
#define kMargin_bottom              Adapted(12)
#define kMargin_level               Adapted(10)
#define kBtnsHeight                 Adapted(40)
#define kTitleLabelHeight           Adapted(40)
#define kSpace_vertical_title_Btn   Adapted(0)
#define kSpace_vertical_Btns        Adapted(10)
#define kSpace_level_Btns           Adapted(12)
#define kBtnTitleFont               [UIFont systemFontOfSize:FloatAdapted(15)]

//标题文字的默认颜色
#define kColor_title    [UIColor colorWithWhite:0.2 alpha:1.0]

//按钮标题的默认颜色
#define kColor_btnTitleNormal        [UIColor grayColor]
#define kColor_btnTitleSeleted       [UIColor redColor]

//按钮边框的默认颜色
#define kColor_btnNormalBorder       [UIColor clearColor]
#define kColor_btnSelectedBorder    [UIColor clearColor]

//按钮tag的初始值
#define kTag_Btn        1001

@interface TagBtnsView()

@property (nonatomic, strong) NSArray *allArray;
@property (nonatomic, copy) TagBtnsViewSelectedBlock selectedBlock;

//外界可以赋值  改变按钮的选中状态
@property (nonatomic, strong) NSMutableArray *selectedStringArray;
@property (nonatomic, strong) NSMutableArray *selectedIndexArray;

@end

@implementation TagBtnsView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title allArray:(NSArray *)allArray selectedArray:(NSArray *)selectedArray isMuti:(BOOL)isMuti configureBlcok:(TagBtnsViewConfigureBlock)configureBlcok selectedBlock:(TagBtnsViewSelectedBlock)block
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.selectedBlock = block;
        self.selectedStringArray = [NSMutableArray array];
        self.selectedIndexArray = [NSMutableArray array];
        
        //配置默认参数
        self.margin_top = kMargin_top;
        self.margin_bottom = kMargin_bottom;
        self.margin_level = kMargin_level;
        self.titleLabelHeight = kTitleLabelHeight;
        self.btnsHeight = kBtnsHeight;
        self.space_vertical_title_Btn = kSpace_vertical_title_Btn;
        self.space_vertical_Btns = kSpace_vertical_Btns;
        self.space_level_Btns = kSpace_level_Btns;
        self.btnTitleFont = kBtnTitleFont;
        self.titleColor = kColor_title;
        self.btnTitleNormalColor = kColor_btnTitleNormal;
        self.btnTitleSeletedColor = kColor_btnTitleSeleted;
        
        self.allArray = allArray;
        
        //从外部配置参数
        configureBlcok(self);
        
        self.titleLabelHeight = title ? self.titleLabelHeight : 0;
        
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        
        //添加标题控件
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_margin_level, _margin_top, self.width - _margin_level * 2.0, _titleLabelHeight)];
        _titleLabel.textColor = _titleColor;
        _titleLabel.font = AdaptedFont(17);
        _titleLabel.text = title;
        [self addSubview:_titleLabel];
        
        
        //排序取出最大的按钮的宽度
        CGFloat btnMaxWidth = 0;
        if (_isSameWidth)
        {
            for (int i = 0; i < allArray.count; i++)
            {
                CGFloat titleWidth = [UILabel getWidthWithFont:_btnTitleFont text:allArray[i]];
                if (titleWidth > btnMaxWidth)
                {
                    btnMaxWidth = titleWidth;
                }
            }
            
            btnMaxWidth += Adapted(16);
        }
        
        CGFloat tagBtnLeft = _margin_level;
        CGFloat tagBtnTop = _titleLabel.bottom + _space_vertical_title_Btn;
        CGFloat maxRight = self.width - _margin_level;
        for (int i = 0; i < allArray.count; i++)
        {
            NSString *btnTitle = allArray[i];
            CGFloat tagBtnWidth = [UILabel getWidthWithFont:_btnTitleFont text:allArray[i]] + Adapted(16);
            if (_isSameWidth)
            {
                tagBtnWidth = btnMaxWidth;
            }
            QButton *tagBtn = [[QButton alloc] initWithFrame:CGRectMake(tagBtnLeft, tagBtnTop, tagBtnWidth, _btnsHeight) style:QButtonStyleNormal layoutStyle:QButtonLayoutStyleNone font:_btnTitleFont title:btnTitle image:nil space:0 margin:0 autoSize:YES];
            tagBtn.tag = kTag_Btn + i;
            tagBtn.normalBgColor = _btnNormalBgColor;
            tagBtn.selectedBgColor = _btnSelectedBgColor;
            [tagBtn setTitleColor:_btnTitleNormalColor forState:UIControlStateNormal];
            [tagBtn setTitleColor:_btnTitleSeletedColor forState:UIControlStateSelected];
            [tagBtn setImage:_btnSelectedImage forState:UIControlStateSelected];
            
            tagBtn.layer.masksToBounds = YES;
            tagBtn.layer.borderWidth = _btnBorderWidth;
            tagBtn.layer.cornerRadius = _btnCornerRadius;
            tagBtn.normalBorderColor = _btnNormalBorderColor;
            tagBtn.selectedBorderColor = _btnSelectedBorderColor;
            if ([selectedArray isHaveString:btnTitle])
            {
                tagBtn.selected = YES;
            }
            if (isMuti)
            {
                [tagBtn addTarget:self action:@selector(handleMultipleBtn:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                [tagBtn addTarget:self action:@selector(handleSigleBtn:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            if ((allArray.count - 1) == i)
            {
                self.height = tagBtn.bottom + _margin_bottom;
                self.justHeight = self.height;
            }
            else
            {
                tagBtnLeft = tagBtn.right + _space_level_Btns;
                
                CGFloat nextBtnWidth = [UILabel getWidthWithFont:_btnTitleFont text:allArray[i]] + Adapted(16);
                if (_isSameWidth)
                {
                    nextBtnWidth = btnMaxWidth;
                }
                //宽度超过一行 则换行
                if ((tagBtnLeft + nextBtnWidth) > maxRight)
                {
                    tagBtnLeft = _margin_level;
                    tagBtnTop  = tagBtn.bottom + _space_vertical_Btns;
                }
            }
            
            [self addSubview:tagBtn];
        }
        
        self.selectedStringArr = selectedArray;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame btnLayoutStyle:(QButtonLayoutStyle)btnLayoutStyle title:(NSString *)title allArray:(NSArray *)allArray selectedArray:(NSArray *)selectedArray btnCountALine:(NSUInteger)btnCountALine normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage titleAndImageSpace:(CGFloat)space isMuti:(BOOL)isMuti configureBlcok:(TagBtnsViewConfigureBlock)configureBlcok selectedBlock:(TagBtnsViewSelectedBlock)block
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.selectedBlock = block;
        self.selectedStringArray = [NSMutableArray array];
        self.selectedIndexArray = [NSMutableArray array];
        //配置默认参数
        self.margin_top = kMargin_top;
        self.margin_bottom = kMargin_bottom;
        self.margin_level = kMargin_level;
        self.titleLabelHeight = kTitleLabelHeight;
        self.btnsHeight = kBtnsHeight;
        self.space_vertical_title_Btn = kSpace_vertical_title_Btn;
        self.space_vertical_Btns = kSpace_vertical_Btns;
        self.space_level_Btns = kSpace_level_Btns;
        self.btnTitleFont = kBtnTitleFont;
        self.titleColor = kColor_title;
        self.btnTitleNormalColor = kColor_btnTitleNormal;
        self.btnTitleSeletedColor = kColor_btnTitleSeleted;
        
        self.btnNormalImage = normalImage;
        self.btnSelectedImage = selectedImage;
        
        self.allArray = allArray;
        
        //从外部配置参数
        configureBlcok(self);
        
        self.titleLabelHeight = title ? self.titleLabelHeight : 0;
        
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        
        //添加标题控件
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_margin_level, _margin_top, self.width - _margin_level * 2.0, _titleLabelHeight)];
        _titleLabel.textColor = _titleColor;
        _titleLabel.font = AdaptedFont(17);
        _titleLabel.text = title;
        [self addSubview:_titleLabel];
        
        CGFloat tagBtnWidth = (self.width -   _margin_level) / btnCountALine - _margin_level;
        CGFloat tagBtnLeft = _margin_level;
        CGFloat tagBtnTop = _titleLabel.bottom + _space_vertical_title_Btn;
        for (int i = 0; i < allArray.count; i++)
        {
            NSString *btnTitle = allArray[i];
            
            QButton *tagBtn = [[QButton alloc] initWithFrame:CGRectMake(tagBtnLeft, tagBtnTop, tagBtnWidth, _btnsHeight) style:QButtonStyleNormal layoutStyle:btnLayoutStyle font:_btnTitleFont title:btnTitle image:_btnNormalImage space:space margin:0 autoSize:YES];
            tagBtn.tag = kTag_Btn + i;
            tagBtn.normalBgColor = _btnNormalBgColor;
            tagBtn.selectedBgColor = _btnSelectedBgColor;
            [tagBtn setTitleColor:_btnTitleNormalColor forState:UIControlStateNormal];
            [tagBtn setTitleColor:_btnTitleSeletedColor forState:UIControlStateSelected];
            [tagBtn setImage:_btnSelectedImage forState:UIControlStateSelected];
            
            tagBtn.layer.masksToBounds = YES;
            tagBtn.layer.borderWidth = _btnBorderWidth;
            tagBtn.layer.cornerRadius = _btnCornerRadius;
            tagBtn.normalBorderColor = _btnNormalBorderColor;
            tagBtn.selectedBorderColor = _btnSelectedBorderColor;
            
            if ([selectedArray isHaveString:btnTitle])
            {
                tagBtn.selected = YES;
            }
            
            if (isMuti)
            {
                [tagBtn addTarget:self action:@selector(handleMultipleBtn:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                [tagBtn addTarget:self action:@selector(handleSigleBtn:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            tagBtnLeft = tagBtn.right + _margin_level;
            if ((i % btnCountALine) == (btnCountALine - 1))
            {
                tagBtnLeft = _margin_level;
                tagBtnTop = tagBtn.bottom + _space_vertical_Btns;
            }
            
            [self addSubview:tagBtn];
            
            if ((allArray.count - 1) == i)
            {
                self.height = tagBtn.bottom + _margin_bottom;
                self.justHeight = self.height;
            }
        }
        
        self.selectedStringArr = selectedArray;
    }
    return self;
}


#pragma mark - override
- (void)setSelectedStringArr:(NSArray *)selectedStringArr
{
    _selectedStringArr = selectedStringArr;
    [_selectedStringArray removeAllObjects];
    [_selectedStringArray addObjectsFromArray:selectedStringArr];
    NSMutableArray *muArray = [NSMutableArray arrayWithArray:_selectedStringArray];
    [self reloadBtnWidthSelectedStringArray:muArray];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    [self handleSigleBtn:[self viewWithTag:kTag_Btn + selectedIndex]];
}

#pragma mark - custom method
//通过传入的选中的标题数组，该表按钮的状态
- (void)reloadBtnWidthSelectedStringArray:(NSMutableArray *)selectedStringArray
{
    for (int i = 0; i < _allArray.count; i++)
    {
        UIButton *btn = [self viewWithTag:i + kTag_Btn];
        btn.selected = NO;
        if (selectedStringArray.count == 0)
        {
            continue;
        }
        NSString *string = _allArray[i];
        for (int j = 0; j < selectedStringArray.count; j++)
        {
            if ([selectedStringArray[j] isEqualToString:string])
            {
                btn.selected = YES;
                [selectedStringArray removeObjectAtIndex:j];
                break;
            }
        }
    }
}

#pragma mark - handle action
//多选
- (void)handleMultipleBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected)
    {
        [self.selectedStringArray addObject:sender.currentTitle];
        _selectedIndex = sender.tag - kTag_Btn;
    }
    else
    {
        [self.selectedStringArray removeObject:sender.currentTitle];
    }
    NSArray *selectedArray = [NSArray arrayWithArray:_selectedStringArray];
    self.selectedBlock(selectedArray, _selectedIndex);
}

#pragma mark - handle action
//单选
- (void)handleSigleBtn:(UIButton *)sender
{
    
    for (int i = 0; i < _allArray.count; i++)
    {
        UIButton *btn = [self viewWithTag:i + kTag_Btn];
        btn.selected = NO;
    }
    sender.selected = YES;
    [self.selectedStringArray removeAllObjects];
    [self.selectedStringArray addObject:sender.currentTitle];
    _selectedIndex = sender.tag - kTag_Btn;
    
    NSArray *selectedArray = [NSArray arrayWithArray:_selectedStringArray];
    self.selectedBlock(selectedArray, _selectedIndex);
}


@end
