//
//  ViewController.m
//  whiteboard
//
//  Created by visvavince on 5/19/15.
//  Copyright (c) 2015 whiteboard. All rights reserved.
//

#import "MainViewController.h"
#import "ColorPanelView.h"
#import "PanelView.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MainViewController () <UIGestureRecognizerDelegate, PanelProtocol,
                                    MFMailComposeViewControllerDelegate,
                                    UIImagePickerControllerDelegate,
                                    UINavigationControllerDelegate> {
    CGFloat centerX;
    PanelView* panelView;
    CGRect start;
    BOOL ignore;
    UIColor *lastColor;
    UIImagePickerController *imagePicker;
    UIPopoverController *popover;
}
@end

@implementation MainViewController

@synthesize drawView = _drawView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // defaults
    ignore = NO;
    lastColor = [UIColor blackColor];
    
    UIScreenEdgePanGestureRecognizer *leftEdgeGesture =
        [[UIScreenEdgePanGestureRecognizer alloc]
         initWithTarget:self action:@selector(handleLeftEdgeGesture:)];
    leftEdgeGesture.edges = UIRectEdgeLeft;
    leftEdgeGesture.delegate = self;
    [self.view addGestureRecognizer:leftEdgeGesture];

    UIScreenEdgePanGestureRecognizer *rightEdgeGesture =
        [[UIScreenEdgePanGestureRecognizer alloc]
         initWithTarget:self action:@selector(handleRightEdgeGesture:)];
    rightEdgeGesture.edges = UIRectEdgeRight;
    rightEdgeGesture.delegate = self;
    [self.view addGestureRecognizer:rightEdgeGesture];
    
    centerX = self.view.bounds.size.width / 2;
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat height = rect.size.height/2;
    start = CGRectMake(-rect.size.width, height,
               rect.size.width, height);
    // shift view off screen
    
    panelView = [[PanelView alloc] initWithFrame:start];
    [panelView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:panelView];
}

- (void)dealloc {
    NSLog(@"Main View Dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleLeftEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    
    if(UIGestureRecognizerStateEnded == gesture.state) {        
        [UIView animateWithDuration:.5 animations:^{
            [panelView nextView:self];
            panelView.center = CGPointMake(centerX, panelView.center.y);

        }];
    }
}

- (void)handleRightEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    
    if(UIGestureRecognizerStateBegan == gesture.state ||
       UIGestureRecognizerStateChanged == gesture.state) {
        [UIView animateWithDuration:.5 animations:^{
            
            panelView.frame = start;
        }];
    }
}

#pragma mark - Panel Protocol

- (void) changeColor: (UIColor*)color {
    lastColor = color;
    [self.drawView setColor:color];
}

- (void) changeLineWidth: (CGFloat)width {
    [self.drawView setLineWidth:width];
}

- (void) changeAlpha: (CGFloat)alpha {
    [self.drawView setAlpha:alpha];
}

- (void) eraseMode: (BOOL)on {
    if (on) {
        [self.drawView setColor:[UIColor whiteColor]];
    } else {
        [self.drawView setColor:lastColor];
    }
}

- (void) undo {
    [self.drawView undo];
}

- (void) redo {
    [self.drawView redo];
}

- (void) screenAndEmail {
    [self emailWithImage:self.drawView.getSnapshot];
}

- (void) importImage {
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        [self presentViewController:imagePicker animated:YES completion:nil];
    else
    {
        popover=[[UIPopoverController alloc]initWithContentViewController:imagePicker];
        [popover presentPopoverFromRect:CGRectZero inView:self.view
               permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

#pragma mark - Import Image

#pragma mark - ImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    } else {
        [popover dismissPopoverAnimated:YES];
    }
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.drawView setSnapshot:image];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Utilitys

- (void) emailWithImage: (UIImage*) img {
    MFMailComposeViewController *vc = [[MFMailComposeViewController alloc] init];
    [vc setMailComposeDelegate:self];
    if([MFMailComposeViewController canSendMail]) {
        [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [vc setSubject:@"Check out my Whiteboard drawing!!!"];
        [vc setMessageBody:@"What do you think?" isHTML:NO];
        NSData *data = UIImageJPEGRepresentation(img,1);
        [vc addAttachmentData:data  mimeType:@"image/jpeg" fileName:@"whiteboard.jpg"];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

#pragma mark - Mail Delegate

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
