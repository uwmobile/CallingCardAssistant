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

}

@end
