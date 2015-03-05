//
//  STMViewController.m
//  STMReactiveViewController
//
//  Created by Stefano Mondino on 03/05/2015.
//  Copyright (c) 2014 Stefano Mondino. All rights reserved.
//

#import "STMViewController.h"
#import <UIViewController+STMReactiveViewController.h>
@interface STMViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn_goto2;
@property (weak, nonatomic) IBOutlet UIButton *btn_modal;
@property (weak, nonatomic) IBOutlet UIButton *btn_alert;

@end

@implementation STMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     @weakify(self);
    self.btn_goto2.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
         @strongify(self);
        [self performSegueWithIdentifier:@"next" parameters:@{@"title":@"SECOND"}];
        return [RACSignal return:nil];
    }];
    self.btn_modal.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self performSegueWithIdentifier:@"modal" parameters:@{@"title":@"modal"}];
        return [RACSignal return:nil];
    }];
    
    
    self.btn_alert.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [self rac_showActionSheetWithTitle:@"TRY ME" message:@"Choose one" cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"Title 1",@"Title 2"]] ;
    }];
    
    [self.btn_alert.rac_command.executionSignals.flatten subscribeNext:^(id x) {
         @strongify(self);
        self.title = [x stringValue];
    }];
       
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

@end
