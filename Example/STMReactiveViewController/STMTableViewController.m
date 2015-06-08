//
//  STMTableViewController.m
//  STMReactiveViewController
//
//  Created by Stefano Mondino on 05/06/15.
//  Copyright (c) 2015 Stefano Mondino. All rights reserved.
//

#import "STMTableViewController.h"
#import "STMTableViewModel.h"
@interface STMTableViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) STMTableViewModel* viewModel;
@end

@implementation STMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     @weakify(self);
    self.viewModel = [STMTableViewModel new];
    [self.tableView registerNib:[UINib nibWithNibName:@"STMTableViewCell" bundle:nil] forCellReuseIdentifier:@"STMTableViewCell"];
    self.tableView.dataSource = self.viewModel;
    [self.viewModel.rac_signalForUpdates subscribeNext:^(id x) {
         @strongify(self);
        [self.tableView reloadData];
    }];

}

@end
