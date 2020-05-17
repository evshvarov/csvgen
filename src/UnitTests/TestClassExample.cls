Class UnitTests.TestClassExample extends %UnitTest.TestCase 
{

Method TestFortyTwo()
{
	Set tResults=##class(community.objectscript.ClassExample).FortyTwo()
	Set tExpected=42
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

}