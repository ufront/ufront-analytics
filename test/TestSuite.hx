import massive.munit.TestSuite;

import ufront.analytics.model.TestGroupSelectionTest;
import ufront.analytics.model.DataPointTest;
import ufront.analytics.api.AnalyticsApiTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(ufront.analytics.model.TestGroupSelectionTest);
		add(ufront.analytics.model.DataPointTest);
		add(ufront.analytics.api.AnalyticsApiTest);
	}
}
