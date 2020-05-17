Class csvgen.generated.iris20200517 Extends %Library.Persistent [ Not Abstract, DdlAllowed, Not LegacyInstanceContext, ProcedureBlock ]
{

Property ProvinceState As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 2, SqlFieldName = "Province/State" ];

Property CountryRegion As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 3, SqlFieldName = "Country/Region" ];

Property LastUpdate As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 4 ];

Property Confirmed As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 5 ];

Property Deaths As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 6 ];

Property Recovered As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 7 ];

Property Latitude As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 8 ];

Property Longitude As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 9 ];

ClassMethod Run() As %Status
{
	set fn="/irisdev/app/data/covid-03-16-2020.csv"
	s sc=..Import(,fn,",",,1,.rc)
	return sc
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
					set tMe.ProvinceState = tImporter.%GetData(1)
					set tMe.CountryRegion = tImporter.%GetData(2)
					set tMe.LastUpdate = tImporter.%GetData(3)
					set tMe.Confirmed = tImporter.%GetData(4)
					set tMe.Deaths = tImporter.%GetData(5)
					set tMe.Recovered = tImporter.%GetData(6)
					set tMe.Latitude = tImporter.%GetData(7)
					set tMe.Longitude = tImporter.%GetData(8)
				}
				elseif pSelectMode = 1 {
					set tMe.ProvinceState = $s('$system.CLS.IsMthd("ProvinceStateOdbcToLogical"):tImporter.%GetData(1),1:tMe.ProvinceStateOdbcToLogical(tImporter.%GetData(1)))
					set tMe.CountryRegion = $s('$system.CLS.IsMthd("CountryRegionOdbcToLogical"):tImporter.%GetData(2),1:tMe.CountryRegionOdbcToLogical(tImporter.%GetData(2)))
					set tMe.LastUpdate = $s('$system.CLS.IsMthd("LastUpdateOdbcToLogical"):tImporter.%GetData(3),1:tMe.LastUpdateOdbcToLogical(tImporter.%GetData(3)))
					set tMe.Confirmed = $s('$system.CLS.IsMthd("ConfirmedOdbcToLogical"):tImporter.%GetData(4),1:tMe.ConfirmedOdbcToLogical(tImporter.%GetData(4)))
					set tMe.Deaths = $s('$system.CLS.IsMthd("DeathsOdbcToLogical"):tImporter.%GetData(5),1:tMe.DeathsOdbcToLogical(tImporter.%GetData(5)))
					set tMe.Recovered = $s('$system.CLS.IsMthd("RecoveredOdbcToLogical"):tImporter.%GetData(6),1:tMe.RecoveredOdbcToLogical(tImporter.%GetData(6)))
					set tMe.Latitude = $s('$system.CLS.IsMthd("LatitudeOdbcToLogical"):tImporter.%GetData(7),1:tMe.LatitudeOdbcToLogical(tImporter.%GetData(7)))
					set tMe.Longitude = $s('$system.CLS.IsMthd("LongitudeOdbcToLogical"):tImporter.%GetData(8),1:tMe.LongitudeOdbcToLogical(tImporter.%GetData(8)))
				}
				elseif pSelectMode = 2 {
					set tMe.ProvinceState = $s('$system.CLS.IsMthd("ProvinceStateDisplayToLogical"):tImporter.%GetData(1),1:tMe.ProvinceStateDisplayToLogical(tImporter.%GetData(1)))
					set tMe.CountryRegion = $s('$system.CLS.IsMthd("CountryRegionDisplayToLogical"):tImporter.%GetData(2),1:tMe.CountryRegionDisplayToLogical(tImporter.%GetData(2)))
					set tMe.LastUpdate = $s('$system.CLS.IsMthd("LastUpdateDisplayToLogical"):tImporter.%GetData(3),1:tMe.LastUpdateDisplayToLogical(tImporter.%GetData(3)))
					set tMe.Confirmed = $s('$system.CLS.IsMthd("ConfirmedDisplayToLogical"):tImporter.%GetData(4),1:tMe.ConfirmedDisplayToLogical(tImporter.%GetData(4)))
					set tMe.Deaths = $s('$system.CLS.IsMthd("DeathsDisplayToLogical"):tImporter.%GetData(5),1:tMe.DeathsDisplayToLogical(tImporter.%GetData(5)))
					set tMe.Recovered = $s('$system.CLS.IsMthd("RecoveredDisplayToLogical"):tImporter.%GetData(6),1:tMe.RecoveredDisplayToLogical(tImporter.%GetData(6)))
					set tMe.Latitude = $s('$system.CLS.IsMthd("LatitudeDisplayToLogical"):tImporter.%GetData(7),1:tMe.LatitudeDisplayToLogical(tImporter.%GetData(7)))
					set tMe.Longitude = $s('$system.CLS.IsMthd("LongitudeDisplayToLogical"):tImporter.%GetData(8),1:tMe.LongitudeDisplayToLogical(tImporter.%GetData(8)))
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

Parameter ROWTYPE = "Province/State VARCHAR(250),Country/Region VARCHAR(250),LastUpdate VARCHAR(250),Confirmed VARCHAR(250),Deaths VARCHAR(250),Recovered VARCHAR(250),Latitude VARCHAR(250),Longitude VARCHAR(250)";

Storage Default
{
<Data name="iris20200517DefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>ProvinceState</Value>
</Value>
<Value name="3">
<Value>CountryRegion</Value>
</Value>
<Value name="4">
<Value>LastUpdate</Value>
</Value>
<Value name="5">
<Value>Confirmed</Value>
</Value>
<Value name="6">
<Value>Deaths</Value>
</Value>
<Value name="7">
<Value>Recovered</Value>
</Value>
<Value name="8">
<Value>Latitude</Value>
</Value>
<Value name="9">
<Value>Longitude</Value>
</Value>
</Data>
<DataLocation>^csvgen.generated.iris20200517D</DataLocation>
<DefaultData>iris20200517DefaultData</DefaultData>
<IdLocation>^csvgen.generated.iris20200517D</IdLocation>
<IndexLocation>^csvgen.generated.iris20200517I</IndexLocation>
<StreamLocation>^csvgen.generated.iris20200517S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
