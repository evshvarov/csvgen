Class evshvarov.datatypes
{

/// types - is a byref, which will return types='type' - preferred type
/// all other types that match
/// types("%String")=""
/// ...
/// types("%Interger")=""
ClassMethod Guess(value As %String, ByRef types As %String) As %Status
{
   if $IsvalidDouble(value) {
       if $I(types("%Double"))
       if $L(value,".")>1,$L($P(value,".",2))<5 if $I(types("%Numeric"))
       if ($L(value,".")=1) if $I(types("%Integer"))
   quit $$$OK
   }
   if ..IsDate(value) {
       if $I(types("%Date")) 
       Quit $$$OK 
   }
   if $I(types("%String"))

   return $$$OK
}

ClassMethod IsDate(pVar As %String = "") As %Boolean
{
    set result=$$$YES
    Try {
        Set test = $ZDateH(pVar,5)
    }
    Catch e {
        set result=$$$NO
    }

    Quit result
}

}
