<!-------------------------------------------
Description:
	query to get the ERP info from Site_Status
-------------------------------------------->

<!--- get Site_Status --->
<CFQUERY NAME="getMaxPeriod" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT Site_ID, MAX(Period) AS maxPeriod
	FROM PPMH.dbo.Site_Status
	GROUP BY Site_ID
	ORDER BY Site_ID
</CFQUERY>

<cfoutput>
	<table width="100%">
		<tr>
			<td>Site ID</td>
			<td>Site Name</td>
			<td>Portfolio</td>
			<td>ERP Stage</td>
		</tr>
		<cfset loopno = 0>
		<cfloop query="getMaxPeriod">
		<cfset loopno = loopno + 1>
			<!--- get Sites ERP based on above query --->
			<CFQUERY NAME="getSitesERP" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
				SELECT a.Site_ID, a.Period,
					b.ERP_Stage, 
					c.Site_ID as AdminSiteID, c.Site_Name,
					d.Portfolio
				FROM PPMH.dbo.Site_Status as a
					left join PPMH.dbo.ERP_Stage as b on a.ERP_Stage_ID = b.ERP_Stage_ID
					left join TurboScope.dbo.Admin_Site as c on a.Site_ID = c.ID 
					left join TurboScope.dbo.Admin_Portfolio as d on c.Portfolio_ID = d.Portfolio_ID 
				where a.Site_ID = #getMaxPeriod.Site_ID# 
						and a.Period = #getMaxPeriod.maxPeriod#
			</CFQUERY>
			<tr>
				<td>#getSitesERP.AdminSiteID#</td>
				<td>#getSitesERP.Site_Name#</td>
				<td>#getSitesERP.Portfolio#</td>
				<td>#getSitesERP.ERP_Stage#</td>
			</tr>
		</cfloop>
	</table>
	loopno=#loopno#
</cfoutput>