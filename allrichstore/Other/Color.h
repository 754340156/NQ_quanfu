//
//  Color.h
//  FullRich
//
//  Created by 任强宾 on 16/10/26.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#ifndef Color_h
#define Color_h

#pragma mark - 全富颜色集
/********************全富颜色集********************/
//全富 —— 黑色
#define QF_BlackColor   [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1.0]

//全富 -- 文字红
#define QF_RedColor [UIColor colorWithRed:232 / 255.0 green:35 / 255.0 blue:45 / 255.0 alpha:1.0]
//全富 -- 按钮红
#define QF_RedBtnColor  [UIColor colorWithRed:242 / 255.0 green:81 / 255.0 blue:89 / 255.0 alpha:1.0]
//全富 -- 黄色
#define QF_YellowColor  [UIColor colorWithRed:253 / 255.0 green:147 / 255.0 blue:39 / 255.0 alpha:1.0]

//全富 -- 橙色
#define QF_OrangeColor  [UIColor colorWithRed:250 / 255.0 green:82 / 255.0 blue:41 / 255.0 alpha:1.0]

//全富 -- 灰色
#define QF_GrayColor kGrayColor_D

//全富 -- 深灰色
#define QF_DarkGrayColor kDarkGrayColor

//全富 -- 商品列表cell上的灰色
#define QF_GrayColor_GoodsListCell kGrayColor_D

//全富 -- 淡灰背景色
#define QFColor_LightGrayBg Color_BaseVCViewBg

//全富 -- self.view的背景色
#define QFColor_BaseVCViewBg Color_BaseVCViewBg

//首页cell分割线的颜色
#define Home_ListCell_Line_Color [UIColor colorWithRed:236 / 255.0 green:236 / 255.0 blue:236 / 255.0 alpha:1.0]

//cell分割线的宽度
#define ListCell_Line_W_H     1.0

//分类菜单的背景颜色
#define QFColor_CoodsClassMenuViewBg [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0]

//全富 -- 搜索栏背景色
#define QFColor_SearchBarBg [UIColor colorWithRed:232 / 255.0 green:232 / 255.0 blue:232 / 255.0 alpha:1.0]

//全富 -- 分割条的颜色
#define QFColor_splitLine_Color [UIColor colorWithRed:236 / 255.0 green:236 / 255.0 blue:236 / 255.0 alpha:1.0]

//全富 -- 半透明背景的颜色
#define QFColor_transitionBg    [UIColor colorWithWhite:0.0 alpha:0.36]

#pragma mark - 定义通用颜色
/********************定义通用颜色********************/
#define kBlackColor         [UIColor blackColor]
#define kDarkGrayColor      [UIColor darkGrayColor]
#define kLightGrayColor     [UIColor lightGrayColor]
#define kWhiteColor         [UIColor whiteColor]
#define kGrayColor          [UIColor grayColor]
#define kRedColor           [UIColor redColor]
#define kGreenColor         [UIColor greenColor]
#define kBlueColor          [UIColor blueColor]
#define kCyanColor          [UIColor cyanColor]
#define kYellowColor        [UIColor yellowColor]
#define kMagentaColor       [UIColor magentaColor]
#define kOrangeColor        [UIColor orangeColor]
#define kPurpleColor        [UIColor purpleColor]
#define kClearColor         [UIColor clearColor]

//在原有基础上加深的颜色
#define kLightGrayColor_D    [UIColor colorWithWhite:0.6 alpha:1.0]

#define kGrayColor_D    [UIColor colorWithWhite:0.45 alpha:1.0]

#define kDarkGrayColor_D    [UIColor colorWithWhite:0.25 alpha:1.0]

//半透明背景的颜色
#define Color_transitionBg    [UIColor colorWithWhite:0.0 alpha:0.36]

#pragma mark - 合成颜色简写
/********************合成颜色简写********************/
//RGB(十六进制) - 透明为1.0
#define ColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB(十六进制) - 可设置透明
#define ColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

//灰度颜色 - 透明为1.0
#define ColorWhite(value) [UIColor colorWithWhite:value alpha:1.0]

//灰度颜色 - 可设置透明
#define ColorWhiteAlpha(value, a) [UIColor colorWithWhite:value alpha:a]

#pragma mark - 主题颜色
/********************主题颜色********************/
#define LightMainCol    RGBA(114, 179, 241, 1)
#define DarkMainCol     RGBA(50, 135, 219, 1)
#define MainCol         RGBA(232, 35, 42, 1)

#pragma mark - 导航相关颜色
/********************导航相关颜色********************/
//导航条渲染色
#define Color_NaviBar_BarTint [UIColor colorWithRed:100 / 255.0 green:100 / 255.0 blue:100 / 255.0 alpha:1.0]
//导航渲染色
#define Color_NaviBar_Tint QF_BlackColor

#pragma mark - 其他颜色
/********************其他颜色********************/
//阴影的颜色
#define Color_Shadow   [UIColor colorWithWhite:0.2 alpha:1.0]

//半透明遮盖背景的颜色
#define Color_Translucent [UIColor colorWithWhite:0.2 alpha:0.2]

//cell分割线的颜色
#define Color_CellSplitLine [UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1]


//webView的背景颜色
#define Color_WebViewScrollBg [UIColor colorWithRed:240 / 255.0 green:241 / 255.0 blue:242 / 255.0 alpha:1.0]

//self.view的背景颜色
#define Color_BaseVCViewBg [UIColor colorWithRed:240 / 255.0 green:241 / 255.0 blue:242 / 255.0 alpha:1.0]

//scrollView的背景颜色
#define Color_ScrollViewBg  [UIColor colorWithRed:240 / 255.0 green:241 / 255.0 blue:242 / 255.0 alpha:1.0]

//tableView的背景色
//#define Color_TableViewBg   [UIColor colorWithRed:243 / 255.0 green:245 / 255.0 blue:247 / 255.0 alpha:1.0]
#define Color_TableViewBg   Color_BaseVCViewBg

//TableViewCell的选中背景颜色
#define Color_TableViewCellSelectedBg [UIColor colorWithWhite:0.9 alpha:1.0]

//自定义毛玻璃视图的背景颜色
#define Color_CustomEffectViewbg    [UIColor colorWithWhite:1.0 alpha:0.88]


#endif /* Color_h */
