//
//  main.m
//  mmmarkdown
//
//  Copyright (c) 2012 Matt Diephouse.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import <Foundation/Foundation.h>

#import <MMMarkdown/MMMarkdown.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool
    {
        // Read the Markdown from STDIN
        NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"md"];
        NSString *markdown = [NSString stringWithContentsOfFile:path
                                                       encoding:NSUTF8StringEncoding
                                                          error:nil];
        
//        NSFileHandle *inHandle = [NSFileHandle fileHandleWithStandardInput];
//        NSData       *inData   = [inHandle readDataToEndOfFile];
//        NSString     *markdown = [[NSString alloc] initWithData:inData encoding:NSUTF8StringEncoding];
        
        // Convert to HTML
        NSError  *error;
        NSString *HTML = [MMMarkdown HTMLStringWithMarkdown:markdown error:&error];
        
        // Bail if there was an error
        if (!HTML)
        {
            NSFileHandle *errHandle = [NSFileHandle fileHandleWithStandardError];
            NSString     *msg       = [error localizedDescription];
            NSData       *errData   = [msg dataUsingEncoding:NSUTF8StringEncoding];
            [errHandle writeData:errData];
            return EXIT_FAILURE;
        }
        
        // Write the HTML to STDOUT
//        NSFileHandle *outHandle = [NSFileHandle fileHandleWithStandardOutput];
//        NSData       *outData   = [HTML dataUsingEncoding:NSUTF8StringEncoding];
//        [outHandle writeData:outData];
        NSString *pathHead = [[NSBundle mainBundle] pathForResource:@"head" ofType:@"html"];
        NSMutableString *strContent = [NSMutableString stringWithContentsOfFile:pathHead];
        [strContent appendString:HTML];
        
//        [strContent replaceOccurrencesOfString:@"<pre><code"
//                                    withString:@"<div class=\"code-block\"><pre><code"
//                                       options:NSCaseInsensitiveSearch
//                                         range:NSMakeRange(0, strContent.length)];
//
//        [strContent replaceOccurrencesOfString:@"</code></pre>"
//                                    withString:@"</code></pre></div>"
//                                       options:NSCaseInsensitiveSearch
//                                         range:NSMakeRange(0, strContent.length)];
        
        NSString *outPath = @"/Users/infc/Downloads/test.html";
        [strContent writeToFile:outPath
               atomically:YES
                 encoding:NSUTF8StringEncoding
                    error:nil];
    }
    
    return EXIT_SUCCESS;
}

