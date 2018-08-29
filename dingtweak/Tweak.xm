
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
%hook AMapLocationManager
- (void)locationManager:(id)arg1 didUpdateLocations:(id)arg2
{
	NSLog(@"🍺🍺🍺=======AMapLocationManager位置\n%@ ",[arg2 class]);

    NSArray *arr =  arg2;
// CLLocation 纬度：22.576599 ,经度：113.920703
    if (arr.count > 0 )
    {
    	CLLocation *location0 = arr[0];
    	CLLocationCoordinate2D coordinate=location0.coordinate;
		NSLog(@"🍺🍺🍺=======AMapLocationManager位置\n%@ 纬度：%f ,经度：%f",[arr[0] class],coordinate.latitude,coordinate.longitude);


	    BOOL isOpen = [[NSUserDefaults standardUserDefaults] boolForKey:@"isOpenDIYLocation"];
	    if (isOpen) {
			CLLocationCoordinate2D startPt = (CLLocationCoordinate2D){22.576599, 113.920703};    //纬度，经度
		    CLLocation *location = [[CLLocation alloc] initWithCoordinate:startPt altitude:location0.altitude horizontalAccuracy:location0.horizontalAccuracy verticalAccuracy:location0.verticalAccuracy timestamp:location0.timestamp];
			arg2 = @[location];
	    }

    }

	%orig;
}
%end


%hook LAPLocationInfo

- (void)dt_locationManager:(id)arg1 didUpdateLocations:(id)arg2{
	NSLog(@"🍺🍺🍺=======LAPLocationInfo位置\n%@",[arg2 class]);
    NSArray *arr =  arg2;

// CLLocation 纬度：22.576599 ,经度：113.920703
    if (arr.count > 0 )
    {
    	CLLocation *location0 = arr[0];
    	CLLocationCoordinate2D coordinate=location0.coordinate;
		NSLog(@"🍺🍺🍺=======LAPLocationInfo位置\n%@ 纬度：%f ,经度：%f",[arr[0] class],coordinate.latitude,coordinate.longitude);

	    BOOL isOpen = [[NSUserDefaults standardUserDefaults] boolForKey:@"isOpenDIYLocation"];
	    if (isOpen) {
		    // CLLocationCoordinate2D startPt = (CLLocationCoordinate2D){22.585022, 113.922612};    //纬度，经度
			CLLocationCoordinate2D startPt = (CLLocationCoordinate2D){22.576599, 113.920703};    //纬度，经度

		    CLLocation *location = [[CLLocation alloc] initWithCoordinate:startPt altitude:location0.altitude horizontalAccuracy:location0.horizontalAccuracy verticalAccuracy:location0.verticalAccuracy timestamp:location0.timestamp];
			arg2 = @[location];
		}
    }

	%orig;
}
%end

%hook DTSettingListViewController

%end

%hook DTTableViewHandler
- (long long)numberOfSectionsInTableView:(id)arg1{
	UITableView *tableView = arg1;
    if([tableView.nextResponder.nextResponder isKindOfClass:%c(DTSettingListViewController)]){
		return %orig+1;
	}
	return %orig;
}

- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)indexPath{
	UITableView *tableView = arg1;
	if([tableView.nextResponder.nextResponder isKindOfClass:%c(DTSettingListViewController)]
    	&& [indexPath section] ==[self numberOfSectionsInTableView:tableView]-1){
		return 55;
	}
	return %orig;
}

- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)section{
	UITableView *tableView = arg1;
	if([tableView.nextResponder.nextResponder isKindOfClass:%c(DTSettingListViewController)]
    	&& section ==[self numberOfSectionsInTableView:tableView]-1){
		return 1;
	}
	return %orig;
}

- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)indexPath{
	UITableView *tableView = arg1;
	if([tableView.nextResponder.nextResponder isKindOfClass:%c(DTSettingListViewController)]
    	&& [indexPath section] ==[self numberOfSectionsInTableView:tableView]-1){
        
        UITableViewCell * cell = nil;
        if([indexPath row] == 0){
            static NSString * switchCell = @"switchCell";
            cell = [tableView dequeueReusableCellWithIdentifier:switchCell];
            if(!cell){
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:switchCell];
            }
            cell.textLabel.text = @"破解定位开启";
            //抢红包开关!!
            UISwitch * switchView = [[UISwitch alloc] init];
            switchView.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"isOpenDIYLocation"];
            [switchView addTarget:self action:@selector(switchChang:) forControlEvents:(UIControlEventValueChanged)];
            cell.accessoryView = switchView;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

        cell.backgroundColor = [UIColor whiteColor];
        return cell;
        
    }
	return %orig;
}

%new
-(void)switchChang:(UISwitch *)switchView{
    [[NSUserDefaults standardUserDefaults] setBool:switchView.isOn forKey:@"isOpenDIYLocation"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    // [MSHookIvar <UITableView *>(self,"_tableView") reloadData];
}
%end






