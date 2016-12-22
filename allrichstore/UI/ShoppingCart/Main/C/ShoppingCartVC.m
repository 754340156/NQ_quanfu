//
//  ShoppingCartVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/10/27.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ShoppingCartVC.h"
#import "ShoppingCartModel.h"
#import "ShoppingCartCell.h"
#import "ShoppingCartBottomView.h"
#import "ShoppingCartHeaderView.h"
#import "SA_HintView.h"

#import "GoodsDetailVC.h"//商品详情
#import "CreateOrderVC.h" //创建订单
@interface ShoppingCartVC ()<ShoppingCartBottomViewDelegate,SA_HintViewDelegate>
/**  底部计算view */
@property(nonatomic,strong) ShoppingCartBottomView * bottomView;
/**  编辑时候的蒙版 */
@property(nonatomic,strong) SA_HintView * hintView;
/**  购物车中选中的数组 */
@property(nonatomic,strong) NSMutableArray * selectedArray;
@end

@implementation ShoppingCartVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *array = @[@{@"shopName":@"柏杨九天",
                         @"goods":@[@{@"icon":@"goodsPic1",
                                      @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                      @"subTitle1":@"颜色分类：白色",
                                      @"subTitle2":@"尺寸：S码",
                                      @"price":@"218.00",
                                      @"count":@"1",
                                      @"inventory":@"20"}]},
                       @{@"shopName":@"柏杨九天",
                         @"goods":@[@{@"icon":@"goodsPic1",
                                      @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                      @"subTitle1":@"颜色分类：白色",
                                      @"subTitle2":@"尺寸：S码",
                                      @"price":@"218.00",
                                      @"count":@"1",
                                      @"inventory":@"20"},
                                    @{@"icon":@"goodsPic1",
                                      @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                      @"subTitle1":@"颜色分类：白色",
                                      @"subTitle2":@"尺寸：S码",
                                      @"price":@"218.00",
                                      @"count":@"1",
                                      @"inventory":@"20"},
                                    @{@"icon":@"goodsPic1",
                                      @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                      @"subTitle1":@"颜色分类：白色",
                                      @"subTitle2":@"尺寸：S码",
                                      @"price":@"218.00",
                                      @"count":@"1",
                                      @"inventory":@"20"}]},
                       @{@"shopName":@"柏杨九天",
                         @"goods":@[@{@"icon":@"goodsPic1",
                                      @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                      @"subTitle1":@"颜色分类：白色",
                                      @"subTitle2":@"尺寸：S码",
                                      @"price":@"218.00",
                                      @"count":@"1",
                                      @"inventory":@"20"},
                                    @{@"icon":@"goodsPic1",
                                      @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                      @"subTitle1":@"颜色分类：白色",
                                      @"subTitle2":@"尺寸：S码",
                                      @"price":@"218.00",
                                      @"count":@"1",
                                      @"inventory":@"20"}]},
                       @{@"shopName":@"柏杨九天",
                         @"goods":@[@{@"icon":@"goodsPic1",
                                      @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                      @"subTitle1":@"颜色分类：白色",
                                      @"subTitle2":@"尺寸：S码",
                                      @"price":@"218.00",
                                      @"count":@"1",
                                      @"inventory":@"20"}]}];
    self.listArray = [ShoppingCartModel mj_objectArrayWithKeyValuesArray:array];
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    [self setNaviBar];
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    [self.tableView registerClass:[ShoppingCartCell class] forCellReuseIdentifier:[ShoppingCartCell className]];
    [self.tableView registerClass:[ShoppingCartHeaderView class] forHeaderFooterViewReuseIdentifier:[ShoppingCartHeaderView className]];
    [self.view addSubview:self.bottomView];
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(Adapted(kBottomViewH));
        make.bottom.offset(self.isDetail ? 0 : -49);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.equalTo(self.bottomView.mas_top);
        make.top.offset(TopBarHeight);
    }];
}

#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
    
}

#pragma mark - custom method
//重置所有button状态
- (void)resetAllBtnState {
    for (ShoppingCartModel *model in self.listArray) {
        for (ShoppingCartListModel *listmodel in model.goods) {
            if (!listmodel.isCellSelected) {
                self.bottomView.allButton.selected = NO;
                return;
            }
        }
    }
    self.bottomView.allButton.selected = YES;
}
//计算商品价格
- (void)CalculationPrice {
    CGFloat allPrict = 0.0;
    for (ShoppingCartModel *model in self.listArray) {
        for (ShoppingCartListModel *listmodel in model.goods) {
            // 计算每个cell的总价
            if (listmodel.isCellSelected) {
                allPrict += listmodel.count.intValue * listmodel.price.floatValue ;
            }
        }
    }
    self.bottomView.totalLabel.text = [NSString stringWithFormat:@"%@: ￥%.2f",String(@"合计"), allPrict];
}
//将选中的商品model加入数组中
- (void)intoSelectedArray
{
    self.selectedArray = [NSMutableArray array];
    if (!self.listArray.count) return;
    [self.listArray enumerateObjectsUsingBlock:^(ShoppingCartModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray * goods = [NSMutableArray array];
        [obj.goods enumerateObjectsUsingBlock:^(ShoppingCartListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.isCellSelected) {
                ShoppingCartListModel *model  = [ShoppingCartListModel mj_objectWithKeyValues:obj];
                [goods addObject:model];
            }
        }];
        if (goods.count)
        {
            ShoppingCartModel *model = [ShoppingCartModel mj_objectWithKeyValues:obj];
            model.goods = goods;
            [self.selectedArray addObject:model];
        }
    }];
}
- (void)setNaviBar
{
    [self addRightImage:Image(@"xiaoxi") action:@selector(messageAction)];
    
    UIButton * editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [editButton setTitle:String(@"编辑") forState:UIControlStateNormal];
    [editButton setTitle:String(@"完成") forState:UIControlStateSelected];
    [editButton setTitleColor:QF_BlackColor forState:UIControlStateNormal];
    editButton.titleLabel.font = Font_Mid;
    editButton.frame = CGRectMake(0, 0, Adapted(40), Adapted(25));
    [self addRightBtn:editButton action:@selector(editAction:)];
}
#pragma mark - handle action
- (void)editAction:(UIButton *) sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        //进入编辑状态
        [self.bottomView editStatus];
    }else
    {
        //退出编辑状态
        [self.bottomView normalStatus];
    }
}
//消息
- (void)messageAction
{
    
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.listArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listArray[section] goods].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WS(weakSelf);
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:[ShoppingCartCell className]];
    cell.model = [self.listArray[indexPath.section] goods][indexPath.row];
    __weak __typeof(cell)weakCell = cell;
    cell.countAddBlock = ^(UIButton *sender){
        ShoppingCartListModel *model = [self.listArray[indexPath.section] goods][indexPath.row];
        NSInteger count = [weakCell.numberLabel.text integerValue];
        count ++;
        if(count > 999) {
            NSLog(@"超出最大范围");
            return ;
        }
        if (count > [model.inventory intValue]) {
            NSLog(@"没有有那么多库存");
            return ;
        }
        weakCell.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
        model.count = [NSString stringWithFormat:@"%ld",(long)count];
        [weakSelf CalculationPrice];
    };
    cell.countReduceBlock = ^(UIButton *sender){
        ShoppingCartListModel *model = [self.listArray[indexPath.section] goods][indexPath.row];
        NSInteger count = [weakCell.numberLabel.text integerValue];
        count --;
        if(count <= 0) {
            NSLog(@"再减就没了");
            return ;
        }
        weakCell.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
        model.count = [NSString stringWithFormat:@"%ld",(long)count];
        [weakSelf CalculationPrice];
    };
    cell.selectedBlock = ^{
        ShoppingCartModel *model = weakSelf.listArray[indexPath.section];
        [model resetHeadClickState];
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:NO];
        [weakSelf resetAllBtnState];
        [weakSelf CalculationPrice];
    };
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ShoppingCartHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[ShoppingCartHeaderView className]];
    headerView.model = self.listArray[section];
    WS(weakSelf);
    headerView.headerClickBlock = ^{
        ShoppingCartModel *model = weakSelf.listArray[section];
        [model resetCellClickState];
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:NO];
        [weakSelf resetAllBtnState];
        [weakSelf CalculationPrice];
    };
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return Adapted(kHeaderH);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Adapted(kCellHeight);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 7;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 7)];
    footerView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    return footerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GoodsDetailVC *detailVC = [[GoodsDetailVC alloc] init];
    [self.navigationController pushVC:detailVC animated:YES];
}
#pragma mark - UIScrollViewDelegate
//禁止悬停
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = Adapted(kHeaderH);
    CGFloat sectionFooterHeight = 7;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= sectionHeaderHeight && offsetY <= scrollView.contentSize.height - scrollView.frame.size.height - sectionFooterHeight)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= scrollView.contentSize.height - scrollView.frame.size.height - sectionFooterHeight && offsetY <= scrollView.contentSize.height - scrollView.frame.size.height)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(scrollView.contentSize.height - scrollView.frame.size.height - sectionFooterHeight), 0);
    }
}
#pragma mark - ShoppingCartBottomViewDelegate
//结算
- (void)ShoppingCartBottomViewDelegate_clickSettlementBtn
{
    //把选中的放入数组中
    [self intoSelectedArray];
    CreateOrderVC *createOrderVC = [[CreateOrderVC alloc] init];
    [self.navigationController pushVC:createOrderVC animated:YES];
}
//移入关注
- (void)ShoppingCartBottomViewDelegate_clickToCareBtn
{
    self.hintView.titleName = String(@"确定要将商品移入我的关注?");
    [[UIApplication sharedApplication].keyWindow addSubview:self.hintView];
}
//删除
- (void)ShoppingCartBottomViewDelegate_clickDeleteButton
{
    self.hintView.titleName = String(@"确定要删除此商品吗?");
    [[UIApplication sharedApplication].keyWindow addSubview:self.hintView];
}
#pragma mark - SA_HintViewDelegate
//点击删除关注蒙版吗确定或者取消
- (void)SA_HintViewDelegate_ClickBtnWith:(BOOL)isSure
{
    [self.hintView removeFromSuperview];
}
#pragma mark - dealloc
- (void)dealloc
{
    
}
#pragma mark - lazy
- (ShoppingCartBottomView *)bottomView
{
    WS(weakSelf);
    if (!_bottomView) {
        _bottomView = [[ShoppingCartBottomView alloc] init];
        _bottomView.backgroundColor = kWhiteColor;
        _bottomView.delegate = self;
        _bottomView.clickAllButtonBlock = ^(QButton *sender)
        {
            [weakSelf.listArray enumerateObjectsUsingBlock:^(ShoppingCartModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
                [model resetAllState:sender.selected];
            }];
            [weakSelf.tableView reloadData];
            [weakSelf CalculationPrice];

        };
    }
    return _bottomView;
}
- (SA_HintView *)hintView
{
    if (!_hintView) {
        _hintView = [[SA_HintView alloc] initWithFrame:self.view.bounds];
        _hintView.sure = @"确定";
        _hintView.notSure = @"取消";
        _hintView.delegate = self;
    }
    return _hintView;
}
- (NSMutableArray *)selectedArray
{
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}
@end
