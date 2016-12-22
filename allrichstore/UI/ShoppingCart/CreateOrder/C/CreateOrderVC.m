//
//  CreateOrderVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "CreateOrderVC.h"
#import "CreateOrderScrollView.h"
#import "CreateOrderBottomView.h"
#import "CreateOrderModel.h"
#import "InvoiceVC.h"           //选择发票信息vc
#import "AddressListVC.h"       //我的收货地址列表vc
#import "AddressListModel.h"    //我的收货地址model

#import "MyOrderDetailVC.h" //生成订单详情
#import "MyCouponVC.h"//优惠券
@interface CreateOrderVC ()<CreateOrderScrollViewdelegate,CreateOrderBottomViewDelegate>
/**  scrollView */
@property(nonatomic,strong) CreateOrderScrollView * mainScrollView;
/**  bottomView */
@property(nonatomic,strong) CreateOrderBottomView * bottomView;
/**  model */
@property(nonatomic,strong) CreateOrderModel * model;

//发票信息model
@property (nonatomic, strong) InvoiceModel *invoiceModel;
//选中的地址model
@property (nonatomic, strong) AddressListModel *addressModel;

@end

@implementation CreateOrderVC

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
    self.mainScrollView = [[CreateOrderScrollView alloc] initWithFrame:CGRectMake(0, TopBarHeight, kScreenW, kScreenH - TopBarHeight - kBottomH)];
    self.mainScrollView.model = self.model;
    self.mainScrollView.CO_delegate = self;
    [self.view addSubview:self.mainScrollView];
    
    self.bottomView = [[CreateOrderBottomView alloc] init];
    self.bottomView.delegate  = self;
    [self.view addSubview:self.bottomView];
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(kBottomH);
    }];
}


#pragma mark - lazy
//发票信息model
- (InvoiceModel *)invoiceModel
{
    if (!_invoiceModel)
    {
        self.invoiceModel = [InvoiceModel new];
        _invoiceModel.containArray = [NSMutableArray array];
        _invoiceModel.identifierCode = @"";
        _invoiceModel.registerAddress = @"";
        _invoiceModel.registerTel = @"";
        _invoiceModel.accountBank = @"";
        _invoiceModel.accountNum = @"";
    }
    return _invoiceModel;
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

#pragma mark - CreateOrderScrollViewdelegate
//点击头部去选择收货地址
- (void)CreateOrderScrollViewdelegate_clickHeaderView
{
    //跳转到 ——>我的收货地址列表VC
    AddressListVC *addressListVC = [[AddressListVC alloc] initWithBlock:^(AddressListModel *object) {
        
        //选中的收货地址Model
        self.addressModel = object;
        
    }];
    [self.navigationController pushVC:addressListVC animated:YES];
}

//点击服务选项
- (void)CreateOrderScrollViewdelegate_clickServiceCellWithIndexPath:(NSIndexPath*)indexPath
{
    switch (indexPath.row) {
        case 0:
            //配送方式
            break;
        case 1:
        {   //跳转到 ——>选择发票信息VC
            //制作发票信息的副本
            InvoiceModel *model = [self.invoiceModel copy];
            InvoiceVC *invoiceVC = [[InvoiceVC alloc] initWithModel:model invoiceBlock:^(InvoiceModel *invoiceModel) {
                
                self.invoiceModel = invoiceModel;
                
            }];
            [self.navigationController pushVC:invoiceVC animated:YES];
        }
            break;
        case 2:
        {
            //优惠券
            MyCouponVC *VC = [[MyCouponVC alloc] init];
            [self.navigationController pushVC:VC animated:YES];
        }
            
            break;
        case 3:
        {
            //现金券
//            MyCashCouponVC *VC = [[MyCashCouponVC alloc] init];
//            [self.navigationController pushVC:VC animated:YES];
        }
            
            break;
        default:
            break;
    }
}
/**  点击开关 */
- (void)CreateOrderScrollViewdelegate_clickSwitchWithIsSelected:(BOOL)isSelected
{
    
}
#pragma mark - CreateOrderBottomView
//提交订单
- (void)CreateOrderBottomViewDelegate_clickSubmitBtn
{
    MyOrderDetailVC *detailVC = [[MyOrderDetailVC alloc] init];
    [self.navigationController pushVC:detailVC animated:YES];
}
#pragma mark - dealloc
- (void)dealloc
{
    
}
- (CreateOrderModel *)model
{
    if (!_model) {
        NSDictionary *dic = @{@"name":@"米洛洛",
                              @"phone":@"18809806547",
                              @"address":@"北京市昌平区天通苑明天生活馆北京市昌平区天通苑明天生活馆北京市昌平区天通苑明天生活馆",
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
                              @"servicesArray":@[@{@"title":String(@"配送方式"),
                                                   @"serviceArray":@[@"快递免邮"]},
                                                 @{@"title":String(@"发票信息"),
                                                   @"serviceArray":@[@"明细（普通）北京内圈科技有限公司"]},
                                                 @{@"title":String(@"优惠券"),
                                                   @"serviceArray":@[]}],
                              @"buyerMessage":@"",
                              @"integral":@"50",
                              @"prices":@{@"goodPrice":@"299.00",
                                          @"freight":@"0.00",
                                          @"preference":@"20.00"},};
        _model = [CreateOrderModel mj_objectWithKeyValues:dic];
    }
    return _model;
}
@end
