//
//  FriendTabView.m
//  Friendlist
//
//  Created by Lawrence on 2022/12/24.
//

#import "FriendTabView.h"

#import <Masonry/Masonry.h>

#import "UIColor+Extension.h"
#import "TabViewData.h"
#import "FriendTabCollectionViewCell.h"

@interface FriendTabView() <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) NSMutableArray <TabViewData*>*tabDataList;
@property (nonatomic) NSInteger currentSelectIndex;

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

- (void)updateTab:(NSMutableArray *)list {
    self.tabDataList = list;
    self.currentSelectIndex = 0;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tabDataList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FriendTabCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[FriendTabCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    [cell updateData:self.tabDataList[indexPath.row]];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 30, 0, 30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 36;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.tabDataList[self.currentSelectIndex].isSelect = NO;
    self.tabDataList[indexPath.row].isSelect = YES;
    self.currentSelectIndex = indexPath.row;
    [collectionView reloadData];
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

- (NSMutableArray<TabViewData *> *)tabDataList {
    if (!_tabDataList) {
        _tabDataList = [[NSMutableArray alloc] init];
    }
    return _tabDataList;
}

@end
