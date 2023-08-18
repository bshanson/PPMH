<!----------------------------------------------------------------------------------------------------------
Description:
	get years

History:
	2/19/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- get years --->
<CFQUERY NAME="getYears" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select Year_ID
	from WebSite_Admin.dbo.Year
	order by Year_ID
</CFQUERY>
