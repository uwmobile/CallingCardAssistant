//
//  _ViewController.m
//  dial
//
//  Created by Irene on 13/10/12.
//  Copyright (c) 2012 Irene. All rights reserved.
//

#import "DialViewController.h"

@interface DialViewController ()

@end

@implementation DialViewController

@synthesize display=_display;
- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit =[sender currentTitle];
    self.display.text=[self.display.text stringByAppendingFormat:digit];
    //TODO if length == 0, what to do?
    


}

- (IBAction)delete:(UIButton *)sender {
    NSString *string = self.display.text;
    NSInteger len = [string length];
               
    if ([string isEqualToString:@""])
    {
        string =self.display.text;
        
    }else{
        string =[string substringToIndex:len-1];
    }
    self.display.text=string;
}



- (IBAction)call:(UIButton *)sender {

    NSString *string =self.display.text;
  
    NSURL *call= [NSURL URLWithString:[@"tel:" stringByAppendingString:string ]];
                     
        [[UIApplication sharedApplication] openURL:call];
   
}




@end
