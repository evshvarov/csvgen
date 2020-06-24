# csvgen
This is not very clever but working util to generate class and import data from an arbitrary CSV.
It can import from file or from public URL

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
USER>do ##classs(community.csvgen).GenerateFromURL("example.com/data/filename.csv")
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


## EXAMPLES
### Import Titanic data
[Data Source](https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv)
```
USER>d ##class(community.csvgen).GenerateFromURL("https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv",",","Data.Titanic)

Class name: Data.Titanic
Header: PassengerId INTEGER,Survived INTEGER,Pclass INTEGER,Name VARCHAR(250),Sex VARCHAR(250),Age INTEGER,SibSp INTEGER,Parch INTEGER,Ticket VARCHAR(250),Fare MONEY,Cabin VARCHAR(250),Embarked VARCHAR(250)
Records imported: 891
USER>
```
### Import COVID19 data
[Data Source](https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/csse_covid_19_daily_reports/05-29-2020.csv")
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
USER>d ##class(community.csvgen).GenerateFromURL("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/05-29-2020.csv",",","Data.Covid19")
```

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

