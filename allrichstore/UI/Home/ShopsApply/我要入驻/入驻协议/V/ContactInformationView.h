//
//  ContactInformationView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/28.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContactInformationViewDelegate <NSObject>
/**  下一步 */
- (void)ContactInformationViewDelegate_clickNext;
@end


@interface ContactInformationView : UIView
/**  代理*/
@property (nonatomic,weak) id <ContactInformationViewDelegate> delegate;
@end
