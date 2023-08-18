<!-------------------------------------------
Description:
	query to get the unclaimed milestones

History:
	4/7/2021 - created
-------------------------------------------->

<cfset RegionsToFind = "">
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">
<!--- set RegionsToFind --->
<cfloop query="getRegions">
	<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")><cfset RegionsToFind = listappend(RegionsToFind,getRegions.COP_Region_ID)></cfif>
</cfloop>

<!--- set period ranges --->
<cfif form.startmonthtofind LTE 9><cfset startMonth = "0" & form.startmonthtofind><cfelse><cfset startMonth = form.startmonthtofind></cfif>
<cfset startPeriod = form.startyeartofind & startMonth>

<cfif form.endmonthtofind LTE 9><cfset endMonth = "0" & form.endmonthtofind><cfelse><cfset endMonth = form.endmonthtofind></cfif>
<cfset endPeriod = form.endyeartofind & endMonth>

<CFQUERY NAME="getUnclaimedMilestones" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT a.id, a.milestone_id, a.Milestone_Plan_Date, a.notes, a.Claim, a.Milestone_Amount, a.Milestone_Baseline_Date, a.Skip,
		c.milestone,
		d.site_id, d.site_Name, d.zip_Code,
		e.portfolio as Site_Portfolio,
		f.State_Abbreviation,
		g.Region,
		e.portfolio,
		h.last_Name + ', ' + h.first_name as SiteManager,
		i.last_Name + ', ' + i.first_name as Deputy,
		j.portfolio as Milestone_Portfolio,
		k.Delay_Reason
	FROM PPMH.dbo.Site_Milestones as a
		inner join PPMH.dbo.Milestones as c on a.milestone_id = c.ID
		inner join TurboScope.dbo.Admin_Site as d on a.site_id = d.ID <cfif form.MilestonePortfolioToFind EQ "0">and a.Portfolio_ID = d.Portfolio_ID</cfif>
		inner join TurboScope.dbo.Admin_Portfolio as e on d.portfolio_id = e.portfolio_id
		left join TurboScope.dbo.Admin_State as f on d.state_id = f.State_ID
		left join TurboScope.dbo.Admin_COP_Region as g on d.COP_Region_ID = g.COP_Region_ID
		left join WebSite_Admin.dbo.Web_Site_Users as h on d.SM_ID = h.User_ID
		left join WebSite_Admin.dbo.Web_Site_Users as i on d.Portfolio_Deputy_ID = i.User_ID
		left join TurboScope.dbo.Admin_Portfolio as j on a.portfolio_id = j.portfolio_id
		left join PPMH.dbo.Delay_Reason as k on a.Delay_Reason_ID = k.Delay_Reason_ID
	WHERE	(a.Claim = 0 or a.Claim is NULL)
		<cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind NEQ 0> AND d.Portfolio_ID = #form.SitePortfolioToFind#</cfif>
		<cfif len(RegionsToFind)> and d.COP_Region_ID in (#RegionsToFind#)</cfif>
		<cfif isDefined("form.SiteIDtofind") and len(form.SiteIDtofind)> AND d.Site_ID like ('%#trim(form.SiteIDtofind)#%')</cfif>
		<cfif isDefined("form.SiteNameToFind") and len(form.SiteNameToFind)> AND d.Site_Name like ('%#trim(form.SiteNameToFind)#%')</cfif>
		<cfif isDefined("form.AddressToFind") and len(form.AddressToFind)> AND d.Address like ('%#trim(form.AddressToFind)#%')</cfif>
		<cfif isDefined("form.CityToFind") and len(form.CityToFind)> AND d.City like ('%#trim(form.CityToFind)#%')</cfif>
		<cfif isDefined("form.StateToFind") and form.StateToFind NEQ "0"> AND d.State_ID = (#form.StateToFind#)</cfif>
		<cfif isDefined("form.smtofind") and form.smtofind NEQ 0> AND d.SM_ID = ('#form.smtofind#')</cfif>
		<cfif isDefined("form.DeputyToFind") and form.DeputyToFind NEQ 0> AND d.Portfolio_Deputy_ID = ('#form.DeputyToFind#')</cfif>
		<cfif isDefined("form.MilestonePortfolioToFind") and form.MilestonePortfolioToFind NEQ "0"> AND a.Portfolio_ID = (#form.MilestonePortfolioToFind#)</cfif>
		<cfif isDefined("form.milestonetofind") and form.milestonetofind NEQ "0"> AND c.ID = (#form.milestonetofind#)</cfif>
		and (a.Milestone_Plan_Date between #startPeriod# and #endPeriod#)
	order by a.Site_ID, 
		a.Milestone_ID, 
		a.Milestone_Plan_Date
</CFQUERY>
