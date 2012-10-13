//
//  SecondViewController.m
//  CallingCardAssistant
//
//  Created by Yuanfeng on 2012-10-13.
//  Copyright (c) 2012 UW Mobile Club. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onChooseContactToCallClicked:(id)sender
{
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
	// place the delegate of the picker to the controller
	picker.peoplePickerDelegate = self;
    
	// showing the picker
	[self presentModalViewController:picker animated:YES];
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    if (property == kABPersonPhoneProperty) {
        ABMultiValueRef phone = ABRecordCopyValue(person, property);
        CFStringRef selectedNumber = ABMultiValueCopyValueAtIndex(phone, identifier);
        
        NSString *phoneNumber = (__bridge NSString *) selectedNumber;
        phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
        phoneNumber = [@"011" stringByAppendingString:phoneNumber];
        if (_calling_card_tel_number.text && ![_calling_card_tel_number.text isEqualToString:@""]) {
            phoneNumber = [_calling_card_tel_number.text stringByAppendingString:[NSString stringWithFormat:@",%@", phoneNumber]];
        }
        phoneNumber = [NSString stringWithFormat:@"tel://%@", phoneNumber];
        CFRelease(selectedNumber);
        
        NSLog(@"%@", phoneNumber);
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
        
        [self dismissModalViewControllerAnimated:YES];
    } else {
        //TODO Show alert view telling user to select phone number
    }
    
    return NO;
}

@end
