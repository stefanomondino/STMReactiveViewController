//
//  STMReactiveViewModel.m
//  Pods
//
//  Created by Stefano Mondino on 05/06/15.
//
//

#import "STMReactiveViewModel.h"
#import <EXTScope.h>
@class STMFormItemViewModel;
@interface STMReactiveViewModel()
//@property (nonatomic,strong) RACSequence* rac_viewModelsSequence;
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

@implementation STMFormItemViewModel
@end

@implementation STMReactiveViewModel
@synthesize sectionedDataSource = _sectionedDataSource;
@synthesize rac_signalForUpdates = _rac_signalForUpdates;


- (instancetype)init {
    if (self = [super init]) {
        @weakify(self);
        RAC(self, viewModelsSequence) = [self.rac_signalForUpdates map:^id(NSArray* sectionedDataSource) {
             @strongify(self);
            if (!sectionedDataSource) return nil;
            return [self viewModelsSequenceFromDataSource];
        }];
        return self;
    }
    return nil;
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
- (RACSignal *)rac_signalForUpdates {
    if (!_rac_signalForUpdates) {
        _rac_signalForUpdates = RACObserve(self, sectionedDataSource);
    }

    return _rac_signalForUpdates;
}

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

#pragma mark Forms

- (STMFormItemViewModel*) formItemWithKeypath:(NSString* ) keypath title:(NSString*)title cellIdentifier:(NSString*) cellIdentifier {
    @weakify(self);
    STMFormItemViewModel* vm = [STMFormItemViewModel new];
    vm.title = title;
    vm.cellIdentifier = cellIdentifier;
    
    RAC(vm,value) = [[self rac_valuesForKeyPath:keypath observer:self] distinctUntilChanged];
    
    [[RACObserve(vm, value) distinctUntilChanged] subscribeNext:^(id x) {
        @strongify(self);
        [self setValue:x forKeyPath:keypath];
    }];
    RAC(vm, isValid) = [RACObserve(vm, value) map:^id(id value) {
        return @YES;
    }];
    return vm;
}



@end


