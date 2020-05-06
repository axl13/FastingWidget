using Toybox.System;
using Toybox.Time;
using Toybox.WatchUi;

class FastingViewDelegate extends WatchUi.BehaviorDelegate {
	
	var fast_manager;
	var resource_manager;
	var key_press_timestamp;
	var key_release_timestamp;
	
  	function initialize() {
        BehaviorDelegate.initialize();
        fast_manager = Application.getApp().fast_manager;
        resource_manager = Application.getApp().resource_manager;
        key_press_timestamp = System.getTimer();
        key_release_timestamp = System.getTimer();
       
    }
	
	function onKeyPressed(evt) {
		var key = evt.getKey();
		
		if (key == WatchUi.KEY_ENTER) {
			key_press_timestamp = System.getTimer();
		}
	}
	
	function onKeyReleased(evt) {
		var key = evt.getKey();
		
		if (key == WatchUi.KEY_ENTER) {
			key_release_timestamp = System.getTimer();
		
			if (key_release_timestamp - key_press_timestamp < resource_manager.longpress_threshold) {
				fast_manager.nextPage();
			} else {
				fast_manager.toggleFast();
			}
		
		}
		
		System.println("KEY DOWN: " + key_press_timestamp.toNumber() 
			+ " | KEY UP: " + key_release_timestamp.toNumber()
			+ " | DELTA: " + (key_release_timestamp - key_press_timestamp).toNumber()
			+ " | THRESHOLD: " + resource_manager.longpress_threshold);
	}

}