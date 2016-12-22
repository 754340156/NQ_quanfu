//
//  TabMenuView.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/28.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TabMenuModelAble <NSObject>

@optional
- (NSString *)qbTitle;
- (NSString *)qbImgUrl;
- (NSString *)qbImgName;

@end

@class TabMenuView;

//配置参数的block
typedef void(^TabMenuConfigureBlock)(TabMenuView *tabMenuView);
//选中的block
typedef void(^TabMenuActionBlock)(NSInteger selectedIndex);

@protocol TabMenuViewDelegate <NSObject>

- (void)tabMenuViewTableView:(UITableView *)tableView didSelectRowIndex:(NSInteger )index;

@end

@interface TabMenuView : UIView

//cell高度
@property (nonatomic, assign) CGFloat cellHeight;

//cell默认背景颜色
@property (nonatomic, strong) UIColor *bgColor_normal;
//cell选中背景颜色
@property (nonatomic, strong) UIColor *bgColor_selected;
//cell默认文字颜色
@property (nonatomic, strong) UIColor *textColor_normal;
//cell选中文字颜色
@property (nonatomic, strong) UIColor *textColor_selected;


@property (nonatomic, strong) NSArray *menuArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) id<TabMenuViewDelegate> delegate;

//选中下标
- (void)selectedIndex:(NSInteger)index;

/**
 传入数组 block形式
 @param menuArray 菜单的数据
 @param configure 配置参数
 @param action    选中的触发事件
 */
- (instancetype)initWithFrame:(CGRect)frame
                    menuArray:(NSArray *)menuArray
                    configure:(TabMenuConfigureBlock)configure
                       action:(TabMenuActionBlock)action;

/**
 传入数组 delegate形式
 @param menuArray 菜单的数据
 @param configure 配置参数
 @param delegate  代理对象
 */
- (instancetype)initWithFrame:(CGRect)frame
                    menuArray:(NSArray *)menuArray
                    configure:(TabMenuConfigureBlock)configure
                     delegate:(id<TabMenuViewDelegate>)delegate;

/**
 传入数组 block形式
 @param menuArray 菜单的数据
 @param configure 配置参数
 @param action    选中的触发事件
 */
- (instancetype)initWithMenuArray:(NSArray *)menuArray
                        configure:(TabMenuConfigureBlock)configure
                           action:(TabMenuActionBlock)action;

/**
 传入数组 delegate形式
 @param menuArray 菜单的数据
 @param configure 配置参数
 @param delegate  代理对象
 */
- (instancetype)initWithMenuArray:(NSArray *)menuArray
                        configure:(TabMenuConfigureBlock)configure
                         delegate:(id<TabMenuViewDelegate>)delegate;

/**
 block形式
 @param configure 配置参数
 @param action    选中的触发事件
 */
- (instancetype)initWithConfigure:(TabMenuConfigureBlock)configure
                           action:(TabMenuActionBlock)action;

/**
 delegate形式
 @param configure 配置参数
 @param delegate  代理对象
 */
- (instancetype)initWithConfigure:(TabMenuConfigureBlock)configure
                         delegate:(id<TabMenuViewDelegate>)delegate;

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)init;

@end

@interface TabMenuCell : UITableViewCell

@property (nonatomic, strong) QButton *titleBtn;

@end
