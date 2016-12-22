//
//  Image.h
//  FullRich
//
//  Created by 任强宾 on 16/10/26.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#ifndef Image_h
#define Image_h

#pragma mark - 简写工具
/********************简写工具********************/
//简写Image
#define Image(imageName) [Single themeImageWithName:imageName]

#define ImageStr(imageName) [UIImage imageNamed:imageName]



#pragma mark - 工程配置
/********************工程配置********************/
//导航条 -- 左侧的返回按钮图标
#define Image_NaviBar_Left_Back    Image(@"fanhuijian")

//系统消息的图片
#define Image_NaviBar_Right_SysMsg Image(@"systemMsg")

//轮播图的page图片
#define Image_CycleCurrentPageDotImage   Image(@"lunbodian1")
#define Image_CyclePageDotImage          Image(@"lunbodian2")

#define ImageUrlArray_Banner @[@"http://renqiangbin-app-image.oss-cn-shanghai.aliyuncs.com/appimages/Banner/banner1%402x.png", @"http://renqiangbin-app-image.oss-cn-shanghai.aliyuncs.com/appimages/Banner/banner2%402x.png", @"http://renqiangbin-app-image.oss-cn-shanghai.aliyuncs.com/appimages/Banner/banner3%402x.png", @"http://renqiangbin-app-image.oss-cn-shanghai.aliyuncs.com/appimages/Banner/banner4%402x.png"]

/********************占位图********************/
#define Image_PlaceHolder_Banner    [UIImage imageNamed:@"PlaceHolder_3_1"]       //banner占位图

#define Image_PlaceHolder_Photo    ImageStr(@"photo_1")     //头像的占位图

#define Image_PlaceHolder_ShopIcon  Image(@"")

#define Image_PlaceHolder_Cell_1 [UIImage imageNamed:@"PlaceHolder_1_1"]       //cell上的占位图

#define Image_PlaceHolder_GoodsListCell [UIImage imageNamed:@"PlaceHolder_GoodsListCell"]    //cell上的占位图

#define Image_PlaceHolder_GoodsClass   [UIImage imageNamed:@"PlaceHolder_GoodsListCell"]//三级分类的占位图

#endif /* Image_h */
