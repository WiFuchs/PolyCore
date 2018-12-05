using Toybox.WatchUi as Ui;

class PolyCoreDelegate extends Ui.BehaviorDelegate {
	var started = 0;

    function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
    		if(started != 1){
    			var countDownView = new PolyCoreStartupView();
    			countDownView.countDownT();
    			started = 1;
    		}
    }

}