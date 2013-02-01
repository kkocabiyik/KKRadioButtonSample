//
//  KKRadioButton.m
//  Rovler
//
//  Created by KEMAL KOCABIYIK on 5/21/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "KKRadioButton.h"
#import "KKRadioButtonPrefs.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(a)  ([[[UIDevice currentDevice] systemVersion] compare:a options:NSNumericSearch] != NSOrderedAscending)



@implementation KKRadioButton


@synthesize lbl_text = _lbl_text;
@synthesize btn_selection = _btn_selection;
@synthesize text = _text;
@synthesize delegate;
@synthesize selected = _selected;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}


-(id) initWithFrame:(CGRect)frame text:(NSString *) txt selectionType:(RadioButtonSelectionType) sType  textLeftPadding:(double) textPadding buttonTopPadding:(double) buttonPadding andFont:(UIFont *) font{
    
    self = [super initWithFrame:frame];
    if(self){
        
        _selectionType = sType;
      
        _text = txt;
        
        // Initialization code
        
        /* BUTTON INITIALIZATION */
        _btn_selection = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textPadding, buttonPadding)];
        [_btn_selection addTarget:self action:@selector(btn_button_selected:) forControlEvents:UIControlEventTouchUpInside];
        
        /*GET TEXT SIZE */
        CGSize constrainedSize = CGSizeMake(frame.size.width - textPadding - 5 , frame.size.height);
        
        CGSize textSize;
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
        textSize = [_text sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:NSLineBreakByWordWrapping];
        
#else
        textSize = [_text sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:UILineBreakModeWordWrap];
        

#endif
        
        
               /*WHY WE SET FRAME IN HERE IS THAT WE GET THE TEXT SIZE AND THEN CREATED A NEW FRAME FOR RADIO BUTTON IN ORDER TO SHOW LABEL COMPLETELY*/
        self.frame = CGRectMake(frame.origin.x, 0, frame.size.width, textSize.height );
       
        /*LABEL INITIALIZATION*/
        /*P.S COLORS ARE TEMPORARILY ADDED IT WAS JUST BECAUSE TO KEEP TRACK OF WHAT IS GOING ON WHILE DEBUGGING*/
        
        _lbl_text = [[UILabel alloc] initWithFrame:CGRectMake(textPadding + 5 , 0, frame.size.width -textPadding - 5  , textSize.height)];
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
       _lbl_text.lineBreakMode = NSLineBreakByWordWrapping;
#else
        _lbl_text.lineBreakMode = UILineBreakModeWordWrap;
        
#endif
        
        _lbl_text.numberOfLines = 0;
        _lbl_text.font = font;
        _lbl_text.backgroundColor = [UIColor clearColor];
        _lbl_text.userInteractionEnabled = YES;
        
        
        _lbl_text.text = self.text;
        [_lbl_text sizeToFit];
        _lbl_text.userInteractionEnabled = YES;
        
        /*ADD TAP GESTURE TO LABEL IN ORDER TO ACT AS LIKE AS BUTTON AT THE LEFT*/
        
        UITapGestureRecognizer *recognizer = [UITapGestureRecognizer new];
        [recognizer addTarget:self action:@selector(btn_button_selected:)];
        [_lbl_text addGestureRecognizer:recognizer];
        
        
        /*ADD VIEWS INTO RADIO BUTTON*/
        [self addSubview:_btn_selection];
        [self addSubview:_lbl_text];
        
        self.userInteractionEnabled = YES;
        _selected = NO;
    
    }
    
    return self;
}

-(void) deSelect{
    
    self.selected = NO;
    self.btn_selection.selected = NO;
      if(delegate != nil)
          [delegate radioButtonDidDeSelect:self];
}

-(void) select{
    
    self.selected = YES;
    _btn_selection.selected = YES;

    if(delegate != nil)
        [delegate radioButtonDidSelect:self];
    
}

#pragma mark - Button Actions

-(void)btn_button_selected:(id)sender{
    
    /* THIS CHECK IS BECAUSE MULTIPLECHOICE ITEMS CAN BE DESELECTED WHEREAS SINGLECHOICE ITEM CANNOT BE DESELECTED IF THE RADIO BUTTON IS ALREADY SELECTED */
    if(_selectionType == kSingleChoice){
        [self select];
    }else{
        
        if(self.selected)
            
            [self deSelect];
        else {
            
            [self select];
        
        }
    }
    
}



@end
