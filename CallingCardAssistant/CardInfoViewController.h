//
//  CardInfoViewController.h
//  CallingCardAssistant
//
//  Created by Yuanfeng on 2012-10-21.
//  Copyright (c) 2012 UW Mobile Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardInfoViewController : UIViewController{
    IBOutlet UIImageView *ImageView;
    IBOutlet UITextField *phoneTextField;
    IBOutlet UITextField *pinTextField;
}
- (IBAction)saveButton:(id)sender;

//- (IBAction)saveButton:(id)sender;


//@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
//-(IBAction)onTextEditingEnd:(id)sender;
////- (IBAction)backgroundTouched:(id)sender;

//@property (strong, nonatomic) IBOutlet UITextField *pinTextField;
//-(IBAction)textFieldReturn:(id)pinTextField;

@end
