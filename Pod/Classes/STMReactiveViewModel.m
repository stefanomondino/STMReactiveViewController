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
@property (nonatomic,strong) NSArray* stm_viewModelsSequence;
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


- (void)setStm_sectionedDataSource:(NSArray *)stm_sectionedDataSource {
    objc_setAssociatedObject(self, @selector(stm_sectionedDataSource), stm_sectionedDataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSArray *)stm_sectionedDataSource {
   return objc_getAssociatedObject(self, @selector(stm_sectionedDataSource));
}
- (void)setStm_rac_signalForUpdates:(RACSignal *)stm_rac_signalForUpdates {
    objc_setAssociatedObject(self, @selector(stm_rac_signalForUpdates), stm_rac_signalForUpdates, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (RACSignal *)stm_rac_signalForUpdates {
    id obj = objc_getAssociatedObject(self, @selector(stm_rac_signalForUpdates));
    if (!obj) {
        obj = RACObserve(self, stm_sectionedDataSource);
        [self setStm_rac_signalForUpdates:obj];
    }
    
    return obj;
}

- (void)setStm_viewModelsSequence:(NSArray *)stm_viewModelsSequence {
    objc_setAssociatedObject(self, @selector(stm_viewModelsSequence), stm_viewModelsSequence, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSArray *)stm_viewModelsSequence {
    return objc_getAssociatedObject(self, @selector(stm_viewModelsSequence));
}
- (void) stm_setupReactiveViewModel {
    @weakify(self);
    RAC(self, stm_viewModelsSequence) = [self.stm_rac_signalForUpdates map:^id(NSArray* stm_sectionedDataSource) {
        @strongify(self);
        if (!stm_sectionedDataSource) return nil;
        return [self stm_viewModelsSequenceFromDataSource];
    }];
}


- (void)setStm_dataSource:(NSArray *)stm_dataSource {

    self.stm_sectionedDataSource = stm_dataSource?@[stm_dataSource]:nil;
}
- (NSArray *)stm_dataSource {
    return self.stm_sectionedDataSource.count == 1 ? self.stm_sectionedDataSource.firstObject : nil;
}
- (NSInteger)stm_numberOfSections {
    return self.stm_sectionedDataSource.count;
}
- (NSInteger)stm_numberOfItemsInSection:(NSInteger)section {
    return [self.stm_sectionedDataSource[section] count];
}
- (id)stm_modelAtIndexPath:(NSIndexPath *)indexPath {
    return self.stm_sectionedDataSource[indexPath.section][indexPath.row];
}
- (NSArray*) stm_viewModelsSequenceFromDataSource {
    @weakify(self);
    return [self.stm_sectionedDataSource.rac_sequence map:^id(NSArray* array) {
        return [array.rac_sequence map:^id(id model) {
            @strongify(self);
            return [self stm_cellViewModelFromModel:model];
        }];
    }].array;
    
};


- (id) stm_cellViewModelFromModel:(id)model {
    return [NSNull new];
}

- (RACSequence*) stm_rac_viewModelsSequenceInSection:(NSInteger) section {
    return self.stm_viewModelsSequence[section];
}
- (id)stm_viewModelAtIndexPath:(NSIndexPath *)indexPath {
    return [[[self stm_rac_viewModelsSequenceInSection:indexPath.section] take:indexPath.row+1].array lastObject];
}
- (NSString *)stm_cellIdentifierAtIndexPath:(NSIndexPath *)indexPath {
    return @"cellId";
}
- (NSArray *)stm_allCellIdentifiers {
    return @[@"cellId"];
}
- (void) stm_bindCell:(id) cell toViewModelAtIndexPath:(NSIndexPath*) indexPath {
    [cell setViewModel:[self stm_viewModelAtIndexPath:indexPath]];
}
- (void) stm_registerCellsInTableView:(UITableView*) tableView {
    for (NSString* cellId in self.stm_allCellIdentifiers) {
        [tableView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
    }
}

- (void) stm_registerCellsInCollectionView:(UICollectionView*) collectionView {
    for (NSString* cellId in self.stm_allCellIdentifiers) {
        [collectionView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellWithReuseIdentifier:cellId];
    }
}
#pragma mark UITableViewDataSource auto-implementations


- (UITableViewCell *)stm_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[self stm_cellIdentifierAtIndexPath:indexPath] forIndexPath:indexPath];
    [self stm_bindCell:cell toViewModelAtIndexPath:indexPath];
    return cell;
}
- (NSInteger)stm_numberOfSectionsInTableView:(UITableView *)tableView {
    return [self stm_numberOfSections];
}
- (NSInteger)stm_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self stm_numberOfItemsInSection:section];
}

#pragma mark UICollectionViewDataSource auto-implementations

- (UICollectionViewCell *)stm_collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self stm_cellIdentifierAtIndexPath:indexPath] forIndexPath:indexPath];
    [self stm_bindCell:cell toViewModelAtIndexPath:indexPath];
    return cell;
}

- (NSInteger)stm_numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self stm_numberOfSections];
}
- (NSInteger)stm_collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self stm_numberOfItemsInSection:section];
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
- (NSArray *)stm_allCellIdentifiers {
    return [self allCellIdentifiers];
}
- (NSArray *)allCellIdentifiers {
    return [super stm_allCellIdentifiers];
}
- (NSArray *)stm_dataSource {
    return self.dataSource;
}
- (NSArray *)dataSource {
    return super.stm_dataSource;
}
- (void)setStmDataSource:(NSArray *)dataSource {
    [self setDataSource:dataSource];
}
- (void)setDataSource:(NSArray *)dataSource {
    [super setStm_dataSource:dataSource];
}
- (void)setSectionedDataSource:(NSArray *)sectionedDataSource {
    [self setStm_sectionedDataSource:sectionedDataSource];
}
- (NSArray *)sectionedDataSource {
    return self.stm_sectionedDataSource;
}

- (RACSignal *)stm_rac_signalForUpdates {
    return [self rac_signalForUpdates];
}
- (RACSignal *)rac_signalForUpdates {
    return [super stm_rac_signalForUpdates];
}

- (id)stm_cellViewModelFromModel:(id)model {
    return [self cellViewModelFromModel:model];
}
- (id)cellViewModelFromModel:(id)model {
    return [super stm_cellViewModelFromModel:model];
}

- (id)stm_viewModelAtIndexPath:(NSIndexPath *)indexPath {
    return [self viewModelAtIndexPath:indexPath];
}
- (id)viewModelAtIndexPath:(NSIndexPath *)indexPath {
    return [super stm_viewModelAtIndexPath:indexPath];
}

- (id)stm_modelAtIndexPath:(NSIndexPath *)indexPath {
    return [self modelAtIndexPath:indexPath];
}
- (id)modelAtIndexPath:(NSIndexPath *)indexPath {
    return [super stm_modelAtIndexPath:indexPath];
}

- (NSArray *)viewModelsSequenceFromDataSource {
    return self.viewModelsSequenceFromDataSource;
}
- (RACSequence *)rac_viewModelsSequenceInSection:(NSInteger)section {
    return [self stm_rac_viewModelsSequenceInSection:section];
}
- (NSString *)stm_cellIdentifierAtIndexPath:(NSIndexPath *)indexPath {
    return [self cellIdentifierAtIndexPath:indexPath];
}
- (NSString *)cellIdentifierAtIndexPath:(NSIndexPath *)indexPath {
    return [super stm_cellIdentifierAtIndexPath:indexPath];
}

- (void)stm_bindCell:(id)cell toViewModelAtIndexPath:(NSIndexPath *)indexPath {
    [self bindCell:cell toViewModelAtIndexPath:indexPath];
}
- (void)bindCell:(id)cell toViewModelAtIndexPath:(NSIndexPath *)indexPath {
    [super stm_bindCell:cell toViewModelAtIndexPath:indexPath];
}
- (void)registerCellsInTableView:(UITableView *)tableView {
    [self stm_registerCellsInTableView:tableView];
}
- (void)registerCellsInCollectionView:(UICollectionView *)collectionView {
    [self stm_registerCellsInCollectionView:collectionView];
}
#pragma mark UITableViewDataSource auto-implementations

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self stm_tableView:tableView cellForRowAtIndexPath:indexPath];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self stm_numberOfSectionsInTableView:tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self stm_tableView:tableView numberOfRowsInSection:section];
}

#pragma mark UICollectionViewDataSource auto-implementations

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self stm_collectionView:collectionView cellForItemAtIndexPath:indexPath];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self stm_numberOfSectionsInCollectionView:collectionView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self stm_collectionView:collectionView numberOfItemsInSection:section];
}


@end

