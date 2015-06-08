//
//  STMTableViewCell.h
//  STMReactiveViewController
//
//  Created by Stefano Mondino on 08/06/15.
//  Copyright (c) 2015 Stefano Mondino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STMCellViewModel.h"
@interface STMTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_text;
@property (nonatomic,strong) STMCellViewModel* viewModel;
@end
