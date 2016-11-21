//
//  NoteNewsViewController.h
//  ClubContact
//
//  Created by Kalana Jayatilake on 1/1/16.
//  Copyright © 2016 askpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NewGreenTableViewCell.h"
#import "FreeDrawingViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "IQAudioRecorderController.h"
#import "PatientsTableViewCell.h"
#import "NoteTableViewCell.h"
#import <MediaPlayer/MediaPlayer.h>

@interface NoteNewsViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate,MPMediaPickerControllerDelegate, IQAudioRecorderControllerDelegate, SWTableViewCellDelegate, UIAlertViewDelegate> {
    IBOutlet UIView *menuButton;
    IBOutlet UIView *notificationButton;
    
    IBOutlet UIImageView *profileIMGView2;
    
    IBOutlet UILabel *nameLabel2;
    IBOutlet UILabel *jobLabel2;
    
    BOOL isNoteUpdate;
    
    Note *noteToUpdate;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Patient *patient;
@property (nonatomic) BOOL isSharedProfile;

@end
