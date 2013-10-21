#import <UIKit/UIKit.h>

@interface SBAppSliderController
-(void)sliderScroller:(id)scroller itemTapped:(unsigned)tapped;
@end

%hook SBAppSliderController

-(BOOL)sliderScroller:(id)scroller isIndexRemovable:(unsigned)removable { 
	return YES;
}

-(void)_quitAppAtIndex:(unsigned)index {
	if (index == 0) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Restart SpringBoard?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Restart", nil];
    	[alert show];
    	[alert release];
	}
	else {
		%orig;
	}
}

%new
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex != 0) {
		system("killall -9 SpringBoard");
	}
	else {
		[self sliderScroller:0 itemTapped:0];
	}
}
%end
