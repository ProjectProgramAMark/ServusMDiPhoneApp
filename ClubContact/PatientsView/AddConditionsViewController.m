//
//  AddConditionsViewController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 3/25/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "AddConditionsViewController.h"

@interface AddConditionsViewController ()

@end

@implementation AddConditionsViewController

@synthesize patientID;
@synthesize messageField;
@synthesize msgInPutView;
@synthesize sendChatBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    conditionTable.delegate = self;
    conditionTable.dataSource = self;
    _conditionsArray = [NSMutableArray array];
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0f/255.0f green:184.0f/255 blue:195.0f/255 alpha:1.0f];
    self.navigationController.navigationBar.translucent = false;
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBar.titleTextAttributes
    = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIBarButtonItem *notiButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    
    
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    //self.navigationItem.rightBarButtonItem = notiButtonItem;
    
    searchCondition.delegate = self;
    
    [conditionTable addLegendFooterWithRefreshingBlock:^{
        [self requestConditionsDataByPage:currentPage + 1 keyword :  searchCondition.text];
    }];
    
    [conditionTable addLegendHeaderWithRefreshingBlock:^{
        [self requestConditionsDataByPage:1 keyword :  searchCondition.text];
    }];
    
    [conditionTable registerNib:[UINib nibWithNibName:@"NewGreenTableViewCell" bundle:nil] forCellReuseIdentifier:kPatientsCellID];
    
    currentPage = 0;
    
    self.title = @"SELECT CONDITIONS";
    
    //if (IS_IPHONE) {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
            [self setEdgesForExtendedLayout:UIRectEdgeNone];
        
      //  searchCondition.frame = CGRectMake(0, 0, searchCondition.frame.size.width, searchCondition.frame.size.height);
       // conditionTable.frame =CGRectMake(0, searchCondition.frame.size.height, windowWidth,self.view.frame.size.height - 50);
    //}
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardDidShow:)
                   name:UIKeyboardWillChangeFrameNotification object:nil];

    
}



- (void)keyboardDidShow:(NSNotification *)notification
{
    // keyboard frame is in window coordinates
    NSDictionary *userInfo = [notification userInfo];
    keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // convert own frame to window coordinates, frame is in superview's coordinates
    CGRect ownFrame = [self.view.window convertRect:self.view.frame fromView:self.view.superview];
    
    // calculate the area of own frame that is covered by keyboard
    CGRect coveredFrame = CGRectIntersection(ownFrame, keyboardFrame);
    
    // now this might be rotated, so convert it back
    coveredFrame = [self.view.window convertRect:coveredFrame toView:self.view.superview];
    
    // set inset to make up for covered array at bottom
    //  self.contentInset = UIEdgeInsetsMake(0, 0, coveredFrame.size.height, 0);
    //self.scrollIndicatorInsets = self.contentInset;
    
    if (IS_IPHONE) {
    offSetKeyboard = keyboardFrame.size.height;
    int commentOffset = (self.view.frame.size.height - 50) - offSetKeyboard;
    
    if (isOffSet == true) {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^
         {
             //  commentContainerView.frame = CGRectMake(0, (windowHeight - 42) - offSetKeyboard, commentContainerView.frame.size.width, commentContainerView.frame.size.height);
             if ([messageField isFirstResponder]) {
                 [self.view bringSubviewToFront:self.msgInPutView];
                 
                 
                 self.msgInPutView.frame = CGRectMake(0, commentOffset, self.msgInPutView.frame.size.width, self.msgInPutView.frame.size.height);
                 
             }
             
         }     completion:^(BOOL finished)
         {
         }];
        
    }
        
    }
}




- (IBAction)cancelConditions:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    if ([self.conditionsArray count] == 0)
    {
        [self requestConditionsDataByPage:1 keyword:searchCondition.text];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.view endEditing:true];
}


- (void)requestConditionsDataByPage:(int)page keyword:(NSString *)keyword
{
    [[AppController sharedInstance] getAllConditionByPage:[NSString stringWithFormat:@"%d", page] keyword:keyword WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        if (success)
        {
            currentPage = page;
            if(currentPage == 1)
            {
                [_conditionsArray removeAllObjects];
            }
            [_conditionsArray addObjectsFromArray:conditions];
            [conditionTable reloadData];
        }
        
        [conditionTable.footer endRefreshing];
        [conditionTable.header endRefreshing];
    }];
}

- (void)addCondtionToDB:(Condition *)condi
{
    [SVProgressHUD showWithStatus:@"Adding..."];
    [[AppController sharedInstance] addConditionToPatient:patientID conditionname:condi.conditionName conditioncode:condi.conditionCode WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        [SVProgressHUD dismiss];
        if (success)
        {
           // [self.delegate refreshPationInfo];
            [self.navigationController popViewControllerAnimated:true];
        }
       // [conditionTable.footer endRefreshing];
       // [conditionTable.header endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}

#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

        return [_conditionsArray count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewGreenTableViewCell *cell = (NewGreenTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kPatientsCellID];
    
    Condition *patientInfo = [_conditionsArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", patientInfo.conditionName];
    cell.nameLabel.numberOfLines = 0;
    cell.imgView.image = [UIImage imageNamed:@"virus9"];
    cell.arrowRightIMG.hidden = true;
    
    
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   

    Condition *patientInfo = [_conditionsArray objectAtIndex:indexPath.row];
    
     [Flurry logEvent:@"ConditionAdd" withParameters:[NSDictionary dictionaryWithObject:patientInfo.conditionName forKey:@"searchKey"]];
    
    [self addCondtionToDB:patientInfo];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UISearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self requestConditionsDataByPage:1 keyword : searchCondition.text];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
  [self requestConditionsDataByPage:1 keyword : searchText];
}





- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
     if (IS_IPHONE) {
    isOffSet = true;
         
     }
    
    return  true;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
     if (IS_IPHONE) {
    isOffSet = true;
         
     }
    
    
    
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if (IS_IPHONE) {
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         if (isOffSet == true) {
             
             
             isOffSet = false;
             
             self.msgInPutView.frame=CGRectMake(0,self.view.frame.size.height-(50),  self.view.frame.size.width, 50);
         }
         
         
     }
     
                     completion:^(BOOL finished)
     {
     }];
        
    }
    
    
    return true;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
     if (IS_IPHONE) {
    isOffSet = false;
         
     }
    
    
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (IBAction)sendMessageNow:(id)sender {
    if (messageField.text.length > 0) {
        
      /*  [SVProgressHUD showWithStatus:@"Adding..."];
        [[AppController sharedInstance] addConditionToPMaster:@"" conditionname:messageField.text conditioncode:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
            if (success) {
                
                [self loadAddedConditions];
            }
        }];*/
        [SVProgressHUD showWithStatus:@"Adding..."];
        [[AppController sharedInstance] addConditionToPatient:patientID conditionname:messageField.text conditioncode:@"" WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
            [SVProgressHUD dismiss];
            if (success)
            {
                
                //[self.delegate refreshPationInfo];
                [self.navigationController popViewControllerAnimated:true];
            }
            // [conditionTable.footer endRefreshing];
            // [conditionTable.header endRefreshing];
        }];
        
        messageField.text = @"";
        
    }
}



@end
