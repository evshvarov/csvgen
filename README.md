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

