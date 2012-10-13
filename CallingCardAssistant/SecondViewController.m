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
        self.title = @"长途卡";
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

- (BOOL)isAmericanLocalAreaNumber:(NSString*)first_three_number
{
    return YES; //TODO
}

- (NSString*)append_1_to_front:(NSString*)string
{
    return [@"1" stringByAppendingString:string];
}

- (NSString*)append_01186_to_front:(NSString*)string
{
    return [@"01186" stringByAppendingString:string];
}

- (NSString*)append_011_to_front:(NSString*)string
{
    return [@"011" stringByAppendingString:string];
}

//Telephone Parser
- (NSString*)parseTelephone:(const NSString*)original
{
    NSString *string = [original copy]; //original.copy()
    
    //Strip all characteres
    string = [string stringByReplacingOccurrencesOfString:@"+" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    //Detect Length
    int length = [string length];
    switch (length) {
        case 7:
        case 8:
        {
            //TODO 1.ask user for local area number (Both China and American), such as 591, 592 (no zero at front!)
            //2. Check which country belongs to
            //3. Add 1 or 01186 to call
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入地区区号" message:@"比如10，592，519 需要地区区号才能继续拨打（比如：）" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"完成",nil];
            //Add text field
            _alert_view_text_field = [[UITextField alloc] initWithFrame:CGRectMake(30, 50, 200, 30)];
            [alert addSubview:_alert_view_text_field];
            [alert show];
        }
            break;
        case 10:
        {
            //TODO check whether it is belong to american number or china mobile phone number
            //2. if american number, plus 1 and call
            //else add 01186 and call
            NSString *first_three = [string substringToIndex:2];
            
            if ([self isAmericanLocalAreaNumber:first_three]) {
                string = [self append_1_to_front:string]; //Add 1 at front
            } else {
                string = [self append_01186_to_front:string]; //Add 01186 at front
            }
        }
            break;
        case 11:
        {
            //TODO check first number is zero or not
            NSString *first_digit = [string substringToIndex:0];
            if ([first_digit isEqualToString:@"0"]) {
                string = [string substringFromIndex:1];
                string = [self append_01186_to_front:string];
            } else {
                //TODO ask user for local area number
            }
        }
            break;
        case 12:
        {
            NSString* first_two = [string substringToIndex:1];
            if ([first_two isEqualToString:@"86"]) {
                string = [string substringFromIndex:2];
                string = [self append_011_to_front:string];
            } else {
                NSString *first_digit = [first_two substringToIndex:0];
                if ([first_digit isEqualToString:@"0"]) {
                    string = [string substringFromIndex:1]; //Get rid of first zero
                    string = [self append_01186_to_front:string];
                } else{
                    string = [self append_01186_to_front:string];
                    //TODO need user confirmation
                }
            }
        }
            break;
        case 13:
        {
            string = [self append_011_to_front:string];
        }
            break;
        default:
        {
            //TODO ask user to upload telephone number for us to debug
        }
            break;
    }
    
    return string;
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //Cancel button index is always 0
    if (buttonIndex == 0) {
        //Do nothing, don't call
    } else {
        //Get text from text field
        NSString *text = _alert_view_text_field.text;
        
    }
}
@end
