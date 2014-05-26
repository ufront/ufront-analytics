package ufront.analytics.model;

import massive.munit.Assert;
import ufront.analytics.model.DataPoint;

class DataPointTest {
	public function new() 
	{
		
	}
	
	@BeforeClass
	public function beforeClass():Void {
		
	}
	
	@AfterClass
	public function afterClass():Void {}
	
	@Before
	public function setup():Void {}
	
	@After
	public function tearDown():Void {}
	
	@Test
	public function testNew():Void {

		// Empty DataPoint

		var beforeTime = Date.now().getTime();
		var dp = new DataPoint();
		var afterTime = dp.date.getTime();

		Assert.isNull( dp.event );
		Assert.isNull( dp.sessionID );
		Assert.isNull( dp.userID );
		Assert.isTrue( afterTime-beforeTime<1000 ); // check the date was around about in the last second or so...

		// DataPoint
		var dp2 = new DataPoint( Login );
		Assert.areEqual( Login, dp2.event );
	}

	@Test
	public function testEvent():Void {

		// Test an event with no parameters
		var dp1 = new DataPoint( Login );
		Assert.areEqual( Login, dp1.event );
		Assert.areEqual( "ufront.analytics.model.Event.Login", dp1.eventType );
		Assert.areEqual( 0, dp1.eventData.length );

		// Test an event with 2 parameters
		var date = Date.now();
		var dp2 = new DataPoint( ViewPage(date,'/') );
		Assert.areEqual( ViewPage(date,'/'), dp2.event );
		Assert.areEqual( "ufront.analytics.model.Event.ViewPage", dp2.eventType );
		Assert.areEqual( 2, dp2.eventData.length );
		Assert.areEqual( date, dp2.eventData[0] );
		Assert.areEqual( "/", dp2.eventData[1] );
	}
}

enum Event {
	Login;
	ViewPage( time:Date, url:String );
}