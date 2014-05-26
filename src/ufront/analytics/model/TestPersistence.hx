package ufront.analytics.model;

/**
	An enum defining the different options for how long test group selections should persist.
**/
enum TestPersistence {
	/** Always keep the user in the same test group **/
	TPUser;

	/** While this session exists, keep the user/visitor in the same test group **/
	TPSession;

	/** Only test on this request, pick a new group on the new request. **/
	TPRequest;
}