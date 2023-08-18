<!-------------------------------------------
Description:
	query to get Agency info for a site from PPMH.Site_Status

History:
	4/13/2021 - created
-------------------------------------------->

<!--- get the Site Agency Info --->
<CFQUERY NAME="getSiteAgencyInfo" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT Site_ID, Period, Regulatory_Agency, Agency_Person
	FROM PPMH.dbo.Site_Status
	WHERE  (Site_ID = #getRegulatory.Admin_Site_ID#)
	ORDER BY Period desc
</CFQUERY>
