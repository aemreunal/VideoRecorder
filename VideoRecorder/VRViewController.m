//
//  VRViewController.m
//  VideoRecorder
//
//  Created by A. Emre Ünal on 10/07/14.
//  Copyright (c) 2014 A. Emre Ünal. All rights reserved.
//

#import "VRViewController.h"

@interface VRViewController ()

@property(strong, nonatomic) IBOutlet UITextField *jobName;
@property(strong, nonatomic) IBOutlet UITextField *duration;

@property(nonatomic, strong) UIImagePickerController *videoPicker;

@end

@implementation VRViewController

#pragma mark - View controller methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.jobName.delegate = self;
    self.duration.delegate = self;
    [self.duration setReturnKeyType:UIReturnKeyNext];
    [self initVideoPicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.videoPicker = nil;
}


#pragma mark - Text field delegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGRect bounds = self.view.bounds;
    bounds.origin.y = 60;
    self.view.bounds = bounds;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    CGRect bounds = self.view.bounds;
    bounds.origin.y = 0;
    self.view.bounds = bounds;
}

#pragma mark - Video recorder methods

- (IBAction)recordButtonTapped:(UIButton *)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        if ([self isDurationTextValid]) {
            if (!self.videoPicker) {
                [self initVideoPicker];
            }
            [self presentViewController:self.videoPicker animated:YES completion:nil];
        } else {
            [self showDurationError];
        }
    }
}

- (void)initVideoPicker {
    self.videoPicker = [[UIImagePickerController alloc] init];
    self.videoPicker.delegate = self;
    self.videoPicker.allowsEditing = ALLOW_EDITING;
    self.videoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.videoPicker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    self.videoPicker.videoMaximumDuration = [self getRecordingDuration];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    self.videoURL = info[UIImagePickerControllerMediaURL];
    // @property videoURL is now the URL of the recorded video
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Helper methods

- (NSInteger)getRecordingDuration {
    return [self.duration.text integerValue];
}

- (BOOL)isDurationTextValid {
    NSInteger recordingDuration = [self getRecordingDuration];
    return (recordingDuration > 0 && recordingDuration <= MAX_RECORDING_DURATION_SECONDS);
}

- (void)showDurationError {
    NSString *errorMessage = [NSString stringWithFormat:@"Please enter a duration between 1 and %d.", (int) MAX_RECORDING_DURATION_SECONDS];
    UIAlertView *durationError = [[UIAlertView alloc] initWithTitle:@"Invalid Duration" message:errorMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [durationError show];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    // If returning from duration text field, jump to job name text field
    if (textField == self.duration) {
        [self.jobName becomeFirstResponder];
    }
    return YES;
}


@end
