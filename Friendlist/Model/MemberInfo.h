//
//  MemberInfo.h
//  Friendlist
//
//  Created by yilong wu on 2022/12/11.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface MemberInfo : JSONModel

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *kokoid;

@end

NS_ASSUME_NONNULL_END
