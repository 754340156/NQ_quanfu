//
//  QBPickerView.h
//  allrichstore
//
//  Created by 任强宾 on 16/12/11.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, QBPickerViewType)
{
    QBPickerViewTypeNormal = 0,
    QBPickerViewTypeHaveBtn
};

typedef void(^PickerActionBlock)(NSArray *selectedArray);

@protocol QBPickerViewAble <NSObject>

@optional
- (NSString *)pickerTitle;
- (NSArray *)subArray;

@end

@interface QBPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

//自定义初始化方法，内部事件通过block传递出来
- (instancetype)initWithStyle:(QBPickerViewType)style dataArray:(NSArray *)dataArray columnCount:(NSInteger)columnCount action:(PickerActionBlock)action;

//设置顶部的按钮Bar的颜色  和  按钮标题的颜色
- (void)setBtnBarColor:(UIColor *)barColor btnTitleColor:(UIColor *)btnTitleColor;

//显示
- (void)show;

//隐藏
- (void)dismiss;

//绑定默认值
- (void)selectIndexArray:(NSArray *)indexArray;

@property (nonatomic, strong) UIView *bgView;

@end
