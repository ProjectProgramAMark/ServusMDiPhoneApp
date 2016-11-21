//
//  AmslerGridViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 10/9/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "AmslerGridViewController.h"

@interface AmslerGridViewController ()

@end

@implementation AmslerGridViewController
@synthesize gridType;
@synthesize delegate;
@synthesize isEnabled;
@synthesize dataString;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Amsler Grid";
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToChose:)];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
  /* UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveGrid:)];
    
    
    self.navigationItem.rightBarButtonItem = saveButton;*/
    
    dataArray = [[NSMutableArray alloc] init];
    dataArrayFromString = [[NSMutableArray alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    dataArrayFromString = [NSMutableArray arrayWithArray:[dataString componentsSeparatedByString:@","]];
    
    if (isEnabled == true) {
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveGrid:)];
        
        
        self.navigationItem.rightBarButtonItem = saveButton;
    }
    
    [self createGrid];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackToChose:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)createGrid {
    
    containerView.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width);
    
    int boxsize = containerView.frame.size.width/20;
    
    int xtimes = 0;
    int ytimes = 0;

   // int yaddition = 0;
   // int xaddition = 0;
    [dataArray removeAllObjects];
    for (int i = 0; i < 400; i++) {
       
        int x = xtimes * boxsize;
        int y = ytimes * boxsize;
         xtimes += 1;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, boxsize, boxsize)];
        
        [containerView addSubview:button];
        
        if (isEnabled == true){
        
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    
        button.tag = i;
        
        if (xtimes == 20) {
            xtimes = 0;
            ytimes += 1;
            
        }
        
        NSString *colorType = @"0";
        
        if (dataArrayFromString.count > i) {
            colorType = [dataArrayFromString objectAtIndex:i];
        }
        
        if ([colorType intValue] == 0) {
              button.backgroundColor = [UIColor clearColor];
        } else if ([colorType intValue] == 1) {
             button.backgroundColor = [UIColor blackColor];
        }
        
         //button.backgroundColor = [UIColor clearColor];
        
        [dataArray addObject:@"0"];
        
        
        
    }
}


- (IBAction)buttonClicked:(UIButton *)sender {
    NSString *buttonType = [dataArray objectAtIndex:sender.tag];
    if ([buttonType intValue] == 0) {
        buttonType = @"1";
        sender.backgroundColor  = [UIColor blackColor];
    } else if ([buttonType intValue] == 1) {
        buttonType = @"0";
        sender.backgroundColor  = [UIColor clearColor];
    }
    
    [dataArray replaceObjectAtIndex:sender.tag withObject:buttonType];
    
    
}

- (IBAction)saveGrid:(id)sender {
    NSString *dataset = @"";
    if (dataArray.count > 0) {
        
        int count = 0;
    for (int i = 0; i < 400; i++) {
        count += 1;
        if (i == 399 ) {
            dataset = [NSString stringWithFormat:@"%@%@", dataset, [dataArray objectAtIndex:i]];
            
        } else {
            dataset = [NSString stringWithFormat:@"%@%@,", dataset, [dataArray objectAtIndex:i]];
        }
    }
        
    }
    if (gridType == 1) {
        [self.delegate rtgridassign:dataset];
    } else if (gridType == 2)  {
        [self.delegate ltgridassign:dataset];
    } else if (gridType == 3)  {
        [self.delegate rtcongridassign:dataset];
    } else if (gridType == 4)  {
        [self.delegate ltcongridassign:dataset];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
