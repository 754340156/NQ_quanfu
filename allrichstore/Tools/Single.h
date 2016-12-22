//
//  Single.h
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/12.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;
@interface Single : NSObject

+ (Single *)single;

+ (void)setLoc:(NSString *)locStr;

+ (QButton *)locBtnTitle:(NSString *)title;

+ (BOOL)isLogin;

+ (NSMutableArray *)addressListArray;

//返回当前（定位/选择的）地址
+ (NSString *)locStr;

@property (nonatomic, copy) NSString *locStr;
//地址选择数组
@property (nonatomic, strong) NSMutableArray *loctionBtnsArray;
//我的收货地址列表数组
@property (nonatomic, strong) NSMutableArray *addressListArray;

@property (nonatomic, assign) BOOL isLogin;


#pragma mark - 图片资源配置
/**图片资源配置*/
@property (nonatomic, copy) NSString *themeName;// 主题名字
@property (nonatomic, strong) NSDictionary * themePlistDic; // 主题属性列表字典
+ (UIImage *)themeImageWithName:(NSString *)imageName;

#pragma mark - 用户相关
//用户信息归档到本地
+ (void)updateWithUserModel:(UserModel *)userModel;

//取出来
+ (UserModel *)getUserModel;

//退出登录的时候清空数据
+ (void)clearUserMode;


@end
