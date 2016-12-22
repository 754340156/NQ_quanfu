//
//  CustomInputView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//  用于账户安全和实名认证的输入view

#import <UIKit/UIKit.h>
#define kHeight 45.0f
@interface CustomInputView : UIView
/**
 *
 *
 *  @param titleName  titlename
 *  @param placeHolder placeHolder
 *  @param isGrayLine 下方是否有灰线
 */
- (instancetype)initWithTitleName:(NSString *)titleName PlaceHolder:(NSString *)placeHolder IsGrayLine:(BOOL)isGrayLine;
/**  textFiled */
@property(nonatomic,strong) UITextField * textFiled;
@end
