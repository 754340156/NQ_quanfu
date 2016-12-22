//
//  Person_TFCell.h
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/18.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Person_TFCell : BaseTableViewCell

@property (nonatomic, strong) UITextField *rightTF;

- (void)configTitle:(NSString *)title tfText:(NSString *)tfText;

@end
