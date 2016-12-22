//
//  MyOrderDetailVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/11.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderDetailVC.h"
#import "Pay_CheckDeskVC.h"
#import "MyOrderDetailScrollView.h"
#import "MyOrderDetailBottomView.h"
#import "MyOrderDetailModel.h"
/******************   VC  *********************/
#import "SendCommentVC.h"//发表评价

@interface MyOrderDetailVC ()<MyOrderDetailBottomViewDelegate>
/**  scrollView */
@property(nonatomic,strong) MyOrderDetailScrollView  * detailScrollV;
/**  bottomView */
@property(nonatomic,strong) MyOrderDetailBottomView * bottomView;
/**  <#注释#> */
@property(nonatomic,strong) MyOrderDetailModel * model;
@end

@implementation MyOrderDetailVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
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
    [self.view addSubview:self.detailScrollV];
    if (self.style != MyOrderVCWaitSend) {
        [self.view addSubview:self.bottomView];
    }
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    
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
#pragma mark - MyOrderDetailBottomViewDelegate
- (void)MyOrderDetailBottomViewDelegate_clickButtonWithTitleStyle:(MyOrderDetailBottomButtonTitle)titleStyle
{
    switch (titleStyle) {
        case MyOrderDetailBottomButtonTitleCancel:
            //取消订单
            break;
        case MyOrderDetailBottomButtonTitleDelete:
            //删除订单
            break;
        case MyOrderDetailBottomButtonTitleLogistic:
            //查看物流
            break;
        case MyOrderDetailBottomButtonTitletRefund:
            //退款售后
            break;
        case MyOrderDetailBottomButtonTitlePay:
            //付款
        {
            Pay_CheckDeskVC *VC = [[Pay_CheckDeskVC alloc] init];
            [self.navigationController pushVC:VC animated:YES];
        }
            break;
        case MyOrderDetailBottomButtonTitleAgainBuy:
            //再次购买
            break;
        case MyOrderDetailBottomButtonTitleSureGet:
            //确认收货
            break;
        case MyOrderDetailBottomButtonTitleComment:
            //评价
        {
            SendCommentVC *commentVC = [[SendCommentVC alloc] init];
            [self.navigationController pushVC:commentVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - lazy
- (MyOrderDetailScrollView *)detailScrollV
{
    if (!_detailScrollV) {

        if (self.style == MyOrderVCWaitSend) {
            _detailScrollV = [[MyOrderDetailScrollView alloc] initWithFrame:CGRectMake(0, TopBarHeight, kScreenW, kScreenH - TopBarHeight)];
        }else
        {
            _detailScrollV = [[MyOrderDetailScrollView alloc] initWithFrame:CGRectMake(0, TopBarHeight, kScreenW, kScreenH - TopBarHeight - Adapted(kBottomViewH) )];
        }
        _detailScrollV.model = self.model;
    }
    return _detailScrollV;
}
- (MyOrderDetailBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[MyOrderDetailBottomView alloc] initWithFrame:CGRectMake(0, kScreenH - Adapted(kBottomViewH), kScreenW, Adapted(kBottomViewH)) Style:self.style];
        _bottomView.delegate = self;
    }
    return _bottomView;
}
- (MyOrderDetailModel *)model
{
    if (!_model) {
        NSDictionary *dic = @{@"status":@"交易成功",
                              @"number":@"1234567890123",
                              @"name":@"米洛洛",
                              @"phone":@"18809806547",
                              @"address":@"北京市昌平区天通苑明天生活馆北京市昌平区天通苑明天生活馆",
                              @"listGoods":@[@{@"shopName":@"柏杨九天",
                                      @"shopIcon":@"jingxuan_icon",
                                      @"goodsStatus":@"等待买家付款",
                                      @"buttonArray":@[],
                                      @"goods":@[@{@"icon":@"jingxuan_cover",
                                                   @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                                   @"subTitle1":@"颜色分类：白色",
                                                   @"subTitle2":@"尺寸：S码",
                                                   @"price":@"218.00",
                                                   @"count":@"1"},
                                                 @{@"icon":@"jingxuan_cover",
                                                   @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                                   @"subTitle1":@"颜色分类：白色",
                                                   @"subTitle2":@"尺寸：S码",
                                                   @"price":@"218.00",
                                                   @"count":@"1"}]},
                                             @{@"shopName":@"柏杨九天",
                                               @"shopIcon":@"jingxuan_icon",
                                               @"goodsStatus":@"等待买家付款",
                                               @"buttonArray":@[],
                                               @"goods":@[@{@"icon":@"jingxuan_cover",
                                                            @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                                            @"subTitle1":@"颜色分类：白色",
                                                            @"subTitle2":@"尺寸：S码",
                                                            @"price":@"218.00",
                                                            @"count":@"1"}]}],
                              @"invoiceType":@"纸质发票",
                              @"invoiceRise":@"北京内圈科技有限公司北京内圈科技有限公司北京内圈科技有限公司北京内圈科技有限公司北京内圈科技有限公司北京内圈科技有限公司北京内圈科技有限公司",
                              @"invoiceContent":@"明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细明细",
                              @"freight":@"0.00",
                              @"time":@"2016-11-03 09:10:48"};
        _model = [MyOrderDetailModel mj_objectWithKeyValues:dic];
    }
    return _model;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
