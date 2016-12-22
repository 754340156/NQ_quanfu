//
//  QBFont.h
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/21.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#ifndef QBFont_h
#define QBFont_h

#pragma mark - 通用
//#define Font(x) [UIFont fontWithName:@"清茶楷体预览版" size:x]
#define Font(x)      [UIFont systemFontOfSize:x]
#define BoldFont(x)  [UIFont boldSystemFontOfSize:x]

//#define AdaptedFont(x)    [UIFont fontWithName:@"清茶楷体预览版" size:FloatAdapted(x)]
#define AdaptedFont(x)     [UIFont systemFontOfSize:FloatAdapted(x)]
#define AdaptedBoldFont(x) [UIFont boldSystemFontOfSize:FloatAdapted(x)]

#define LightAdaptedFont(x)     [UIFont systemFontOfSize:LightAdapted(x)]

#pragma mark - 工程字体配置
/***************BaseCell的控件字体***************/
#define BaseFont_Cell_Title     AdaptedBoldFont(16)
#define BaseFont_Cell_Context   Font_Mid
#define BaseFont_Cell_Time      AdaptedFont(13)


//中文字体
#define CHINESE_FONT_NAME  @"Heiti SC"
#define CHINESE_SYSTEM(x) [UIFont fontWithName:CHINESE_FONT_NAME size:x]



#endif /* QBFont_h */
