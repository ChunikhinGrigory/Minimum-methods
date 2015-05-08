//Чунихин Григорий ФТ-20
//

#import "AppDelegate.h"

@interface AppDelegate ()
// Generals constants
@property (strong) IBOutlet NSTextField *leftBorder;
@property (strong) IBOutlet NSTextField *rightBorder;
@property (strong) IBOutlet NSTextField *delta;
@property (strong) IBOutlet NSTextField *functionField;
@property (strong) IBOutlet NSTextField *resultLabel;

- (IBAction)startButton:(id)sender;
- (IBAction)cleaningButton:(id)sender;
// 4 interval method
@property (strong) IBOutlet NSButton *onOff4interval;
@property (strong) IBOutlet NSTextField *label4interval;
@property (strong) IBOutlet NSTextView *result4interval;
@property (strong) IBOutlet NSScrollView *scrollView4;

- (IBAction)enabled4interval:(id)sender;

// 3 interval method
@property (strong) IBOutlet NSButton *onOff3interval;
@property (strong) IBOutlet NSTextField *label3interval;
@property (strong) IBOutlet NSTextView *result3interval;
@property (strong) IBOutlet NSScrollView *scrollView3;


- (IBAction)enabled3interval:(id)sender;

// Golden section
@property (strong) IBOutlet NSButton *onOffGoldenSectionButton;
@property (strong) IBOutlet NSTextField *goldenSectionLabel;
@property (strong) IBOutlet NSScrollView *goldenSectionScrollView;
@property (strong) IBOutlet NSTextView *resultGoldenSection;

- (IBAction)enabledGoldenSection:(id)sender;


@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

int functionCounter = 0;
int count = 0;
#pragma mark - input function

double Function (double x) {
    
    //Enter your function there
    double newFunction = pow(x - 3, 2) + 2;
    functionCounter++;
    return newFunction;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSNumberFormatter *NumberFormatter = [[NSNumberFormatter alloc]init];
    [NumberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [self.leftBorder setFormatter:NumberFormatter];
    [self.rightBorder setFormatter:NumberFormatter];
    
    NSNumberFormatter *deltaNumberFormatter = [[NSNumberFormatter alloc]init];
    [deltaNumberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [deltaNumberFormatter setMaximumFractionDigits:8];
    [self.delta setFormatter:deltaNumberFormatter];
}
- (void)applicationWillTerminate:(NSNotification *)aNotification {
}
#pragma mark - IB Action
// Enable/disable methods

- (IBAction)enabled4interval:(id)sender {
    if (self.onOff4interval.state == YES ) {
        self.label4interval.hidden = NO;
        self.scrollView4.hidden = NO;

    } else {
        self.label4interval.hidden = YES;
        self.scrollView4.hidden = YES;

    }
}

- (IBAction)enabled3interval:(id)sender {
    if (self.onOff3interval.state == YES) {
        self.label3interval.hidden = NO;
        self.scrollView3.hidden = NO;
    } else {
        self.label3interval.hidden = YES;
        self.scrollView3.hidden = YES;
    }
}

- (IBAction)enabledGoldenSection:(id)sender {
    if (self.onOffGoldenSectionButton.state == YES) {
        self.goldenSectionLabel.hidden = NO;
        self.goldenSectionScrollView.hidden = NO;
    } else {
        self.goldenSectionLabel.hidden = YES;
        self.goldenSectionScrollView.hidden = YES;
    }
}

#pragma mark - Start button
- (IBAction)startButton:(id)sender {
    int c[3],k = 3;
    // Считываем границы и погрешность
    double delta0 = self.delta.doubleValue;
    float A = self.leftBorder.floatValue, B = self.rightBorder.floatValue;
    //Проверяем условия введенных данных
    if (delta0 > 0 && delta0 < (B-A)/2) {
        
        // 4 intervals method
#pragma mark - 4 interval method
        if (self.onOff4interval.state == YES) {
            
            float leftBorder = A, rightBorder = B;
            double delta=0, xMin = 0,minFunction = 0,x[3], someFunction[3];
            
            delta = (rightBorder - leftBorder)/4;
            int i = 0;
            for (i = 0; i < 3; i++) {
                
                x[i] = leftBorder + (i+1)* delta;
                someFunction[i] = Function(x[i]);
            }
            
            while (delta0 < 2 * delta ) {
                count++; // iteration counter
                
                if (someFunction[0]<someFunction[1]) {
                    minFunction = someFunction[0];
                    xMin = x[0];
                    rightBorder = x[1];
                    x[1] = x[0];
                    someFunction [1] = someFunction[0];
                    delta = (rightBorder - leftBorder)/4;
                    x[0] = leftBorder + delta;
                    x[2] = leftBorder + 3*delta;
                    someFunction[0] = Function(x[0]);
                    someFunction[2] = Function(x[2]);
                } else {
                    if (someFunction[1]<someFunction[2]) {
                        minFunction = someFunction[1];
                        xMin = x[1];
                        leftBorder = x[0];
                        rightBorder = x[2];
                        delta = (rightBorder - leftBorder)/4;
                        x[0] = leftBorder + delta;
                        x[2] = leftBorder + 3*delta;
                        someFunction[0] = Function(x[0]);
                        someFunction[2] = Function(x[2]);
                    } else {
                        minFunction = someFunction[2];
                        xMin = x[2];
                        leftBorder = x[1];
                        delta = (rightBorder - leftBorder)/4;
                        x[0] = leftBorder + delta;
                        x[1] = x[2];
                        x[2] = leftBorder + 3*delta;
                        someFunction[1] = someFunction[2];
                        someFunction[0] = Function(x[0]);
                        someFunction[2] = Function(x[2]);
                    }
                }
            }
            
            NSString *output = [NSString stringWithFormat:
                                @"\nf(x1) = %f    x1= %f\nf(x2) = %f    x2= %f\nf(x3) = %f"
                                "x3= %f\n\nminF(x) = %f    xMin = %f\nКоличество циклов = %d"
                                "\nОбращений к функции: %d"
                                ,someFunction[0],x[0],someFunction[1],x[1],someFunction[2]
                                ,x[2],minFunction,xMin,count,functionCounter];
            
            [self.result4interval insertText:output];
            count = 0;
            c[0] = functionCounter;
            functionCounter = 0;
        }
        // The end of 4 interval method
#pragma mark - 3 interval method
        // 3 interval method
        if (self.onOff3interval.state == YES) {
            
            float leftBorder = A, rightBorder = B;
            double xMin = 0, minFunction = 0, length, x[2], someFunction[2], epsilon = 0.25 * delta0;
            
            length = rightBorder - leftBorder;
            
            while (delta0 < length/2) {
                
                x[0] = (rightBorder + leftBorder)/2 - epsilon;
                x[1] = (rightBorder + leftBorder)/2 + epsilon;
                someFunction[0] = Function(x[0]);
                someFunction[1] = Function(x[1]);
                
                if (someFunction[0]<someFunction[1]) {
                    
                    minFunction = someFunction[0];
                    xMin = x[0];
                    rightBorder = x[1];
                    
                } else {
                    
                    minFunction = someFunction[1];
                    xMin = x[1];
                    leftBorder = x[0];
                    
                }
                
                length = rightBorder - leftBorder;
                count++;
            }
            NSString *output = [NSString stringWithFormat:
                                @"\nf(x1) = %f    x1= %f\nf(x2) = %f    x2= %f\n"
                                "\nminF(x) = %f    xMin = %f\nКоличество циклов = %d"
                                "\nОбращений к функции: %d"
                                ,someFunction[0],x[0],someFunction[1],x[1]
                                ,minFunction,xMin,count,functionCounter];
            
            [self.result3interval insertText:output];
            count = 0;
            c[1] = functionCounter;
            functionCounter = 0;
            
        }
        // The end of 3 interval method
        
#pragma mark - Method of golden section
        // Method of golden section
        if (self.onOffGoldenSectionButton.state == YES) {
            
            float z = 0.382, leftBorder = A, rightBorder = B, length = rightBorder - leftBorder;
            double xMin = 0,minFunction = 0, x[2], someFunction[2];
            
            x[0] = leftBorder + z * length;
            x[1] = rightBorder - z * length;
            someFunction[0] = Function(x[0]);
            someFunction[1] = Function(x[1]);
            
            while (delta0 < length/2) {
                count++;
               
                if (someFunction[0] < someFunction[1]) {
                    
                    minFunction = someFunction[0];
                    xMin = x[0];
                    rightBorder = x[1];
                    length = rightBorder - leftBorder;
                    x[1] = x[0];
                    someFunction[1] = someFunction[0];
                    x[0] = leftBorder + z * length;
                    someFunction[0] = Function(x[0]);
                } else {
                    minFunction = someFunction[1];
                    xMin = x[1];
                    leftBorder = x[0];
                    length = rightBorder - leftBorder;
                    x[0] = x[1];
                    someFunction[0] = someFunction[1];
                    x[1] = rightBorder - z * length;
                    someFunction[1] = Function(x[1]);
                  }
                length = rightBorder - leftBorder;
            }
            
            NSString *output = [NSString stringWithFormat:
                                @"\nf(x1) = %f    x1= %f\nf(x2) = %f    x2= %f\n\nminF(x) = %f"
                                "xMin = %f\nКоличество циклов = %d\nОбращений к функции: %d"
                                ,someFunction[0],x[0],someFunction[1],x[1],minFunction,xMin
                                ,count,functionCounter];
            
            [self.resultGoldenSection insertText:output];
            count = 0;
            c[2] = functionCounter;
            functionCounter = 0;
        }
        // The end of method of golden section
#pragma mark - Comparsion of methods
        // comparison of methods
        int i = 0, cmin = 1000000;
        for (i=0; i<3; i++) {
            if (c[i]>0) {
                if (c[i] < cmin) {
                    cmin = c[i];
                    k = i;
                }
            }
        }
        
        switch (k) {
            case 0:
            {
                self.resultLabel.hidden = NO;
                self.resultLabel.stringValue = @"4 интервальный метод был лучше";
            }
                break;
            case 1:
            {
                self.resultLabel.hidden = NO;
                self.resultLabel.stringValue = @"3 интервальный метод был лучше";
            }
                break;
            case 2:
            {
                self.resultLabel.hidden = NO;
                self.resultLabel.stringValue = @"Метод золотого сечения был лучше";
            }
                break;
                
            default:
                break;
        }

    } else {
#pragma mark - Alert
        k = 3;
        NSAlert *alert = [NSAlert alertWithMessageText:@"Ошибка ввода"
                                         defaultButton:@"OK"
                                       alternateButton:nil
                                           otherButton:nil
                             informativeTextWithFormat:
                          @"1.Погрешность должна быть положительной величиной.\n"
                          "2.Погрешность должна быть меньше диапазона поиска!"];
        [alert runModal];
    }
    
}
#pragma mark - Cleaning fields
// Cleaning fields
- (IBAction)cleaningButton:(id)sender {
    [self.result4interval setString:@""];
    [self.result3interval setString:@""];
    [self.resultGoldenSection setString:@""];
}

@end
