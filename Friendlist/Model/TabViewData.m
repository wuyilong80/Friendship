//
//  TabViewData.m
//  Friendlist
//
//  Created by Lawrence on 2022/12/25.
//

#import "TabViewData.h"

@implementation TabViewData

- (instancetype)initWithName:(NSString *)name count:(NSInteger)count isSelect:(BOOL)select {
    self = [super init];
    self.tabName = name;
    self.badgeCount = count;
    self.isSelect = select;
    return self;
}

@end
