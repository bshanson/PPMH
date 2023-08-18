<!--------------------------------------------------------------
Description:
	get the Access / LUC admins

History:
	10/03/2022 - created
--------------------------------------------------------------->

<!--- get the Access LUC Admins --->
<CFQUERY NAME="getAccessLUCAdmins" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT User_ID
	FROM  #Request.WebSite#.dbo.Site_Users_Attributes
	WHERE (Access_LUC_Admin = 1)
</CFQUERY>
<cfset canEditList = valuelist(getAccessLUCAdmins.User_ID)>
