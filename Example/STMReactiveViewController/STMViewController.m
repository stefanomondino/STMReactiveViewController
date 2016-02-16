//
//  STMViewController.m
//  STMReactiveViewController
//
//  Created by Stefano Mondino on 03/05/2015.
//  Copyright (c) 2014 Stefano Mondino. All rights reserved.
//

#import "STMViewController.h"
#import <STMReactiveViewController/UIViewController+STMReactiveViewController.h>
@interface STMViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn_goto2;
@property (weak, nonatomic) IBOutlet UIButton *btn_modal;
@property (weak, nonatomic) IBOutlet UIButton *btn_alert;
@property (weak, nonatomic) IBOutlet UIButton *btn_actionsheet;

@end

@implementation STMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     @weakify(self);
    self.btn_goto2.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
         @strongify(self);
        [self performSegueWithIdentifier:@"next" parameters:@{@"detailString":@"Welcome to the second view controller! You came here with a PUSH segue"}];
        return [RACSignal return:nil];
    }];
    self.btn_modal.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self performSegueWithIdentifier:@"modal" parameters:@{@"detailString":@"Welcome to the second view controller! You came here with a MODAL segue. Parameters passed through the UINavigationController and were set on its first child. Isn't that great?"}];
        return [RACSignal return:nil];
    }];
    
    
    self.btn_alert.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [self rac_showAlertWithTitle:@"TRY ME" message:@"Choose one" cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"Title 1",@"Title 2"]] ;
    }];
    
    [[self.btn_alert.rac_command.executionSignals.flatten
      filter:^BOOL(id value) {
        return [value integerValue]> 0;
    }] subscribeNext:^(NSNumber* x) {
         @strongify(self);
        [self performSegueWithIdentifier:@"next" parameters:@{@"detailString":[NSString stringWithFormat:@"Welcome to the second view controller! You came here with a PUSH segue by clicking item number %@ in alert",x.stringValue]}];
    }];
    
    self.btn_actionsheet.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [self rac_showActionSheetWithTitle:@"TRY ME" message:@"Choose one" cancelButtonTitle:@"Cancel" otherButtonTitles:@[@"Title 1",@"Title 2"]] ;
    }];
    
    [[self.btn_actionsheet.rac_command.executionSignals.flatten
      filter:^BOOL(id value) {
          return [value integerValue]> 0;
      }] subscribeNext:^(NSNumber* x) {
          @strongify(self);
          [self performSegueWithIdentifier:@"next" parameters:@{@"detailString":[NSString stringWithFormat:@"Welcome to the second view controller! You came here with a PUSH segue by clicking item number %@ in actionsheet",x.stringValue]}];
      }];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

@end
