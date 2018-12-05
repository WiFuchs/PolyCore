using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.Attention;

var countDown = 4;

class PolyCoreStartupView extends WatchUi.View {

	var countDownTimer = new Timer.Timer();
	
	function countDownT(){
		Attention.playTone(Attention.TONE_LOUD_BEEP);
		countDownTimer.start(method(:decrementSeconds), 1000, true);
		countDown = 3;
		WatchUi.requestUpdate();
	}
	
	function decrementSeconds(){
		countDown -= 1;
		if(countDown == 0){
			countDownTimer.stop();
			Attention.playTone(Attention.TONE_START);
			WatchUi.switchToView(new PolyCoreView(), new PolyCoreDelegate(), WatchUi.SLIDE_UP);
		} else {
			Attention.playTone(Attention.TONE_LOUD_BEEP);
		}
		WatchUi.requestUpdate();
	}
	
    function initialize() {
        View.initialize();
    }

    // Resources are loaded here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // onShow() is called when this View is brought to the foreground
    function onShow() {
    }

    // onUpdate() is called periodically to update the View
    function onUpdate(dc) {
    		if(countDown == 4){
        		View.onUpdate(dc);
        	} else {
        		dc.setColor(dc.COLOR_WHITE,dc.COLOR_BLACK);
        		dc.clear();
        		dc.drawText(dc.getWidth()/2, 
        			(dc.getHeight()-dc.getFontHeight(dc.FONT_SYSTEM_NUMBER_THAI_HOT))/2, 
        			dc.FONT_SYSTEM_NUMBER_THAI_HOT, 
        			countDown.format("%1d"), 
        			Graphics.TEXT_JUSTIFY_CENTER);
        	}
    }

    // onHide() is called when this View is removed from the screen
    function onHide() {
    }
}