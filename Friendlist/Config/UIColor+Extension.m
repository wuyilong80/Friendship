//
//  UIColor+Extension.m
//  Friendlist
//
//  Created by Lawrence on 2022/12/23.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (UIColor *)mainBackgroundColor {
    return [UIColor colorWithRed:252.0/255.0 green:252.0/255.0 blue:252.0/255.0 alpha:1];
}

+ (UIColor *)buttonGradientStartColor {
    return [UIColor colorWithRed:86.0/255.0 green:179.0/255.0 blue:11.0/255.0 alpha:1];
}

+ (UIColor *)buttonGradientEndColor {
    return [UIColor colorWithRed:166.0/255.0 green:204.0/255.0 blue:66.0/255.0 alpha:1];
}

+ (UIColor *)hotPinkColor {
    return [UIColor colorWithRed:236.0/255.0 green:0.0/255.0 blue:140.0/255.0 alpha:1];
}

+ (UIColor *)textMainColor {
    return [UIColor colorWithRed:71.0/255.0 green:71.0/255.0 blue:17.0/255.0 alpha:1];
}

+ (UIColor *)textSecondColor {
    return [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
}

@end
