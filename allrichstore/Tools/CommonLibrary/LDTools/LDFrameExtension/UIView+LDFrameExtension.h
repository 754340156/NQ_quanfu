//
//  UIView+LDFrameExtension.h
//  OCLDProject
//
//  Created by apple on 16/4/29.
//  Copyright © 2016年 LDSmallCat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LDFrameExtension)

@property (nonatomic,assign) CGFloat LDWidth;
@property (nonatomic,assign) CGFloat LDHeight;
@property (nonatomic,assign) CGFloat LDX;
@property (nonatomic,assign) CGFloat LDY;
@property (nonatomic,assign) CGSize LDSize;
@property (nonatomic, assign) CGFloat LDCenterX;
@property (nonatomic, assign) CGFloat LDCenterY;
@property (nonatomic, assign) CGFloat LDRight;
@property (nonatomic, assign) CGFloat LDBottom;
@end
/**
 *  在分类中声明属性@property,只会生成方法的声明,不会生成方法的实现和带有_下划线的成员变量.只相当于写了set和get方法的声明没有实现
 *  分类中一般只添加方法,不添加成员变量.分类中特有的语法.
 */