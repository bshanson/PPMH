<!--------------------------------------------------------------
Description:
	get the Chevron Portfolio Managers

History:
	4/3/2020 - created
--------------------------------------------------------------->

<!--- get the Chevron Portfolio Managers --->
<CFQUERY NAME="getChevronPortfolioManagers" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT User_ID, Last_Name, First_Name
	FROM WebSite_Admin.dbo.Web_Site_Users
	WHERE (User_ID IN (SELECT DISTINCT Chevron_PM_ID FROM Turboscope.dbo.Admin_Site))
		AND (Active = 1)
	ORDER BY Last_Name, First_Name
</CFQUERY>
