using Toybox.Activity;
using Toybox.Lang;
using Toybox.WatchUi;
using Toybox.Sensor;
using Toybox.Timer;

class SimpleSpeedDataFieldView extends WatchUi.SimpleDataField {

    function initialize() {
        SimpleDataField.initialize();
        label = "Speed";
    }

    function compute(info as Activity.Info) {
        // Get current speed from activity info
        if (info has :currentSpeed && info.currentSpeed != null) {
            var speed = info.currentSpeed; // Speed in m/s
            var speedKmh = speed * 3.6;   // Convert to km/h
            return speedKmh;
        }
        return null;
    }
}

// Minimal Sensor Delegate to trigger native pairing flow
class SimpleSpeedSensorDelegate extends Sensor.SensorDelegate {
    private var mScanTimer as Timer.Timer?;

    function initialize() {
        SensorDelegate.initialize();
    }

    // Must return true to participate in native pairing flow
    function sensorPairingRequired() as Lang.Boolean {
        return true;
    }

    // Called when system requests a scan - do minimal scan and complete quickly
    function onScan() {
        // Start a brief scan timer
        mScanTimer = new Timer.Timer();
        mScanTimer.start(method(:onScanTimeout), 5000, false); // 5 second scan
        return true;
    }

    // Called after brief scan timeout
    function onScanTimeout() as Void {
        // No sensors found - just complete the scan
        Sensor.notifyScanComplete();
        mScanTimer = null;
    }

    // Called when user selects a sensor to pair (won't happen in our case)
    function onPair(sensorInfo as Sensor.SensorInfo) {
        // Complete pairing immediately
        Sensor.notifyPairComplete(sensorInfo);
        return true;
    }

    // Called when user requests to unpair a sensor
    function onUnpair(sensorInfo as Sensor.SensorInfo) {
        // Complete unpairing immediately
        Sensor.notifyUnpairComplete(sensorInfo);
        return true;
    }
}

