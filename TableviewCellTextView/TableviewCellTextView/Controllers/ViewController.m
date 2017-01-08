//
//  ViewController.m
//  TableviewCellTextView
//
//  Created by stkcctv on 17/1/6.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "ViewController.h"
#import "JGCreateBusOppController.h"



@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}


- (IBAction)btnClick {
    
    JGCreateBusOppController *VC = [[JGCreateBusOppController alloc] init];
    
    [self presentViewController:VC animated:YES completion:nil];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
