//
//  ShopHomeVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/10.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ShopHomeVC.h"      //店铺首页
#import "ShopHomeTopView.h" //店铺首页 顶部的视图

#import "ShopHome_homeVC.h"     //店铺首页_首页
#import "ShopHome_allGoodsVC.h" //店铺首页_全部商品
#import "ShopHome_hotGoodsVC.h" //店铺首页_热销商品
#import "ShopHome_newGoodsVC.h" //店铺首页_新商品

#import "HotClassView.h"        //热门分类

#define kHeight_BottomBtnsView  45

@interface ShopHomeVC ()<ButtonsViewDelegate>

@property (nonatomic, strong) ButtonsView *topBtnsView;
@property (nonatomic, strong) ButtonsView *bottomBtnsView;

@end

@implementation ShopHomeVC

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
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = self.shopName;
    QButton *rightBtn = [[QButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40) style:QButtonStyleNormal layoutStyle:QButtonLayoutStyleRight font:Font(17) title:String(@"联系客服") image:nil space:0 margin:0 autoSize:YES];
    rightBtn.transparentWhenhighlight = YES;
    
    [self addRightBtn:rightBtn action:@selector(handleContactService)];
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    
    [self.view addSubview:self.scrollView];
    
    //顶部店铺栏
    ShopHomeTopView *shopHomeTopView = [[ShopHomeTopView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, Adapted(66))];
    [shopHomeTopView.shopIconImgView sd_setImageWithURL:[NSURL URLWithString:_shopHeadimage] placeholderImage:Image_PlaceHolder_ShopIcon];
    shopHomeTopView.shopIconImgView.image = ImageStr(@"goods2");
    shopHomeTopView.shopNameLabel.text = _shopName;
    CGFloat shopScore = [_shopScore floatValue];
    shopHomeTopView.shopScoreLabel.text = [NSString stringWithFormat:@"综合：%.1f", shopScore];
    [self.view addSubview:shopHomeTopView];
    
    //添加分割条
    UIView *splitView1 = [[UIView alloc] initWithFrame:CGRectMake(0, shopHomeTopView.bottom, self.view.width, 5)];
    splitView1.backgroundColor = QFColor_splitLine_Color;
    [self.view addSubview:splitView1];
    
    //上面的店铺菜单
    NSArray *normalImages = @[Image(@"dianpushouye"), Image(@"quanbushangpin"), Image(@"rexiao"), Image(@"shangxin")];
    NSArray *selectedImages = @[Image(@"dianpushouye copy"), Image(@"quanbushangpin copy"), Image(@"rexiao copy"), Image(@"shangxin copy")];
    self.topBtnsView = [[ButtonsView alloc] initWithFrame:CGRectMake(0, splitView1.bottom, self.view.width, 60) btnTitles:@[String(@"店铺首页"), String(@"全部商品"), String(@"热销"), String(@"上新")] titleColor:QF_GrayColor selectedColor:QF_RedColor normalImages:normalImages selectedImages:selectedImages style:QButtonStyleImageTop space:5.0];
    _topBtnsView.delegate = self;
    _topBtnsView.backgroundColor = Color_CustomEffectViewbg;
    _topBtnsView.effectView.alpha = 1.0;
    _topBtnsView.splitWidth = 1.0;
    [self.view addSubview:_topBtnsView];
    
    //底部的菜单
    self.bottomBtnsView = [[ButtonsView alloc] initWithFrame:CGRectMake(0, self.view.height - kHeight_BottomBtnsView, self.view.width, kHeight_BottomBtnsView) btnTitles:@[String(@"店铺详情"), String(@"热门分类"), String(@"联系卖家")] titleColor:QF_BlackColor];
    _bottomBtnsView.delegate = self;
    _bottomBtnsView.backgroundColor = Color_CustomEffectViewbg;
    _bottomBtnsView.effectView.alpha = 1.0;
    _bottomBtnsView.splitWidth = 1.0;
    [_bottomBtnsView addTopLineWithHeight:0.8 style:LineLayoutStyleOutside];
    [self.view addSubview:_bottomBtnsView];
    
    //添加分割条
    UIView *splitView2 = [[UIView alloc] initWithFrame:CGRectMake(0, _topBtnsView.bottom, self.view.width, 5)];
    splitView2.backgroundColor = QFColor_splitLine_Color;
    [self.view addSubview:splitView2];
    
//    self.scrollView.frame = CGRectMake(0, splitView2.bottom, self.view.width, self.view.height - splitView2.bottom- _bottomBtnsView.height);
    _scrollView.contentSize = CGSizeMake(_scrollView.width * 4, _scrollView.height);
    self.scrollView.bounces = NO;
    
    //添加子控制器
    //店铺首页
    ShopHome_homeVC *homeVC = [ShopHome_homeVC new];
    [self addChild:homeVC container:_scrollView inRect:CGRectMake(0, 0, _scrollView.width, _scrollView.height)];
    [self.childVcArray addObject:homeVC];
    
    //全部商品
    ShopHome_allGoodsVC *allGoodsVC = [ShopHome_allGoodsVC new];
    [self addChild:allGoodsVC container:_scrollView inRect:CGRectMake(_scrollView.width, 0, _scrollView.width, _scrollView.height)];
    [self.childVcArray addObject:allGoodsVC];
    
    //热销商品
    ShopHome_hotGoodsVC *hotGoodsVC = [ShopHome_hotGoodsVC new];
    [self addChild:hotGoodsVC container:_scrollView inRect:CGRectMake(_scrollView.width * 2.0, 0, _scrollView.width, _scrollView.height)];
    [self.childVcArray addObject:hotGoodsVC];
    
    //上新商品
    ShopHome_newGoodsVC *newGoodsVC = [ShopHome_newGoodsVC new];
    [self addChild:newGoodsVC container:_scrollView inRect:CGRectMake(_scrollView.width * 3.0, 0, _scrollView.width, _scrollView.height)];
    [self.childVcArray addObject:newGoodsVC];
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    
}

//请求初始数据
- (void)requestInitialData
{
    [self requestShopData]; //请求店铺数据
}

#pragma mark - request data
//请求店铺数据
- (void)requestShopData
{
    NSDictionary *parameters;
    NSString *userId = [Single getUserModel].ID;
    if (userId && userId.length) {
        parameters = @{@"shopid":_shopId, @"userid":userId};
    } else {
        parameters = @{@"shopid":_shopId};
    }
    
    WS(weakSelf)
    [self POST_:API_ShopHome parameters:parameters success:^(NSDictionary *dic) {
        
        
        
    } fail:^(NSError *error) {
        
    }];
}

//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
    NSDictionary *parameters = @{@"":@"", @"":@""};
    WS(weakSelf)
    [self POST:self.listUrl parameters:parameters success:^(NSDictionary *dic) {
        
    } fail:^(NSError *error) {
        
    } sendView:nil animSuperView:self.view animated:animated];
}

#pragma mark - custom method


#pragma mark - handle action
//联系客服 -- 跳转聊天界面
- (void)handleContactService
{
    
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView)
    {
        NSInteger index = _scrollView.contentOffset.x / _scrollView.width + 0.5;
        [_topBtnsView selectBtn:[_topBtnsView viewWithTag:101 + index]];
        
        if (_topBtnsView.isRepeatTouch)
        {
            return;
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView == _scrollView)
    {
        NSInteger index = _scrollView.contentOffset.x / _scrollView.width + 0.5;
        [_topBtnsView selectBtn:[_topBtnsView viewWithTag:101 + index]];
        
    }
}

#pragma mark - <ButtonsViewDelegate>
- (void)btsView:(ButtonsView *)btnView IsClicked:(UIButton *)btn atIndex:(NSInteger)index isRepeatTouch:(BOOL)isRepeatTouch
{
    if (btnView == _topBtnsView)
    {
        [_scrollView setContentOffset:CGPointMake(_scrollView.width * index, 0) animated:YES];
        
        switch (index)
        {
            case 0:
            {
                
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                
            }
                break;
            case 3:
            {
                
            }
                break;
            default:
                break;
        }
    }
    else
    {
        switch (index)
        {
            case 0:
            {
                
            }
                break;
            case 1:
            {   //热门分类
                HotClassView *hotClassView = [[HotClassView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64) array:@[@"哑铃", @"瑜伽垫", @"跑步机"] block:^(NSString *string) {
                    NSLog(@"%@", string);
                }];
                
                [self.view addSubview:hotClassView];
                [hotClassView show];
                
            }
                break;
            case 2:
            {
                
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
