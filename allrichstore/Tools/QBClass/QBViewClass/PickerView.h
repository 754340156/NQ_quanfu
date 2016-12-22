//
//  PickerView.h
//  MeiYiQuan
//
//  Created by 任强宾 on 16/9/28.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PickerViewType)
{
    PickerViewTypeNormal = 0,
    PickerViewTypeHaveBtn
};

typedef  void(^PickerViewBlock)(NSArray *selectedArray);

@interface PickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

/**
 *  自定义初始化方法
 *
 *  @param style     类型
 *  @param dataArray 数组嵌套数组的形式传进来
 *  @param block     内部事件通过block传递出来
 */
- (instancetype)initWithStyle:(PickerViewType)style dataArray:(NSArray *)dataArray pickerViewHeight:(CGFloat)pickerViewHeight inView:(UIView *)view block:(PickerViewBlock)block;

//显示
- (void)show;

//隐藏
- (void)dismiss;

//绑定默认值
- (void)configDataFromArray:(NSArray *)array;

@end
