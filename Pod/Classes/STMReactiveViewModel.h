//
//  STMReactiveViewModel.h
//  Pods
//
//  Created by Stefano Mondino on 05/06/15.
//
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@interface UITableViewCell(STMReactiveViewModel)
@property (nonatomic,readwrite) id viewModel;
@end
@interface UICollectionViewCell(STMReactiveViewModel)
@property (nonatomic,readwrite) id viewModel;
@end

@interface STMReactiveViewModel : NSObject <UITableViewDataSource,UICollectionViewDataSource>
@property (nonatomic,readwrite) NSArray* dataSource;
@property (nonatomic,readwrite) RACSignal* rac_signalForUpdates;
- (NSInteger) numberOfSections;
- (NSInteger) numberOfItemsInSection:(NSInteger) section;
- (id) viewModelAtIndexPath:(NSIndexPath*) indexPath;
- (id) modelAtIndexPath:(NSIndexPath*) indexPath;


- (NSString*) cellIdentifierAtIndexPath:(NSIndexPath*) indexPath;
- (void) bindCell:(id) cell toViewModelAtIndexPath:(NSIndexPath*) indexPath;
@end



