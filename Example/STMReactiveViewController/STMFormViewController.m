//
//  STMFormViewController.m
//  STMReactiveViewController
//
//  Created by Stefano Mondino on 21/09/15.
//  Copyright © 2015 Stefano Mondino. All rights reserved.
//

#import "STMFormViewController.h"
#import "STMFormViewModel.h"
@interface STMFormViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) STMFormViewModel* viewModel;


@end

@implementation STMFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [STMFormViewModel new];
    self.tableView.dataSource = self.viewModel;
    for (NSString* cellId in self.viewModel.allCellIdentifiers) {
        [self.tableView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
    }
    [self.tableView reloadData];
}



@end
