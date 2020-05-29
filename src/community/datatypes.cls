Class community.datatypes
{

ClassMethod Decide(ByRef types) As %String
{
    If $D(types("MONEY")),$D(types("DOUBLE")) {
        if types("MONEY")=types("DOUBLE") return "MONEY"
    }
    set i=$Order(types(""))
    while i'="" {
        set typesI(types(i))=i
        set i=$Order(types(i))
    }
    if $D(typesI) return typesI($Order(typesI(""),-1))
    return "VARCHAR"
}

/// types - is a byref, which will return types='type' - preferred type
/// all other types that match
/// types("VARCHAR")=""
/// ...
/// types("%Interger")=""
ClassMethod Guess(value As %String, ByRef types) As %Status
{
   if $IsvalidDouble(value) {
       if $I(types("DOUBLE"))
       if $L(value,".")>1,$L($P(value,".",2))<10 if $I(types("MONEY"))
       if ($L(value,".")=1) if $I(types("INTEGER"))
   quit $$$OK
   }
   if ..IsDate(value) {
       if $I(types("DATE")) 
       Quit $$$OK 
   }
   if $I(types("VARCHAR"))

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
