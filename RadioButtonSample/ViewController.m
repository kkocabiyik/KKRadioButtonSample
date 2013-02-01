//
//  ViewController.m
//  RadioButtonSample
//
//  Created by Kemal Kocabiyik on 2/1/13.
//  Copyright (c) 2013 Kemal Kocabiyik. All rights reserved.
//

#import "ViewController.h"
#import "KKRadioButtonGroup.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *ar = [NSArray arrayWithObjects:@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. 1" ,@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. 2",@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. 3",@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. 4",@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. 5" , nil];
    
    KKRadioButtonGroup *group = [[KKRadioButtonGroup alloc] initWithFrame:CGRectMake(10, 10, 300, 400) items:ar selectionType:kSingleChoice];
    group.unSelectedImage = [UIImage imageNamed:@"radio_not_selected.png"];
    group.selectedImage = [UIImage imageNamed:@"radio_selected.png"];
    group.del = self;
    [self.view addSubview:group];
    
    group.extraSpace = 20;
    group.font = [UIFont fontWithName:@"Helvetica" size:20];
    group.textLeftPadding = 50;
    group.buttonTopPadding = 0;

    

    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)radioButtonGroup:(KKRadioButtonGroup *)radioButtonGroup selectedIndex:(int)index{
    
}

-(void)radioButtonGroup:(KKRadioButtonGroup *)radioButtonGroup selectedIndexes:(NSArray *)indexes{
    NSLog(@"%@" , indexes);
    
}
@end
