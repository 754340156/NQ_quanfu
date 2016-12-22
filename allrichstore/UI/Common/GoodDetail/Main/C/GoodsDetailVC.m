//
//  GoodsDetailVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/1.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsDetailVC.h"
#import "ShoppingCartVC.h"//购物车

#import "GoodsDetailScrollView.h"
#import "GoodsDetailSecondView.h"
#import "GoodsDetailBottomView.h" //底部工具条
#import "GoodsDetailChooseView.h" //选择商品属性view
#import "GoodsDetailModel.h"
#import "ChooseModel.h"
#import "CommentVC.h"
#import "CustomNavigationBar.h"//假导航
#import "ShopHomeVC.h"         //店铺主页

#define kChooseViewH 400.0f //规格view固定宽度
#define kScrollViewOffset 50.0f //显示假导航偏移量

@interface GoodsDetailVC ()<GoodsDetailBottomViewDelegate,UIScrollViewDelegate,GoodsDetailScrollViewDelegate,GoodsDetailChooseViewDelegate,CustomNavigationBarDelegate>
/**  购物车按钮 */
@property(nonatomic,strong) UIButton * cartBtn;
/**  分享按钮 */
@property(nonatomic,strong) UIButton * shareBtn;
/**  allView */
@property(nonatomic,strong) UIView * allView;
/**  scrollView */
@property(nonatomic,strong) GoodsDetailScrollView * goodsDetailSV;
/**  bottom */
@property(nonatomic,strong) GoodsDetailBottomView * bottomView;
/**  下面的第二个页面 */
@property(nonatomic,strong) GoodsDetailSecondView * secondView;
/**  弹出选择商品属性 */
@property (strong, nonatomic) GoodsDetailChooseView *chooseView;
/**  model */
@property(nonatomic,strong) GoodsDetailModel * model;
/**  遮罩视图 */
@property (strong, nonatomic) UIView *maskView;
/**  记录传入选择界面的model */
@property(nonatomic,strong) ChooseModel * chooseModel;
/**  假导航 */
@property(nonatomic,strong) CustomNavigationBar * navigationBar;
@end

@implementation GoodsDetailVC
{
    //用于判断偏移量
    CGFloat minY;
    CGFloat maxY;
}
#pragma mark - SubClass Override

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].keyWindow.backgroundColor = kBlackColor;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].keyWindow.backgroundColor = kWhiteColor;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

//配置初始化的参数（继承重写）
- (void)configParams
{
    self.automaticallyAdjustsScrollViewInsets = NO;
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
    [self.view addSubview:self.allView];
    
    self.goodsDetailSV = [[GoodsDetailScrollView alloc] init];
    self.goodsDetailSV.frame = CGRectMake(0, 0, kScreenW, kScreenH - Adapted(GD_BottomH));
    self.goodsDetailSV.delegate = self;
    self.goodsDetailSV.GD_delegate = self;

    self.goodsDetailSV.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
    }];
    MJRefreshBackStateFooter *footer=  (MJRefreshBackStateFooter *) self.goodsDetailSV.mj_footer;
    [footer setTitle:String(@"上拉查看图文详情") forState:MJRefreshStateIdle];
    [footer setTitle:String(@"释放查看图文详情") forState:MJRefreshStatePulling];
    [footer setTitle:String(@"释放查看图文详情") forState:MJRefreshStateRefreshing];
    [self.allView addSubview:self.goodsDetailSV];
    [self.allView addSubview: self.secondView];
    
    self.bottomView = [[GoodsDetailBottomView alloc] init];
    self.bottomView.delegate = self;
    self.bottomView.IsCollection = self.model.collectstate.boolValue;
    [self.view addSubview:self.bottomView];
    //设置假导航
    [self.view addSubview:self.navigationBar];
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];

    //底部
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
        make.height.offset(GD_BottomH);
    }];
}

#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
    self.goodId = @"1";
    NSDictionary *parameters = @{@"id":self.goodId};
#warning 商品id先写死
    WS(weakSelf)
    [self POST:API_GoodDetail_Find parameters:parameters success:^(NSDictionary *dic) {
        weakSelf.model = [GoodsDetailModel mj_objectWithKeyValues:dic[@"response"]];
        weakSelf.goodsDetailSV.model = weakSelf.model;
    } fail:^(NSError *error) {
        
    } sendView:nil animSuperView:self.view animated:YES];
}
//属性列表请求
- (void)chooseViewDataRequestSuccess:(void(^)(ChooseModel *model))success Fail:(void(^)(NSError *error))fail
{
    NSDictionary *parameters = @{@"id":self.goodId};
    WS(weakSelf)
    [self POST:API_GoodDetail_FindGoodsProperty parameters:parameters success:^(NSDictionary *dic) {
        weakSelf.chooseModel = [ChooseModel mj_objectWithKeyValues:dic[@"response"]];
        success(weakSelf.chooseModel);
    } fail:^(NSError *error) {
        fail(error);
    } sendView:nil animSuperView:self.view animated:YES];
}
#pragma mark - custom method
// 动画1
- (CATransform3D)firstStepTransform
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / -500.0;
    transform = CATransform3DScale(transform, 0.98, 0.98, 1.0);
    transform = CATransform3DRotate(transform, 5.0 * M_PI / 180.0, 1, 0, 0);
    transform = CATransform3DTranslate(transform, 0, 0, -30.0);
    return transform;
}
// 动画2
- (CATransform3D)secondStepTransform
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = [self firstStepTransform].m34;
    transform = CATransform3DTranslate(transform, 0, kScreenH * -0.08, 0);
    transform = CATransform3DScale(transform, 0.8, 0.8, 1.0);
    return transform;
}
- (void)open
{
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.chooseView];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.view.layer.transform = [self firstStepTransform];
        self.maskView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.layer.transform = [self secondStepTransform];
            self.chooseView.transform = CGAffineTransformTranslate(self.chooseView.transform, 0, -Adapted(kChooseViewH));
        }];
    }];
}
//点击背景关闭弹出View
- (void)close
{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.layer.transform = [self firstStepTransform];
        self.chooseView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.view.layer.transform = CATransform3DIdentity;
            self.maskView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self.maskView removeFromSuperview];
            [self.chooseView removeFromSuperview];
        }];
    }];
}
#pragma mark - handle action

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate) {
        CGFloat offset = scrollView.contentOffset.y;
        if (scrollView == self.goodsDetailSV) {
            if (offset < 0) {
                minY = MIN(minY, offset);
            } else {
                maxY = MAX(maxY, offset);
            }
        } else {
            minY = MIN(minY, offset);
        }
        
        // 滚到图文详情
        if (maxY >= self.goodsDetailSV.contentSize.height - kScreenH + GD_DRAG_SHOW_HEIGHT + Adapted(GD_BottomH)) {
            [UIView animateWithDuration:0.4 animations:^{
                self.allView.transform = CGAffineTransformTranslate(self.allView.transform, 0, - (kScreenH - Adapted(GD_BottomH)));
            } completion:^(BOOL finished) {
                maxY = 0.0f;
                [self.goodsDetailSV.mj_footer endRefreshing];
            }];
        }
        
        // 滚到商品详情
        if (minY <= -GD_DRAG_SHOW_HEIGHT ) {
            [UIView animateWithDuration:0.4 animations:^{
                self.allView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                minY = 0.0f;
                for (UITableView *tableView in self.secondView.viewsArray) {
                    [tableView.mj_header endRefreshing];
                }
            }];
        }
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[GD_SecondTableView class]]) return;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > kScrollViewOffset) {
        CGFloat alpha = MIN(1, 1 - ((kScrollViewOffset + TopBarHeight - offsetY) / TopBarHeight));
        [self.navigationBar setShowStatusButtonImageWithAlpha:alpha];
    } else {
        [self.navigationBar setHiddenStatusButtonImage];
    }
}
#pragma mark - CustomNavigationBarDelegate
//返回
- (void)CustomNavigationBar_back
{
    [self.navigationController popViewControllerAnimated:YES];
}
//分享
- (void)CustomNavigationBar_share
{
    
}
//购物车
- (void)CustomNavigationBar_cart
{
    ShoppingCartVC *cartVC = [[ShoppingCartVC alloc] init];
    cartVC.isDetail = YES;
    [self.navigationController pushVC:cartVC animated:YES];
}
#pragma mark - GoodsDetailScrollViewDelegate
- (void)GoodsDetailScrollViewDelegate_clickEvaluativeWithEvaluativeView:(GoodsDetailEvaluativeView *)evaluativeView
{
    CommentVC *commentVC = [[CommentVC alloc] init];
    commentVC.goodId = self.goodId;
    [self.navigationController pushVC:commentVC animated:YES];
}
#pragma mark - GoodsDetailBottomViewDelegate
/**  点击客服 */
- (void)GoodsDetailBottomViewDelegate_clickService
{
    
}
/**  点击店铺 */
- (void)GoodsDetailBottomViewDelegate_clickStore
{
    ShopHomeVC *shopHomeVC = [ShopHomeVC new];
    GoodsDetailStoreModel *shopModel = _model.shop[0];
    shopHomeVC.shopId = shopModel.ID;
    shopHomeVC.shopName = shopModel.s_name;
    shopHomeVC.shopHeadimage = shopModel.s_headimage;
    shopHomeVC.shopScore = shopModel.s_score;
    [self.navigationController pushVC:shopHomeVC animated:YES];
}
/**  点击收藏 */
- (void)GoodsDetailBottomViewDelegate_clickCollectionWithButton:(UIButton *)sender
{
    if (sender.selected) {
        //已收藏
    }else
    {
      sender.selected = YES;
        //收藏
        NSDictionary *parameters = @{@"goodid":@"", @"userid":[Single getUserModel].ID};
        WS(weakSelf)
        [NetWork POST:API_GoodDetail_AddCollectGoods parameters:parameters success:^(NSDictionary *dic) {
            
        } fail:^(NSError *error) {
            
        } sendView:nil animSuperView:self.view animated:YES];
        
    }
}
/**  点击加入购物车 */
- (void)GoodsDetailBottomViewDelegate_clickIntoCart
{
    //打开属性选择
    [self open];
    [self chooseViewDataRequestSuccess:^(ChooseModel *model) {
        [self.chooseView  setChooseModelWithModel:model];
    } Fail:^(NSError *error) {
        
    }];
}
/**  点击立即购买 */
- (void)GoodsDetailBottomViewDelegate_clickBuy
{
    //打开属性选择
    [self open];
}
#pragma mark - GoodsDetailChooseViewDelegate
- (void)GoodsDetailChooseViewDelegate_clickSureActionWithArray:(NSArray *)array
{
    if (array.count < self.chooseModel.property.count) {
        [Tools showToastMsg:String(@"缺少参数")];
        return;
    }
    [self close];
}
#pragma mark - lazy
- (CustomNavigationBar *)navigationBar
{
    if (!_navigationBar) {
        _navigationBar = [[CustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreenW, TopBarHeight)];
        _navigationBar.delegate = self;
    }
    return  _navigationBar;
}
- (UIView *)allView
{
    if (!_allView) {
        _allView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, (kScreenH - Adapted(GD_BottomH)) * 2)];
    }
    return _allView;
}
- (GoodsDetailSecondView *)secondView
{
    if (!_secondView) {
        _secondView = [[GoodsDetailSecondView alloc] initWithFrame:CGRectMake(0, kScreenH + TopBarHeight - Adapted(GD_BottomH) , kScreenW, kScreenH - Adapted(GD_BottomH) - TopBarHeight )];
        _secondView.superVC = self;
    }
    return _secondView;
}
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.400];
        _maskView.alpha = 0.0f;
        // 添加点击背景按钮
        UIButton *btn = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [_maskView addSubview:btn];
    }
    return _maskView;
}
- (GoodsDetailChooseView *)chooseView {
    if (!_chooseView) {
        _chooseView = [[GoodsDetailChooseView alloc] initWithFrame:CGRectMake(0, kScreenH, kScreenW, Adapted(kChooseViewH))];
        _chooseView.delegate = self;
        _chooseView.backgroundColor = kWhiteColor;
    }
    return _chooseView;
}
- (GoodsDetailModel *)model
{
    if (!_model) {
        _model = [[GoodsDetailModel alloc] init];
    }
    return _model;
}
- (ChooseModel *)chooseModel
{
    if (!_chooseModel) {

        _chooseModel = [[ChooseModel alloc] init];
    }
    return _chooseModel;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
