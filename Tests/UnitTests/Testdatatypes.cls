Class UnitTests.Testdatatypes Extends %UnitTest.TestCase
{

Method TestInteger()
{
	Set tExpected=1
    set value=42
    w ##class(community.datatypes).Guess(value,.types)
    set tResults=$D(types("INTEGER"))
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestString()
{
	Set tExpected=1
    set value="blabla"
    w ##class(community.datatypes).Guess(value,.types)
    set tResults=$D(types("VARCHAR"))
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestDate()
{
	Set tExpected=1
    set value="01.01.2000"
    w ##class(community.datatypes).Guess(value,.types)
    set tResults=$D(types("DATE"))
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestDouble()
{
	Set tExpected=1
    set value=20.123123123
    w ##class(community.datatypes).Guess(value,.types)
    set tResults=$D(types("DOUBLE"))
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestNumeric()
{
	Set tExpected=1
    set value=20.1231
    w ##class(community.datatypes).Guess(value,.types)
    set tResults=$D(types("MONEY"))
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

}
