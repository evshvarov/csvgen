## objectscript-package-template
This is a template for InterSystems ObjectScript class package which is planned to be published into [ZPM registry](https://pm.community.intersystems.com/packages/-/all).
[Learn more on Community Package Manager (ZPM)](https://community.intersystems.com/post/introducing-intersystems-objectscript-package-manager)

## Unit tests

## repo structure
1. put ObjectScript classes under /src folder in form
/package_name/class_name.cls
or-and
/package_name/mac_routine.mac
or-and
/package_name/int_routine.int
or-and
/package_name/include_file.inc

2. Put module.xml file in the root of the repo. Learn more about [module.xml format](https://community.intersystems.com/post/anatomy-zpm-module-packaging-your-intersystems-solution)


## Naming convention
Each folder under /src corresponds to application package.
first folder/package is the organisatoin or developer name.
second level is the project name
third is class or sub-package
E.g. this repo contains a simple example of ObjectScript class for the repository published in [Developers Community github](https://github.com/intersystems-community/objectscript-package-template)
The organisation is intersystems-community, and the corresponding package name is 'community'.
The repo is objectscript-package-template and the subpackage name for this repo is 'objectscript'

## Installation 

Clone/git pull the repo into any local directory

```
$ git clone https://github.com/your-repository.git
```

Open the terminal in this directory and run:


```
$ docker-compose up -d
```

## How to Test it

Open IRIS terminal:

```
$ docker-compose exec iris iris session iris
USER>zn "IRISAPP"
IRISAPP>write ##class(community.objectscript.ClassExample).Test()
```
## How to start coding
This repository is ready to code in VSCode with ObjectScript plugin.
Install [VSCode](https://code.visualstudio.com/) and [ObjectScript](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript) plugin and open the folder in VSCode.
Open /src/cls/PackageSample/ObjectScript.cls class and try to make changes - it will be compiled in running IRIS docker container.

Feel free to delete PackageSample folder and place your ObjectScript classes in a form
/src/Package/Classname.cls

The script in Installer.cls will import everything you place under /src and globals in /gbl into IRIS.

## What's insde the repo

# Dockerfile

The simplest dockerfile which starts IRIS and imports Installer.cls and then runs the Installer.setup method, which creates IRISAPP Namespace and imports ObjectScript code from /src folder into it.
Use the related docker-compose.yml to easily setup additional parametes like port number and where you map keys and host folders.
Use .env/ file to adjust the dockerfile being used in docker-compose.
It also installs ZPM - ObjectScript Package Manager client

# module.xml

This file describes project to be installed as package in ObjectScript Package Manager. You can test your module.xml with following commands:
// load the source code of the package as it is described in module.xml
IRISAPP:zpm>load /irisdev/app
// run the package installer test
IRISAPP:zpm>objectscript-package-template package -v

# .vscode/settings.json

Settings file to let you immedietly code in VSCode with [VSCode ObjectScript plugin](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript))

# .vscode/launch.json
Config file if you want to debug with VSCode ObjectScript
