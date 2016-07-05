//
//  ViewController.m
//  MusicStories
//
//  Created by Song Liao on 6/25/16.
//  Copyright © 2016 Song. All rights reserved.
//

#import "ViewController.h"
#import "ViewHeader.h"
@import MediaPlayer;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *textBackground;

@property (weak, nonatomic) IBOutlet UITableView *commentsTable;
@property (weak, nonatomic) IBOutlet UITextField *postingField;
@property (strong, nonatomic) MPMediaItem* currentPlayingItem;
@end

@implementation ViewController 

@synthesize currentPlayingItem;

- (void)viewDidLoad {
  [super viewDidLoad];
  [self registerForKeyboardNotifications];
  currentPlayingItem = [[MPMusicPlayerController systemMusicPlayer] nowPlayingItem];
  self.automaticallyAdjustsScrollViewInsets = YES;
  
  [self setUpHeader];
 
}

-(void) setUpHeader {
  ViewHeader *header = [[self commentsTable] dequeueReusableCellWithIdentifier:@"ViewHeader" ];
  if ([currentPlayingItem artwork])
  {
    header.albumImage.image = [[currentPlayingItem artwork] imageWithSize: CGSizeMake(80, 80)];
    header.albumImage.layer.masksToBounds = YES;
    header.albumImage.layer.borderColor = [UIColor grayColor].CGColor;
    header.albumImage.layer.borderWidth = 0.4f;
  }
  
  if ([currentPlayingItem title]) {
   header.titleLabel.text = [currentPlayingItem title];
  }
  if ([currentPlayingItem artist]) {
    header.subtitleLabel.text = [currentPlayingItem artist];
  }
  self.commentsTable.tableHeaderView = header;
}


//MARK: tableview datasource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  //this is fucking obj-c;
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   UITableViewCell *cell = nil;
  return cell;
}

// PRAGMA MARK: keyboard
- (void)registerForKeyboardNotifications
{
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWasShown:)
                                               name:UIKeyboardDidShowNotification object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillBeHidden:)
                                               name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
  NSDictionary* info = [aNotification userInfo];
  CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
  UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
  NSLog(@"keyboardWasShown");
  
  //[self textBackground] contentInsetSet = contentInsets;
//  
//  UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
//  scrollView.contentInset = contentInsets;
//  scrollView.scrollIndicatorInsets = contentInsets;
//  
//  // If active text field is hidden by keyboard, scroll it so it's visible
//  // Your app might not need or want this behavior.
//  CGRect aRect = self.view.frame;
//  aRect.size.height -= kbSize.height;
//  if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
//    [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
//  }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
  UIEdgeInsets contentInsets = UIEdgeInsetsZero;
  NSLog(@"keyboardWillBeHidden");
//  scrollView.contentInset = contentInsets;
//  scrollView.scrollIndicatorInsets = contentInsets;
}
@end
