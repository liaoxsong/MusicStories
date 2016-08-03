
#import "ViewController.h"
#import "CommentCell.h"

@import MediaPlayer;
@import MarqueeLabel;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

//@property (weak, nonatomic) IBOutlet UIView *textCover;
//@property (weak, nonatomic) IBOutlet UITextView *postField;
@property (weak, nonatomic) IBOutlet UITableView *commentsTable;
@property (strong, nonatomic) MPMediaItem* currentPlayingItem;
@end

@implementation ViewController

@synthesize currentPlayingItem;
UIView *textCover;
UITextView *postField;

- (void)viewDidLoad {
  [super viewDidLoad];
  //set up comment field programmtically to avoid autolayout conflicts with setFrame issue
  [self setUpCommentField];
  

  [self registerForKeyboardNotifications];
  currentPlayingItem = [[MPMusicPlayerController systemMusicPlayer] nowPlayingItem];
  self.automaticallyAdjustsScrollViewInsets = YES;
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                 initWithTarget:self
                                 action:@selector(dismissKeyboard)];
  [self.view addGestureRecognizer:tap];
}

- (void) viewWillAppear:(BOOL)animated {
  [self refreshNavigationBar];
}

-(void) setUpCommentField {
  textCover = [[UIView alloc] initWithFrame: CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 110)];
  textCover.backgroundColor = [UIColor whiteColor];
  [[self view] addSubview:textCover];
  
  postField = [[UITextView alloc] initWithFrame:CGRectMake(16, 16, self.view.frame.size.width - 32, 40)];
  postField.backgroundColor = [UIColor lightGrayColor];
  [textCover addSubview:postField];
  
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
  [postField resignFirstResponder];
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
  [postField resignFirstResponder];
}

- (void) keyboardWillShow: (NSNotification*)aNotification {
  NSDictionary* info = [aNotification userInfo];
  CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
  
  //NSLog(@"textCover origin:%f", _textCover.frame.origin.y);
  
  [UIView animateWithDuration:0.3f animations:^{
    [textCover setFrame:CGRectMake(0, self.view.frame.size.height - kbSize.height - textCover.frame.size.height, textCover.frame.size.width, textCover.frame.size.height)];
  }];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
  
  [UIView animateWithDuration:0.3f animations:^{
    [textCover setFrame:CGRectMake(0, self.view.frame.size.height, textCover.frame.size.width, textCover.frame.size.height)];
  }];
}

- (IBAction)writePressed:(UIButton *)sender {
  [postField becomeFirstResponder];
}

- (IBAction)postPressed:(UIButton *)sender {
  
}

@end
