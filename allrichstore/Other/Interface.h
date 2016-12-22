//
//  Interface.h
//  FullRich
//
//  Created by 任强宾 on 16/10/26.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#ifndef Interface_h
#define Interface_h


#pragma mark - 服务器地址
/********************服务器地址********************/
//正式
//#define BaseUrl @"http://101.201.121.106:8080/allRich-api"
//本地1
//#define BaseUrl @"http://192.168.1.199:8080/allRich-api"
//本地2
//#define BaseUrl @"http://192.168.1.254:8080/allRich-api"
//外网1
//#define BaseUrl @"http://101.201.121.106:8080/allRich-api"
//外网2
#define BaseUrl @"http://101.201.121.106:8080/allRich-api"


//地址拼接
#define UrlAPI(url) [NSString stringWithFormat:@"%@%@", BaseUrl, url]


//苹果商店审核开关
#define AuditingSwitch  UrlAPI(@"/api/other/switch")


#pragma mark - 登录/注册
/********************登录/注册********************/
//发送验证码
#define API_SendCode    UrlAPI(@"/server/login/forgetPassword.do")
//验证验证码
#define API_ClientCode  UrlAPI(@"/server/message/testMessageCode.do")
//设置密码
#define API_SetPW    UrlAPI(@"/server/message/savePassword.do")
//注册
#define API_Register    UrlAPI(@"/ulogin/register.do")

//第三方登录——登录成功 自动关联
#define API_Login  UrlAPI(@"/server/login/accountRelating.do")

//短信验证码登录
#define API_MsgLogin    UrlAPI(@"/api/user/login")

//忘记密码（验证验证码）
#define API_ClientCode_FindPW    UrlAPI(@"/server/login/testMessageCode.do")

//忘记密码（重置密码）
#define API_ResetPW_FindPW    UrlAPI(@"/server/login/registePassword.do")

//第三方绑定手机号
#define API_ThirdBindPhone   UrlAPI(@"/api/user/otherAccountRegister")

#pragma mark - 首页
/********************首页********************/
//搜索接口
#define API_SearchGoods   UrlAPI(@"/server/Search/findSearchOne.do")

//banner列表(根据id参数区分不同区域的banner列表)
#define API_BannerList 	UrlAPI(@"/server/Banner/findBannerOne.do")

//商品活动列表
#define API_FindActivity    UrlAPI(@"/server/Activity/findActivity.do")

//自营速达-商品列表
#define API_SelfBusinessMenuList  UrlAPI(@"/server/SelfThree/findSelfFastName.do")

//自营速达商品列表（根据自营分类id查询）
#define API_SelfBusinessGoosList  UrlAPI(@"/server/SelfThree/findSelfFastOne.do")

#pragma mark - 分类
/********************分类********************/
//分类 一级分类
#define API_GoodsClass_FirstLevel  UrlAPI(@"/server/Category/findCategoryFirst.do")
//分类 二三级分类
#define API_GoodsClass_SecondAndThirdLevel UrlAPI(@"/server/Category/findCategorySecond.do")

//商品列表
#define API_GoodsList   UrlAPI(@"/server/Goods/findGoodsRank.do")

#pragma mark - 店铺
/********************店铺********************/
//店铺首页
#define API_ShopHome UrlAPI(@"/server/Shop/findShopHomePage.do")
//店铺详情
#define API_ShopDetail  UrlAPI(@"/server/Shop/findShopPage.do")
//店铺商品页接口
#define API_ShopGoods   UrlAPI(@"/server/Shop/findShopGoods.do")
//店铺的分类名称接口
#define API_ShopClass   UrlAPI(@"/server/Shop/findShopCategoryName.do")
//店铺的分类商品页接口
#define API_ShopCategoryGoods   UrlAPI(@"/server/Shop/findShopCategoryGoods.do")
//店铺的商品活动接口
#define API_ShopActivity    UrlAPI(@"/server/Shop/findShopActivity.do")


#pragma mark - 精选
/********************精选********************/

#pragma mark - 商品详情
/********************商品详情********************/
//获取商品详情
#define API_GoodDetail_Find UrlAPI(@"/server/Goods/findGoodsOne.do")	

//商品评论好中差等分类个数
#define API_GoodDetail_CommentType UrlAPI(@"/server/Goods/findGoodsCommentCategory.do")

//商品评论
#define API_GoodDetail_Comment UrlAPI(@"/server/Goods/findGoodsComment.do")

//商品评论回复个数接口
#define API_GoodDetail_CommentReply UrlAPI(@"/server/Goods/findGoodsCommentReply.do")

//收藏商品接口
#define API_GoodDetail_AddCollectGoods UrlAPI(@"/server/Collect/addCollectGoods.do")

//收藏商铺接口
#define API_GoodDetail_AddCollectShop UrlAPI(@"/server/Collect/addCollectShop.do")

//商品属性规格请求
#define API_GoodDetail_FindGoodsProperty UrlAPI(@"/server/Goods/findGoodsProperty.do")

//带着属性加入购物车
#define API_GoodDetail_ChooseGoodsProperty UrlAPI(@"/server/Goods/findGoodsPropertyChoose.do")

#pragma mark - 购物车
/********************购物车********************/
//查询购物车
#define API_ShoppingCart_Find UrlAPI(@"/server/shopcar/showShoppingCart.do")

//加入购物车
#define API_API_ShoppingCart_Add UrlAPI(@"/server/shopcar/addToShoppingCart.do")

//从购物车中删除
#define API_API_ShoppingCart_Remove UrlAPI(@"/server/shopping/shopcar/removeGoodToShopCart.do")

//加入关注
#define API_API_ShoppingCart_ADDCare UrlAPI(@"/server/shopping/shopcar/addToCollection.do")

//提交订单	/server/shopping/shopcar/submitOrder.do
#define API_API_ShoppingCart_SubmitOrder UrlAPI(@"/server/shopping/shopcar/submitOrder.do")

#pragma mark - 我的
/********************我的********************/
//获取用户信息
#define API_MineGetUserData UrlAPI(@"/server/user/findUserDetail.do")
//上传头像
#define API_MineUploadIcon 	UrlAPI(@"/server/user/fileUpload.do")
//用户信息修改
#define API_MineModifyUser 	UrlAPI(@"/server/user/modifyUser.do")
//修改个人爱好
#define API_MineModifyHobby UrlAPI(@"/server/user/modifyHobby.do")

//查询爱好/月收入/教育程度 /行业类别
/*
 查询爱好：h_id=0&type=1
 查询月收入：type=2
 查询教育程度type=3
 行业类别：h_id=0&type=4
 */
#define API_MineDataGetAllList UrlAPI(@"/server/user/getAllList.do")

/***********我的收藏*************/

//查询收藏宝贝和店铺
#define API_MyCollection UrlAPI(@"/server/Collect/findAllCollection.do")

//查询积分
#define API_MyIntegral UrlAPI(@"/server/integral/findAllIntegeral_Record.do")

//查询现金券
#define API_MyCashCoupon UrlAPI(@"/server/cashcoupon_record/findCashcoupon_RecordByUser.do")

//查询优惠券
#define API_MyCoupon UrlAPI(@"/server/user_coupon/getUserCoupon.do")

//意见反馈
#define API_FeedBack UrlAPI(@"/server/feedback/submitFeedback.do")
#pragma mark - 账号安全
/********************账号安全********************/
//修改登录密码--发送验证码(同登录验证码一样)

//修改登录密码--下一步 验证code
#define API_UpdatePassword_VerificationCode UrlAPI(@"/server/login/testMessageCode.do")

//修改登录密码--提交
#define API_UpdatePassword_SubmitNewPW UrlAPI(@"/server/login/registePassword.do")

//修改绑定邮箱--发送验证码(同登录验证码一样)

//修改绑定邮箱--完成(同用户信息修改一样)

//修改绑定手机--原手机号能发送验证码(同登录验证码一样)

//修改绑定手机--输入新手机号(同用户信息修改一样)

//修改支付密码--发送验证码(同登录验证码一样)

//修改支付密码--完成(同用户信息修改一样)

#pragma mark - 其他
/********************其他********************/
#define kResponse @"response"

#endif /* Interface_h */
