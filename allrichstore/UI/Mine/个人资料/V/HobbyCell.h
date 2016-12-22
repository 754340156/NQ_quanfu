//
//  HobbyCell.h
//  allrichstore
//
//  Created by 任强宾 on 16/12/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "HobbyModel.h"  //爱好model

@interface HobbyCell : BaseCollectionViewCell

@property (nonatomic, strong) QButton *tagBtn;
@property (nonatomic, strong) HobbySubModel *model;

@end
