//
//  STMFormViewModel.m
//  STMReactiveViewController
//
//  Created by Stefano Mondino on 21/09/15.
//  Copyright © 2015 Stefano Mondino. All rights reserved.
//

#import "STMFormViewModel.h"

@implementation STMFormViewModel
- (instancetype)init {
    self = [super init];
     @weakify(self);
    NSMutableArray* array = [NSMutableArray new];
    [array addObject:[self formItemWithKeypath:@"firstName" title:@"First Name" cellIdentifier:@"STMFormTableViewCell"]];
    [array addObject:[self formItemWithKeypath:@"lastName" title:@"Last Name" cellIdentifier:@"STMFormTableViewCell"]];
    
    
    self.dataSource = array;
    
    [RACObserve(self, firstName).logNext subscribeCompleted:^{
        
    }];
    [[RACSignal interval:5 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
         @strongify(self);
        self.firstName = @"TIMER!";
    }];
    return self;
}
- (NSString *)cellIdentifierAtIndexPath:(NSIndexPath *)indexPath {
    return [[self viewModelAtIndexPath:indexPath] cellIdentifier];
}
- (NSArray *)allCellIdentifiers {
    return @[@"STMFormTableViewCell"];
}
- (id)cellViewModelFromModel:(id)model {
    return model;
}
@end
