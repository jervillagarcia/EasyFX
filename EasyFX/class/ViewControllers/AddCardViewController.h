//
//  AddCardViewController.h
//  EasyFX
//
//  Created by Errol on 2/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyFXPreloader.h"
#import "UIViewControllerTextDelegate.h"

@interface AddCardViewController : UIViewControllerTextDelegate{
    EasyFXPreloader *preloadView;
    UIBarButtonItem *backItem1;
    UIBarButtonItem *backItem2;    
}

    

@end
