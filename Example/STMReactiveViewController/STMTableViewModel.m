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
       
        NSMutableArray* array = [NSMutableArray new];
        for (NSInteger i = 1;i <1000;i++) {
            NSDate* d = [NSDate dateWithTimeIntervalSinceNow:(60*60*24*i)];
            [array addObject:d];
        }
        
        BOOL multisection  = YES ;
        if (!multisection) {
            self.dataSource = array;
        }
        else {
            self.sectionedDataSource = @[@[[NSDate date]],array];
        }
       
    }
    return self;
}

- (NSString *)cellIdentifierAtIndexPath:(NSIndexPath *)indexPath {
    return @"STMTableViewCell";
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 0?@"Today":@"Next";
}

- (id)cellViewModelFromModel:(id)model {
    NSLog(@"%@",model);
    return [[STMCellViewModel alloc] initWithDate:model];
}


@end
