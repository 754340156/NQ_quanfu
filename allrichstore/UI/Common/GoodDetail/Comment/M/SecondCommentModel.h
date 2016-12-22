//
//  SecondCommentModel.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/23.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"

@interface SecondCommentModel : BaseModel
/**  icon */
@property(nonatomic,copy) NSString * icon;
/**  title */
@property(nonatomic,copy) NSString * title;
/**  content */
@property(nonatomic,copy) NSString * content;
/**  time */
@property(nonatomic,copy) NSString * time;
/**  评论id */
@property(nonatomic,copy) NSString * cmid;
@end
