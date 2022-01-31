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
	
set fn="/irisrun/repo/data/10k_diabetes_small 2.csv"
	kill pclass
    kill prowtype
	set status=##class(community.csvgen).Generate(fn,",",.pclass,.prowtype,1,.tResults)
	

w ##class(community.csvgen).Run()
 ##class(community.csvgen).RunURL()

 
 w $System.Status.GetErrorText(##class(community.csvgen).ToCSV(";",1,"/irisrun/repo/data/test","select * from csvgen.runtest"))

