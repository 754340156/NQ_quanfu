//
//  PlaceholderTextView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/22.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "PlaceholderTextView.h"

#import "UIView+MJExtension.h"
@interface PlaceholderTextView()

@property (nonatomic,weak) UILabel *placeholderLabel;

@end
@implementation PlaceholderTextView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
        //设置一个字体大小的默认值
        self.font = [UIFont systemFontOfSize:14];
        
        //初始化占位文字的label
        UILabel *placeholderLabel = [[UILabel alloc] init];
        //设置占位label的文字颜色
        placeholderLabel.textColor = [UIColor grayColor];
        placeholderLabel.text=@"请输入备注";
        //换行
        placeholderLabel.numberOfLines = 0;
        
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        
        self.placeholderLabel.font = self.font;
        
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];
        
        
    }
    return self;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        
        //设置一个字体大小的默认值
        self.font = [UIFont systemFontOfSize:14];
        
        //初始化占位文字的label
        UILabel *placeholderLabel = [[UILabel alloc] init];
        //设置占位label的文字颜色
        placeholderLabel.textColor = QF_GrayColor;
        //换行
        placeholderLabel.numberOfLines = 0;
        
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        
        self.placeholderLabel.font = self.font;
        
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];
        
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //设置占位文字的x与y
    self.placeholderLabel.mj_x = 5;
    self.placeholderLabel.mj_y = 8;
    //设置大小
    //指定最大的宽度
    CGSize constrainedSize = CGSizeMake(self.mj_w - self.placeholderLabel.mj_x * 2, MAXFLOAT);
    self.placeholderLabel.size = [self.placeholderLabel.text sizeWithFont:self.placeholderLabel.font constrainedToSize:constrainedSize];
}
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
    
}
/**
 *  重写setFont方法,以便在设置当前TextView的时候,去设置占位文字的label字体大小
 */
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderLabel.font = font;
}

-(void)setText:(NSString *)tex{
    if (tex.length>0) {
        self.placeholderLabel.hidden=YES;
    }
    [super setText:tex];
}
- (void)textViewDidChange:(NSNotification *)noti{
    if (self.text.length == 0) {
        [self setTextColor:[UIColor blackColor]];
    }
    self.placeholderLabel.hidden = self.text.length;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
