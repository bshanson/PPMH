<!--------------------------------------------------------------------------------------------------------------------------------
Description:
	query to get Milestones

History:
	2/19/2020 - created
--------------------------------------------------------------------------------------------------------------------------------->

<!--- get the site Milestones --->
<cfif Attributes.Type EQ "site">
	<cfquery name="getMilestones"  datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT b.id, b.Milestone, b.UploadDoc,
					 a.ID as SiteMilestoneID, a.Year, a.Milestone_Amount, a.Quantity, a.Milestone_Plan_Date, a.Milestone_Baseline_Date,
					 a.period, a.site_id, a.Milestone_Doc, a.On_Track, a.Skip, a.FCO, a.Deliverable, a.Notes, a.Claim, a.ACS_Milestone,
					 c.ERP_Stage,
					 d.Delay_Reason
		FROM PPMH.dbo.Site_Milestones AS a 
				 INNER JOIN PPMH.dbo.Milestones AS b ON a.Milestone_ID = b.id and b.Active = 1
				 Left JOIN PPMH.dbo.ERP_Stage AS c ON b.ERP_Stage_ID = c.ERP_Stage_ID and c.Active = 1
				 left JOIN PPMH.dbo.Delay_Reason AS d ON a.Delay_Reason_ID = d.Delay_Reason_ID
		WHERE a.Site_ID = <cfqueryparam value="#attributes.AdminSiteID#" cfsqltype="cf_sql_integer" >
					<cfif len(attributes.StatusPortfolioID)>and a.Portfolio_ID = #attributes.StatusPortfolioID#</cfif>
		<cfif isDefined("attributes.Sort") and attributes.Sort EQ "erp">
		ORDER BY c.ERP_Stage, b.Milestone, a.Milestone_Plan_Date
		<cfelseif  isDefined("attributes.Sort") and attributes.Sort EQ "plandate">
		ORDER BY a.Milestone_Plan_Date, b.Milestone
		<cfelse>
		ORDER BY b.Milestone, a.Milestone_Plan_Date
		</cfif>
	</cfquery>
</cfif>

<CFSET "Caller.#Attributes.Return#" = getMilestones>
