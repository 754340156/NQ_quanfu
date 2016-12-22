//
//  Image_Text_Ver_Cell.m
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/11.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "Image_Text_Ver_Cell.h"

#define ImageViewBackGroundColor [UIColor colorWithWhite:0.9 alpha:1.0]

#define LabelFont   [UIFont systemFontOfSize:14]
#define LabelTextColor [UIColor colorWithWhite:0.9 alpha:1.0]

#define kTopMargin      8   //上边距
#define kVerSpace       6   //图片和文字的垂直距离
#define kButtomMargin   6   //下边距

//默认：按钮是关闭用户交互

@implementation Image_Text_Ver_Cell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createViews];  //创建子视图
        [self layoutViews];  //布局子视图
    }
    return self;
}

//创建子视图
- (void)createViews
{
    self.imageView = [[UIImageView alloc] init];
    _imageView.backgroundColor = ImageViewBackGroundColor;
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.cornerRadius = _imageView.width / 2.0;
    [self addSubview:_imageView];
    
    self.label = [[UILabel alloc] init];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font =  LabelFont;
    _label.textColor = LabelTextColor;
    [self addSubview:_label];
}

- (void)layoutViews
{
    CGRect rect = [@"哈哈" boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_label.font} context:nil];
    CGSize labelSize = CGSizeMake(ceilf(rect.size.width), ceilf(rect.size.height));
    
    CGFloat label_H = labelSize.height;
    CGFloat image_W_H = self.height - kTopMargin - kVerSpace - kButtomMargin - label_H;
    
    self.imageView.frame = CGRectMake((self.width - image_W_H) / 2.0, kTopMargin, image_W_H, image_W_H);
    self.label.frame = CGRectMake(0, _imageView.bottom + kVerSpace, self.width, label_H);
}

@end
