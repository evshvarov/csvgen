## csvgen

[![Gitter](https://img.shields.io/badge/Available%20on-Intersystems%20Open%20Exchange-00b2a9.svg)](https://openexchange.intersystems.com/package/csvgen)
 [![Quality Gate Status](https://community.objectscriptquality.com/api/project_badges/measure?project=intersystems_iris_community%2Fcsvgen&metric=alert_status)](https://community.objectscriptquality.com/dashboard?id=intersystems_iris_community%2Fcsvgen)
 <img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/evshvarov/csvgen">

This is a simple module that allows you to import data from an arbitrary CSV to InterSystems IRIS.
It can import from file or from public URL, create the class and import the data. 
If you are on IRIS 2021.2 and newer it uses the [LOAD DATA](https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=RSQL_loaddata) function to import data.

Also it can export data from an arbitrary SQL to CSV.

## Installation with ZPM
```
zpm:USER>install csvgen
```

## Usage

### Generate and import from CSV file

```
USER>do ##class(community.csvgen).Generate("/folder/filename.csv")
```

This will parse csv with "," as delimeter, generate class "csvgen.filenameYYYYMMDD" and import the data from file
It tries to "guess" the datatype upon the data in first 4 rows.
pass the 3-rd parameter as 0 if you want all the datatypes be as "%String MAXLEN=250"
The class will have Import method to make more imports from the file with the same structure.
With parameters to the Generate method you can alter delimeter, classname and get the number of imported records.

### Generate and import from URL

```
USER>do ##class(community.csvgen).GenerateFromURL("example.com/data/filename.csv")
```

This will do the same as above with the same parameters, but from URL in the Internet, which is publicly avaliable.
it will use SSL connection, with "default" SSL, but you can alter this.

### Additional parameters:
- dlm - delimiter symbol for the file, "," by default.
- ByRef pclass - classname if you want to setup the name. If omitted will be generated in a package csvgen.
- ByRef prowtype - rowtypes in CSV2CLASS format, e.g. FIELD1 VARCHAR(250), FIELD2 INTEGER,.... If omitted, will be generated upon the header of CSV.
- pguessTypes - guess on field types. 1 by default. if 0 then all fields will be as VARCHAR 250
- Output recordsCount - returns amount of imported records.
- verbose 1 by default - outputs the results of class generation and data import.
- pappend 0 by default - turn to 1 if you want to add the data in the existing table from the similar csv
- ploaddata 1 by default - if 1 it uses LOAD DATA function to load the data from CSV. Should be faster and with less errors
- pheader 1 by default -  if 1 it considers first line of the CSV as a header and skips it


### Exporting SQL query result to CSV

you can export the results of an arbitrary SQL query to a class name.
```
USER>set query="select * from your.classname"

USER>w ##class(community.csvgen).SQLToCSV(";",1,"/folder/file.csv",query)
1
```
this will export all the data from your.classname to /file.csv with ";" as a delimeter. And it will overwrite file.csv if it exists.

## EXAMPLES
### Import Titanic data
[Data Source](https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv)
```
USER>d ##class(community.csvgen).GenerateFromURL("https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv",",","Data.Titanic")

Class name: Data.Titanic
Header: PassengerId INTEGER,Survived INTEGER,Pclass INTEGER,Name VARCHAR(250),Sex VARCHAR(250),Age INTEGER,SibSp INTEGER,Parch INTEGER,Ticket VARCHAR(250),Fare MONEY,Cabin VARCHAR(250),Embarked VARCHAR(250)
Records imported: 891
USER>
```
### Import COVID19 data
[Data Source](https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/csse_covid_19_daily_reports/05-29-2020.csv)
```
USER>d ##class(community.csvgen).GenerateFromURL("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/05-29-2020.csv",",","Data.Covid19")

Class name: Data.Covid19
Header: FIPS INTEGER,Admin2 VARCHAR(250),Province_State VARCHAR(250),Country_Region VARCHAR(250),Last_Update DATE,Lat MONEY,Long_ DOUBLE,Confirmed INTEGER,Deaths INTEGER,Recovered INTEGER,Active INTEGER,Combined_Key VARCHAR(250),Incidence_Rate DOUBLE,Case-Fatality_Ratio DOUBLE
Records imported: 3522
USER>
```
### Import Countries data
[Data Source](https://raw.githubusercontent.com/datasciencedojo/datasets/master/WorldDBTables/CountryTable.csv)
```
USER>d ##class(community.csvgen).GenerateFromURL("https://raw.githubusercontent.com/datasciencedojo/datasets/master/WorldDBTables/CountryTable.csv",",","Data.Countries")

Class name: Data.Countries
Header: code VARCHAR(250),name VARCHAR(250),continent VARCHAR(250),region VARCHAR(250),surface_area INTEGER,independence_year INTEGER,population INTEGER,life_expectancy MONEY,gnp DOUBLE,gnp_old INTEGER,local_name VARCHAR(250),government_form VARCHAR(250),head_of_state VARCHAR(250),capital INTEGER,code2 VARCHAR(250)
Records imported: 167
```

## Known Issues
Doesn't work if column name contains dots, e.g. column.name



## COLLABORATION

Collaboration to this util is very welcome! 
This repository is dockerised to make the collaboration easy.


## Installation for collaboration

Fork the repository and then clone/git pull the repo into any local folder:

```
$ git clone git@github.com:yourrepository/csvgen.git
```

Open the folder in VSCode and run in VSCode Terminal:

```
$ docker-compose up -d
```

and the following to open InterSystems IRIS terminal:

````
$ docker-compose exec iris iris session iris
````

If you don't have VSCode yet, install [VSCode](https://code.visualstudio.com/) and [ObjectScript](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript) plugin and open the folder in VSCode.

Pull Requests are welcome!

