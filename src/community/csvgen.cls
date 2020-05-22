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
	set status=##class(community.csvgen).GenerateFromURL(url,",",,1,.tResults)
    Write tResults
    return status
}

ClassMethod Run() As %Status
{
	set fn="/irisdev/app/data/covid-03-16-2020.csv"
	set status=##class(community.csvgen).Generate(fn,",",,.tResults)
    return status
}

ClassMethod GenerateFromURL(URL As %String, dlm As %String = ",", pclass As %String, ByRef recordCount As %Integer) As %Status
{
    s stream=..GetStreamFromURL(URL)
    s sc=..StreamToFile(stream,.filename)
    s sc=..Generate(filename,dlm,.pclass,.recordCount)  
    return sc
}

/// generates class for an arbitrary CSV. All the properties are VARCHAR 250
/// fncsv - csv file on disk
/// dlm - delimeter
/// pclass - class name, if not passed, then will be generated and returned by ref
/// importData - 1, if you want data be loaded into the generated class 
/// recordCount - amount of records created and returned byRef
ClassMethod Generate(fncsv As %String, dlm As %String = ",", ByRef pclass As %String, Output recordsCount As %Integer) As %Status
{
    set sc=$$$OK
    if $g(pclass)="" set pclass="community.csvgen.generated."_$TR($E(fncsv,1,5),"/.","")_($zd($h,8))
    set rowtype=..GetRowTypes(fncsv,dlm,1)
    do ##class(%SQL.Util.Procedures).CSVTOCLASS(1, rowtype, fncsv,",", ,1, pclass)
    set sc=..HowManyRecords(pclass,.recordsCount)
    //ClassMethod Import(pSelectMode As %Library.Integer = {$zu(115,5)}, pFileName As %Library.String(MAXLEN=""), pDelimiter As %String = ",", pQuote As %String = """", pHeaders As %Integer = 0, ByRef pRecordCount As %Integer) As %Library.Integer [ SqlProc ]
    //if importData d $ClassMethod(pclass,"Import",1,fncsv,dlm,,1,.recordCount)
    q sc
}

/// returns the string in format: "FieldName1 VARCHAR(250), FieldName2 VARCHAR(250)"
/// if guessTypes=1 tries to guess the type upon the value taking first n rows
/// deep - how many rows to take for analysis
ClassMethod GetRowTypes(fncsv As %String, dlm As %String = ",", guessTypes As %Boolean = 0, deep As %Integer = 4) As %String
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
            if stream.AtEnd quit
            set line(r)=stream.ReadLine()
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

    
    Return rowtypes
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