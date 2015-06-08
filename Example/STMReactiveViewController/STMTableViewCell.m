//
//  STMTableViewCell.m
//  STMReactiveViewController
//
//  Created by Stefano Mondino on 08/06/15.
//  Copyright (c) 2015 Stefano Mondino. All rights reserved.
//

#import "STMTableViewCell.h"


@implementation STMTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
     @weakify(self);
    [RACObserve(self, viewModel) subscribeNext:^(STMCellViewModel* viewModel) {
         @strongify(self);
        self.lbl_text.text = self.viewModel.title;
    }];
}


@end
