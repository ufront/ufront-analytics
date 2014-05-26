package ufront.analytics.api;

import ufront.api.UFApi;
import ufront.analytics.model.*;
using tink.CoreApi;

class AnalyticsApi extends UFApi {
	
	@inject("currentUserID")
	public var userID:String;

	@inject("sessionID") 
	public var sessionID:String;

	var requestSelections:Map<Enum<Dynamic>,EnumValue>;

	public function new() {
		requestSelections = new Map();
	}

	public function getGroup<T>( options:Enum<T>, ?persistence:TestPersistence, ?distribution:Map<T,Float> ):T {


		See plan

		Also create ReportsApi and dump the functions there, I guess.
		Then create a middleware to log requests.
	}

	/**
		For a given test, retrieve the selection, matching on either user ID, session ID, or DataPoint.

		Matches on the most recently modified selection record where sessionID OR userID OR dataPointID match.
	**/
	public function findTestGroupForDataPoint<T>( dp:DataPoint, e:Enum<T> ):Null<T> {
		var enumName = Type.getEnumName( e );
		var selection = TestGroupSelection.manager.select( 
			$testName==enumName 
			&& (
				($sessionID!=null && $sessionID==dp.sessionID) 
				|| ($userID!=null && $userID==dp.userID)
				|| ($dataPointID==dp.id)
			), 
			{ orderBy : modified } 
		);
		return if ( selection!=null ) cast selection.selection else null;
	}

	/**
		Retrieve all selection groups associated with this data point, session, or user.
	**/
	public function findTestGroupsForDataPoint( dp:DataPoint ):List<EnumValue> {
		var tgs = TestGroupSelection.manager.search( 
			(
				($sessionID!=null && $sessionID==dp.sessionID) 
				|| ($userID!=null && $userID==dp.userID)
				|| ($dataPointID==dp.id)
			),
			{ orderBy : modified } 
		);
		return tgs.map( function(tgs) return tgs.selection );
	}
}