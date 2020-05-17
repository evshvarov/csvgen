Class UnitTests.Testcsv Extends %UnitTest.TestCase
{

Method TestGenerate()
{
	Set tExpected=272
	set fn="/irisdev/app/data/covid-03-16-2020.csv"
	set status=##class(evshvarov.csvgen.csv).Generate(fn,",",,1,.tResults)
	do $$$AssertStatusOK(status,"Generate")
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

}
