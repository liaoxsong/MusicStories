//Pikachu

#import "ViewController.h"
#import "ViewHeader.h"
@import MediaPlayer;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *textBackground;
@property (weak, nonatomic) IBOutlet UITableView *commentsTable;
@property (weak, nonatomic) IBOutlet UITextField *postingField;
@property (strong, nonatomic) MPMediaItem* currentPlayingItem;
@end

@implementation ViewController 

@synthesize currentPlayingItem;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self postingField].delegate = self;
  
   //_postingField.frame = CGRectMake(0, 0, 100,50);
   NSLog(@"posting field frame: %@", NSStringFromCGRect([_postingField frame]));
   NSLog(@"textBackground field frame: %@", NSStringFromCGRect([_textBackground frame]));
  [self registerForKeyboardNotifications];
  currentPlayingItem = [[MPMusicPlayerController systemMusicPlayer] nowPlayingItem];
  self.automaticallyAdjustsScrollViewInsets = YES;
  
  [self setUpHeader];
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                 initWithTarget:self
                                 action:@selector(dismissKeyboard)];
  
  [self.view addGestureRecognizer:tap];
 
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
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   UITableViewCell *cell = nil;
  return cell;
}

// PRAGMA MARK: keyboard

-(void)dismissKeyboard {
  [[self postingField] resignFirstResponder];
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



- (void) keyboardWillShow: (NSNotification*) aNotification {
 // NSLog(@"keyboardWillShow");
  
  
  
}


- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
  
  [UIView animateWithDuration:1.0f animations:^ {
    // [_postingField.] = CGRectMake(0, 0, 100, 50);
    _textBackground.frame = CGRectMake(0, 556, 600, 44);
  
  }];
 // NSLog(@"keyboardWillBeHidden");
  
}
@end
