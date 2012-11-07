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
    [super viewDidLoad];
    
    _imageView.image = [UIImage imageNamed: @"phone-card.jpeg"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *cardPhoneNumber = [defaults objectForKey:@"cardPhoneNumber"];
    NSString *cardPINNumber = [defaults objectForKey:@"cardPINNumber"];
    _phoneTextField.text = cardPhoneNumber;
    _pinTextField.text = cardPINNumber;
    NSLog(@"activated viewdidload");
}

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
    NSString *cardPhoneNumber = [_phoneTextField text];
    NSString *cardPINNumber  = [_pinTextField text];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:cardPhoneNumber forKey:@"cardPhoneNumber"];
    [defaults setObject:cardPINNumber forKey:@"cardPINNumber"];
    [defaults synchronize];
    //TODO show a message
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

#pragma mark - UITableView Datasource
- (int)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2; //One fo phone card image, one for input fields
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return 2;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //return the phone card cell
    } else {
        if (indexPath.row == 0) {
            //return number cell
        } else {
            //return the pin cell
        }
    }
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Card Info";
    } else {
        return nil;
    }
}
@end

