using Toybox.WatchUi;
using Toybox.Graphics;

class FastingView extends WatchUi.View {
	
	var resource_manager;
	var fast_manager;
	
	var center_x;
	var center_y;
	
    function initialize() {
        View.initialize();
        fast_manager = Application.getApp().fast_manager;
        resource_manager = Application.getApp().resource_manager;
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
        center_x = dc.getWidth() / 2;
        center_y = dc.getHeight() / 2;
        
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
        switch (fast_manager.getPage()) {
        	case fast_manager.STREAK:
        		drawStreak(dc);
        		break;
        	
        	case fast_manager.ELAPSED:
        		drawFast(dc, false);
        		break;
        	
        	case fast_manager.REMAINING: 
        		drawFast(dc, true);
        		break;
        	
        	case fast_manager.CALORIES:
        		drawCalories(dc);
        		break;
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

	function drawStreak(dc) {
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
		dc.clear();
		
		dc.drawText(center_x, center_y - 25 - dc.getFontHeight(Graphics.FONT_MEDIUM), Graphics.FONT_MEDIUM, "STREAK", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		dc.drawText(center_x, center_y, Graphics.FONT_NUMBER_HOT, "1000", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		dc.drawText(center_x, center_y + 60, Graphics.FONT_MEDIUM, "FASTS", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
	}
	
	function drawFast(dc, show_remaining) {
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
		dc.clear();
		
		var mode_label = "ELAPSED";
		var time_label = "03D 18H 20MIN";
		
		if (show_remaining == true) {
			mode_label = "REMAINING";
			time_label = "02D 06H 01MIN";
		}
		
		dc.drawText(center_x, center_y - 46 - dc.getFontHeight(Graphics.FONT_TINY), Graphics.FONT_TINY, mode_label, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		dc.drawText(center_x, center_y - dc.getFontHeight(Graphics.FONT_LARGE), Graphics.FONT_MEDIUM, time_label, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		dc.drawText(center_x, center_y, Graphics.FONT_TINY, "UNTIL", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		dc.drawText(center_x, center_y + 36, Graphics.FONT_MEDIUM, "06.05.20, 07:26", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		dc.drawText(center_x, center_y + 75, Graphics.FONT_MEDIUM, "85.5%", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		
		drawProgressArc(dc, 1);
	}
	
	function drawCalories(dc) {
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
		dc.clear();
		dc.drawBitmap(center_x - 32, center_y - 100, resource_manager.bitmap_burn);
		dc.drawText(center_x, center_y + 10, Graphics.FONT_NUMBER_HOT, "1000", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
		dc.drawText(center_x, center_y + 70, Graphics.FONT_MEDIUM, "KCAL", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
	}
	
	function drawProgressArc(dc, percent) {
		var degrees = 360 * percent;
		var arc_end = 0;
		
		if (degrees < 90) {
			arc_end = 90 - degrees;
		} else {
			arc_end = 360 - (degrees - 90);
		}
	
		dc.setPenWidth(10);
		dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLACK);
		dc.drawArc(center_x, center_y, 115, dc.ARC_CLOCKWISE, 90, arc_end);
	}
}
