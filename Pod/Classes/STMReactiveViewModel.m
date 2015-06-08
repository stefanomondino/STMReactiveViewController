//
//  STMReactiveViewModel.m
//  Pods
//
//  Created by Stefano Mondino on 05/06/15.
//
//

#import "STMReactiveViewModel.h"

@interface STMReactiveViewModel()
@end
@implementation UITableViewCell(STMReactiveViewModel)
- (id)viewModel{return nil;}
- (void)setViewModel:(id)viewModel{;}
@end
@implementation UICollectionViewCell(STMReactiveViewModel)
- (id)viewModel{return nil;}
- (void)setViewModel:(id)viewModel{;}
@end

@implementation STMReactiveViewModel
@synthesize dataSource = _dataSource;
@synthesize rac_signalForUpdates = _rac_signalForUpdates;

- (RACSignal *)rac_signalForUpdates {
    if (!_rac_signalForUpdates) {
        _rac_signalForUpdates = RACObserve(self, dataSource);
    }
    return _rac_signalForUpdates;
}
- (NSInteger)numberOfSections {
    return 1;
}
- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource count];
}
- (id)modelAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataSource[indexPath.row];
}
- (id)viewModelAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
- (NSString *)cellIdentifierAtIndexPath:(NSIndexPath *)indexPath {
    return @"";
}
- (void) bindCell:(id) cell toViewModelAtIndexPath:(NSIndexPath*) indexPath {
    return;
}
#pragma mark UITableViewDataSource auto-implementations


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifierAtIndexPath:indexPath] forIndexPath:indexPath];
    [self bindCell:cell toViewModelAtIndexPath:indexPath];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self numberOfSections];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfItemsInSection:section];
}

#pragma mark UICollectionViewDataSource auto-implementations

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self cellIdentifierAtIndexPath:indexPath] forIndexPath:indexPath];
    [self bindCell:cell toViewModelAtIndexPath:indexPath];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self numberOfSections];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self numberOfItemsInSection:section];
}


@end
