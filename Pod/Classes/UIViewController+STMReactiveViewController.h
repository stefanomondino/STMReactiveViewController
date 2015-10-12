//
//  UIViewController+STMReactiveViewController.h
//  Pods
//
//  Created by Stefano Mondino on 05/03/15.
//
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface NSError (STMReactiveViewController)
+ (NSError*) stm_errorWithMessage:(NSString*) message;
- (NSString*) stm_message;
@end

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
 Convenience signal for viewWillDisappear calls.
 */
- (RACSignal*) rac_viewWillDisappear;

/**
 Convenience signal for viewDidDisappear calls.
 */
- (RACSignal*) rac_viewDidDisappear;

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

//TODO write documentation
/**
Automatically creates an appropriate UIAlertView/UIAlertController (based upon system version), presents it and sends clicked button index as next. Alert presentation will happen lazily upon signal subscription.
 Subclasses may completely rewrite implementation to be able to show custom modal UI with custom views that share similar behavior with UIAlertView (a view that present multiple choice to end user) and use choices in a chain of operations.
 @param title The alert's title
 @param message The alert's message
 @param cancelButtonTitle A title for cancel button
 @params otherButtonTitles An array for additional (optional) titles for other buttons
 @return A signal that will present an appropriate UIAlert/UIAlertController upon subscription, will send clicked button index once and then complete. Cancel button index is 0.
 */
- (RACSignal*) rac_showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray*) otherButtonTitles;

/**
 Automatically creates an appropriate UIActionSheet/UIAlertController (based upon system version), presents it and sends clicked button index as next. Action sheet presentation will happen lazily upon signal subscription.
 Subclasses may completely rewrite implementation to be able to show custom modal UI with custom views that share similar behavior with UIActionSheet (a view that present multiple choice to end user) and use choices in a chain of operations.
 @param title The actionSheet's title
 @param message The actionSheet's message
 @param cancelButtonTitle A title for cancel button
 @params otherButtonTitles An array for additional (UIActionSheet/UIAlertController upon subscription, will send clicked button index once and then complete. Cancel button index is 0.
 */
- (RACSignal*) rac_showActionSheetWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray*) otherButtonTitles;



- (RACSignal*) rac_showErrorsFromCommand:(RACCommand*) command;
- (RACSignal*) rac_showLoaderFromCommand:(RACCommand*) command;
- (RACSignal*) rac_errorSignalWithMessage:(NSString*)message;
- (UIView*) stm_showLoader;
- (void) stm_hideLoader;

@end
