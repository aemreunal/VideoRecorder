//
//  VRViewController.h
//  VideoRecorder
//
//  Created by A. Emre Ünal on 10/07/14.
//  Copyright (c) 2014 A. Emre Ünal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>

const NSInteger MAX_RECORDING_DURATION_SECONDS = 180;
const BOOL ALLOW_EDITING = NO;

@interface VRViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSURL *videoURL;

@end
