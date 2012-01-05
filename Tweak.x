#import <UIKit/UIKit2.h>

%config(generator=internal);

%hook UINavigationBar

- (CGSize)defaultSizeForOrientation:(UIInterfaceOrientation)orientation
{
	if ([self promptView])
		return %orig;
	CGSize size;
	size.width = %orig.width;
	size.height = 32.0f;
	return size;
}

%end

%hook UIToolbar

- (CGSize)defaultSizeForOrientation:(UIInterfaceOrientation)orientation
{
	CGSize size;
	size.width = %orig.width;
	size.height = 32.0f;
	return size;
}

%end

// Twitter.app tab bar

%group Twitter

%hook ABSubTabBar

- (void)reallySetFrame:(CGRect)frame
{
	frame.size.height = 32.0f;
	%orig;
}

%end

%end

// Tweetbot tab bar

%group Tweetbot

%hook PTHCustomTabBar

- (void)setFrame:(CGRect)frame
{
	frame.size.height = 33.0f;
	%orig;
}

%end

%end

// LinkedIn open button

%group LinkedIn

%hook NavFooterView

- (void)setFrame:(CGRect)frame
{
	if (frame.origin.y == 44.0f)
		frame.origin.y = 32.0f;
	%orig;
}

%end

%end

%ctor
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	%init;
	NSString *bundleIdentifier = [NSBundle mainBundle].bundleIdentifier;
	if ([bundleIdentifier isEqualToString:@"com.atebits.Tweetie2"])
		%init(Twitter);
	else if ([bundleIdentifier isEqualToString:@"com.tapbots.Tweetbot"])
		%init(Tweetbot);
	else if ([bundleIdentifier isEqualToString:@"com.linkedin.LinkedIn"])
		%init(LinkedIn);
	[pool drain];
}