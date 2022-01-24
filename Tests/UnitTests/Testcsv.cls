Class UnitTests.Testcsv Extends %UnitTest.TestCase
{

Method TestReservedWords()
{
	Set tExpected=30
	set fn="/irisrun/repo/data/Educational_Attainment_small.csv"
	kill pclass
    kill prowtype
	set status=##class(community.csvgen).Generate(fn,",",.pclass,.prowtype,1,.tResults)
	do $$$AssertStatusOK(status,"Generate")
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestDateTime()
{
	Set tExpected=1010
	set fn="/irisrun/repo/data/Educational_Attainment.csv"
	kill pclass
    kill prowtype
	set status=##class(community.csvgen).Generate(fn,",",.pclass,.prowtype,1,.tResults)
	do $$$AssertStatusOK(status,"Generate")
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestNoHeader()
{
	Set tExpected=10
	set fn="/irisrun/repo/data/10k_diabetes_small 2.csv"
	kill pclass
    kill prowtype
	set status=##class(community.csvgen).Generate(fn,",",.pclass,.prowtype,0,.tResults,,,1,0)
	do $$$AssertStatusOK(status,"Generate")
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestNoLoadData()
{
	Set tExpected=9
	set fn="/irisrun/repo/data/10k_diabetes_small 2.csv"
	kill pclass
    kill prowtype
	set status=##class(community.csvgen).Generate(fn,",",.pclass,.prowtype,1,.tResults,,,0)
	do $$$AssertStatusOK(status,"Generate")
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestAppend()
{
	Set tExpected=18
	set fn="/irisrun/repo/data/10k_diabetes_small 2.csv"
	kill pclass
    kill prowtype
	set status=##class(community.csvgen).Generate(fn,",",.pclass,.prowtype,1,.tResults)
	set status=##class(community.csvgen).Generate(fn,",",.pclass,.prowtype,1,.tResults,1,1)
	do $$$AssertStatusOK(status,"Generate")
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestDotsinCols()
{
	Set tExpected=809
	set fn="/irisrun/repo/data/organisations.csv"
	kill pclass
    kill prowtype
	set status=##class(community.csvgen).Generate(fn,";",.pclass,.prowtype,1,.tResults)
	do $$$AssertStatusOK(status,"Generate")
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestGenerate()
{
	Set tExpected=272
	set fn="/irisrun/repo/data/covid-03-16-2020.csv"
	kill pclass
    kill prowtype
	set status=##class(community.csvgen).Generate(fn,",",.pclass,.prowtype,0,.tResults)
	do $$$AssertStatusOK(status,"Generate")
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestWithRowtype()
{
	Set tExpected=272
	set fn="/irisrun/repo/data/covid-03-16-2020.csv"
	kill pclass
	set prowtype="ProvinceState VARCHAR(250),CountryRegion VARCHAR(250),LastUpdate DATE,Confirmed INTEGER,Deaths INTEGER,Recovered INTEGER,Latitude MONEY,Longitude MONEY"
	set status=##class(community.csvgen).Generate(fn,",",.pclass,.prowtype,1,.tResults)
	do $$$AssertStatusOK(status,"Generate")
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestGenerateNoGuess()
{
	Set tExpected=272
	set fn="/irisrun/repo/data/covid-03-16-2020.csv"
	kill pclass
    kill prowtype
	set status=##class(community.csvgen).Generate(fn,",",.pclass,.prowtype,0,.tResults)
	do $$$AssertStatusOK(status,"Generate")
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

Method TestGenerateFromURL()
{
	Set tExpected=3333
	set url="https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/05-17-2020.csv"
	kill pclass
    kill prowtype
	set status=##class(community.csvgen).GenerateFromURL(url,",",.pclass,.prowtype,1,.tResults)
	do $$$AssertStatusOK(status,"GenerateFromURL")
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

}
