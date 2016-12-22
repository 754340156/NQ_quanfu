//
//  AddressPickerView.h
//  MeiYiQuan
//
//  Created by 任强宾 on 16/9/28.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

typedef NS_ENUM(NSInteger, AddressViewType)
{
    AddressViewTypeNormal = 0,
    AddressViewTypeHaveBtn
};

@interface AddressPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

//自定义初始化方法，内部事件通过block传递出来
- (instancetype)initWithStyle:(AddressViewType)style columnCount:(NSInteger)columnCount block:(AdressBlock)block;

//设置顶部的按钮Bar的颜色  和  按钮标题的颜色
- (void)setBtnBarColor:(UIColor *)barColor btnTitleColor:(UIColor *)btnTitleColor;

//显示
- (void)show;

//隐藏
- (void)dismiss;

//绑定默认值 省名 市名 区名
- (void)configDataProvinceName:(NSString *)provinceName cityName:(NSString *)cityName regionName:(NSString *)regionName;

//绑定默认值 省码 市码 区码
- (void)configDataProvinceCode:(NSString *)provinceCode cityCode:(NSString *)cityCode regionCode:(NSString *)regionCode;

@property (nonatomic, strong) UIView *bgView;

@end
