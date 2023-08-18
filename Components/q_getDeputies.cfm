<!--------------------------------------------------------------
Description:
	get the Deputies

History:
	04/01/2022 - created
--------------------------------------------------------------->

<!--- get the Deputies --->
<CFQUERY NAME="getDeputies" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT DISTINCT a.Portfolio_Deputy_ID, b.User_ID, b.Last_Name, b.First_Name
	FROM TurboScope.dbo.Admin_Site as a
		inner join WebSite_Admin.dbo.Web_Site_Users as b on a.Portfolio_Deputy_ID = b.User_ID and b.active = 1
	ORDER BY b.Last_Name, b.First_Name
</CFQUERY>
