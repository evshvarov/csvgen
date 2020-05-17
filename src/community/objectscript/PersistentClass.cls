Class community.objectscript.PersistentClass Extends %Persistent
{

Property Test As %String(MAXLEN = 12);

ClassMethod CreateRecord() As %Status
{
    s objPC=..%New()
    s objPC.Test="Test string"
    #; some comment
    return objPC.%Save()
}

ClassMethod WriteAllRecords() As %Status
{

    #dim tSC As %Status = $$$OK

    Set rset = ..ExtentFunc()

    While rset.%Next() {   
        Set record =..%OpenId(rset.ID)    
        Write "ID=",record.%Id()," Test=",record.Test
        Write !

    }
    Quit tSC
}

Storage Default
{
<Data name="PersistentClassDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Test</Value>
</Value>
</Data>
<DataLocation>^community45DC.PersistentC1A93D</DataLocation>
<DefaultData>PersistentClassDefaultData</DefaultData>
<IdLocation>^community45DC.PersistentC1A93D</IdLocation>
<IndexLocation>^community45DC.PersistentC1A93I</IndexLocation>
<StreamLocation>^community45DC.PersistentC1A93S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
