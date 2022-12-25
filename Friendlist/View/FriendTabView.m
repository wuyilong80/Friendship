//
//  FriendTabView.m
//  Friendlist
//
//  Created by Lawrence on 2022/12/24.
//

#import "FriendTabView.h"

#import <Masonry/Masonry.h>

#import "UIColor+Extension.h"
#import "FriendTabCollectionViewCell.h"

@interface FriendTabView() <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) UICollectionView *collectionView;

@end

@implementation FriendTabView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FriendTabCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[FriendTabCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.badgeLabel.text = @"1";
    } else {
        cell.badgeLabel.text = @"99+";
    }
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 20, 0, 20);
}

#pragma mark - Accesscors

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor mainBackgroundColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[FriendTabCollectionViewCell class] forCellWithReuseIdentifier:[FriendTabCollectionViewCell reuseIdentifier]];
    }
    return _collectionView;
}

@end
