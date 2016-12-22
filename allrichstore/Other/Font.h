//
//  Font.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/3.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#ifndef Font_h
#define Font_h

#pragma mark - 全富字体
/*******************cell字体*****************/
#pragma mark - -商品cell(四方形)-
//商品标题
#define QFFont_GoodsSquareCell_Title  AdaptedFont(14)
//商品价格
#define QFFont_GoodsSquareCell_Price  AdaptedFont(14)
//最小字体（评价人数/好评率）
#define QFFont_GoodsSquareCell_Min  AdaptedFont(10)

#pragma mark - -商品cell(长方形)-
//商品标题
#define QFFont_GoodsOblongCell_Title  AdaptedFont(14)
//商品价格
#define QFFont_GoodsOblongCell_Price  AdaptedFont(16)
//地址
#define QFFont_GoodsOblongCell_Address  AdaptedFont(13)
//最小字体（评价人数/好评率）
#define QFFont_GoodsOblongCell_Min  AdaptedFont(13)


#pragma mark - 通用
/******************font**********************/

#define Font_Min Font(13)
#define Font_Mid Font(15)
#define Font_Max Font(16)

//固定字体
#define Font_SizeOf(x)      [UIFont systemFontOfSize:x]
#define BoldFont_SizeOf(x)  [UIFont boldSystemFontOfSize:(x)]

//适配字体
#define AdaptedFontSize(R)     CHINESE_SYSTEM(AdaptedWidth(R))
#define AdaptedSystemFontSize(R) Font_SizeOf(AdaptedWidth(R))
#define AdaptedBoldSystemFontSize(R) [UIFont boldSystemFontOfSize:AdaptedWidth(R)]

#endif /* Font_h */
