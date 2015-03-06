//
//  UIViewController+STMReactiveViewController.h
//  Pods
//
//  Created by Stefano Mondino on 05/03/15.
//
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa.h>
@interface UIViewController (STMReactiveViewController)


/**
 Convenience signal for viewWillAppear calls.
 */
- (RACSignal*) rac_viewWillAppear;
/**
 Convenience signal for viewDidAppear calls.
 */
- (RACSignal*) rac_viewDidAppear;

/**
 Convenience signal that completes the first time viewWillAppear is called after subscribtion.
 @return A signal that completes after first viewWillAppear call.
 */
- (RACSignal*) rac_firstViewWillAppear;

/**
 Convenience signal that completes the first time viewDidAppear is called after subscribtion.
 @return A signal that completes after first viewDidAppear call.
 */
- (RACSignal*) rac_firstViewDidAppear;

/**
 Performs a manual segue with specified identifier and sets parameters to destination view controller as specified in dictionary. Each key in dictionary should match a property in destination view controller, which will be set to corresponding value. If destination view controller is a Navigation Controller, parameters will be set to its first child.
 @param identifier An identifier that should match a manual segue in storyboard
 @param parameters A dictionary with keys matching property names on destination view controller and values to be set on each of them before viewDidLoad.
 */
- (void) performSegueWithIdentifier:(NSString *)identifier parameters:(NSDictionary*) dictionary;

/**
 Performs a manual segue with specified identifier and sets a view model on viewModel property of destination view controller before viewDidLoad is called. If destination view controller is a Navigation Controller, view model will be set to its first child. If no viewModel property is specified, it fails silently.
 @param identifier An identifier that should match a manual segue in storyboard
 @param viewModel An arbitrary object that will be set on destination view controller's viewModel property before viewDidLoad.
 */
- (void) performSegueWithIdentifier:(NSString *)identifier viewModel:(id) viewModel;



- (RACSignal*) rac_showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray*) otherButtonTitles;
- (RACSignal*) rac_showActionSheetWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray*) otherButtonTitles;

@end