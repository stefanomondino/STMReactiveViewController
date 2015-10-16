//
//  STMReactiveViewModel.m
//  Pods
//
//  Created by Stefano Mondino on 05/06/15.
//
//

#import "STMReactiveViewModel.h"
#import <objc/runtime.h>
@class STMFormItemViewModel;
@interface NSObject(STMReactiveViewModel_Private)
@property (nonatomic,strong) NSArray* viewModelsSequence;
@end
@implementation UITableViewCell(STMReactiveViewModel)
- (id)viewModel{return nil;}
- (void)setViewModel:(id)viewModel{;}
@end
@implementation UICollectionViewCell(STMReactiveViewModel)
- (id)viewModel{return nil;}
- (void)setViewModel:(id)viewModel{;}
@end



@implementation NSObject(STMReactiveViewModel)
;


- (void)setSectionedDataSource:(NSArray *)sectionedDataSource {
    objc_setAssociatedObject(self, @selector(sectionedDataSource), sectionedDataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSArray *)sectionedDataSource {
   return objc_getAssociatedObject(self, @selector(sectionedDataSource));
}
- (void)setRac_signalForUpdates:(RACSignal *)rac_signalForUpdates {
    objc_setAssociatedObject(self, @selector(rac_signalForUpdates), rac_signalForUpdates, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (RACSignal *)rac_signalForUpdates {
    id obj = objc_getAssociatedObject(self, @selector(rac_signalForUpdates));
    if (!obj) {
        obj = RACObserve(self, sectionedDataSource);
        [self setRac_signalForUpdates:obj];
    }
    
    return obj;
}

- (void)setViewModelsSequence:(NSArray *)viewModelsSequence {
    objc_setAssociatedObject(self, @selector(viewModelsSequence), viewModelsSequence, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSArray *)viewModelsSequence {
    return objc_getAssociatedObject(self, @selector(viewModelsSequence));
}
- (void) stm_setupReactiveViewModel {
    @weakify(self);
    RAC(self, viewModelsSequence) = [self.rac_signalForUpdates map:^id(NSArray* sectionedDataSource) {
        @strongify(self);
        if (!sectionedDataSource) return nil;
        return [self viewModelsSequenceFromDataSource];
    }];
}


- (void)setDataSource:(NSArray *)dataSource {

    self.sectionedDataSource = dataSource?@[dataSource]:nil;
}
- (NSArray *)dataSource {
    return self.sectionedDataSource.count == 1 ? self.sectionedDataSource.firstObject : nil;
}
- (NSInteger)numberOfSections {
    return self.sectionedDataSource.count;
}
- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    return [self.sectionedDataSource[section] count];
}
- (id)modelAtIndexPath:(NSIndexPath *)indexPath {
    return self.sectionedDataSource[indexPath.section][indexPath.row];
}
- (NSArray*) viewModelsSequenceFromDataSource {
    @weakify(self);
    return [self.sectionedDataSource.rac_sequence map:^id(NSArray* array) {
        return [array.rac_sequence map:^id(id model) {
            @strongify(self);
            return [self cellViewModelFromModel:model];
        }];
    }].array;
    
};


- (id) cellViewModelFromModel:(id)model {
    return [NSNull new];
}

- (RACSequence*) rac_viewModelsSequenceInSection:(NSInteger) section {
    return self.viewModelsSequence[section];
}
- (id)viewModelAtIndexPath:(NSIndexPath *)indexPath {
    return [[[self rac_viewModelsSequenceInSection:indexPath.section] take:indexPath.row+1].array lastObject];
}
- (NSString *)cellIdentifierAtIndexPath:(NSIndexPath *)indexPath {
    return @"cellId";
}
- (NSArray *)allCellIdentifiers {
    return @[@"cellId"];
}
- (void) bindCell:(id) cell toViewModelAtIndexPath:(NSIndexPath*) indexPath {
    [cell setViewModel:[self viewModelAtIndexPath:indexPath]];
}
- (void) registerCellsInTableView:(UITableView*) tableView {
    for (NSString* cellId in self.allCellIdentifiers) {
        [tableView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
    }
}

- (void) registerCellsInCollectionView:(UICollectionView*) collectionView {
    for (NSString* cellId in self.allCellIdentifiers) {
        [collectionView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellWithReuseIdentifier:cellId];
    }
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

@implementation STMReactiveViewModel
- (instancetype)init {
    if (self = [super init]) {
        [self stm_setupReactiveViewModel];
        return self;
    }
    return nil;
}
@end

