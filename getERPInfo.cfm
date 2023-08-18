<!-------------------------------------------
Description:
	query to get ERP info from the site status table
-------------------------------------------->

<!--- get Sites --->
<CFQUERY NAME="getSites" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT DISTINCT Site_ID
	FROM PPMH.dbo.Site_Status
	ORDER BY Site_ID
</CFQUERY>
<!---<cfdump var="#getSites#">--->

	<cfset recno=0>
	<table>
		<tr>
			<td width="15%">Site_ID</td>
			<td width="15%">admin_Site_ID</td>
			<td width="15%">Period</td>
			<td width="15%">ERP_Stage_ID</td>
			<td width="15%">ERP_Stage</td>
		</tr>
<cfloop query="getSites">
	<!--- get max period for a site --->
	<CFQUERY NAME="getMaxPeriod" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
		SELECT Site_ID, MAX(Period) AS maxPeriod
		FROM ppmh.dbo.Site_Status
		WHERE (Site_ID IN (#getSites.Site_ID#))
		GROUP BY Site_ID
	</CFQUERY>
<!---	<cfdump var="#getMaxPeriod#">--->

	<!--- get erp info --->
	<CFQUERY NAME="getERPInfo" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
		SELECT a.Site_ID, c.Site_ID as admin_Site_ID, a.Period, a.ERP_Stage_ID, b.ERP_Stage
		FROM ppmh.dbo.Site_Status as a
		left join ppmh.dbo.ERP_Stage as b on a.ERP_Stage_ID = b.ERP_Stage_ID
		left join turboscope.dbo.admin_site as c on a.site_ID = c.ID
		WHERE a.Site_ID = #getSites.Site_ID# and a.period = #getMaxPeriod.maxPeriod#
	</CFQUERY>
		<cfoutput>
		<tr>
			<td>#getERPInfo.Site_ID#</td>
			<td>#getERPInfo.admin_Site_ID#</td>
			<td>#getERPInfo.Period#</td>
			<td>#getERPInfo.ERP_Stage_ID#</td>
			<td>#getERPInfo.ERP_Stage#</td>
		</tr>
		<cfset recno=recno+1>
		</cfoutput>
</cfloop>
	</table>
<cfdump var="#recno#">