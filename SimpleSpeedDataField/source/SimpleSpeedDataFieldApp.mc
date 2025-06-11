import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class SimpleSpeedDataFieldApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    function getSensorDelegate() {
        return new SimpleSpeedSensorDelegate();
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new SimpleSpeedDataFieldView() ];
    }

}

function getApp() as SimpleSpeedDataFieldApp {
    return Application.getApp() as SimpleSpeedDataFieldApp;
}