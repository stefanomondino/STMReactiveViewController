//
//  STMTableViewModel.m
//  STMReactiveViewController
//
//  Created by Stefano Mondino on 05/06/15.
//  Copyright (c) 2015 Stefano Mondino. All rights reserved.
//

#import "STMTableViewModel.h"
#import "STMCellViewModel.h"
@implementation STMTableViewModel
- (instancetype)init {
    if (self = [super init]) {
       
        RAC(self,dataSource) = [[[[[RACSignal interval:2 onScheduler:RACScheduler.mainThreadScheduler] startWith:[NSDate date]]
                                 take:20]
                                map:^id(NSDate* value) {
                                    return [[STMCellViewModel alloc]  initWithDate:value];
                                }]
                                scanWithStart:@[] reduce:^id(id running, id next) {
                                    NSMutableArray* array = [NSMutableArray arrayWithArray:running];
                                    [array insertObject:next atIndex:0];
                                    return array;
                                }];
    }
    return self;
}
- (NSString *)cellIdentifierAtIndexPath:(NSIndexPath *)indexPath {
    return @"STMTableViewCell";
}

- (id)viewModelAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataSource[indexPath.row];
}
- (void)bindCell:(UITableViewCell*)cell toViewModelAtIndexPath:(NSIndexPath *)indexPath {
    [cell setViewModel:[self viewModelAtIndexPath:indexPath]];
}
@end
