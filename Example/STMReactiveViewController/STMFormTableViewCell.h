//
//  STMFormTableViewCell.h
//  STMReactiveViewController
//
//  Created by Stefano Mondino on 21/09/15.
//  Copyright © 2015 Stefano Mondino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <STMReactiveViewModel.h>
@interface STMFormTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UITextField *txt_value;
@property (weak, nonatomic) STMFormItemViewModel* viewModel;
@end
