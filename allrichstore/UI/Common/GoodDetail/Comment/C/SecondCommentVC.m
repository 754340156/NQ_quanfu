//
//  SecondCommentVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/23.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SecondCommentVC.h"
#import "SecondCommentCell.h"
#import "SecondCommentBottomView.h"
#import "SecondCommentModel.h"
@interface SecondCommentVC ()<SecondCommentBottomViewDelegate>
/**  bottomView */
@property(nonatomic,strong) SecondCommentBottomView * bottomView;
@end

@implementation SecondCommentVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    NSArray *array = @[@{@"icon":@"jingxuan_icon",
                         @"title":@"妞妞旺铺女装",
                         @"content":@"拿到衣服就迫不及待的试穿了，很好看相当满意的说还要说推荐大家购买，好评",
                         @"time":@"2016-10-10 10:34"},
                       @{@"icon":@"jingxuan_icon",
                         @"title":@"妞妞旺铺女装",
                         @"content":@"拿到衣服就迫不及待的试穿了，很好看相当满意的说还要说推荐大家购买，好评",
                         @"time":@"2016-10-10 10:34"},
                       @{@"icon":@"jingxuan_icon",
                         @"title":@"妞妞旺铺女装",
                         @"content":@"拿到衣服就迫不及待的试穿了，很好看相当满意的说还要说推荐大家购买，好评,拿到衣服就迫不及待的试穿了，很好看相当满意的说还要说推荐大家购买，好评,拿到衣服就迫不及待的试穿了，很好看相当满意的说还要说推荐大家购买，好评",
                         @"time":@"2016-10-10 10:34"},
                       @{@"icon":@"jingxuan_icon",
                         @"title":@"妞妞旺铺女装",
                         @"content":@"拿到衣服就迫不及待的试穿了，很好看相当满意的说还要说推荐大家购买，好评,拿到衣服就迫不及待的试穿了，很好看相当满意的说还要说推荐大家购买，好评",
                         @"time":@"2016-10-10 10:34"}];
    self.listArray = [SecondCommentModel mj_objectArrayWithKeyValuesArray:array];
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    self.tableView.frame = CGRectMake(0, 0, kScreenW, kScreenH - kBottomH);
    self.tableView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[SecondCommentCell class] forCellReuseIdentifier:[SecondCommentCell className]];
    
    [self.view addSubview:self.bottomView];
    
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(50);
    }];
}

#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
    NSDictionary *parameters = @{@"":@"", @"":@""};
    WS(weakSelf)
    [self POST:self.listUrl parameters:parameters success:^(NSDictionary *dic) {
        
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}

#pragma mark - custom method


#pragma mark - handle action

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:[SecondCommentCell className]];
    cell.model = self.listArray[indexPath.row];
    return cell;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:[SecondCommentCell className] cacheByIndexPath:indexPath configuration:^(SecondCommentCell* cell) {
        cell.model = self.listArray[indexPath.row];
    }];
}
#pragma mark - SecondCommentBottomViewDelegate
//提交回复
- (void)SecondCommentBottomViewDelegate_clickSubmit
{
    
}
#pragma mark - lazy
- (SecondCommentBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[SecondCommentBottomView alloc] init];
        _bottomView.delegate = self;
    }
    return _bottomView;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
