//
//  SearchVC.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseVC.h"

@class SearchResultVC;
@interface SearchVC : BaseVC

//模态出self的控制器的 导航控制器
@property (nonatomic, strong) UINavigationController *frontNC;

//搜索结果列表控制器
@property (nonatomic, strong) SearchResultVC *searchResultVC;

@end
