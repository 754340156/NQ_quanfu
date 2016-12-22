//
//  MineVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/10/27.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MineVC.h"
#import "Mine_SetupVC.h" // 去设置
#import "Mine_IconCell.h"
#import "Mine_OrderCell.h"
#import "Mine_MainCell.h"
#import "Mine_SubfieldCell.h"
/****************     section0     *****************/
#import "LoginVC.h" // 登录/注册
#import "IconOrNickNameVC.h"//登录状态的头像
#import "MyOrder.h" // 我的订单
#import "MyOrderWaitVC.h" // 待付款等
#import "MyOrderRefundHomeVC.h" // 退款
/****************     section1     *****************/
#import "PersonDataVC.h"  // 个人资料
#import "MyCollectionVC.h"//我的收藏
#import "MyCouponVC.h"    // 我的优惠券
#import "MyIntegralVC.h"  //我的积分
#import "MyCashCouponVC.h"//我的现金券
#import "AddressListVC.h"  //地址管理
/****************     section2     *****************/
#import "AuthenticationVC.h"//实名认证
#import "SecurityVC.h"//账号安全
/****************     section3     *****************/
#import "ServiceVC.h"//联系客服
#import "HelpVC.h"//帮助说明
#import "FeedbackVC.h"//意见反馈


#import "HobbyModel.h"      //爱好model
#import "IncomeModel.h"     //月收入model
#import "EducatModel.h"     //教育程度model
#import "ProfessionModel.h" //职业model

@interface MineVC ()<Mine_SubfieldCellDelegate>
/**   */
@property(nonatomic,strong) NSArray * dataArray;

@end

@implementation MineVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    [self updateListData];  //更新后台列表数据
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    //导航栏配置
    [self addRightImage:Image(@"xiaoxi") action:@selector(MessageAction)];
    [self addRightImage:Image(@"shezhi") action:@selector(setupAction)];
    
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    [self.tableView registerClass:[Mine_IconCell class] forCellReuseIdentifier:[Mine_IconCell className]];
    [self.tableView registerClass:[Mine_OrderCell class] forCellReuseIdentifier:[Mine_OrderCell className]];
    [self.tableView registerClass:[Mine_SubfieldCell class] forCellReuseIdentifier:[Mine_SubfieldCell className]];
    [self.tableView registerClass:[Mine_MainCell class] forCellReuseIdentifier:[Mine_MainCell className]];
    
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
    
}

//更新后台列表数据
- (void)updateListData
{
    //爱好（总列表）
    NSDictionary *parameters1 = @{@"type":@"1"};
    [NetWork POST_:API_MineDataGetAllList parameters:parameters1 success:^(NSDictionary *dic) {
        
        NSArray *array = dic[kResponse];
        NSArray *modelArray = [HobbyModel mj_objectArrayWithKeyValuesArray:array];
        [Tools writeToSandBox:modelArray key:Key_PersonDataHobbyArray];
        
    } fail:^(NSError *error) {
        
    }];
    
    //更新月收入（总列表）
    NSDictionary *parameters2 = @{@"type":@"2"};
    [NetWork POST_:API_MineDataGetAllList parameters:parameters2 success:^(NSDictionary *dic) {
        
        NSArray *array = dic[kResponse];
        NSArray *modelArray = [IncomeModel mj_objectArrayWithKeyValuesArray:array];
        [Tools writeToSandBox:modelArray key:Key_PersonDataIncomeArray];
        
    } fail:^(NSError *error) {
        
    }];
    
    //更新教育程度（总列表）
    NSDictionary *parameters3 = @{@"type":@"3"};
    [NetWork POST_:API_MineDataGetAllList parameters:parameters3 success:^(NSDictionary *dic) {
        
        NSArray *array = dic[kResponse];
        NSArray *modelArray = [EducatModel mj_objectArrayWithKeyValuesArray:array];
        [Tools writeToSandBox:modelArray key:Key_PersonDataEducatArray];
        
    } fail:^(NSError *error) {
        
    }];
    
    //更新职业（总列表）
    NSDictionary *parameters4 = @{@"type":@"4"};
    [NetWork POST_:API_MineDataGetAllList parameters:parameters4 success:^(NSDictionary *dic) {
        
        NSArray *array = dic[kResponse];
        NSArray *modelArray = [ProfessionModel mj_objectArrayWithKeyValuesArray:array];
        [Tools writeToSandBox:modelArray key:Key_PersonDataProfessionArray];
        
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark - custom method


#pragma mark - handle action
//去设置
- (void)setupAction
{
    Mine_SetupVC * setupVC = [[Mine_SetupVC alloc] init];
    [self.navigationController pushVC:setupVC animated:YES];
}
//去聊天界面
- (void)MessageAction
{
    
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count + 1;
  

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else
    {
        return [self.dataArray[section - 1] count] ;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0)
        {
            Mine_IconCell *cell = [tableView dequeueReusableCellWithIdentifier:[Mine_IconCell className]];
            cell.model = [Single getUserModel];
            return cell;
        }else if (indexPath.row == 1)
        {
            Mine_OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:[Mine_OrderCell className]];
            cell.titleName = String(@"我的订单") ;
            cell.attestationName = String(@"查看我的订单");
            return cell;
        }else if (indexPath.row == 2)
        {
            Mine_SubfieldCell *cell = [tableView dequeueReusableCellWithIdentifier:[Mine_SubfieldCell className]];
            cell.delegate = self;
            return cell;
        }
    }
    Mine_MainCell *cell =[tableView dequeueReusableCellWithIdentifier:[Mine_MainCell className]];
    NSDictionary *dic = self.dataArray[indexPath.section - 1][indexPath.row];
    cell.icon = dic[@"icon"];
    cell.title = dic[@"title"];
    cell.attestation = dic[@"isAttestation"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                return 60;
                break;
            case 1:
                return kBottomH;
                break;
            case 2:
                return 50;
                break;
        }
    }
    return kBottomH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kFooterViewH;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kFooterViewH)];
    backView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    return backView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                if (Single.isLogin) {
                    //
                    IconOrNickNameVC *VC =[[IconOrNickNameVC alloc] init];
                    [self.navigationController pushVC:VC animated:YES];
                }else{
                    //去登录
                    LoginVC *loginVC = [LoginVC new];
                    loginVC.loginSuccessBlock = ^
                    {
                        [self.tableView reloadData];
                    };
                    BaseNC *nc = [[BaseNC alloc] initWithBackBtnStyleRootViewController:loginVC];
                    [self presentVC:nc animated:YES completion:^{
                        
                    }];
                }

            }
                break;
            case 1:
            {
                if (![Single isLogin]) {
                    //去登录
                    LoginVC *loginVC = [LoginVC new];
                    loginVC.loginSuccessBlock = ^
                    {
                        [self.tableView reloadData];
                    };
                    BaseNC *nc = [[BaseNC alloc] initWithBackBtnStyleRootViewController:loginVC];
                    [self presentVC:nc animated:YES completion:^{
                        
                    }];
                    return;
                }
                //我的订单
                MyOrder *orderVC = [[MyOrder alloc] init];
                orderVC.style = MyOrderVCFinish;
                [self.navigationController pushVC:orderVC animated:YES];
            }
                break;
            case 2:
            {
                
            }
                break;
        }
    }else if(indexPath.section == 1)
    {
        if (![Single isLogin]) {
            //去登录
            LoginVC *loginVC = [LoginVC new];
            loginVC.loginSuccessBlock = ^
            {
                [self.tableView reloadData];
            };
            BaseNC *nc = [[BaseNC alloc] initWithBackBtnStyleRootViewController:loginVC];
            [self presentVC:nc animated:YES completion:^{
                
            }];
            return;
        }
        switch (indexPath.row) {
            case 0:
            {
                //个人资料
                PersonDataVC *personDataVC = [[PersonDataVC alloc] init];
                [self.navigationController pushVC:personDataVC animated:YES];
            }
                break;
            case 1:
            {
                //我的收藏
                MyCollectionVC *collectionVC = [[MyCollectionVC alloc] init];
                [self.navigationController pushVC:collectionVC animated:YES];
            }
                break;
            case 2:
            {
                //我的优惠券
                MyCouponVC *couponVC = [[MyCouponVC alloc] init];
                [self.navigationController pushVC:couponVC animated:YES];
            }
                break;
            case 3:
            {
                //我的积分
                MyIntegralVC *integralVC = [[MyIntegralVC alloc] init];
                [self.navigationController pushVC:integralVC animated:YES];
            }
                break;
            case 4:
            {
                //我的现金券
                MyCashCouponVC *cashCouponVC = [[MyCashCouponVC alloc] init];
                [self.navigationController pushVC:cashCouponVC animated:YES];
            }
                break;
            case 5:
            {
                //地址管理
                AddressListVC *addressVC = [AddressListVC new];
                [self.navigationController pushVC:addressVC animated:YES];
            }
                break;
        }
        
    }else if (indexPath.section == 2)
    {
        if (Single.isLogin) {
            switch (indexPath.row) {
                case 0:
                {
                    //实名认证
                    AuthenticationVC *authenticationVC = [[AuthenticationVC alloc] init];
                    [self.navigationController pushVC:authenticationVC animated:YES];
                }
                    break;
                case 1:
                {
                    //账号认证
                    SecurityVC *securityVC = [[SecurityVC alloc] init];
                    [self.navigationController pushVC:securityVC animated:YES];
                }
                    break;
            }
        }else
        {
            switch (indexPath.row) {
                case 0:
                {
                    //联系客服
                    ServiceVC *serviceVC = [[ServiceVC alloc] init];
                    [self.navigationController pushVC:serviceVC animated:YES];
                }
                    break;
                case 1:
                {
                    //帮助说明
                    HelpVC *helpVC = [[HelpVC alloc] init];
                    [self.navigationController pushVC:helpVC animated:YES];
                }
                    break;
                case 2:
                {
                    //意见反馈
                    FeedbackVC *feedbackVC = [[FeedbackVC alloc] init];
                    [self.navigationController pushVC:feedbackVC animated:YES];
                }
                    break;
            }
        }
    }else if (indexPath.section == 3)
    {
        switch (indexPath.row) {
            case 0:
            {
                //联系客服
                ServiceVC *serviceVC = [[ServiceVC alloc] init];
                [self.navigationController pushVC:serviceVC animated:YES];
            }
                break;
            case 1:
            {
                //帮助说明
                HelpVC *helpVC = [[HelpVC alloc] init];
                [self.navigationController pushVC:helpVC animated:YES];
            }
                break;
            case 2:
            {
                //意见反馈
                FeedbackVC *feedbackVC = [[FeedbackVC alloc] init];
                [self.navigationController pushVC:feedbackVC animated:YES];
            }
                break;
        }
    }
}
#pragma mark - UIScrollViewDelegate
#pragma mark - Mine_SubfieldCellDelegate
- (void)Mine_SubfieldCellDelegate_clickButtonWithIndex:(NSInteger)index Button:(UIButton *)sender
{
    if (![Single isLogin]) {
        //去登录
        LoginVC *loginVC = [LoginVC new];
        loginVC.loginSuccessBlock = ^
        {
            [self.tableView reloadData];
        };
        BaseNC *nc = [[BaseNC alloc] initWithBackBtnStyleRootViewController:loginVC];
        [self presentVC:nc animated:YES completion:^{
            
        }];
        return;
    }
    if (index  == 4) {
        MyOrderRefundHomeVC *refundVC = [[MyOrderRefundHomeVC alloc] init];
        [self.navigationController pushVC:refundVC animated:YES];
    }else
    {
        MyOrderWaitVC *waitVC = [[MyOrderWaitVC alloc] init];
        MyOrderVCStyle style ;
        if ([sender.titleLabel.text isEqualToString:String(@"待付款")]) {
            style = MyOrderVCWaitPay;
        }else if ([sender.titleLabel.text isEqualToString:String(@"待发货")])
        {
            style = MyOrderVCWaitSend;
        }else if ([sender.titleLabel.text isEqualToString:String(@"待收货")])
        {
            style = MyOrderVCWaitAccept;
        }else if ([sender.titleLabel.text isEqualToString:String(@"待评价")])
        {
            style = MyOrderVCWaitComment;
        }
         waitVC.style = style;
        [self.navigationController pushVC:waitVC animated:YES];
    }
}
#pragma mark - dealloc
- (void)dealloc
{
    
}
#pragma mark - lazy
- (NSArray *)dataArray
{
        if (Single.isLogin) {
            _dataArray = @[@[@{@"title":String(@"个人资料"),@"icon":@"gerenziliao"},
                             @{@"title":String(@"我的收藏"),@"icon":@"wodeshoucang"},
                             @{@"title":String(@"我的优惠券"),@"icon":@"wodeyouhuiquan"},
                             @{@"title":String(@"我的积分"),@"icon":@"wodejifen",@"isAttestation":String(@"0积分")},
#warning 0积分加国际化没处理
                             @{@"title":String(@"我的现金券"),@"icon":@"wodexianjinquan"},
                             @{@"title":String(@"地址管理"),@"icon":@"dizhiguanli"}],
                           @[@{@"title":String(@"实名认证"),@"icon":@"shimingrenzheng",@"isAttestation":String(@"立即认证")},
                             @{@"title":String(@"账号安全"),@"icon":@"zhanghaoanquan",@"isAttestation":String(@"立即认证")}],
                           @[@{@"title":String(@"联系客服"),@"icon":@"lianxikefu",@"isAttestation":String(@"立即认证")},
                             @{@"title":String(@"帮助说明"),@"icon":@"bangzhushuoming"},
                             @{@"title":String(@"意见反馈"),@"icon":@"yijianfankui"}]];
        }else
        {
            _dataArray =@[@[@{@"title":String(@"个人资料"),@"icon":@"gerenziliao"},
                            @{@"title":String(@"我的收藏"),@"icon":@"wodeshoucang"},
                            @{@"title":String(@"我的优惠券"),@"icon":@"wodeyouhuiquan"},
                            @{@"title":String(@"我的积分"),@"icon":@"wodejifen",@"isAttestation":String(@"0积分")},
                            @{@"title":String(@"我的现金券"),@"icon":@"wodexianjinquan"},
                            @{@"title":String(@"地址管理"),@"icon":@"dizhiguanli"}],
                          @[@{@"title":String(@"联系客服"),@"icon":@"lianxikefu",@"isAttestation":String(@"立即认证")},
                            @{@"title":String(@"帮助说明"),@"icon":@"bangzhushuoming"},
                            @{@"title":String(@"意见反馈"),@"icon":@"yijianfankui"}]];
        }
        
    return _dataArray;
}
                                              

@end
