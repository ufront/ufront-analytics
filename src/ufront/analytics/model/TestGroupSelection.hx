package ufront.analytics.model;

import sys.db.Types;
import ufront.auth.model.User;
import ufront.db.Object;

/**
	A database record of which choice in an AB test was used for a given request, session or user.
**/
@:index(testName,userID,unique)
@:index(testName,sessionID,unique)
@:index(testName,dataPointID,unique)
class TestGroupSelection extends Object {

	/**
		The chosen selection from the group.

		The getter and setter here will serialize to `testName` and `option` to be stored in the database.

		Please note that any enum parameters will be ignored - only the enum name and the constructor name matter.
	**/
	@:isVar @:skip public var selection(get,set):EnumValue;

	/**
		The userID associated with this selection.
		Should match the userID in `ufront.analytics.model.DataPoint`.
	**/
	public var userID:Null<SString<255>>;

	/**
		The sessionID associated with this selection.
		Should match the sessionID in `ufront.analytics.model.DataPoint`.
	**/
	public var sessionID:Null<SString<255>>;

	/**
		The DataPoint record this test selection is related to.
		Please note, if `sessionID` or `userID` are supplied, this group selection may apply to more than one DataPoint.
		We only record the first DataPoint this selection was associated with.
	**/
	public var dataPoint:BelongsTo<DataPoint>;
	
	/** The enum name of the group we are selecting from. **/
	public var testName(default,null):SString<255>;

	/** The name of the enum constructor we have selected. **/
	public var option(default,null):SString<255>;

	function get_selection():EnumValue {
		if ( selection==null && testName!=null ) {
			var e = Type.resolveEnum( testName );
			selection = Type.createEnum( e, option );
		}
		return selection;
	}

	function set_selection(m:EnumValue) {
		testName = Type.getEnumName( Type.getEnum(m) );
		option = Type.enumConstructor( m );
		return selection = m;
	}
}