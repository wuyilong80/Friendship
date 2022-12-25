//
//  TabViewData.h
//  Friendlist
//
//  Created by Lawrence on 2022/12/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TabViewData : NSObject

@property (copy, nonatomic) NSString *tabName;
@property (assign, nonatomic) NSInteger badgeCount;
@property (assign, nonatomic) BOOL isSelect;

- (instancetype)initWithName:(NSString *)name count:(NSInteger)count isSelect:(BOOL)select;

@end

NS_ASSUME_NONNULL_END
