//
//  STMDetailViewController.m
//  STMReactiveViewController
//
//  Created by Stefano Mondino on 06/03/15.
//  Copyright (c) 2015 Stefano Mondino. All rights reserved.
//

#import "STMDetailViewController.h"
#import <ReactiveCocoa.h>
@interface STMDetailViewController ()
@property (nonatomic,weak) IBOutlet UILabel* lbl_text;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btn_close;
@end

@implementation STMDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RAC(self.lbl_text,text) = RACObserve(self,detailString);
    // Do any additional setup after loading the view.
    @weakify(self);
    if (self.presentingViewController == nil) self.navigationItem.leftBarButtonItem = nil;
    self.btn_close.rac_command = [[RACCommand alloc]  initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        return [RACSignal return:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
