//
//  Single.m
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/12.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "Single.h"
#import "UserModel.h"
static Single *singleInstance = nil;

@interface Single ()
/**  存储取出来的userModel */
@property(nonatomic,strong) UserModel * userModel;

@end

@implementation Single

+ (Single *)single
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleInstance = [[super allocWithZone:NULL] init];
        NSString *themePath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        singleInstance.themePlistDic = [NSDictionary dictionaryWithContentsOfFile:themePath];
        singleInstance.themeName = @"theme1";
    });
    return singleInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self single];
}

#pragma mark - 定位相关
+ (void)setLoc:(NSString *)locStr
{
    Single *single = [Single single];
    single.locStr = locStr;
    
    for (int i = 0; i < single.loctionBtnsArray.count; i++)
    {
        QButton *loctionBtn = single.loctionBtnsArray[i];
        [loctionBtn setTitle:locStr forState:UIControlStateNormal];
    }
}

//返回当前（定位/选择的）地址
+ (NSString *)locStr
{
    Single *single = [Single single];
    return  single.locStr ? single.locStr : NotAddressString;
}

+ (QButton *)locBtnTitle:(NSString *)title
{
    QButton *loctionBtn = [[QButton alloc] initWithFrame:CGRectMake(0, 0, 56, 42) style:QButtonStyleImageRight layoutStyle:QButtonLayoutStyleLeft font:Font(17) title:title image:Image(@"xialajiantou") space:1.0 margin:0.0 autoSize:YES];

    Single *single = [Single single];
    single.locStr = title;
    [single.loctionBtnsArray addObject:loctionBtn];
    return loctionBtn;
}

+ (NSMutableArray *)addressListArray
{
    Single *single = [Single single];
    return single.addressListArray;
}

#pragma mark - lazy
//城市地址选择数组
- (NSMutableArray *)loctionBtnsArray
{
    if (!_loctionBtnsArray)
    {
        self.loctionBtnsArray = [NSMutableArray array];
    }
    return _loctionBtnsArray;
}

//收货地址数组
- (NSMutableArray *)addressListArray
{
    if (!_addressListArray)
    {
        self.addressListArray = [NSMutableArray array];
    }
    return _addressListArray;
}

#pragma mark - 用户登录状态
//通过此方法获取本app的用户登录状态
+ (BOOL)isLogin
{
    Single *single = [Single single];
    return single.isLogin;
}

//重写setter（更新本地的登录状态）
- (void)setIsLogin:(BOOL)isLogin
{
    _isLogin = isLogin;
    WriteForLocation(@(_isLogin), kIsLoginKey);
}

#pragma mark - 图片资源配置
- (void)setThemeName:(NSString *)themeName
{
    _themeName = themeName;
}

//从主题路径下取图片
+ (UIImage *)themeImageWithName:(NSString *)imageName
{
    if (imageName == nil) {
        return nil;
    }
    
    NSString *themePath = [[Single single] themePath];
    NSString *themeImagePath = [themePath stringByAppendingPathComponent:imageName];
    UIImage *themeImage = [UIImage imageWithContentsOfFile:themeImagePath];
    return themeImage;
}

// 返回主题路径
- (NSString *)themePath
{
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    if (self.themeName == nil || [self.themeName isEqualToString:@""]) {
        return resourcePath;
    }

    NSString *themeSubPath = [self.themePlistDic objectForKey:self.themeName];
    NSString *themeFilePath = [resourcePath stringByAppendingPathComponent:themeSubPath];
    
    return themeFilePath;
}

//归档到本地
+ (void)updateWithUserModel:(UserModel *)userModel
{
    [Tools writeToSandBox:userModel key:kUserModelKey];
    [Single single].userModel = userModel;
}
//取出来
+ (UserModel *)getUserModel
{
    return  [Single single].userModel;
}
//退出登录的时候清空数据
+ (void)clearUserMode
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSString * libPath = [Tools getFilePathWithKey:kUserModelKey];
    NSArray *libSubpaths = [mgr subpathsAtPath:libPath];
    for ( NSString *str in libSubpaths) {
        NSString *path  =[libPath stringByAppendingPathComponent:str];
        [mgr removeItemAtPath:path error:nil];
    }
}

- (UserModel *)userModel
{
    if (!_userModel) {
        _userModel = [Tools readFromSandBox:kUserModelKey];
    }
    return _userModel;
}
@end
