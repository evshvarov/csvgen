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
USER>do ##class(evshvarov.csvgen).Generate("/folder/filename.csv")
```

This will parse csv with "," as delimeter, generate class "csvgen.filenameYYYYMMDD" and import the data from file
ALL the propeties are of %String (MAXLEN=250).
The class will have Import method to make more imports from the file with the same structure.
With parameters to the Generate method you can alter delimeter, classname and get the number of imported records.

### Generate and import from URL

```
USER>do ##classs(evshvarov.csvgen).GenerateFromURL("example.com/data/filename.csv")
```

This will do the same as above with the same parameters, but from URL in the Internet, which is publicly avaliable.
it will use SSL connection, with "default" SSL, but you can alter this.


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

