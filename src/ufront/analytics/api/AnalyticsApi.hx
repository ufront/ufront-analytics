package ufront.analytics.api;

import ufront.api.UFApi;
import ufront.analytics.model.*;
using tink.CoreApi;

class AnalyticsApi extends UFApi {
	
	@inject("currentUserID")
	public var userID:String;

	@inject("sessionID") 
	public var sessionID:String;

	var dataPoints:Array<DataPoint> = [];

	/**
		Log an individual event.
	**/
	public function log( e:EnumValue ) {
		var d = new DataPoint();

		d.event = e;
		d.sessionID = sessionID;
		d.userID = userID;

		return saveDataPoint( d );
	}

	/**
		Add a datapoint to the queue.

		This will be saved to the database when `flush` is called.
	**/
	public function saveDataPoint( dataPoint:DataPoint ):Noise {
		dataPoints.push( dataPoint );
		return null;
	}

	/**
		Add some datapoints to the queue.

		This will be saved to the database when `flush` is called.
	**/
	public function saveDataPoints( points:Array<DataPoint> ):Noise {
		for ( p in points ) {
			dataPoints.push( p );
		}
		return null;
	}

	/**
		Flush various DataPoints to the server's database.

		This will return a Success if it works, or if not, a Failure containing:

		a) An Array of the DataPoints which failed to save, so you can re-attempt them.
		b) An Error object containing details about the failures.
	**/
	public function flush( dataPoints:Array<DataPoint> ):Outcome<Noise,Pair<Array<DataPoint>,Error>> {
		var failed = [];
		var errors = [];
		for ( d in dataPoints ) {
			try {
				d.save();
			}
			catch ( e:Dynamic )  {
				failed.push( d );
				errors.push( ""+e );
			}
		}

		return 
			if ( errors.length>0 ) Failure( new Pair(failed,'Failed to log DataPoints on server.'.withData(errors)) );
			else Success( Noise );
	}
}