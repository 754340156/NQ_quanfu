//
//  ShareView.m
//  YunSuLive
//
//  Created by 任强宾 on 16/7/7.
//  Copyright © 2016年 22. All rights reserved.
//

#import "ShareView.h"

#pragma mark - 参数配置
/************图片***********/
//app图标(当图片下载失败的时候，使用app图标占位)
#define ShareView_ImageName_AppIcon @"appIcon"

//新浪
#define ShareView_ImageName_Sina  @"share_sina"
//微信好友
#define ShareView_ImageName_WechatSession   @"share_wechatSession"
//微信朋友圈
#define ShareView_ImageName_WechatTimeline   @"share_wechatTimeline"
//QQ好友
#define ShareView_ImageName_QQ   @"share_QQ"
//QQ朋友圈
#define ShareView_ImageName_Qzone   @"share_Qzone"

/************分享标题和内容***********/
//标题
#define ShareView_Title_Web      @""
#define ShareView_Title_Image    @""
#define ShareView_Title_Video    @""

//内容
#define ShareView_Content_Web      @""
#define ShareView_Content_Image    @""
#define ShareView_Content_Video    @""

/***********app的分享地址**********/
#define ShareView_AppShareUrl  @""

/************布局***********/
//单行支持的做多的按钮数量
#define ShareView_MaxOneLineCount     5
//底部菜单视图的高度
#define ShareView_MenuView_height    self.width / 2.0
//取消按钮的高度
#define ShareView_CancelBtn_height   50
//分享按钮的宽高
#define ShareView_ShareBtn_W_H       self.width / 7.0
//collectView的高度
#define ShareView_CollectView_H      70

/************颜色***********/
//半透明黑色背景
#define ShareView_TransBlackCol  [UIColor colorWithWhite:0.0 alpha:0.2]

/************动画***********/
#define ShareView_AnimationTime 0.3 //出现和消失的动画周期

@interface ShareView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIButton *backBtn;  //背景按钮
@property (nonatomic, strong) UIView *menuView;   //分享菜单底图
@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, strong) UIButton *cancelBtn;//取消按钮
@property (nonatomic, strong) NSArray *shareArray;

@property (nonatomic, strong) NSDictionary *shareDic; //分享字典

@property (nonatomic, strong) UIViewController *backVC;

@property (nonatomic, assign) id<ShareViewModelAble>shareModel;

@end

static NSString *identifierCell = @"collectCell";

@implementation ShareView

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
                        backVC:(UIViewController *)backVC
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
    if (self) {
        
        self.shareArray = shareArray;
        self.shareType = style;
        self.shareModel = shareModel;
        self.backVC = backVC;
        //标记每种分享对应的数组
        self.shareDic = @{
                          UMShareToSina:@(0),
                          UMShareToWechatSession:@(1),
                          UMShareToWechatTimeline:@(2),
                          UMShareToQQ:@(3),
                          UMShareToQzone:@(4)
                          };
        [self createSubviews];  //创建子视图
    }
    return self;
}

#pragma mark - create subviews
//创建子视图
- (void)createSubviews
{
    //关闭友盟自带的吐丝
    [UMSocialConfig setFinishToastIsHidden:YES position:(UMSocialiToastPositionCenter)];
    
    //创建背景按钮
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = self.bounds;
    _backBtn.backgroundColor = [UIColor clearColor];
    [_backBtn addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchDown];
    [self addSubview:_backBtn];
    
    //创建底部的分享菜单
    self.menuView = [[UIView alloc] initWithFrame:CGRectMake(0, _backBtn.height, _backBtn.width, ShareView_MenuView_height)];
    _menuView.backgroundColor = [UIColor whiteColor];
    [_backBtn addSubview:_menuView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    //创建cellectionView
    self.collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, ((ShareView_MenuView_height - ShareView_CancelBtn_height) - ShareView_CollectView_H) / 2.0, _menuView.width, ShareView_CollectView_H) collectionViewLayout:layout];
    _collectView.backgroundColor = [UIColor whiteColor];
    _collectView.dataSource = self;
    _collectView.delegate = self;
    [_collectView registerClass:[ShareCell class] forCellWithReuseIdentifier:identifierCell];
    [_menuView addSubview:_collectView];
    
    //创建取消按钮
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _cancelBtn.frame = CGRectMake(0, _menuView.height - ShareView_CancelBtn_height, _menuView.width, ShareView_CancelBtn_height);
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor colorWithWhite:0.2 alpha:1.0] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
    [_menuView addSubview:_cancelBtn];
    
    //创建分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _cancelBtn.top + 1, _menuView.width, 1.0)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [_menuView addSubview:lineView];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
}

#pragma mark - handle action
#pragma mark 弹出分享面板
//视图出现
- (void)show
{
    [UIView animateWithDuration:ShareView_AnimationTime animations:^{
        
        //透明按钮渐变为半透明灰色的颜色
        _backBtn.backgroundColor = ShareView_TransBlackCol;
        //白底菜单视图从下面推上来
        CGRect frame = _menuView.frame;
        frame.origin.y = _backBtn.height - ShareView_MenuView_height;
        _menuView.frame = frame;
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark 分享取消
//分享取消
- (void)dissMiss
{
    //分享菜单动画收回，完成后本视图移除
    [UIView animateWithDuration:ShareView_AnimationTime animations:^{
        
        //半透明灰色按钮的颜色渐变为透明
        _backBtn.backgroundColor = [UIColor clearColor];
        //白底菜单视图向下推出去
        CGRect frame = _menuView.frame;
        frame.origin.y = _backBtn.height;
        _menuView.frame = frame;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    if (_delegate && [_delegate respondsToSelector:@selector(cancelShare)]) {
        [_delegate cancelShare];
    }
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
//每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ShareView_ShareBtn_W_H, ShareView_ShareBtn_W_H);
}

//每个item的edge
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//每组的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat lineSpace = (_menuView.width - ShareView_ShareBtn_W_H * _shareArray.count) / (_shareArray.count + 1);
    return lineSpace;
}

//每组的列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat lineSpace = (_menuView.width - ShareView_ShareBtn_W_H * _shareArray.count) / (_shareArray.count + 1);
    return lineSpace;
}

//每组 组头的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGFloat lineSpace = (_menuView.width - ShareView_ShareBtn_W_H * _shareArray.count) / (_shareArray.count + 1);
    return CGSizeMake(lineSpace, ShareView_ShareBtn_W_H);
}

//每组 组尾的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGFloat lineSpace = (_menuView.width - ShareView_ShareBtn_W_H * _shareArray.count) / (_shareArray.count + 1);
    return CGSizeMake(lineSpace, ShareView_ShareBtn_W_H);
}

#pragma mark - <UICollectionViewDataSource>
//collectionView包含的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每一组的item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shareArray.count;
}

//创建item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierCell forIndexPath:indexPath];
    [cell passDataWithModel:_shareArray[indexPath.row]];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
//item的点击触发
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedPlatformIndex:)]) {
        [_delegate didSelectedPlatformIndex:indexPath.row];
    }
   
    NSInteger shareIndex = [_shareDic[_shareArray[indexPath.row]] integerValue];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    //取出用户头像的地址
    NSString *imageUrl = [self.shareModel shareImageUrl];
    
    //先下载头像 再分享
    __weak typeof(self) ws = self;
    [manager downloadImageWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        [ws shareWithIndex:shareIndex image:image];
        
    }];
}

//分享的方法
- (void)shareWithIndex:(NSInteger)index
                 image:(UIImage *)image
{
    
    UIImage *shareImage;
    NSString *title;
    NSString *content;
    UMSocialWXMessageType wxMessageType = UMSocialWXMessageTypeWeb;

    //当图片下载失败的时候，使用app图标占位
    shareImage = image ? image : [UIImage imageNamed:ShareView_ImageName_AppIcon];
    
    //如果model的分享地址为空  使用默认地址
    NSString *shareUrl = [self.shareModel shareWebUrl] ? [self.shareModel shareWebUrl] : ShareView_AppShareUrl;
    
    UMSocialUrlResource *urlResource;
    
    //根据不同分享类型 配置分享标题和内容
    switch (self.shareType)
    {
        case ShareStyleWeb:
        {
            wxMessageType = UMSocialWXMessageTypeWeb;
            
            title = ShareView_Title_Web;
            content = ShareView_Content_Web;
            urlResource = [[UMSocialUrlResource alloc]initWithSnsResourceType:UMSocialUrlResourceTypeWeb url:shareUrl];
        }
            break;
            
        case ShareStyleImage:
        {
            title = ShareView_Title_Image;
            content = ShareView_Content_Image;
            urlResource = [[UMSocialUrlResource alloc]initWithSnsResourceType:UMSocialUrlResourceTypeImage url:shareUrl];
        }
            break;
            
        case ShareStyleVoide:
        {
            title = ShareView_Title_Video;
            content = ShareView_Content_Video;
            //如果是视频的分享
            urlResource = [[UMSocialUrlResource alloc]initWithSnsResourceType:UMSocialUrlResourceTypeVideo url:[self.shareModel shareVoideUrl]];
        }
            break;

        default:
            break;
    }
    

    //针对不同的分享平台 做不同的参数配置
    switch (index)
    {
        case 0:
        {//分享至新浪微博
            if (self.shareType != ShareStyleImage)
            {
                shareImage = [shareImage scaleToSize:CGSizeMake(100, 100)];
            }
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:content image:shareImage location:nil urlResource:urlResource presentedController:self.backVC completion:^(UMSocialResponseEntity *response){
            }];
        }
            break;
        case 1:
        {//分享至微信好友
            
            [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
            
            [UMSocialData defaultData].extConfig.wechatSessionData.url = shareUrl;
            
            
            [UMSocialData defaultData].extConfig.wxMessageType = wxMessageType;
            if (self.shareType != ShareStyleVoide) {
                
                urlResource = nil;
            }
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:content image:shareImage location:nil urlResource: urlResource presentedController:self.backVC completion:^(UMSocialResponseEntity *response){
            }];
        }
            break;
        case 2:
        {//分享至微信朋友圈
            
            //[UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
            
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareUrl;
            
            [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = wxMessageType;
            if (self.shareType == ShareStyleImage) {
                
                urlResource = nil;
            }
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:content image:shareImage location:nil urlResource:urlResource presentedController:self.backVC completion:^(UMSocialResponseEntity *response){
            }];
        }
            break;
        case 3:
        {//分享至QQ好友
            
            if ((self.shareType != ShareStyleVoide) && (self.shareType != ShareStyleImage))
            {
                urlResource = nil;
                [UMSocialData defaultData].extConfig.qqData.url = shareUrl;
                [UMSocialData defaultData].extConfig.qqData.title = title;
            }
        
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:content image:shareImage location:nil urlResource:urlResource presentedController:self.backVC completion:^(UMSocialResponseEntity *response){
            }];
        }
            break;
        case 4:
        {//分享至QQ空间
            
            if ((self.shareType != ShareStyleVoide) && (self.shareType != ShareStyleImage))
            {
                urlResource = nil;
                [UMSocialData defaultData].extConfig.qqData.url = shareUrl;
                [UMSocialData defaultData].extConfig.qqData.title = title;
            }
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:content image:shareImage location:nil urlResource:urlResource presentedController:self.backVC completion:^(UMSocialResponseEntity *response){
            }];
        }
            break;
        default:
            break;
    }
}


@end


#pragma mark - ShareCell

@interface ShareCell ()

//分享按钮
@property (nonatomic, strong) UIButton *shareBtn;
//分享Label
@property (nonatomic, strong) UILabel *shareLabel;

@property (nonatomic, strong) NSDictionary *imageDic;

@end

@implementation ShareCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureData];   //配置数据源
        [self createView];      //创建子视图
    }
    return self;
}

//配置数据源
- (void)configureData
{
    self.imageDic = @{UMShareToSina:ShareView_ImageName_Sina, UMShareToWechatSession:ShareView_ImageName_WechatSession, UMShareToWechatTimeline:ShareView_ImageName_WechatTimeline, UMShareToQQ:ShareView_ImageName_QQ, UMShareToQzone:ShareView_ImageName_Qzone};
}

//创建子视图
- (void)createView
{
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shareBtn.frame = CGRectMake(0, 0, self.width, self.height);
    _shareBtn.userInteractionEnabled = NO;
    [self addSubview:_shareBtn];
}

//给cell传上数据
- (void)passDataWithModel:(NSString *)model
{
    [_shareBtn setImage:[UIImage imageNamed:_imageDic[model]] forState:UIControlStateNormal];
}

@end


