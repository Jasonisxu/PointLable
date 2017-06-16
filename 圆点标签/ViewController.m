//
//  ViewController.m
//  圆点标签
//
//  Created by Wicrenet_Jason on 2017/6/16.
//  Copyright © 2017年 Wicrenet_Jason. All rights reserved.
//

#import "ViewController.h"
#import "TaggedImageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)addNextControllerAction:(id)sender {
    [self.navigationController pushViewController:[TaggedImageViewController new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
