Class evshvarov.csvgen.csv
{

/// generates class for an arbitrary CSV. All the properties are VARCHAR 250
/// fncsv - csv file on disk
/// dlm - delimeter
/// pclass - class name, if not passed, then will be generated and returned by ref
/// importData - 1, if you want data be loaded into the generated class 
/// recordCount - amount of records created and returned byRef
ClassMethod Generate(fncsv As %String, dlm As %String = ",", ByRef pclass As %String, importData As %Boolean = 1, ByRef recordCount As %Integer) As %Status
{
    if $g(pclass)="" set pclass="evshvarov.csvgen.generated."_$TR($E(fncsv,1,5),"/.","")_($zd($h,8))
    set rowtype=..GetRowTypes(fncsv,dlm)
    do ##class(%SQL.Util.Procedures).CSVTOCLASS(, rowtype, fncsv,",", ,1, pclass)
    //ClassMethod Import(pSelectMode As %Library.Integer = {$zu(115,5)}, pFileName As %Library.String(MAXLEN=""), pDelimiter As %String = ",", pQuote As %String = """", pHeaders As %Integer = 0, ByRef pRecordCount As %Integer) As %Library.Integer [ SqlProc ]
    if importData d $ClassMethod(pclass,"Import",,fncsv,dlm,,1,.recordCount)
    q $$$OK
}

/// returns the string in format: "FieldName1 VARCHAR(250), FieldName2 VARCHAR(250)"
ClassMethod GetRowTypes(fncsv As %String, dlm As %String = ",") As %String
{
    set stream=..GetStreamFromFile(fncsv)
    set line=stream.ReadLine()
    for i=1:1:$Length(line,dlm) {
        set $Piece(rowtypes,dlm,i)=$TR($Piece(line,dlm,i)," ","")_" VARCHAR(250)"
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

}
