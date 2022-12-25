//
//  Friend.m
//  Friendlist
//
//  Created by yilong wu on 2022/12/11.
//

#import "Friend.h"

@implementation Friend

- (double)getUpdateTimestamp {
    NSString *format = @"";
    if (self.updateDate.length > 8) {
        format = @"yyyy/MM/dd";
    } else if (self.updateDate.length == 8) {
        format = @"yyyyMMdd";
    } else {
        return 0.0;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    NSDate *date = [formatter dateFromString:self.updateDate];    
    NSTimeInterval interval = [date timeIntervalSince1970];
    return interval;
}

@end
