//
//  Friend.h
//  Friendlist
//
//  Created by yilong wu on 2022/12/11.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface Friend : JSONModel

@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger status;
@property (copy, nonatomic) NSString *isTop;
@property (copy, nonatomic) NSString *fid;
@property (copy, nonatomic) NSString *updateDate;

- (double)getUpdateTimestamp;

@end

NS_ASSUME_NONNULL_END
