//
//  HotClassView.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/17.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "HotClassView.h"    //热门分类

//动画的周期
#define kAnimationDuration  0.3
//半透明背景的颜色
#define kColor_transitionBg Color_transitionBg

//tableView的宽度
#define kWidth_tableView    (self.width / 3.0)

//cell的高度
#define kCellHeight         Adapted(50)

@interface HotClassView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) StringBlock block;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *listArray;
@property (nonatomic, strong) UIButton *bgBtn;

@end

@implementation HotClassView

- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)array block:(StringBlock)block
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.listArray = array;
        self.block = block;
        [self createViews]; //创建子视图
    }
    return self;
}

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.bgBtn = [[UIButton alloc] initWithFrame:self.bounds];
    _bgBtn.backgroundColor = kColor_transitionBg;
    _bgBtn.alpha = 0.0;
    [_bgBtn addTarget:self action:@selector(handleBgBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_bgBtn];
    
    //tableView的高度
    CGFloat tableViewHeight = kCellHeight * _listArray.count;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake((self.width - kWidth_tableView) / 2.0, self.height - tableViewHeight - 45, kWidth_tableView, tableViewHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[LabelCell class] forCellReuseIdentifier:[LabelCell className]];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
}


#pragma mark - custom method
//展示
- (void)show
{
    _bgBtn.userInteractionEnabled = NO;
    [UIView animateWithDuration:kAnimationDuration animations:^{
        
        _bgBtn.alpha = 1.0;
        
    } completion:^(BOOL finished) {
       
        _bgBtn.userInteractionEnabled = YES;
        
    }];
}

//消失
- (void)dissMiss
{
    _bgBtn.userInteractionEnabled = NO;
    [UIView animateWithDuration:kAnimationDuration animations:^{
        
        _bgBtn.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

#pragma mark - handle action
//背景按钮 -- 触发事件
- (void)handleBgBtn:(UIButton *)sender
{
    [self dissMiss];
}

#pragma mark - <UITableViewDataSource>
//设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//设置每组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.listArray.count;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[LabelCell className] forIndexPath:indexPath];
    cell.label.text = _listArray[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
//cell被选中时触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _block(_listArray[indexPath.row]);
}

//设置cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

@end
