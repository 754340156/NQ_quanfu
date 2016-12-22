//
//  FoldMenuView.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/3.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "FoldMenuView.h"
#import "FoldMenu_HeaderView.h"
#import "FoldMenu_Cell.h"

#pragma mark - defaultConfigure

#define kOneLevelHeight             Adapted(60)
#define kTwoLevelHeight             Adapted(50)

/**按钮的默认背景颜色（选中和未选中）*/
//一级默认背景色
#define kColor_bg_normal_oneLevel   [UIColor whiteColor]
//一级选中背景色
#define kColor_bg_selected_oneLevel [UIColor whiteColor]
//二级默认背景色
#define kColor_bg_normal_twoLevel   [UIColor colorWithWhite:0.97 alpha:1.0]
//二级选中背景色
#define kColor_bg_selected_twoLevel [UIColor colorWithWhite:0.97 alpha:1.0]

/**按钮的默认文字颜色（选中和未选中）*/
//一级默认文本色
#define kColor_text_normal_oneLevel     [UIColor colorWithWhite:0.15 alpha:1.0]
//一级选中文本色
#define kColor_text_selected_oneLevel   [UIColor colorWithRed:232 / 255.0 green:35 / 255.0 blue:45 / 255.0 alpha:1.0]
//二级默认文本色
#define kColor_text_normal_twoLevel     [UIColor colorWithWhite:0.15 alpha:1.0]
//二级选中文本色
#define kColor_text_selected_twoLevel   [UIColor colorWithRed:232 / 255.0 green:35 / 255.0 blue:45 / 255.0 alpha:1.0]

@interface FoldMenuView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) FoldMenuActionBlock actionBlock;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

static NSString *identifier_cell = @"FoldMenu_Cell";
static NSString *identifier_cellHeader = @"FoldMenu_HeaderView";

@implementation FoldMenuView

#pragma mark - init method
/**
 传入model block形式
 @param model     菜单的model
 @param configure 配置参数
 @param action    选中的触发事件
 */
- (instancetype)initWithFrame:(CGRect)frame
                        model:(id<FoldMenuAble>)model
                    configure:(FoldMenuConfigureBlock)configure
                       action:(FoldMenuActionBlock)action
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.actionBlock = action;
        self.menuModel = model;
        
        //默认配置
        self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        self.isSingleOpen = YES;
        self.isSelectedWhenOpen = YES;
        self.oneLevelHeight = kOneLevelHeight;
        self.twoLevelHeight = kTwoLevelHeight;
        self.bgColor_normal_oneLevel = kColor_bg_normal_oneLevel;
        self.bgColor_selected_oneLevel = kColor_bg_selected_oneLevel;
        self.bgColor_normal_twoLevel = kColor_bg_normal_twoLevel;
        self.bgColor_selected_twoLevel = kColor_bg_selected_twoLevel;
        
        self.textColor_normal_oneLevel = kColor_text_normal_oneLevel;
        self.textColor_selected_oneLevel = kColor_text_selected_oneLevel;
        self.textColor_normal_twoLevel = kColor_text_normal_twoLevel;
        self.textColor_selected_twoLevel = kColor_text_selected_twoLevel;
        
        //外部传入的配置
        if (configure)
        {
            configure(self);
        }
        
        [self addSubview:self.tableView];
        [self layoutViews]; //布局子控件
    }
    return self;
}

/**
 传入model delegate形式
 @param model     菜单的model
 @param configure 配置参数
 @param delegate  代理对象
 */
- (instancetype)initWithFrame:(CGRect)frame
                        model:(id<FoldMenuAble>)model
                    configure:(FoldMenuConfigureBlock)configure
                     delegate:(id<FoldMenuViewDelegate>)delegate
{
    FoldMenuView *menuView = [self initWithFrame:frame model:model configure:configure action:nil];
    menuView.delegate = delegate;
    return menuView;
}

/**
 block形式
 @param configure 配置参数
 @param action    选中的触发事件
 */
- (instancetype)initWithFrame:(CGRect)frame
                    configure:(FoldMenuConfigureBlock)configure
                        action:(FoldMenuActionBlock)action
{
    return [self initWithFrame:frame model:nil configure:configure action:action];
}

/**
 delegate形式
 @param configure 配置参数
 @param delegate  代理对象
 */
- (instancetype)initWithFrame:(CGRect)frame
                    configure:(FoldMenuConfigureBlock)configure
                     delegate:(id<FoldMenuViewDelegate>)delegate
{
    return [self initWithFrame:frame model:nil configure:configure delegate:delegate];
}

/**
 传入model block形式
 @param model     菜单的model
 @param configure 配置参数
 @param action    选中的触发事件
 */
- (instancetype)initWithModel:(id<FoldMenuAble>)model
                    configure:(FoldMenuConfigureBlock)configure
                       action:(FoldMenuActionBlock)action
{
    return  [self initWithFrame:CGRectZero model:model configure:configure action:action];
}

/**
 传入model delegate形式
 @param model     菜单的model
 @param configure 配置参数
 @param delegate  代理对象
 */
- (instancetype)initWithModel:(id<FoldMenuAble>)model
                    configure:(FoldMenuConfigureBlock)configure
                     delegate:(id<FoldMenuViewDelegate>)delegate
{
    return [self initWithFrame:CGRectZero model:model configure:configure delegate:delegate];
}

/**
 block形式
 @param configure 配置参数
 @param action    选中的触发事件
 */
- (instancetype)initWithConfigure:(FoldMenuConfigureBlock)configure
                           action:(FoldMenuActionBlock)action
{
    return [self initWithModel:nil configure:configure action:action];
}

/**
 delegate形式
 @param configure 配置参数
 @param delegate  代理对象
 */
- (instancetype)initWithConfigure:(FoldMenuConfigureBlock)configure
                         delegate:(id<FoldMenuViewDelegate>)delegate
{
    return [self initWithModel:nil configure:configure delegate:delegate];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame model:nil configure:nil delegate:nil];
}

- (instancetype)init
{
    return [self initWithModel:nil configure:nil delegate:nil];
}

#pragma mark - setter
//如果更新menuModel 刷新tabelView
- (void)setMenuModel:(id<FoldMenuAble>)menuModel
{
    _menuModel = menuModel;
    [self.tableView reloadData];
}

#pragma mark - lazy
- (UITableView *)tableView
{
    if (!_tableView)
    {
        self.tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kClearColor;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.alwaysBounceVertical = YES;
        [_tableView registerClass:[FoldMenu_Cell class] forCellReuseIdentifier:identifier_cell];
        [_tableView registerClass:[FoldMenu_HeaderView class] forHeaderFooterViewReuseIdentifier:identifier_cellHeader];
    }
    return _tableView;
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
//tableView组头按钮 -- 触发事件
- (void)handleHeaderBtn:(UIButton *)sender
{
    NSInteger section = sender.tag - 1001;
    id<SubMenuAble> subMenu = [_menuModel oneLevelArray][section];
    subMenu.isSubOpened = ![subMenu isSubOpened];
    
    if (subMenu.isSubOpened)
    {
        if (_isSelectedWhenOpen)
        {
            self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
            if (_actionBlock)
            {
                _actionBlock(_selectedIndexPath);
            }
            [self.delegate foldMenuViewTableView:self.tableView didSelectRowAtIndexPath:_selectedIndexPath];
        }
    }
    
    
    //如果是单开组 --> 关闭其他打开的组
    if (_isSingleOpen)
    {
        //关闭其他的分组
        NSArray *menuArray = [_menuModel oneLevelArray];
        for (int i = 0; i < menuArray.count; i++)
        {
            if (i == section)
            {
                continue;
            }
            
            id<SubMenuAble> subMenuModel = [_menuModel oneLevelArray][i];
            BOOL isSectionOpen = [subMenu isSubOpened];
            if (isSectionOpen)
            {
                subMenuModel.isSubOpened = NO;
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:i] withRowAnimation:UITableViewRowAnimationNone];
            }
            
        }
    }
    
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    
    [_tableView scrollToRowAtIndexPath:_selectedIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - <UITableViewDataSource>
//设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_menuModel oneLevelArray].count;
}

//设置每组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    id<SubMenuAble> subMenu = [_menuModel oneLevelArray][section];
    return [subMenu twoLevelArray].count;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FoldMenu_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_cell forIndexPath:indexPath];
    [cell.titleBtn setTitleColor:_textColor_normal_twoLevel forState:UIControlStateNormal];
    [cell.titleBtn setTitleColor:_textColor_selected_twoLevel forState:UIControlStateSelected];
    cell.titleBtn.normalBgColor = _bgColor_normal_twoLevel;
    cell.titleBtn.selectedBgColor = _bgColor_normal_twoLevel;
    id<SubMenuAble> subMenu = [_menuModel oneLevelArray][indexPath.section];
    NSString *title = [subMenu twoLevelArray][indexPath.row];
    [cell.titleBtn setTitle:title forState:UIControlStateNormal];
    cell.titleBtn.selected = (_selectedIndexPath == indexPath);
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor clearColor];
}

//返回组头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    id<SubMenuAble> subMenu = [_menuModel oneLevelArray][section];
    FoldMenu_HeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier_cellHeader];
    headerView.menuBtn.tag = 1001 + section;
    [headerView.menuBtn setTitle:[subMenu subTitle] forState:UIControlStateNormal];
    
    [headerView.menuBtn setTitleColor:_textColor_normal_oneLevel forState:UIControlStateNormal];
    [headerView.menuBtn setTitleColor:_textColor_selected_oneLevel forState:UIControlStateSelected];
    headerView.menuBtn.normalBgColor = _bgColor_normal_oneLevel;
    headerView.menuBtn.selectedBgColor = _bgColor_selected_oneLevel;
    headerView.menuBtn.selected = [subMenu isSubOpened];
    [headerView.menuBtn addTarget:self action:@selector(handleHeaderBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return headerView;
}

#pragma mark - <UITableViewDelegate>
//cell被选中时触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    [tableView reloadData];
    
    if (self.actionBlock)
    {
        self.actionBlock(_selectedIndexPath);
    }
    
    [self.delegate foldMenuViewTableView:tableView didSelectRowAtIndexPath:indexPath];
}

//设置cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<SubMenuAble> subMenu = [_menuModel oneLevelArray][indexPath.section];
    BOOL isOpen = [subMenu isSubOpened];
    return isOpen ? _twoLevelHeight : 0;
}

//组头高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return _oneLevelHeight;
}

#pragma mark - helper


@end

@implementation SubMenuModel

- (void)setSubTitle:(NSString *)subTitle
{
    self.title = subTitle;
}

- (NSString *)subTitle
{
    return self.title;
}

- (void)setIsSubOpened:(BOOL)isSubOpened
{
    self.isOpened = isSubOpened;
}

- (BOOL)isSubOpened
{
    return self.isOpened;
}

- (void)setTwoLevelArray:(NSMutableArray<NSString *> *)twoLevelArray
{
    self.subMenuArray = twoLevelArray;
}

- (NSMutableArray<NSString *> *)twoLevelArray
{
    return self.subMenuArray;
}

#pragma mark - lazy
- (NSMutableArray<NSString *> *)subMenuArray
{
    if (!_subMenuArray)
    {
        self.subMenuArray = [NSMutableArray array];
    }
    return _subMenuArray;
}

@end


@implementation FoldMenuModel

- (void)setOneLevelArray:(NSMutableArray *)oneLevelArray
{
    self.menuArray = oneLevelArray;
}

- (NSMutableArray *)oneLevelArray
{
    return self.menuArray;
}

#pragma mark - lazy
- (NSMutableArray *)menuArray
{
    if (!_menuArray)
    {
        self.menuArray = [NSMutableArray array];
    }
    return _menuArray;
}

@end

