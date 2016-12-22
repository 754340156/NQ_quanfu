//
//  QBJugleManger.m
//  RQBClass
//
//  Created by apple on 15/1/12.
//  Copyright © 2015年 任强宾. All rights reserved.
//


#import "QBJugleManger.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>

@import AVFoundation;

@implementation QBJugleManger


#pragma mark - 判断手机号
//判断输入框中得文本是否为手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    //  NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
//    NSString *regex = @"^((13[0-9])|(15[012356789])|(14[678])|(17[678])|(18[0-9])|(147)[0-9])\\d{8}$";
    NSString *regex = @"^((13[0-9])|(15[0-9])|(17[0-9])|(18[0-9])|(14[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:mobileNum];
    if (!isMatch) {
        return NO;
    }
    return YES;
}

//验证邮箱
+ (BOOL)isEmailAddress:(NSString *)address;
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:address];
}

//验证身份证号
+ (BOOL)isPersonIDCardNumber:(NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {
        return NO;
    }
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
    + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

//判断字符串是否是只能精确到小数点后两位, 且不超过999999.99
+ (BOOL)isFloatPrice:(NSString *)priceStr
{
    NSString *priceRegex = @"^[1-9]\\d{0,5}.\\d{0,2}$|^[1-9]\\d{0,5}&|^[0].\\d{0,2}$";
    NSPredicate *priceTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", priceRegex];
    return [priceTest evaluateWithObject:priceStr];
}

//判断字符串是否与数组中的第几个元素相等，不相等返回999
+ (NSInteger )string:(NSString *)string haveEqualByArray:(NSArray *)array;
{
    for (NSInteger i = 0; i < array.count; i++)
    {
        if ([string isEqualToString:array[i]])
        {
            return i;
        }
    }
    return 999;
}

//判断手机是否处于静音模式
+ (BOOL)silenced
{
    CFStringRef state;
    UInt32 propertySize = sizeof(CFStringRef);
    AudioSessionInitialize(NULL, NULL, NULL, NULL);
    AudioSessionGetProperty(kAudioSessionProperty_AudioRoute, &propertySize, &state);
    if(CFStringGetLength(state) == 0)
    {
        //SILENT
        return YES;
    }
    else
    {
        //NOT SILENT
        return NO;
    }
}

#pragma mark - 系统权限
//检测相册权限
+ (BOOL)checkPhotoLibraryAuthorizationStatus
{
    //if ([ALAssetsLibrary respondsToSelector:@selector(authorizationStatus)]) {
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    if (ALAuthorizationStatusDenied == authStatus ||
        ALAuthorizationStatusRestricted == authStatus) {
        
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        [window showToastMsg:@"请在iPhone的“设置->隐私->照片”中打开本应用的访问权限"];
        return NO;
    }
    return YES;
}

//检测拍照权限
+ (BOOL)checkCameraAuthorizationStatus
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        [window showToastMsg:@"该设备不支持拍照"];
        return NO;
    }
    
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)]) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (AVAuthorizationStatusDenied == authStatus ||
            AVAuthorizationStatusRestricted == authStatus) {
            
            UIWindow *window = [UIApplication sharedApplication].delegate.window;
            [window showToastMsg:@"请在iPhone的“设置->隐私->相机”中打开本应用的访问权限"];
            return NO;
        }
    }
    return YES;
}

//检测麦克风权限，仅支持iOS7.0以上系统
+ (BOOL)checkMicAuthorizationStatus
{
    if ([[AVAudioSession sharedInstance] respondsToSelector:@selector(requestRecordPermission:)]) {
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        __block BOOL isGranted=YES;
        [[AVAudioSession sharedInstance] performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            isGranted=granted;
            dispatch_semaphore_signal(sema);
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        return isGranted;
    }
    else{
        return YES;
    }
}

@end
