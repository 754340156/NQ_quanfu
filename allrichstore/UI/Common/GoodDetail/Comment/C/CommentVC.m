//
//  CommentVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/3.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "CommentVC.h"
#import "SecondCommentVC.h"
#import "CommentHeaderCell.h"
#import "GD_EvaluativeCell.h"
#import "GoodsDetailModel.h"
@interface CommentVC ()<GD_EvaluativeCellDelegate,CommentHeaderCellDelegate>
/**  headerArray */
@property(nonatomic,strong) NSMutableArray * headerArray;
@end

@implementation CommentVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    
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
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    self.tableView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    [self.tableView registerClass:[GD_EvaluativeCell class] forCellReuseIdentifier:[GD_EvaluativeCell className]];
    [self.tableView registerClass:[CommentHeaderCell class] forCellReuseIdentifier:[CommentHeaderCell className]];
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    //请求header
    [self networkHeader];
}

#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
        //默认选择全部评论
    [self networkWithFlag:@"0"];

}

#pragma mark - custom method
//根据不同的按钮选择请求	0：全部；1：好评；2：中评；3：差评；4：有图
- (void)networkWithFlag:(NSString *)flag
{

    NSDictionary *parameters = @{@"id":self.goodId, @"flag":flag};
    WS(weakSelf)
    [self POST:API_GoodDetail_Comment parameters:parameters success:^(NSDictionary *dic) {
        weakSelf.listArray = [GoodsDetailEvaluativeModel mj_objectArrayWithKeyValuesArray:dic[@"response"]];
//        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
//        [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        [weakSelf.tableView reloadData];
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}
//请求headerView
- (void)networkHeader
{
    NSDictionary *parameters = @{@"id":self.goodId};
    WS(weakSelf)
    [self POST:API_GoodDetail_CommentType parameters:parameters success:^(NSDictionary *dic) {
        [weakSelf.headerArray addObject:@{@"全部":dic[@"response"][@"all"]}];
        [weakSelf.headerArray addObject:@{@"好评":dic[@"response"][@"good"]}];
        [weakSelf.headerArray addObject:@{@"中评":dic[@"response"][@"centre"]}];
        [weakSelf.headerArray addObject:@{@"有图":dic[@"response"][@"haveimage"]}];
        [weakSelf.headerArray addObject:@{@"差评":dic[@"response"][@"bad"]}];
        [weakSelf.tableView reloadData];
    } fail:^(NSError *error) {
        
    } sendView:nil animSuperView:self.view animated:YES];
}
#pragma mark - handle action

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 1;
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CommentHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:[CommentHeaderCell className]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.headerArray.count != cell.btnArray.count) {
            cell.btnArray = self.headerArray;
        }
        cell.delegate = self;
        return cell;
        
    }
    GD_EvaluativeCell *cell = [tableView dequeueReusableCellWithIdentifier:[GD_EvaluativeCell className]];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.listArray[indexPath.row];
    return cell;    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.section == 0)  return  Adapted(90);
    return [tableView fd_heightForCellWithIdentifier:[GD_EvaluativeCell className] cacheByIndexPath:indexPath configuration:^(GD_EvaluativeCell* cell) {
        cell.model = self.listArray[indexPath.row];
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return Adapted(kFooterViewH);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, Adapted(kFooterViewH))];
    footerView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    return footerView;
}

#pragma mark - GD_EvaluativeCellDelegate
//点击头像
- (void)GD_EvaluativeCellDelegate_clickIconWithModel:(GoodsDetailEvaluativeModel *)model
{
    
}
//点赞
- (void)GD_EvaluativeCellDelegate_clickLike
{
    
}
//二级评论
- (void)GD_EvaluativeCellDelegate_clickSecondComment
{
    SecondCommentVC * secondCommentVC = [[SecondCommentVC alloc] init];
    [self.navigationController pushVC:secondCommentVC animated:YES];
}
#pragma mark - CommentHeaderCellDelegate
//点击哪个选项
- (void)CommentHeaderCellDelegate_clickButtonWithButton:(UIButton *)sender Index:(NSInteger)index
{
     [self networkWithFlag:[NSString stringWithFormat:@"%ld",(long)index]];
}
#pragma mark - lazy
- (NSMutableArray *)headerArray
{
    if (!_headerArray) {
        _headerArray = [NSMutableArray array];
    }
    return _headerArray;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
