# useful commands
## build container with no cache
```
docker-compose build --no-cache --progress=plain
```
## open terminal to docker
```
docker-compose exec iris iris session iris -U IRISAPP
```
set url="https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/05-17-2020.csv"

set fn="/home/irisowner/irisdev/data/10k_diabetes_small 2.csv"
	kill pclass
    kill prowtype
	set status=##class(community.csvgen).Generate(fn,",",.pclass,.prowtype,1,.tResults)


w ##class(community.csvgen).Run()
 ##class(community.csvgen).RunURL()


 w $System.Status.GetErrorText(##class(community.csvgen).SQLToCSV(";",1,"/home/irisowner/irisdev/data/test","select * from csvgen.runtest"))

##class(community.csvgen).GetSQLTableName("community.csvgen.generated.home202508218")