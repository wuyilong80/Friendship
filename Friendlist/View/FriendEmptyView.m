//
//  FriendEmptyView.m
//  Friendlist
//
//  Created by Lawrence on 2022/12/23.
//

#import "FriendEmptyView.h"

@implementation FriendEmptyView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self test];
    }
    return self;
}

- (void)test {
    self.backgroundColor = [UIColor darkGrayColor];
}

@end
