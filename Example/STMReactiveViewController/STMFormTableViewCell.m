//
//  STMFormTableViewCell.m
//  STMReactiveViewController
//
//  Created by Stefano Mondino on 21/09/15.
//  Copyright © 2015 Stefano Mondino. All rights reserved.
//

#import "STMFormTableViewCell.h"

@implementation STMFormTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    RAC(self,lbl_title.text) = RACObserve(self, viewModel.title);
     @weakify(self);
    [[RACObserve(self, viewModel.value) distinctUntilChanged] subscribeNext:^(id x) {
         @strongify(self);
        self.txt_value.text = x;
    }];
    RAC(self,viewModel.value) = [self.txt_value.rac_newTextChannel distinctUntilChanged];
}


@end
