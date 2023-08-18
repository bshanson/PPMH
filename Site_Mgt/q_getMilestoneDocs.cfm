
<!----------------------------------------------------------------------------------------------------------
Description:
	query for milestone docs

History:
	07/19/2016 - created
----------------------------------------------------------------------------------------------------------->

<!--- query for milestone docs --->
<cfquery name="getMilestoneDocs" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select a.ID, a.Milestone, b.period, b.Milestone_Doc, b.Milestone_Year, b.Year
	from PPMH.dbo.Milestones as a 
			 inner join PPMH.dbo.Site_Milestones as b on a.id = b.Milestone_ID 
					and b.Site_ID = '#attributes.AdminSiteID#'
					and b.Period = #attributes.Period#
	where a.ERP_Stage_ID = #attributes.type#
	order by a.ID
</cfquery>

<CFSET "Caller.#Attributes.Return#" = getMilestoneDocs>
