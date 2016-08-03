
#import "ViewController.h"
#import "CommentCell.h"

@import MediaPlayer;
@import MarqueeLabel;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *textCover;
@property (weak, nonatomic) IBOutlet UITextView *postField;
@property (weak, nonatomic) IBOutlet UITableView *commentsTable;
@property (strong, nonatomic) MPMediaItem* currentPlayingItem;
@end

@implementation ViewController


@synthesize currentPlayingItem;

- (void)viewDidLoad {
  [super viewDidLoad];

  [self registerForKeyboardNotifications];
  currentPlayingItem = [[MPMusicPlayerController systemMusicPlayer] nowPlayingItem];
  self.automaticallyAdjustsScrollViewInsets = YES;
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                 initWithTarget:self
                                 action:@selector(dismissKeyboard)];
  [self.view addGestureRecognizer:tap];
  
  //_textCover.translatesAutoresizingMaskIntoConstraints = YES;
}

- (void) viewWillAppear:(BOOL)animated {
  [self refreshNavigationBar];
}

-(void) refreshNavigationBar {
   //set a button if no song appear
  CGRect headerFrame = CGRectMake(0, 0, self.view.frame.size.width, 44);
  
  if (currentPlayingItem == nil) {
  
   // UIButton *playButton = [UIButton alloc] ini
  } else {
    
    UIView *wrapper = [[UIView alloc] initWithFrame:headerFrame];
    
    UIImageView *microphoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 25, 25)];
    microphoneImage.image = [UIImage imageNamed:@"microphone_icon"];
    microphoneImage.contentMode = UIViewContentModeScaleAspectFit;
    microphoneImage.center = CGPointMake(microphoneImage.center.x, 22);
    [wrapper addSubview:microphoneImage];
    
    MarqueeLabel *titleLabel = [[MarqueeLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(microphoneImage.frame) + 8, 0, self.view.frame.size.width*0.7, 44) duration:8.0 andFadeLength:10.0f];
    titleLabel.text = [NSString stringWithFormat:@"%@ - %@", currentPlayingItem.title ?: @"" , currentPlayingItem.artist?: @"" ];
    [wrapper addSubview:titleLabel];
  
    self.navigationItem.titleView = wrapper;
  }
}

//MARK: tableview datasource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   UITableViewCell *cell = nil;
  return cell;
}

// PRAGMA MARK: keyboard

-(void)dismissKeyboard {
  [_postField resignFirstResponder];
}

- (void)registerForKeyboardNotifications
{
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification object:nil];
  
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillBeHidden:)
                                               name:UIKeyboardWillHideNotification object:nil];
  
}

- (void) registerMediaLibraryChangedNotification {

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  [_postField resignFirstResponder];
}

- (void) keyboardWillShow: (NSNotification*)aNotification {
  NSDictionary* info = [aNotification userInfo];
  CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
  
  NSLog(@"textCover origin:%f", _textCover.frame.origin.y);
  
  [UIView animateWithDuration:0.3f animations:^{
    [_textCover setFrame:CGRectMake(0, self.view.frame.size.height - kbSize.height - _textCover.frame.size.height, _textCover.frame.size.width, _textCover.frame.size.height)];
  }];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
  
  [UIView animateWithDuration:0.3f animations:^{
    [_textCover setFrame:CGRectMake(0, self.view.frame.size.height, _textCover.frame.size.width, _textCover.frame.size.height)];
  }];
}

- (IBAction)writePressed:(UIButton *)sender {
  [_postField becomeFirstResponder];
}

- (IBAction)postPressed:(UIButton *)sender {
  
}

@end
