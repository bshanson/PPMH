<!-------------------------------------------
Description:
	query to get the info from Site_Status from Site_Status_Temp table
-------------------------------------------->

<!--- get Site_Status --->
<CFQUERY NAME="getERPSites" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT Site_ID, Period, ERP_Stage_ID
	FROM PPMH.dbo.Site_Status_Temp
	ORDER BY Site_ID
</CFQUERY>
<cfloop query="getERPSites">
	<!--- update Site_Status based on above query --->
	<CFQUERY NAME="update" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
		update PPMH.dbo.Site_Status
		set ERP_Stage_ID = #getERPSites.ERP_Stage_ID#
		where Site_ID = #getERPSites.Site_ID# and Period = #getERPSites.Period# 
	</CFQUERY>
</cfloop>
done