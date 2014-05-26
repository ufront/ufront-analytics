package ufront.analytics.model;

import sys.db.Types;
import ufront.db.Object;

class DataPoint extends Object {

	public function new( ?event:EnumValue ) {
		this.event = event;
		this.date = Date.now();
		super();
	}

	/**
		The time the event took place.

		It is annoying that we also have `modified` and `created` in the super class, but `sys.db.Object` currently has no way to set these manually or prevent using them.
	**/
	public var date:SDateTime;

	/**
		The Session ID of the user/visitor that the event is related to.

		Will be null if the information is not supplied or the user has no active session.
	**/
	public var sessionID:Null<SString<255>>;

	/**
		The user ID (String) of the user that this event is related to.

		This is not necessarily the database unique ID, it should match the output of `ufront.auth.UFAuthUser.userID`.

		Will be null if the information is not supplied or the user is not logged in.
	**/
	public var userID:Null<SString<255>>;

	/**
		The event for this DataPoint.  

		This should be an enum value, which can contain parameters.

		This field is serialized and deserialized from the database using the eventType and eventData fields.
	**/
	@:skip @:isVar
	public var event(get,set):EnumValue;

	function get_event() {
		if ( event==null && eventType!=null ) {
			var parts = eventType.split( "." );
			var constructorName = parts.pop();
			var enumName = parts.join( "." );
			var e = Type.resolveEnum( enumName );
			var params = eventData;
			var event = Type.createEnum( e, constructorName, params );
		}
		return event;
	}

	function set_event(e:EnumValue) {
		if ( e!=null ) {
			var enumName = Type.getEnumName( Type.getEnum(e) );
			var constructorName = Type.enumConstructor( e );
			var params = Type.enumParameters( e );
			eventType = '$enumName.$constructorName';
			eventData = params;
		}
		else {
			eventType = null;
			eventData = null;
		}
		return event = e;
	}

	/**
		The name of event.  

		Takes the form `my.pack.EnumName.Constructor`.
	**/
	public var eventType(default,null):SString<255>;

	/**
		The parameters of the event.  May be an empty array if the event enum has no arguments.
	**/
	public var eventData(default,null):SData<Array<Dynamic>>;
}