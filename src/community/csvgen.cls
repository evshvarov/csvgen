Class community.csvgen
{

ClassMethod HowManyRecords(pclass As %String, ByRef recordsCount As %Integer) As %Status
{
   s tSC=$$$OK
   set table= ##class(%DeepSee.Utils).%GetSQLTableName(pclass)
   try {
    set st=##class(%SQL.Statement).%ExecDirect(,"SELECT COUNT(1) as ""result"" FROM "_table)
    if st.%SQLCODE < 0 throw ##class(%Exception.SQL).CreateFromSQLCODE(st.%SQLCODE,st.%Message)
    d st.%Next()
    set recordsCount=st."result"
   }
   Catch e {
       Set tSC = e.AsStatus()
   }

    q tSC
}

ClassMethod RunURL() As %Status
{
    set url="https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/05-17-2020.csv"
	kill pclass
 kill prowtype
    set status=##class(community.csvgen).GenerateFromURL(url,",",.pclass,.prowtype,1,.tResults)
    return status
}

ClassMethod Run() As %Status
{
	set fn="/irisdev/app/data/game_of_thrones_deaths_collecti.csv"
    set fn="/irisdev/app/data/covid-03-16-2020.csv"
    set fn="/irisdev/app/data/organisations.csv"
    set fn="/irisdev/app/data/10k_diabetes_small 2.csv"
    kill pclass
    kill prowtype
  	set status=##class(community.csvgen).Generate(fn,,.pclass,.prowtype,0,.tResults)
    return status
}

ClassMethod GenerateFromURL(URL As %String, dlm As %String = ",", ByRef pclass As %String, ByRef prowtype As %String, pguessTypes As %Boolean = 1, Output recordsCount As %Integer, verbose As %Boolean = 1) As %Status
{
    s stream=..GetStreamFromURL(URL)
    s sc=..StreamToFile(stream,.filename)
    if $$$ISERR(sc) Return sc
    s sc=..Generate(filename,dlm,.pclass,.prowtype,pguessTypes,.recordsCount,verbose) 
    
    return sc
}

/// generates class for an arbitrary CSV. All the properties are VARCHAR 250
/// fncsv - csv file on disk
/// dlm - delimeter
/// pguessTypes - flag to try to guess on datatypes
/// pclass - class name, if not passed, then will be generated and returned by ref
/// importData - 1, if you want data be loaded into the generated class 
/// recordCount - amount of records created and returned byRef
ClassMethod Generate(fncsv As %String, dlm As %String = ",", ByRef pclass As %String, ByRef prowtype As %String, pguessTypes As %Boolean = 1, Output recordsCount As %Integer, verbose As %Boolean = 1) As %Status
{
    set sc=$$$OK
    if $g(pclass)="" set pclass="community.csvgen.generated."_$TR($E(fncsv,1,5),"\/.","")_($zd($h,8))
    if $g(prowtype)="" set prowtype=..GetRowTypes(fncsv,dlm,pguessTypes)
    do ##class(%SQL.Util.Procedures).CSVTOCLASS(1, prowtype, fncsv, dlm, ,1, pclass)
    If %sqlcontext.%SQLCODE && (%sqlcontext.%SQLCODE '= 100) Quit $$$ERROR($$$SQLCode, %sqlcontext.%SQLCODE, %sqlcontext.%Message)
    set sc=..HowManyRecords(pclass,.recordsCount)
    if $$$ISERR(sc) q sc
    if verbose {
        Write !
        Write "Class name: "_pclass,!
        Write "Header: "_prowtype,!
        Write "Records imported: "_recordsCount
    }
    //ClassMethod Import(pSelectMode As %Library.Integer = {$zu(115,5)}, pFileName As %Library.String(MAXLEN=""), pDelimiter As %String = ",", pQuote As %String = """", pHeaders As %Integer = 0, ByRef pRecordCount As %Integer) As %Library.Integer [ SqlProc ]
    //if importData d $ClassMethod(pclass,"Import",1,fncsv,dlm,,1,.recordCount)
    q sc
}

/// returns the string in format: "FieldName1 VARCHAR(250), FieldName2 VARCHAR(250)"
/// if guessTypes=1 tries to guess the type upon the value taking first n rows
/// deep - how many rows to take for analysis
ClassMethod GetRowTypes(fncsv As %String, dlm As %String = ",", guessTypes As %Boolean = 0, deep As %Integer = 5) As %String
{
    set rowtypes=""
    set stream=..GetStreamFromFile(fncsv)
    if 'guessTypes {
        set line=stream.ReadLine()

        for i=1:1:$Length(line,dlm) {
            set $Piece(rowtypes,dlm,i)=$TR($Piece(line,dlm,i)," ","")_" VARCHAR(250)"
        }
    }
    if guessTypes {
        set header=stream.ReadLine() // header
        // load test lines
        for r=1:1:deep{
            if stream.AtEnd set deep=r-1 quit
            set line(r)=stream.ReadLine()
            set line(r)=..RemoveDlm(line(r),dlm)
        }
        
        for i=1:1:($Length(header,dlm)) {
            kill types
            for r=1:1:deep {
                do ##class(datatypes).Guess($Piece(line(r),dlm,i),.types)
                }
            set type=##class(datatypes).Decide(.types) 
            //if type="DATE" set type ="VARCHAR"
            if type="VARCHAR" set type="VARCHAR(250)"
            set $Piece(rowtypes,dlm,i)=$TR($Piece(header,dlm,i)," ","")_" "_type

        }
        

    }

    set rowtypes=$TR(rowtypes,dlm,",")
    // change "." symbol in column names
    set rowtypes=$TR(rowtypes,".","_")
    Return rowtypes
}

/// remove all occurences of dlm inside quoutes
ClassMethod RemoveDlm(str As %String, dlm As %String = ",") As %String
{
    //s str="1,0,3,""Braund, Mr. Owen Harris"",male,22,1,0,A/5 21171,7.25,,S"
    //s str="29,1,3,""O'Dwyer, Miss. Ellen ""Nellie"""",female,,0,0,330959,7.8792,,Q"
    set quote=""""
    While $L(str,quote)>1 {
        set $P(str,quote,2)=$Tr($P(str,quote,2),dlm)
        set str=$P(str,quote,1)_$P(str,quote,2)_$p(str,quote,3,*)
    }
    return str
}

ClassMethod GetStreamFromFile(fn As %String) As %Stream
{
    set stream = ##Class(%Stream.FileCharacter).%New()
    set stream.LineTerminator = $Char(13,10)
    $$$TOE(sc,stream.LinkToFile(fn))
    //TBD check for sc
    return stream
}

ClassMethod StreamToFile(stream As %Stream, ByRef filename As %String) As %Status
{
    if $G(filename)="" set filename=##class(%File).NormalizeDirectory(##class(%SYS.System).TempDirectory())_"stream"_($zd($h,8)) 
    Set file=##class(%Stream.FileCharacter).%New()
    Do file.LinkToFile(filename)
    Set sc=file.CopyFromAndSave(stream)
    return sc
}

/// 
/// URL=example.com/data/document.csv
ClassMethod GetStreamFromURL(URL As %String, SSLConf As %String = "default") As %CharacterStream
{
    //set SSLConfig="GitHub"   
    //do:'##class(Security.SSLConfigs).Exists(SSLConfig) ##class(Security.SSLConfigs).Create(SSLConfig)
    if $L(URL,"http")>1 set URL=$P(URL,"//",2)
    Set httprequest = ##class(%Net.HttpRequest).%New()
    Set httprequest.Server = $P(URL,"/")
    Set httprequest.Https = 1
    Set httprequest.SSLConfiguration = SSLConf
    set filename="/"_$P(URL,"/",2,*)
    $$$TOE(sc,httprequest.Get(filename))
    Set stream = httprequest.HttpResponse.Data
    
    //Reset the HTTP connection, to allow for another connection and not throw a 404 error
    Do httprequest.Reset()

    //TBD check for sc
    return stream
}

}
