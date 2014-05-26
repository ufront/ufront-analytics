package ufront.analytics.model;

import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import ufront.analytics.model.TestGroupSelection;

class TestGroupSelectionTest 
{
	public function new() {}
	
	@BeforeClass
	public function beforeClass():Void {}
	
	@AfterClass
	public function afterClass():Void {}
	
	@Before
	public function setup():Void {}
	
	@After
	public function tearDown():Void {}
	
	@Test
	public function testNew():Void {
		var tgs = new TestGroupSelection();

		Assert.isNull( tgs.selection );
		Assert.isNull( tgs.testName );
		Assert.isNull( tgs.option );
		Assert.isNull( tgs.sessionID );
		Assert.isNull( tgs.userID );
	}
	
	@Test
	public function testSelection():Void {
		var tgs = new TestGroupSelection();

		tgs.selection = New;
		Assert.areEqual( New, tgs.selection );
		Assert.areEqual( "ufront.analytics.model.Layout", tgs.testName );
		Assert.areEqual( "New", tgs.option );

		tgs.selection = Old;
		Assert.areEqual( Old, tgs.selection );
		Assert.areEqual( "ufront.analytics.model.Layout", tgs.testName );
		Assert.areEqual( "Old", tgs.option );
	}
}

enum Layout {
	New;
	Old;
}