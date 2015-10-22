//
//  ViewController.m
//  Instagram
//
//  Created by Greyson Gregory on 10/22/15.
//  Copyright © 2015 GreyAlex. All rights reserved.
//

#import "PhotosViewController.h"

@interface PhotosViewController ()
@property (strong, nonatomic) NSArray *popularContent;

@end

@implementation PhotosViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	NSString *clientId = @"3a3219fc3d0247d3ad7e026562eb53dd";
	NSString *urlString =
	[@"https://api.instagram.com/v1/media/popular?client_id=" stringByAppendingString:clientId];
	
	NSURL *url = [NSURL URLWithString:urlString];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	
	NSURLSession *session =
	[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
								  delegate:nil
							 delegateQueue:[NSOperationQueue mainQueue]];
	
	NSURLSessionDataTask *task = [session dataTaskWithRequest:request
											completionHandler:^(NSData * _Nullable data,
																NSURLResponse * _Nullable response,
																NSError * _Nullable error) {
												if (!error) {
													NSError *jsonError = nil;
													NSDictionary *responseDictionary =
													[NSJSONSerialization JSONObjectWithData:data
																					options:kNilOptions
																					  error:&jsonError];
													NSLog(@"Response: %@", responseDictionary);
													self.popularContent = responseDictionary[@"data"];
												} else {
													NSLog(@"An error occurred: %@", error.description);
												}
											}];
	[task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
