//
//  ShareView.h
//  YunSuLive
//
//  Created by 任强宾 on 16/7/7.
//  Copyright © 2016年 22. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ShareStyle)
{
    ShareStyleWeb        = 0,   //分享网页
    ShareStyleImage      = 1,   //分享图片
    ShareStyleVoide      = 2    //分享视频
};

#pragma mark - 使用shareView的model必须服从的协议
@protocol ShareViewModelAble <NSObject>

@optional
//分享网页的url
@property (nonatomic, copy) NSString *shareWebUrl;
//分享图片的url
@property (nonatomic, copy) NSString *shareImageUrl;
//分享视频的url
@property (nonatomic, copy) NSString *shareVoideUrl;

@end

@protocol ShareViewDelegate <NSObject>

@optional
/**
 *  点击分享平台时调用
 *
 *  @param index 选中平台的索引
 */
- (void)didSelectedPlatformIndex:(NSInteger)index;
//取消分享时调用
- (void)cancelShare;

@end

@interface ShareView : UIView

/**
 shareView初始化方法

 @param shareArray  UM分享平台标识
 @param style       分享的类型
 @param shareModel  装载分享内容的model
 @param backVC      分享成功或失败之后返回的控制器
 
 */
- (instancetype)initShareArray:(NSArray *)shareArray
                        style:(ShareStyle)style
                   shareModel:(id<ShareViewModelAble>)shareModel
                        backVC:(UIViewController *)backVC;

//弹出分享面板
- (void)show;

@property (nonatomic, strong) UIViewController *viewController;

@property (nonatomic, assign) id<ShareViewDelegate>delegate;
//分享的类型
@property (nonatomic, assign) ShareStyle shareType;

@end


#pragma mark - 分享面板上的cell
@interface ShareCell : UICollectionViewCell

//给cell传上数据
- (void)passDataWithModel:(NSString *)model;

//cell分享的平台的字符串标识
@property (nonatomic, strong) NSString *platformIdentifier;

@end
