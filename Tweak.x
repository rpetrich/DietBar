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
