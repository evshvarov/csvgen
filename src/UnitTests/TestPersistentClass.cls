Class UnitTests.TestPersistentClass Extends %UnitTest.TestCase
{

Method TestCreateRecord()
{
   do $$$AssertStatusOK(##class(community.objectscript.PersistentClass).CreateRecord(),"Create Record")
}

}
