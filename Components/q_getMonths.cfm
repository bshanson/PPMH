<!----------------------------------------------------------------------------------------------------------
Description:
	get months

History:
	2/19/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- get months --->
<CFQUERY NAME="getMonths" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select Month_ID, Month
	from WebSite_Admin.dbo.Month
	order by Month_ID
</CFQUERY>
