Class UnitTests.Testcsv Extends %UnitTest.TestCase
{

Method TestGenerate()
{
	Set tExpected=42
	set fn="/irisdev/app/data/covid-03-16-2020.csv"
	set status=##class(evsshvarov.csvgen.csv).Generate(fn,",")
	do $$$AssertStatusOK(status,"Create Record")
	set tResults=272
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

}
