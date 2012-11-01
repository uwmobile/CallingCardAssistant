//
//  CardInfoViewController.m
//  CallingCardAssistant
//
//  Created by Yuanfeng on 2012-10-21.
//  Copyright (c) 2012 UW Mobile Club. All rights reserved.
//

#import "CardInfoViewController.h"

@interface CardInfoViewController ()

@end

@implementation CardInfoViewController
//@synthesize phoneTextField;
//@synthesize pinTextField;
bool  keyboardup = false;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    
    
    ImageView.image = [UIImage imageNamed: @"phone-card.jpeg"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *cardPhoneNumber = [defaults objectForKey:@"cardPhoneNumber"];
    NSString *cardPINNumber = [defaults objectForKey:@"cardPINNumber"];
    phoneTextField.text = cardPhoneNumber;
    pinTextField.text = cardPINNumber;
      NSLog(@"activated viewdidload");
    [super viewDidLoad];
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"Application Did Enter Background");
}

//- (void)applicationWillResignActive:(UIApplication *)application{
//     keyboardup = false;
//     NSLog(@"activated");
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

-(IBAction)backgroundTouched:(id)sender
{
   // [sender resignFirstResponder];
    [[self view] endEditing:YES];
}

- (IBAction)saveButton:(id)sender {
    NSString *cardPhoneNumber = [phoneTextField text];
    NSString *cardPINNumber  = [pinTextField text];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:cardPhoneNumber forKey:@"cardPhoneNumber"];
    [defaults setObject:cardPINNumber forKey:@"cardPINNumber"];
    [defaults synchronize];
  
}


-(IBAction)onTextEditing:(id)sender
{
 
    if(keyboardup == false){
     
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
        
        self.view.transform = CGAffineTransformTranslate(self.view.transform, 0, -175);
        [UIView commitAnimations];
        keyboardup  = true;
        
    }
    
}
-(IBAction)onTextEditingEnd:(id)sender
{
    
     //  [[self view] endEditing:YES];
    if(keyboardup == true){
     
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.5];
    
        self.view.transform = CGAffineTransformTranslate(self.view.transform, 0, 175);
        [UIView commitAnimations];
        
        keyboardup = false;
    }
   // [self.destext resignFirstResponder];
   
}

@end
