//
//  STMReactiveViewModel.h
//  Pods
//
//  Created by Stefano Mondino on 05/06/15.
//
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NSObject+STMFormViewModel.h"
@interface UITableViewCell(STMReactiveViewModel)
@property (nonatomic,readwrite) id viewModel;
@end
@interface UICollectionViewCell(STMReactiveViewModel)
@property (nonatomic,readwrite) id viewModel;
@end

@class STMFormItemViewModel;

@interface NSObject(STMReactiveViewModel)
@property (nonatomic,readwrite) NSArray* stm_dataSource;

/** Utility to quickly retrieve all cells identifier used by viewModel's logic and to be registered in viewController's tableView. Note: works best if cellIdentifier is equal to custom cell's class*/
@property (nonatomic,readonly) NSArray* stm_allCellIdentifiers;
@property (nonatomic,readwrite) NSArray* stm_sectionedDataSource;

/** Triggered every time dataSource changes*/
@property (nonatomic,readwrite) RACSignal* stm_rac_signalForUpdates;

/** Setup viewModel class for proper observation */
- (void) stm_setupReactiveViewModel;

/** Default implementation has 1 section*/
- (NSInteger) stm_numberOfSections;
- (NSInteger) stm_numberOfItemsInSection:(NSInteger) section;

/** Create custom cell viewModels to bind to custom cells */
- (id) stm_cellViewModelFromModel:(id)model;

/** Default implementation use a RACSequence to improve performances. This means that every cell viewModel is created only once and re-assigned when a cell is displayed at the same indexPath every time after the first one. For very large dataSources made by large-consuming memory objects this could lead to potential memory leaks.It's up to you to override the default implementation and directly return cellViewModelFromModel (ignoring the RACSequence).
 */
- (id) stm_viewModelAtIndexPath:(NSIndexPath*) indexPath;
/** Creates a sequence of cell viewModels for lazy loading. Default implementations creates an array with one sequence*/
- (NSArray*) stm_viewModelsSequenceFromDataSource;
/** Retrieve correct viewModelsSequence in corresponding section**/
- (RACSequence*) stm_rac_viewModelsSequenceInSection:(NSInteger) section;

/** Use to retrieve your specific model object from dataSource and create a cell view model from it (if needed) */
- (id) stm_modelAtIndexPath:(NSIndexPath*) indexPath;


/** Custom cell identifier at index path. Use custom cell's class name if possible*/
- (NSString*) stm_cellIdentifierAtIndexPath:(NSIndexPath*) indexPath;

/** Retrieve cell viewModel and apply it to cell */
- (void) stm_bindCell:(id) cell toViewModelAtIndexPath:(NSIndexPath*) indexPath;

- (void) stm_registerCellsInTableView:(UITableView*) tableView;
- (void) stm_registerCellsInCollectionView:(UICollectionView*) collectionView;


- (UITableViewCell *)stm_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)stm_numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)stm_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section ;
- (UICollectionViewCell *)stm_collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath ;
- (NSInteger)stm_numberOfSectionsInCollectionView:(UICollectionView *)collectionView ;
- (NSInteger)stm_collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section ;
@end


/** Extend this class if you don't need your own base implementation */
@interface STMReactiveViewModel : NSObject <UITableViewDataSource,UICollectionViewDataSource>
@property (nonatomic,readwrite) NSArray* dataSource;

/** Utility to quickly retrieve all cells identifier used by viewModel's logic and to be registered in viewController's tableView. Note: works best if cellIdentifier is equal to custom cell's class*/
@property (nonatomic,readonly) NSArray* allCellIdentifiers;
@property (nonatomic,readwrite) NSArray* sectionedDataSource;

/** Triggered every time dataSource changes*/
@property (nonatomic,readwrite) RACSignal* rac_signalForUpdates;

/** Create custom cell viewModels to bind to custom cells */
- (id) cellViewModelFromModel:(id)model;

/** Default implementation use a RACSequence to improve performances. This means that every cell viewModel is created only once and re-assigned when a cell is displayed at the same indexPath every time after the first one. For very large dataSources made by large-consuming memory objects this could lead to potential memory leaks.It's up to you to override the default implementation and directly return cellViewModelFromModel (ignoring the RACSequence).
 */
- (id) viewModelAtIndexPath:(NSIndexPath*) indexPath;
/** Creates a sequence of cell viewModels for lazy loading. Default implementations creates an array with one sequence*/
- (NSArray*) viewModelsSequenceFromDataSource;
/** Retrieve correct viewModelsSequence in corresponding section**/
- (RACSequence*) rac_viewModelsSequenceInSection:(NSInteger) section;

/** Use to retrieve your specific model object from dataSource and create a cell view model from it (if needed) */
- (id) modelAtIndexPath:(NSIndexPath*) indexPath;


/** Custom cell identifier at index path. Use custom cell's class name if possible*/
- (NSString*) cellIdentifierAtIndexPath:(NSIndexPath*) indexPath;

/** Retrieve cell viewModel and apply it to cell */
- (void) bindCell:(id) cell toViewModelAtIndexPath:(NSIndexPath*) indexPath;

- (void) registerCellsInTableView:(UITableView*) tableView;
- (void) registerCellsInCollectionView:(UICollectionView*) collectionView;
@end

