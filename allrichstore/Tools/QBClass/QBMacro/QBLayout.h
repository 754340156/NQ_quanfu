//
//  QBLayout.h
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/21.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#ifndef QBLayout_h
#define QBLayout_h

//系统固定宽高
#pragma mark ------------------系统固定宽高------------------

#define kScreenW   [UIScreen mainScreen].bounds.size.width
#define kScreenH   [UIScreen mainScreen].bounds.size.height

//不同屏幕尺寸字体适配（375.0，667.0是因为效果图为IPHONE6 如果不是则根据实际情况修改）
#define kScreenWidthRatio  (kScreenW / 375.0)
#define kScreenHeightRatio (kScreenH / 667.0)
#define AdaptedWidth(x)  floorf((x) * kScreenWidthRatio)
#define AdaptedHeight(x) floorf((x) * kScreenHeightRatio)

//尺寸适配（按真实比例）取整
#define Adapted(x)  floorf((x) * kScreenWidthRatio)

//尺寸适配（按真实比例）不取整（适配字体时需要用）
#define FloatAdapted(x)  ((x) * kScreenWidthRatio)

//尺寸适配（轻比例）（特殊情况下使用）
#define LightAdapted(x)  floorf((x) * ((kScreenWidthRatio > 1) ? (1 + (kScreenWidthRatio - 1) / 2.0) : (1 - (1 - kScreenWidthRatio) / 2.0)))


#endif /* QBLayout_h */
