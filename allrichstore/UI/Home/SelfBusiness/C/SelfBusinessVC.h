//
//  SelfBusinessVC.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/4.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseVC.h"
#import "PulldownMoreView.h"  //下拉展示更多菜单

@interface SelfBusinessVC : BaseVC

@end

@interface SelfBusinessModel : NSObject<PulldownMoreModelAble, NSCoding>

@property (nonatomic, assign) long id;          //id
@property (nonatomic, copy) NSString *teName;   //名称

@end
