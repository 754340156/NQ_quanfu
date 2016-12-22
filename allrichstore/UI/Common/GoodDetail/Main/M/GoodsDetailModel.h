//
//  GoodsDetailModel.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/1.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"
@class GoodsDetailStoreModel,GoodsDetailEvaluativeModel,GoodsDetailActiveModel,GoodsDetailImageModel,GoodsDetailChooseModel;
@interface GoodsDetailModel : BaseModel
/**  付款人数 */
@property(nonatomic,copy) NSString * g_salenumber;
/**  商品名 */
@property(nonatomic,copy) NSString * g_name;
/**  轮播图片数组 */
@property(nonatomic,strong) NSArray <GoodsDetailImageModel *>* image;
/**  商品id */
@property(nonatomic,copy) NSString * goodid;
/**  价格 */
@property(nonatomic,copy) NSString * g_price;
/**  地址 */
@property(nonatomic,copy) NSString * g_site;
/**  快递 */
@property(nonatomic,copy) NSString * g_freight;
/**  评价数 */
@property(nonatomic,copy) NSString * g_commentcount;
/**  好评度 */
@property(nonatomic,copy) NSString * g_famerate;
/**  是否收藏 */
@property(nonatomic,copy) NSString * collectstate;
/**  活动数组 */
@property(nonatomic,strong) NSArray <GoodsDetailActiveModel *>* coupon;
/**  评论数组 */
@property(nonatomic,strong) NSArray <GoodsDetailEvaluativeModel*>* comment;
/**  店铺数组 */
@property(nonatomic,strong) NSArray <GoodsDetailStoreModel *>* shop;
/**  规格属性数组 */
@property(nonatomic,strong) NSArray <GoodsDetailChooseModel *>*property;
/****************           计算属性                ****************/
/**  活动整体的高度 */
@property(nonatomic,assign) CGFloat active_height;
/**  评价整体的高度 */
@property(nonatomic,assign) CGFloat evaluative_height;
/**  推荐店铺整体高度 */
@property(nonatomic,assign) CGFloat store_height;

@end

@interface GoodsDetailActiveModel : BaseModel // 活动model
/**  开始时间 */
@property(nonatomic,copy) NSString * c_begintime;
/**  结束时间 */
@property(nonatomic,copy) NSString * c_endtime;
/**  减多少 */
@property(nonatomic,copy) NSString * c_costmin;
/**  满减 */
@property(nonatomic,copy) NSString * c_costmax;
/**  id */
@property(nonatomic,copy) NSString * coupon;
@end


@interface GoodsDetailEvaluativeModel : BaseModel //评论model
/**  星级 */
@property(nonatomic,copy) NSString * c_fame;
/**  评论id */
@property(nonatomic,copy) NSString * cmid;
/**  创建时间 */
@property(nonatomic,copy) NSString * c_createtime;
/**  评论人的头像 */
@property(nonatomic,copy) NSString * u_headimage;
/**  评论昵称 */
@property(nonatomic,copy) NSString * u_nickname;
/**  评论内容 */
@property(nonatomic,copy) NSString * c_content;
/**  点赞数量 */
@property(nonatomic,copy) NSString * c_likenumber;
/**  二级评论数量 */
@property(nonatomic,copy) NSString * c_replynumber;
/**  图片数组 */
@property(nonatomic,strong) NSArray <GoodsDetailImageModel *>* commentimage;
/****************           计算属性                ****************/
/**  当前评论的高度 */
@property(nonatomic,assign) CGFloat  evaluative_height;
@end


@interface GoodsDetailStoreModel : BaseModel // 店铺的model
/**  头像 */
@property(nonatomic,copy) NSString * s_headimage;
/**  店铺名 */
@property(nonatomic,copy) NSString * s_name;
/**  店铺评分 */
@property(nonatomic,copy) NSString * s_score;
@end



@interface GoodsDetailImageModel : NSObject
/**  url */
@property(nonatomic,copy) NSString * url;
@end


@interface GoodsDetailChooseModel : NSObject
/**  属性名 */
@property(nonatomic,copy) NSString * gpv_property;
/**  属性值 */
@property(nonatomic,copy) NSString * gpv_propertyvalue;
@end
