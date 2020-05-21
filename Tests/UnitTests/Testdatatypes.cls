Class UnitTests.Testdatatypes Extends %UnitTest.TestCase
{

Method TestInteger()
{
	Set tExpected=1
    set value=42
    w ##class(evshvarov.datatypes).Guess(value,.types)
    set tResults=$D(types("%Integer"))
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestString()
{
	Set tExpected=1
    set value="blabla"
    w ##class(evshvarov.datatypes).Guess(value,.types)
    set tResults=$D(types("%String"))
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestDate()
{
	Set tExpected=1
    set value="01.01.2000"
    w ##class(evshvarov.datatypes).Guess(value,.types)
    set tResults=$D(types("%Date"))
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestDouble()
{
	Set tExpected=1
    set value=20.123123123
    w ##class(evshvarov.datatypes).Guess(value,.types)
    set tResults=$D(types("%Double"))
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestNumeric()
{
	Set tExpected=1
    set value=20.1231
    w ##class(evshvarov.datatypes).Guess(value,.types)
    set tResults=$D(types("%Numeric"))
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

}
