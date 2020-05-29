Class community.csvgen.generated.usr20200529 Extends %Library.Persistent [ Not Abstract, DdlAllowed, Not LegacyInstanceContext, ProcedureBlock ]
{

Property FIPS As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 2 ];

Property Admin2 As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 3 ];

Property ProvinceState As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 4, SqlFieldName = Province_State ];

Property CountryRegion As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 5, SqlFieldName = Country_Region ];

Property LastUpdate As %Library.Date [ SqlColumnNumber = 6, SqlFieldName = Last_Update ];

Property Lat As %Library.Currency [ SqlColumnNumber = 7 ];

Property Long As %Library.Double [ SqlColumnNumber = 8, SqlFieldName = Long_ ];

Property Confirmed As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 9 ];

Property Deaths As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 10 ];

Property Recovered As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 11 ];

Property Active As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 12 ];

Property CombinedKey As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 13, SqlFieldName = Combined_Key ];

ClassMethod Run() As %Status
{
  set fn="/irisdev/app/data/covid-05-17-2020.csv"
  do ..Import(1,fn,,,1)
  q $$$OK
}

ClassMethod Import(pSelectMode As %Library.Integer = {$zu(115,5)}, pFileName As %Library.String(MAXLEN=""), pDelimiter As %String = ",", pQuote As %String = """", pHeaders As %Integer = 0, ByRef pRecordCount As %Integer) As %Library.Integer [ SqlProc ]
{
	set tStatementId = $SYSTEM.Util.CreateGUID(), tCounter = 0, pRecordCount = 0
	set tPreparedStatement = ##class(%SQL.DynamicStatement).Prepare(tStatementId,..#ROWTYPE,pDelimiter,pQuote,,,0,"CSV")
	if $Isobject(tPreparedStatement) {
		set tImporter = tPreparedStatement.%New(tPreparedStatement,,pFileName,pDelimiter,pQuote)
		if $Isobject(tImporter) {
			do ..%DeleteExtent(,.tDeleted,.tInstances,1)
				// burn the column headers
			for tPtr = 1:1:pHeaders { do tImporter.%Next() }
			while tImporter.%Next() {
				set tMe = ..%New()
				if 'pSelectMode {
					set tMe.FIPS = tImporter.%GetData(1)
					set tMe.Admin2 = tImporter.%GetData(2)
					set tMe.ProvinceState = tImporter.%GetData(3)
					set tMe.CountryRegion = tImporter.%GetData(4)
					set tMe.LastUpdate = tImporter.%GetData(5)
					set tMe.Lat = tImporter.%GetData(6)
					set tMe.Long = tImporter.%GetData(7)
					set tMe.Confirmed = tImporter.%GetData(8)
					set tMe.Deaths = tImporter.%GetData(9)
					set tMe.Recovered = tImporter.%GetData(10)
					set tMe.Active = tImporter.%GetData(11)
					set tMe.CombinedKey = tImporter.%GetData(12)
				}
				elseif pSelectMode = 1 {
					set tMe.FIPS = $s('$system.CLS.IsMthd("FIPSOdbcToLogical"):tImporter.%GetData(1),1:tMe.FIPSOdbcToLogical(tImporter.%GetData(1)))
					set tMe.Admin2 = $s('$system.CLS.IsMthd("Admin2OdbcToLogical"):tImporter.%GetData(2),1:tMe.Admin2OdbcToLogical(tImporter.%GetData(2)))
					set tMe.ProvinceState = $s('$system.CLS.IsMthd("ProvinceStateOdbcToLogical"):tImporter.%GetData(3),1:tMe.ProvinceStateOdbcToLogical(tImporter.%GetData(3)))
					set tMe.CountryRegion = $s('$system.CLS.IsMthd("CountryRegionOdbcToLogical"):tImporter.%GetData(4),1:tMe.CountryRegionOdbcToLogical(tImporter.%GetData(4)))
					set tMe.LastUpdate = $s('$system.CLS.IsMthd("LastUpdateOdbcToLogical"):tImporter.%GetData(5),1:tMe.LastUpdateOdbcToLogical(tImporter.%GetData(5)))
					set tMe.Lat = $s('$system.CLS.IsMthd("LatOdbcToLogical"):tImporter.%GetData(6),1:tMe.LatOdbcToLogical(tImporter.%GetData(6)))
					set tMe.Long = $s('$system.CLS.IsMthd("LongOdbcToLogical"):tImporter.%GetData(7),1:tMe.LongOdbcToLogical(tImporter.%GetData(7)))
					set tMe.Confirmed = $s('$system.CLS.IsMthd("ConfirmedOdbcToLogical"):tImporter.%GetData(8),1:tMe.ConfirmedOdbcToLogical(tImporter.%GetData(8)))
					set tMe.Deaths = $s('$system.CLS.IsMthd("DeathsOdbcToLogical"):tImporter.%GetData(9),1:tMe.DeathsOdbcToLogical(tImporter.%GetData(9)))
					set tMe.Recovered = $s('$system.CLS.IsMthd("RecoveredOdbcToLogical"):tImporter.%GetData(10),1:tMe.RecoveredOdbcToLogical(tImporter.%GetData(10)))
					set tMe.Active = $s('$system.CLS.IsMthd("ActiveOdbcToLogical"):tImporter.%GetData(11),1:tMe.ActiveOdbcToLogical(tImporter.%GetData(11)))
					set tMe.CombinedKey = $s('$system.CLS.IsMthd("CombinedKeyOdbcToLogical"):tImporter.%GetData(12),1:tMe.CombinedKeyOdbcToLogical(tImporter.%GetData(12)))
				}
				elseif pSelectMode = 2 {
					set tMe.FIPS = $s('$system.CLS.IsMthd("FIPSDisplayToLogical"):tImporter.%GetData(1),1:tMe.FIPSDisplayToLogical(tImporter.%GetData(1)))
					set tMe.Admin2 = $s('$system.CLS.IsMthd("Admin2DisplayToLogical"):tImporter.%GetData(2),1:tMe.Admin2DisplayToLogical(tImporter.%GetData(2)))
					set tMe.ProvinceState = $s('$system.CLS.IsMthd("ProvinceStateDisplayToLogical"):tImporter.%GetData(3),1:tMe.ProvinceStateDisplayToLogical(tImporter.%GetData(3)))
					set tMe.CountryRegion = $s('$system.CLS.IsMthd("CountryRegionDisplayToLogical"):tImporter.%GetData(4),1:tMe.CountryRegionDisplayToLogical(tImporter.%GetData(4)))
					set tMe.LastUpdate = $s('$system.CLS.IsMthd("LastUpdateDisplayToLogical"):tImporter.%GetData(5),1:tMe.LastUpdateDisplayToLogical(tImporter.%GetData(5)))
					set tMe.Lat = $s('$system.CLS.IsMthd("LatDisplayToLogical"):tImporter.%GetData(6),1:tMe.LatDisplayToLogical(tImporter.%GetData(6)))
					set tMe.Long = $s('$system.CLS.IsMthd("LongDisplayToLogical"):tImporter.%GetData(7),1:tMe.LongDisplayToLogical(tImporter.%GetData(7)))
					set tMe.Confirmed = $s('$system.CLS.IsMthd("ConfirmedDisplayToLogical"):tImporter.%GetData(8),1:tMe.ConfirmedDisplayToLogical(tImporter.%GetData(8)))
					set tMe.Deaths = $s('$system.CLS.IsMthd("DeathsDisplayToLogical"):tImporter.%GetData(9),1:tMe.DeathsDisplayToLogical(tImporter.%GetData(9)))
					set tMe.Recovered = $s('$system.CLS.IsMthd("RecoveredDisplayToLogical"):tImporter.%GetData(10),1:tMe.RecoveredDisplayToLogical(tImporter.%GetData(10)))
					set tMe.Active = $s('$system.CLS.IsMthd("ActiveDisplayToLogical"):tImporter.%GetData(11),1:tMe.ActiveDisplayToLogical(tImporter.%GetData(11)))
					set tMe.CombinedKey = $s('$system.CLS.IsMthd("CombinedKeyDisplayToLogical"):tImporter.%GetData(12),1:tMe.CombinedKeyDisplayToLogical(tImporter.%GetData(12)))
				}
				set tStatus = tMe.%Save()
				if $$$ISOK(tStatus) { set tCounter = tCounter + 1 }
			}
		}
	}
	set %sqlcontext.%SQLCODE = 0
	set %sqlcontext.%ROWCOUNT = tCounter
	set pRecordCount = tCounter
	quit tCounter
}

Parameter ROWTYPE = "FIPS INTEGER,Admin2 VARCHAR(250),Province_State VARCHAR(250),Country_Region VARCHAR(250),Last_Update DATE,Lat MONEY,Long_ DOUBLE,Confirmed INTEGER,Deaths INTEGER,Recovered INTEGER,Active INTEGER,Combined_Key VARCHAR(250)";

Storage Default
{
<Data name="usr20200529DefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>FIPS</Value>
</Value>
<Value name="3">
<Value>Admin2</Value>
</Value>
<Value name="4">
<Value>ProvinceState</Value>
</Value>
<Value name="5">
<Value>CountryRegion</Value>
</Value>
<Value name="6">
<Value>LastUpdate</Value>
</Value>
<Value name="7">
<Value>Lat</Value>
</Value>
<Value name="8">
<Value>Long</Value>
</Value>
<Value name="9">
<Value>Confirmed</Value>
</Value>
<Value name="10">
<Value>Deaths</Value>
</Value>
<Value name="11">
<Value>Recovered</Value>
</Value>
<Value name="12">
<Value>Active</Value>
</Value>
<Value name="13">
<Value>CombinedKey</Value>
</Value>
</Data>
<DataLocation>^community.csvgeBF0.usr20200529D</DataLocation>
<DefaultData>usr20200529DefaultData</DefaultData>
<IdLocation>^community.csvgeBF0.usr20200529D</IdLocation>
<IndexLocation>^community.csvgeBF0.usr20200529I</IndexLocation>
<StreamLocation>^community.csvgeBF0.usr20200529S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
