<!--------------------------------------------------------------
Description:
	toggle the users PM field on/off

History:
	1/11/2019 - created
--------------------------------------------------------------->

<!--- toggle the PM field --->
<CFQUERY NAME="updUserPM" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	update WebSite_Admin.dbo.Web_Site_User_Attribute 
	set PM = #attributes.toggle#
	where user_id = <cfqueryparam value="#attributes.uid#" cfsqltype="cf_sql_integer">
</CFQUERY>
