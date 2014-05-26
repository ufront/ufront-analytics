package ufront.analytics.api;

import massive.munit.util.Timer;
import ufront.analytics.api.AnalyticsApi;
import ufront.analytics.model.*;
import sys.db.Manager;
import sys.db.Sqlite;

class AnalyticsApiTest 
{
	var api:AnalyticsApi; 
	
	public function new() {}
	
	@BeforeClass
	public function beforeClass():Void {}
	
	@AfterClass
	public function afterClass():Void {}
	
	@Before
	public function setup():Void {

		var db = 'test.sqlite';
		
		if ( Manager.cnx!=null ) 
			Manager.cnx.close

		if ( FileSystem.exists(db) )
			FileSystem.deleteFile( db );

		Manager.cnx = Sqlite.open( db );

		TableCreate.create( TestGroupSelection.manager );
		TableCreate.create( DataPoint.manager );

		log,
		saveDataPoint,
		saveDataPoints,
		flush,

		api = new AnalyticsApi();
	}
	
	@After
	public function tearDown():Void {
		if ( FileSystem.exists(db) )
			FileSystem.deleteFile( db );
	}
	
	@Test
	public function testLog():Void {
		
	}
	
	@Test
	public function testSaveDataPoint():Void {
		
	}
	
	@Test
	public function testSaveDataPoints():Void {
		
	}
	
	@Test
	public function testFlush():Void {
		
	}
}