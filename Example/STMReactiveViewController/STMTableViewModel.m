//
//  STMTableViewModel.m
//  STMReactiveViewController
//
//  Created by Stefano Mondino on 05/06/15.
//  Copyright (c) 2015 Stefano Mondino. All rights reserved.
//

#import "STMTableViewModel.h"
#import "STMCellViewModel.h"
#import <LoremIpsum.h>
@implementation STMTableViewModel
- (instancetype)init {
    if (self = [super init]) {
       
        
        /*This datasource doesn't make particular sense at all, since I'm using random words as my models. In concrete use cases, your models should can be NSDictionaries, native objects, NSManagedObjects or whatever you will need. */
        NSMutableArray* array = [NSMutableArray new];
        for (NSInteger i = 1;i <1000;i++) {
            NSString* string = [LoremIpsum wordsWithNumber:3];
            [array addObject:string];
        }
        
        BOOL multisection  = YES ; /*You can change this flag at compile time to switch on/off sections in tableView*/
        if (!multisection) {
            self.dataSource = array;
        }
        else {
            self.sectionedDataSource = @[@[@"custom, not-loremipsumed word"],array];
        }
       
    }
    return self;
}
- (NSArray *)allCellIdentifiers {
    return @[@"STMTableViewCell"];
}
- (NSString *)cellIdentifierAtIndexPath:(NSIndexPath *)indexPath {
    return @"STMTableViewCell";
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section == 0?@"Highlight":@"All";
}

- (id)cellViewModelFromModel:(id)model {
    NSLog(@"%@",model);
    return [[STMCellViewModel alloc] initWithTitle:model];
}


@end
