//
//  PharmacySelectController.m
//  ClubContact
//
//  Created by Kalana Jayatilake on 5/14/15.
//  Copyright (c) 2015 askpi. All rights reserved.
//

#import "PharmacySelectController.h"

@interface PharmacySelectController ()

@end

@implementation PharmacySelectController

@synthesize delegate;
@synthesize pharmacyClient;
@synthesize locationManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    conditionTable.delegate = self;
    conditionTable.dataSource = self;
    _conditionsArray = [NSMutableArray array];
    _addedConditionsArray = [NSMutableArray array];
    
    /*UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
     target:self
     action:@selector(cancelPrescription)];
     self.navigationItem.leftBarButtonItem = cancelButton;*/
    
    isNotLoaded = false;
    
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
    
    self.pharmacyClient = [[SearchPharmacyAPIClient alloc] init];
    
    
    searchCondition.delegate = self;
    
  //  [conditionTable addLegendFooterWithRefreshingBlock:^{
   //     [self requestConditionsDataByPage:currentPage + 1 keyword :  searchCondition.text];
   // }];
    
    [conditionTable addLegendHeaderWithRefreshingBlock:^{
        [self requestConditionsDataByPage:1 keyword :  searchCondition.text];
    }];
    
         [conditionTable registerNib:[UINib nibWithNibName:@"PharmacyTableViewCell" bundle:nil] forCellReuseIdentifier:kPatientsCellID];
    currentPage = 0;
    
    self.title = @"SELECT PHARMACY";
    
    searchCondition.delegate = self;
    
    searchCondition.placeholder = @"Search Pharmacy By Location";
    
    //if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
    //} else {
     //   NSLog(@"Location services are not enabled");
   // }k

   // if (IS_IPHONE) {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
            [self setEdgesForExtendedLayout:UIRectEdgeNone];
        
   // }
    
    
}

- (IBAction)goBackToChose:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.conditionsArray count] == 0)
    {
        //[self requestConditionsDataByPage:1 keyword:searchCondition.text];
    }
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
  
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [self.locationManager requestWhenInUseAuthorization];
    
      [self.locationManager startUpdatingLocation];
    if ([CLLocationManager locationServicesEnabled]) {
        
    } else {
        
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.locationManager stopUpdatingLocation];
    [self.view endEditing:true];
}


- (void)cancelPrescription {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)goToDrugs {
   
}

- (void)requestConditionsDataByPage:(int)page keyword:(NSString *)keyword
{
    
   DeviceInfo *device = [DeviceInfo getFromUserDefault];
    
    if (keyword.length == 0) {
        keyword = [NSString stringWithFormat:@"Pharmacy in %@", device.city];
    } else {
        keyword = [NSString stringWithFormat:@"Pharmacy in %@", keyword];
    }
        
        
    
    keyword = [keyword stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    /*[[AppController sharedInstance] getSearchPharmacy:[NSString stringWithFormat:@"in %@", keyword] WithCompletion:^(BOOL success, NSString *message, NSMutableArray *conditions) {
        
     
     if (success)
     {
         
         [_conditionsArray removeAllObjects];
         [_conditionsArray addObjectsFromArray:conditions];
           [conditionTable reloadData];
         
     [conditionTable.footer endRefreshing];
     [conditionTable.header endRefreshing];
         
     }
     }];*/
    
    [self.pharmacyClient searchForPharmacy:keyword completion:^(NSArray *results, NSError *error) {
        _conditionsArray = [NSMutableArray array];
        _conditionsArray  = [results copy];
        [conditionTable reloadData];
        
        [conditionTable.footer endRefreshing];
        [conditionTable.header endRefreshing];
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


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
   
      
        return @"All Pharmacies";

    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_addedConditionsArray.count > 0) {
        if (indexPath.section == 0) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        PharmacyTableViewCell  *cell = (PharmacyTableViewCell  *)[tableView dequeueReusableCellWithIdentifier:kPatientsCellID];
   
    
        Pharmacy *patientInfo = [_conditionsArray objectAtIndex:indexPath.row];
        //cell.pharmacy = patientInfo;
    
    

        cell.nameLabel.text = patientInfo.pharmName;
        cell.addressLabel.text = patientInfo.address;
        
       // cell.nameLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
       // cell.addressLabel.textColor = [UIColor colorWithRed:214.0f/255.0f green:108.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
    cell.nameLabel.textColor = [UIColor blackColor];
    cell.addressLabel.textColor = [UIColor blackColor];
        cell.cellImageView.image = [UIImage imageNamed:@"pharmacy9"];
  
    
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /* Patient *patientInfo = [_patientsArray objectAtIndex:indexPath.row];
     UIStoryboard *sb = [UIStoryboard storyboardWithName:@"iPad" bundle:nil];
     PatientDetailViewController *vc = (PatientDetailViewController *)[sb instantiateViewControllerWithIdentifier:@"PatientDetailViewController"];
     vc.patient = patientInfo;
     
     [self.navigationController pushViewController:vc animated:YES];*/
   /* if (_addedConditionsArray.count > 0) {
        if (indexPath.section == 1) {
            [_addedConditionsArray addObject:[_conditionsArray objectAtIndex:indexPath.row]];
        }
        
    } else {
        if (indexPath.section == 0) {
            [_addedConditionsArray addObject:[_conditionsArray objectAtIndex:indexPath.row]];
        }
    }
    
    [conditionTable reloadData];*/
    
    Pharmacy *patientInfo = [_conditionsArray objectAtIndex:indexPath.row];
    
    [self.delegate pharmacySelected:patientInfo];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    // Get the managedObjectContext from the AppDelegate (for use in CoreData Applications)
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        if (_addedConditionsArray.count > 0) {
            if (indexPath.section == 0) {
                [_addedConditionsArray removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
            
        }
        
    }
    
    
}


#pragma mark - UISearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self requestConditionsDataByPage:1 keyword : searchCondition.text];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:true];
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText  {
   // [self requestConditionsDataByPage:1 keyword : searchText];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
  location = [locations lastObject];
   // self.latitudeValue.text = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
   // self.longtitudeValue.text = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    
    CLGeocoder *reverseGeocoder = [[CLGeocoder alloc] init];
    
    [reverseGeocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
       
         if (error){
             //DDLogError(@"Geocode failed with error: %@", error);
             return;
         }
         
         //DDLogVerbose(@"Received placemarks: %@", placemarks);
         
         
         CLPlacemark *myPlacemark = [placemarks objectAtIndex:0];
         NSString *countryCode = myPlacemark.ISOcountryCode;
         cityText = myPlacemark.locality;
         countryText = myPlacemark.country;
         NSString *subCityText = myPlacemark.thoroughfare;
         
        
         
         if (isNotLoaded == false) {
             if ([self.conditionsArray count] == 0)
             {
                 searchCondition.text = [NSString stringWithFormat:@"%@ %@ %@", subCityText, cityText, countryText];
                 isNotLoaded = true;
                 [self requestConditionsDataByPage:1 keyword:searchCondition.text];
             }

         }
         
     }];
    
}

@end
