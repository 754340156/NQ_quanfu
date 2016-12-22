//
//  FoldMenuView.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/3.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoldMenuView;
//配置参数的block
typedef void(^FoldMenuConfigureBlock)(FoldMenuView *foldMenuView);
//选中的block
typedef void(^FoldMenuActionBlock)(NSIndexPath *selectedIndexPath);

@protocol FoldMenuViewDelegate <NSObject>

- (void)foldMenuViewTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

//子菜单协议
@protocol SubMenuAble <NSObject>

@required
//子菜单标题
@property (nonatomic, copy) NSString *subTitle;
//子菜单是否处于打开状态
@property (nonatomic, assign) BOOL isSubOpened;
//装子菜单标题的数组
@property (nonatomic, strong) NSMutableArray<NSString *> *twoLevelArray;

@end

//折叠菜单model必须服从的协议
@protocol FoldMenuAble <NSObject>

@required
//装子菜单的数组
@property (nonatomic, strong) NSMutableArray<id<SubMenuAble>> *oneLevelArray;

@end

@class FoldMenuModel;
@interface FoldMenuView : UIView

//一级高度
@property (nonatomic, assign) CGFloat oneLevelHeight;
//二级高度
@property (nonatomic, assign) CGFloat twoLevelHeight;

//一级菜单的默认背景颜色
@property (nonatomic, strong) UIColor *bgColor_normal_oneLevel;
//一级菜单的选中背景颜色
@property (nonatomic, strong) UIColor *bgColor_selected_oneLevel;
//一级菜单的默认文字颜色
@property (nonatomic, strong) UIColor *textColor_normal_oneLevel;
//一级菜单的选中文字颜色
@property (nonatomic, strong) UIColor *textColor_selected_oneLevel;

//二级菜单的默认背景颜色
@property (nonatomic, strong) UIColor *bgColor_normal_twoLevel;
//二级菜单的选中背景颜色
@property (nonatomic, strong) UIColor *bgColor_selected_twoLevel;
//二级菜单的默认文字颜色
@property (nonatomic, strong) UIColor *textColor_normal_twoLevel;
//二级菜单的选中文字颜色
@property (nonatomic, strong) UIColor *textColor_selected_twoLevel;


//是否是单展开
@property (nonatomic, assign) BOOL isSingleOpen;
@property (nonatomic, assign) BOOL isSelectedWhenOpen;
@property (nonatomic, strong) id<FoldMenuAble> menuModel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) id<FoldMenuViewDelegate> delegate;

/**
 传入model block形式
 @param model     菜单的model
 @param configure 配置参数
 @param action    选中的触发事件
 */
- (instancetype)initWithFrame:(CGRect)frame
                        model:(id<FoldMenuAble>)model
                    configure:(FoldMenuConfigureBlock)configure
                       action:(FoldMenuActionBlock)action;

/**
 传入model delegate形式
 @param model     菜单的model
 @param configure 配置参数
 @param delegate  代理对象
 */
- (instancetype)initWithFrame:(CGRect)frame
                        model:(id<FoldMenuAble>)model
                    configure:(FoldMenuConfigureBlock)configure
                     delegate:(id<FoldMenuViewDelegate>)delegate;

/**
 传入model block形式
 @param model     菜单的model
 @param configure 配置参数
 @param action    选中的触发事件
 */
- (instancetype)initWithModel:(id<FoldMenuAble>)model
                    configure:(FoldMenuConfigureBlock)configure
                       action:(FoldMenuActionBlock)action;

/**
 传入model delegate形式
 @param model     菜单的model
 @param configure 配置参数
 @param delegate  代理对象
 */
- (instancetype)initWithModel:(id<FoldMenuAble>)model
                    configure:(FoldMenuConfigureBlock)configure
                     delegate:(id<FoldMenuViewDelegate>)delegate;

/**
 block形式
 @param configure 配置参数
 @param action    选中的触发事件
 */
- (instancetype)initWithConfigure:(FoldMenuConfigureBlock)configure
                           action:(FoldMenuActionBlock)action;

/**
 delegate形式
 @param configure 配置参数
 @param delegate  代理对象
 */
- (instancetype)initWithConfigure:(FoldMenuConfigureBlock)configure
                     delegate:(id<FoldMenuViewDelegate>)delegate;

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)init;

@end


@interface SubMenuModel : NSObject<SubMenuAble>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isOpened;
@property (nonatomic, strong) NSMutableArray<NSString *> *subMenuArray;

@end

@interface FoldMenuModel : NSObject<FoldMenuAble>

@property (nonatomic, strong) NSMutableArray<id< SubMenuAble>> *menuArray;

@end
