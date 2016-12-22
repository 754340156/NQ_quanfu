//
//  SendCommentSuccessVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/22.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SendCommentSuccessVC.h"
#define kBackViewH 90.0f
#define kIconImageVW 100.0f

@interface SendCommentSuccessVC ()
/**  imageView */
@property(nonatomic,strong) UIImageView * iconImageV;
@end

@implementation SendCommentSuccessVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    self.view.backgroundColor = QFColor_CoodsClassMenuViewBg;
    self.iconImageV.image = ImageStr(@"jingxuan_cover");
    
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    
}

#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
    NSDictionary *parameters = @{@"":@"", @"":@""};
    WS(weakSelf)
    [self POST:self.listUrl parameters:parameters success:^(NSDictionary *dic) {
        
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}

#pragma mark - custom method


#pragma mark - handle action

#pragma mark - lazy
- (UIImageView *)iconImageV
{
    if (!_iconImageV) {
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = kWhiteColor;
        [self.view addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.offset(TopBarHeight);
            make.height.offset(Adapted(kBackViewH));
        }];
        _iconImageV = [[UIImageView alloc] init];
        [backView addSubview:_iconImageV];
        [_iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset(Adapted(kMargin));
            make.bottom.offset(Adapted(-kMargin));
            make.width.offset(Adapted(kIconImageVW));
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = String(@"感谢您的评价~");
        titleLabel.font = Font_Mid;
        [titleLabel sizeToFit];
        titleLabel.textColor = QF_BlackColor;
        [backView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.equalTo(_iconImageV.mas_right).offset(Adapted(kMargin * 2));
        }];
        
    }
    return _iconImageV;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
