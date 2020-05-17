Class community.objectscript.RESTExample Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/version" Method="GET" Call="GetVersion"/>
<Route Url="/data" Method="GET" Call="GetData"/>

</Routes>
}

ClassMethod GetVersion() As %Status
{

    write $zv

    Quit $$$OK
}

ClassMethod GetData() As %Status
{

    ZWrite @##class(community.objectscript.ClassExample).#Global

    Quit $$$OK
}

}
