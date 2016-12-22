//
//  BannerModel.h
//  LiveTest
//
//  Created by 任强宾 on 16/8/29.
//  Copyright © 2016年 NeiQuan. All rights reserved.
//

#import "BaseModel.h"
#import "SDCycleScrollView+Extend.h"    //轮播图扩展

@interface BannerModel : BaseModel<SDCycleModelAble, NSCopying>

//图片的地址
@property (nonatomic, copy) NSString *bImgurl;
//标题
@property (nonatomic, copy) NSString *bName;
//点击banner之后的跳转的链接地址
@property (nonatomic, copy) NSString *bUrl;

@end
