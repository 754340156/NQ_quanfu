//
//  QBAlertView.h
//  PRJ_CreditRecruit
//
//  Created by 任强宾 on 16/5/19.
//  Copyright © 2016年 河南维创盈通科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QBAlertView;

@protocol QBAlertViewDelegate <NSObject>

- (void)qbAlertview:(QBAlertView *)qbAlertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface QBAlertView : UIView

@property (nonatomic, assign) id<QBAlertViewDelegate> delegate;

@property (nonatomic, strong) UIColor *backColor;   //大窗背景色(默认：blackColor)
@property (nonatomic) CGFloat backAlpha;            //大窗背景色的透明度(默认：0.2)

@property (nonatomic) BOOL isEffect;    //是否是毛玻璃(默认：YES)
@property (nonatomic, strong) UIColor *littleBackColor; //小窗背景色(默认：whiteColor)
@property (nonatomic) CGFloat littleBackAlpha;          //小窗背景色的透明度(默认：1.0)

@property (nonatomic, copy) NSString *title;        //标题(默认：空)
@property (nonatomic, strong) UIFont *titleFont;    //标题的字体(默认：系统粗体 16.0)
@property (nonatomic, strong) UIColor *titleColor;  //标题的颜色(默认：blackColor)
@property (nonatomic) NSTextAlignment titleAlignment;//标题的布局方式(默认：居中)

@property (nonatomic, copy) NSString *message;      //消息内容(默认：空)
@property (nonatomic, strong) UIFont *messageFont;  //标题的字体(默认：系统细体 16.0)
@property (nonatomic, strong) UIColor *messageColor;//标题的颜色(默认：blackColor)
@property (nonatomic) NSTextAlignment messageAlignment;//消息的布局方式(默认：居中)

@property (nonatomic, strong) NSString *cancleTitle;    //取消按钮的标题(默认：取消)
@property (nonatomic, strong) UIFont *cancleBtnFont;    //取消按钮标题的字体(默认：系统粗体18.0)
@property (nonatomic, strong) UIButton *cancleBtn;      //取消按钮

@property (nonatomic, strong) NSArray *otherTitles;     //按钮的标题数组(默认为nil)
@property (nonatomic, strong) UIFont *otherBtnFont;     //其他按钮的字体(默认：系统细体 17.0)
@property (nonatomic, strong) NSArray *otherBtnArray;   //存放按钮的数组(默认为nil)

@property (nonatomic) CGFloat titleTopMargin;       //标题上边距(默认：18.0)
@property (nonatomic) CGFloat title_messageSpace;   //标题与消息的距离(默认：12.0)
@property (nonatomic) CGFloat message_BtnSpace;     //消息与按钮的距离(默认：18.0)

//初始化方法
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                     delegate:(id)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles;

//构造便利器

@end
