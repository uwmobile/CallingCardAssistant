//
//  SecondViewController.h
//  CallingCardAssistant
//
//  Created by Yuanfeng on 2012-10-13.
//  Copyright (c) 2012 UW Mobile Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface SecondViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate>
{
    IBOutlet UITextField *_calling_card_tel_number;
    IBOutlet UITextField *_pin_number;
}

- (IBAction)onChooseContactToCallClicked:(id)sender;

@end
