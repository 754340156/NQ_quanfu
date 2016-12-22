//
//  TabMenuView.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/28.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "TabMenuView.h"

#define kCellHeight             Adapted(60)

/**按钮的默认背景颜色（选中和未选中）*/
//默认背景色
#define kColor_bg_normal    [UIColor whiteColor]
//选中背景色
#define kColor_bg_selected  [UIColor clearColor]

/** cell按钮的默认文字颜色（选中和未选中）*/
//默认文本色
#define kColor_text_normal     qbBlackColor
//选中文本色
#define kColor_text_selected   qbRedColor

@interface TabMenuView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) TabMenuActionBlock actionBlock;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

static NSString *identifier_cell = @"tabMenu_Cell";

@implementation TabMenuView

/**
 传入数组 block形式
 @param menuArray 菜单的数据
 @param configure 配置参数
 @param action    选中的触发事件
 */
- (instancetype)initWithFrame:(CGRect)frame
                    menuArray:(NSArray *)menuArray
                    configure:(TabMenuConfigureBlock)configure
                       action:(TabMenuActionBlock)action
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //默认配置
        self.selectedIndex = -1;
        self.cellHeight = kCellHeight;
        self.bgColor_normal = kColor_bg_normal;
        self.bgColor_selected = kColor_bg_selected;
        self.textColor_normal = kColor_text_normal;
        self.textColor_selected = kColor_text_selected;
        
        //外部传入的配置
        if (configure)
        {
            configure(self);
        }
        
        [self addSubview:self.tableView];
        [self layoutViews]; //布局子控件
        
        self.actionBlock = action;
        self.menuArray = menuArray;
        
    }
    return self;
}

/**
 传入数组 delegate形式
 @param menuArray 菜单的数据
 @param configure 配置参数
 @param delegate  代理对象
 */
- (instancetype)initWithFrame:(CGRect)frame
                    menuArray:(NSArray *)menuArray
                    configure:(TabMenuConfigureBlock)configure
                     delegate:(id<TabMenuViewDelegate>)delegate
{
    TabMenuView *tabMenuView = [self initWithFrame:frame menuArray:menuArray configure:configure action:nil];
    tabMenuView.delegate = delegate;
    return tabMenuView;
}

/**
 传入数组 block形式
 @param menuArray 菜单的数据
 @param configure 配置参数
 @param action    选中的触发事件
 */
- (instancetype)initWithMenuArray:(NSArray *)menuArray
                        configure:(TabMenuConfigureBlock)configure
                           action:(TabMenuActionBlock)action
{
    return [self initWithFrame:CGRectZero menuArray:menuArray configure:configure action:action];
}

/**
 传入数组 delegate形式
 @param menuArray 菜单的数据
 @param configure 配置参数
 @param delegate  代理对象
 */
- (instancetype)initWithMenuArray:(NSArray *)menuArray
                        configure:(TabMenuConfigureBlock)configure
                         delegate:(id<TabMenuViewDelegate>)delegate
{
    return [self initWithFrame:CGRectZero menuArray:menuArray configure:configure delegate:delegate];
}

/**
 block形式
 @param configure 配置参数
 @param action    选中的触发事件
 */
- (instancetype)initWithConfigure:(TabMenuConfigureBlock)configure
                           action:(TabMenuActionBlock)action
{
    return [self initWithMenuArray:nil configure:configure action:action];
}

/**
 delegate形式
 @param configure 配置参数
 @param delegate  代理对象
 */
- (instancetype)initWithConfigure:(TabMenuConfigureBlock)configure
                         delegate:(id<TabMenuViewDelegate>)delegate
{
    return [self initWithMenuArray:nil configure:configure delegate:delegate];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame menuArray:nil configure:nil delegate:nil];
}

- (instancetype)init
{
    return [self initWithFrame:CGRectZero menuArray:nil configure:nil delegate:nil];
}

#pragma mark - lazy
- (UITableView *)tableView
{
    if (!_tableView)
    {
        self.tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.alwaysBounceVertical = YES;
        [_tableView registerClass:[TabMenuCell class] forCellReuseIdentifier:identifier_cell];
    }
    return _tableView;
}

- (void)setMenuArray:(NSArray *)menuArray
{
    BOOL lastArrayIsEmpty = NO;
    if (_menuArray.count == 0)
    {
        lastArrayIsEmpty = YES;
    }
    _menuArray = menuArray;
    [self.tableView reloadData];
    [self.tableView setNeedsLayout];
    if (lastArrayIsEmpty)
    {
        //默认选中第一个
        [self selectedIndex:0];
    }
}

#pragma mark - custom
//布局子控件
- (void)layoutViews
{
    //添加约束
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
}

#pragma mark - handle action
//选中下标
- (void)selectedIndex:(NSInteger)index
{
    if (_menuArray.count > index)
    {
        [self tableView:_tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    }
}

#pragma mark - <UITableViewDataSource>
//设置每组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _menuArray.count;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TabMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_cell forIndexPath:indexPath];
    [cell.titleBtn setTitleColor:_textColor_normal forState:UIControlStateNormal];
    [cell.titleBtn setTitleColor:_textColor_selected forState:UIControlStateSelected];
    cell.titleBtn.normalBgColor = _bgColor_normal;
    cell.titleBtn.selectedBgColor = _bgColor_selected;
    NSString *title;
    if ([_menuArray[indexPath.row] isKindOfClass:[NSString class]])
    {
        title = _menuArray[indexPath.row];
    }
    else
    {
        id<TabMenuModelAble> model = _menuArray[indexPath.row];
        title = [model qbTitle];
    }
    [cell.titleBtn setTitle:title forState:UIControlStateNormal];
    cell.titleBtn.selected = (_selectedIndex == indexPath.row);
    return cell;
}

#pragma mark - <UITableViewDelegate>
//cell被选中时触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectedIndex == indexPath.row)
    {
        return;
    }
    self.selectedIndex = indexPath.row;
    [tableView reloadData];
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    if (self.actionBlock)
    {
        self.actionBlock(_selectedIndex);
    }
    
    [self.delegate tabMenuViewTableView:tableView didSelectRowIndex:indexPath.row];
}

//设置cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cellHeight;
}

@end

//底线的属性
#define kBottomLineView_Color   [UIColor colorWithWhite:0.92 alpha:1.0]
#define kBottomLineView_Height  0.8

@implementation TabMenuCell
    
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self addOwnViews]; //添加子控件
        [self layoutViews]; //布局子控件
    }
    return self;
}

#pragma mark - addOwnviews
//添加子控件
- (void)addOwnViews
{
    [self.contentView addSubview:self.titleBtn];
    [self.contentView addBottomLineWithColor:kBottomLineView_Color height:kBottomLineView_Height];
}

#pragma mark - layoutViews
//布局子控件
- (void)layoutViews
{
    _titleBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-kBottomLineView_Height]];
}

#pragma mark - lazy
- (QButton *)titleBtn
{
    if (!_titleBtn)
    {
        self.titleBtn = [QButton buttonWithType:UIButtonTypeCustom];
        _titleBtn.userInteractionEnabled = NO;
        _titleBtn.titleLabel.font = AdaptedFont(16);
    }
    return _titleBtn;
}

@end
