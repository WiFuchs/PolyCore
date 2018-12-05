using Toybox.WatchUi as Ui;
using Toybox.Timer;
using Toybox.Math;
using Toybox.Attention;

class PolyCoreView extends Ui.View {
	const numExercises = 14;
	
	var exercises = [
		new PolyCoreExercise(1, "Russian Twists", 0),
		new PolyCoreExercise(1, "Penguins", 0),
		new PolyCoreExercise(1, "Smiley Faces", 0),
		new PolyCoreExercise(1, "Side Crunches", 1),
		new PolyCoreExercise(1, "Opposite Arm/Leg", 0),
		new PolyCoreExercise(1, "Fours", 1),
		new PolyCoreExercise(1, "Slow Bicycle", 0),
		new PolyCoreExercise(1, "Deadbugs", 0),
		new PolyCoreExercise(1, "Side/Middle/Side", 0),
		new PolyCoreExercise(1, "Elbow to Knee", 1),
		new PolyCoreExercise(0, "Suitcases", 0),
		new PolyCoreExercise(0, "Butterfly Crunches", 0),
		new PolyCoreExercise(0, "Butt Lifts", 0),
		new PolyCoreExercise(0, "In-Out Up-Down", 0),
		new PolyCoreExercise(0, "Flutter Kick", 0),
		new PolyCoreExercise(0, "V-Ups", 0),
		new PolyCoreExercise(0, "Leg Lifts", 0),
		new PolyCoreExercise(0, "Toe Touches", 0),
		new PolyCoreExercise(0, "Supermans", 0),
		new PolyCoreExercise(0, "Mountain Climbers", 0)];
	var time = 0;
	var totalTimer;
	var centerX;
	var centerY;
	var radSquared;
	var coreSet = [new PolyCoreExercise(0, "Front Plank", 0), 
		new PolyCoreExercise(0, "Front Plank", 0), 
		new PolyCoreExercise(0, "Left Side Plank", 0), 
		new PolyCoreExercise(0, "Right Side Plank", 0)];

    function initialize() {
        View.initialize();
        for (var i=4; i<numExercises; i+=1){
        		var rando = Math.rand()%exercises.size();	//Get random number
        		var ex = exercises[rando];					//get corresponding exercise
        		exercises.remove(ex);						//remove exercise from exercises
        		coreSet.add(ex);								//add exercise to coreSet at i
        	}
    }

	function handleTimer(){
		time += 1;
		WatchUi.requestUpdate();
		if (time % 60 == 0){
			coreSet.remove(coreSet[0]);					//Remove the current exercise - It's finished!
			if(coreSet.size() != 0){
				Attention.playTone(Attention.TONE_START);
			} else {
				Attention.playTone(Attention.TONE_SUCCESS);
			}
		} else if(coreSet[0].symmetric == 1 && time % 30 == 0){
			Attention.playTone(Attention.TONE_LOUD_BEEP);
		}
	}

    // Load your resources here
    function onLayout(dc) {
        totalTimer = new Timer.Timer();
        totalTimer.start(method(:handleTimer), 1000, true);
        centerX = dc.getWidth() / 2;
        centerY = dc.getHeight() / 2;
        radSquared = Math.pow(dc.getWidth()/2, 2);
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
        
        me.drawProgress(dc, time);
        if(coreSet.size() > 0){
	        dc.setColor(dc.COLOR_WHITE, dc.COLOR_TRANSPARENT);
	        dc.drawText(
		        centerX,
		        centerY,
		        dc.FONT_SYSTEM_NUMBER_HOT,
		        Lang.format("$1$:$2$",
		        [(time / 60).format("%02d"), (time.toNumber() % 60).format("%02d")]),
		        Graphics.TEXT_JUSTIFY_CENTER);
		    dc.drawText(
		        centerX,
		        15,
		        dc.FONT_MEDIUM,
		        coreSet[0].name,
		        Graphics.TEXT_JUSTIFY_CENTER);
		}
	        
	    if(time >= numExercises*60){
	    		totalTimer.stop();
	    		dc.setColor(dc.COLOR_WHITE, dc.COLOR_BLACK);
	    		dc.clear();
	    		dc.drawText(centerX, 
	    			centerY-dc.getFontHeight(dc.FONT_SYSTEM_LARGE)/2, 
	    			dc.FONT_SYSTEM_LARGE,
	    			"DONE!",
	    			Graphics.TEXT_JUSTIFY_CENTER);
	    	}
    }
    
    function drawProgress(dc, secs){
    		dc.setColor(0x00AA00, 0x000000);
    		dc.setPenWidth(centerX);
		var theta = 360*((secs%60)/60.0);
    		dc.drawArc(centerX, centerY, centerX/2, Graphics.ARC_CLOCKWISE, 90, 90-theta);
    		dc.setPenWidth(1);
    		
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
