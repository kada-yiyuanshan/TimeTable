//
//  ViewController.m
//  SideBarNavDemo
//
//  Created by JianYe on 12-12-11.
//  Copyright (c) 2012年 JianYe. All rights reserved.
//

#import "SidebarViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface SidebarViewController ()

@end

@implementation SidebarViewController
@synthesize timeSideBarViewController,navBackView;

static SidebarViewController *rootViewCon;
const int ContentOffset=90;
const int ContentMinOffset=60;
const float MoveAnimationDuration = 0.3;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

+ (id)share
{
    return rootViewCon;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (rootViewCon) {
        rootViewCon = nil;
    }
	rootViewCon = self;
    
    sideBarShowing = NO;
    currentTranslate = 0;
    
    self.contentView.layer.shadowOffset = CGSizeMake(0, 0);
    self.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.contentView.layer.shadowOpacity = 1;
    
    TimeDateViewController *_leftCon = [[TimeDateViewController alloc] initWithNibName:@"TimeDateViewController" bundle:nil];
    _leftCon.delegate = self;
    self.timeSideBarViewController = _leftCon;

    [self addChildViewController:self.timeSideBarViewController];
    self.timeSideBarViewController.view.frame = self.navBackView.bounds;
    [self.navBackView addSubview:self.timeSideBarViewController.view];
    
    _panGestureReconginzer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panInContentView:)];
    [self.contentView addGestureRecognizer:_panGestureReconginzer];
}

- (void)contentViewAddTapGestures
{
    if (_tapGestureRecognizer) {
        [self.contentView   removeGestureRecognizer:_tapGestureRecognizer];
        _tapGestureRecognizer = nil;
    }
    
    _tapGestureRecognizer = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(tapOnContentView:)];
    [self.contentView addGestureRecognizer:_tapGestureRecognizer];
}

- (void)tapOnContentView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
}

- (void)panInContentView:(UIPanGestureRecognizer *)panGestureReconginzer
{

	if (panGestureReconginzer.state == UIGestureRecognizerStateChanged)
    {
        CGFloat translation = [panGestureReconginzer translationInView:self.contentView].x;
        UIView *view ;
        if (translation+currentTranslate>0)
        {
            if (translation+currentTranslate<=90) {
                self.contentView.transform = CGAffineTransformMakeTranslation(translation+currentTranslate, 0);
                view = self.timeSideBarViewController.view;
                [self.navBackView bringSubviewToFront:view];
            }
            
        }
        
	} else if (panGestureReconginzer.state == UIGestureRecognizerStateEnded)
    {
		currentTranslate = self.contentView.transform.tx;
        if (!sideBarShowing) {
            if (fabs(currentTranslate)<ContentMinOffset) {
                [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
            }else if(currentTranslate>ContentMinOffset)
            {
                [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
            }
        }else
        {
            if (fabs(currentTranslate)<ContentOffset-ContentMinOffset) {
                [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
            
            }else if(currentTranslate>ContentOffset-ContentMinOffset)
            {
                
                [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
                            
            }
        }
        
        
	}
    
   
}

#pragma mark - nav con delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController.viewControllers count]>1) {
        [self removepanGestureReconginzerWhileNavConPushed:YES];
    }else
    {
        [self removepanGestureReconginzerWhileNavConPushed:NO];
    }

}

- (void)removepanGestureReconginzerWhileNavConPushed:(BOOL)push
{
    if (push) {
        if (_panGestureReconginzer) {
            [self.contentView removeGestureRecognizer:_panGestureReconginzer];
            _panGestureReconginzer = nil;
        }
    }else
    {
        if (!_panGestureReconginzer) {
            _panGestureReconginzer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panInContentView:)];
            [self.contentView addGestureRecognizer:_panGestureReconginzer];
        }
    }
}
#pragma mark - side bar select delegate
- (void)leftSideBarSelectWithController:(UIViewController *)controller
{
    if ([controller isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)controller setDelegate:self];
    }
    if (_currentMainController == nil) {
		controller.view.frame = self.contentView.bounds;
		_currentMainController = controller;
		[self addChildViewController:_currentMainController];
		[self.contentView addSubview:_currentMainController.view];
		[_currentMainController didMoveToParentViewController:self];
	} else if (_currentMainController != controller && controller !=nil) {
		controller.view.frame = self.contentView.bounds;
		[_currentMainController willMoveToParentViewController:nil];
		[self addChildViewController:controller];
		self.view.userInteractionEnabled = NO;
		[self transitionFromViewController:_currentMainController
						  toViewController:controller
								  duration:0
								   options:UIViewAnimationOptionTransitionNone
								animations:^{}
								completion:^(BOOL finished){
									self.view.userInteractionEnabled = YES;
									[_currentMainController removeFromParentViewController];
									[controller didMoveToParentViewController:self];
									_currentMainController = controller;
								}
         ];
	}
    
    [self showSideBarControllerWithDirection:SideBarShowDirectionNone];
}


- (void)rightSideBarSelectWithController:(UIViewController *)controller
{
    
}
- (void)showSideBarControllerWithDirection:(SideBarShowDirection)direction
{
    
    if (direction!=SideBarShowDirectionNone) {
        UIView *view ;
        if (direction == SideBarShowDirectionLeft)
        {
            view = self.timeSideBarViewController.view;
        }
        [self.navBackView bringSubviewToFront:view];
    }
    [self moveAnimationWithDirection:direction duration:MoveAnimationDuration];
}



#pragma animation

- (void)moveAnimationWithDirection:(SideBarShowDirection)direction duration:(float)duration
{
    void (^animations)(void) = ^{
		switch (direction) {
            case SideBarShowDirectionNone:
            {
                self.contentView.transform  = CGAffineTransformMakeTranslation(0, 0);
            }
                break;
            case SideBarShowDirectionLeft:
            {
                self.contentView.transform  = CGAffineTransformMakeTranslation(ContentOffset, 0);
            }
                break;
            default:
                break;
        }
	};
    void (^complete)(BOOL) = ^(BOOL finished) {
        self.contentView.userInteractionEnabled = YES;
        self.navBackView.userInteractionEnabled = YES;
        
        if (direction == SideBarShowDirectionNone) {
           
            if (_tapGestureRecognizer) {
                [self.contentView removeGestureRecognizer:_tapGestureRecognizer];
                _tapGestureRecognizer = nil;
            }
            sideBarShowing = NO;
            
            
        }else
        {
            [self contentViewAddTapGestures];
             sideBarShowing = YES;
        }
        currentTranslate = self.contentView.transform.tx;
	};
    self.contentView.userInteractionEnabled = NO;
    self.navBackView.userInteractionEnabled = NO;
    [UIView animateWithDuration:duration animations:animations completion:complete];
}

@end
