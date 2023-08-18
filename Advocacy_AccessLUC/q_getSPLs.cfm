<!--------------------------------------------------------------
Description:
	get the SPLs

History:
	1/10/2022 - created
--------------------------------------------------------------->

<!--- get the SPLs --->
<CFQUERY NAME="getSPLs" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT a.User_ID, b.First_Name, b.Last_Name
	FROM #Request.WebSite#.dbo.Site_Users_Attributes as a
		inner join WebSite_Admin.dbo.Web_Site_Users as b on a.User_ID = b.User_ID
	WHERE (a.SPL = 1)
	ORDER BY a.id
</CFQUERY>
