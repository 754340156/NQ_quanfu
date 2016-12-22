//
//  Layout.h
//  FullRich
//
//  Created by 任强宾 on 16/10/26.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#ifndef Layout_h
#define Layout_h

#pragma mark - 全富
//首页和店铺首页组头的高度
#define Layout_home_sectionHeader_height    40

//自定义底部bar的高度
#define Layout_customBar_height     45

//圆角的大小
#define Layout_cornerRadius         3.0

//边线的宽度
#define Layout_borderWidth          0.6

//margin
#define kMargin 10.0f
//footerH
#define kFooterViewH 5.0f
// 某些页面下面红色横条
#define kBottomH 45.0f
//右箭头的尺寸
#define kArrowImageVSize  CGSizeMake(9, 14)

#pragma mark - 通用尺寸
/****************通用尺寸****************/
//导航栏高度
#define TopBarHeight 64
#define kCommentRect  CGRectMake(0, TopBarHeight, kScreenW, kScreenH - TopBarHeight)
#pragma mark - 比例
/****************比例****************/
#define Banner_W_H_Scale 2.2              //Banner图的宽高比
#define Banner_Shop_W_H_Scale 2.2         //店铺Banner图的宽高比
#define Advert_W_H_Scale 5.0              //广告图的宽高比
#define Cell_Goods_W_H_Scale  (156.0 / 120) //商品图片展示的宽高比


#endif /* Layout_h */
