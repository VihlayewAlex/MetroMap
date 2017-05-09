//
//  DetailedWayController.m
//  MetroMap
//
//  Created by Alex Vihlayew on 5/9/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

#import "DetailedWayController.h"
#import "MetroMap-Swift.h"

@interface DetailedWayController ()

@end

@implementation DetailedWayController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI Actions

- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_way count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stationCell" forIndexPath:indexPath];

    MetroStation_Vertex_* currentStation = [_way objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[currentStation stationName]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




@end
