<!-------------------------------------------
Description:
	query to get the review sites

History:
	3/26/2020 - created
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

<cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind EQ 64>
	<CFQUERY NAME="getReviewSites" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT a.ID, a.Site_ID, a.Site_Name, a.Address, a.City, a.State_ID, a.COP_ID, a.COP_Region_ID, a.Portfolio_ID, a.zip_code,
			c.Period, c.Milestone_Doc, c.Milestone_Year, c.Year, c.Skip, c.Notes, c.Milestone_Amount, c.Quantity, c.SAP_Charge_Code, c.Portfolio_ID as Milestone_Portfolio_ID,
			c.Milestone_Plan_Date,
			d.ID as MID, d.Milestone, d.MGC_Ariba_Codes,
			f.State_Abbreviation,
			'' as Overall_Project_Status, '' as Forecast_Quarter, '' as Forecast_Year,
			h.Bill_Set,
			i.Contract_Line_Number,
			'-' + j.ERP_Code as ERP_Code,
			k.last_name + ', ' + k.first_name as OpsLead
		FROM TurboScope.dbo.Admin_Site as a
		inner join PPMH.dbo.Site_Milestones as c on a.ID = c.Site_ID and (c.Period between #startPeriod# and #endPeriod#) and (c.Claim = 1)
		inner join PPMH.dbo.Milestones as d on c.Milestone_ID = d.ID
		inner join TurboScope.dbo.Admin_State as f on a.state_ID = f.State_ID
		left join TurboScope.dbo.Admin_Taxation_Base as h on f.Taxation_Base_ID = h.Taxation_Base_ID
		left join PPMH.dbo.Site_Milestones_Contract_Line_Number as i on c.Milestone_ID = i.Milestone_ID and a.ID = i.Admin_Site_ID
		left join WebSite_Admin.dbo.Web_Site_Users as k on a.Chevron_PM_ID = k.User_ID
		WHERE a.Site_ID is not NULL
			and a.Status = 'A'
			<cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind NEQ 0> AND a.Portfolio_ID = #form.SitePortfolioToFind#</cfif>
			<cfif len(RegionsToFind)> and a.COP_Region_ID in (#RegionsToFind#)</cfif>
			<cfif isDefined("form.SiteIDtofind") and len(form.SiteIDtofind)> AND a.Site_ID like ('%#trim(form.SiteIDtofind)#%')</cfif>
			<cfif isDefined("form.SiteNameToFind") and len(form.SiteNameToFind)> AND a.Site_Name like ('%#trim(form.SiteNameToFind)#%')</cfif>
			<cfif isDefined("form.AddressToFind") and len(form.AddressToFind)> AND a.Address like ('%#trim(form.AddressToFind)#%')</cfif>
			<cfif isDefined("form.CityToFind") and len(form.CityToFind)> AND a.City like ('%#trim(form.CityToFind)#%')</cfif>
			<cfif isDefined("form.StateToFind") and form.StateToFind NEQ "0"> AND a.State_ID = (#form.StateToFind#)</cfif>
			<cfif isDefined("form.smtofind") and form.smtofind NEQ 0> AND a.SM_ID = ('#form.smtofind#')</cfif>
			<cfif isDefined("form.DeputyToFind") and form.DeputyToFind NEQ 0> AND a.Portfolio_Deputy_ID = ('#form.DeputyToFind#')</cfif>
			<cfif isDefined("form.ChevronOpsToFind") and form.ChevronOpsToFind NEQ 0> AND a.Chevron_PM_ID = ('#form.ChevronOpsToFind#')</cfif>
			<cfif isDefined("form.MilestonePortfolioToFind") and form.MilestonePortfolioToFind NEQ "0"> AND c.Portfolio_ID = (#form.MilestonePortfolioToFind#)<cfelse>AND c.Portfolio_ID = (a.Portfolio_id)</cfif>
			<cfif isDefined("form.milestonetofind") and form.milestonetofind NEQ "0"> AND d.ID = (#form.milestonetofind#)</cfif>
			<cfif isDefined("form.taxationbasetofind") and form.taxationbasetofind NEQ "0"> AND h.Taxation_Base_ID = (#form.taxationbasetofind#)</cfif>
		ORDER BY f.State_Abbreviation, a.Site_ID, c.Period DESC
	</CFQUERY>
<cfelse>
	<CFQUERY NAME="getReviewSites" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT a.ID, a.Site_ID, a.Site_Name, a.Address, a.City, a.State_ID, a.COP_ID, a.COP_Region_ID, a.Portfolio_ID, a.zip_code,
			c.Period, c.Milestone_Doc, c.Milestone_Year, c.Year, c.Skip, c.Notes, c.Milestone_Amount, c.Quantity, c.SAP_Charge_Code, c.Portfolio_ID as Milestone_Portfolio_ID,
			c.Milestone_Plan_Date,
			d.ID as MID, d.Milestone, d.MGC_Ariba_Codes,
			f.State_Abbreviation,
			g.Overall_Project_Status, g.Forecast_Quarter, g.Forecast_Year,
			h.Bill_Set,
			i.Contract_Line_Number,
			'-' + j.ERP_Code as ERP_Code,
			k.last_name + ', ' + k.first_name as OpsLead
		FROM TurboScope.dbo.Admin_Site as a
		inner join PPMH.dbo.Site_Milestones as c on a.ID = c.Site_ID and (c.Period between #startPeriod# and #endPeriod#) and (c.Claim = 1)
		inner join PPMH.dbo.Milestones as d on c.Milestone_ID = d.ID
		inner join TurboScope.dbo.Admin_State as f on a.state_ID = f.State_ID
		left join PPMH.dbo.Site_Status as g on c.Site_ID = g.Site_ID and c.Period = g.Period
		left join TurboScope.dbo.Admin_Taxation_Base as h on f.Taxation_Base_ID = h.Taxation_Base_ID
		left join PPMH.dbo.Site_Milestones_Contract_Line_Number as i on c.Milestone_ID = i.Milestone_ID and a.ID = i.Admin_Site_ID
		left join PPMH.dbo.ERP_Stage as j on g.ERP_Stage_ID = j.ERP_Stage_ID
		left join WebSite_Admin.dbo.Web_Site_Users as k on a.Chevron_PM_ID = k.User_ID
		WHERE a.Site_ID is not NULL
			and a.Status = 'A'
			<cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind NEQ 0> AND a.Portfolio_ID = #form.SitePortfolioToFind#</cfif>
			<cfif len(RegionsToFind)> and a.COP_Region_ID in (#RegionsToFind#)</cfif>
			<cfif isDefined("form.SiteIDtofind") and len(form.SiteIDtofind)> AND a.Site_ID like ('%#trim(form.SiteIDtofind)#%')</cfif>
			<cfif isDefined("form.SiteNameToFind") and len(form.SiteNameToFind)> AND a.Site_Name like ('%#trim(form.SiteNameToFind)#%')</cfif>
			<cfif isDefined("form.AddressToFind") and len(form.AddressToFind)> AND a.Address like ('%#trim(form.AddressToFind)#%')</cfif>
			<cfif isDefined("form.CityToFind") and len(form.CityToFind)> AND a.City like ('%#trim(form.CityToFind)#%')</cfif>
			<cfif isDefined("form.StateToFind") and form.StateToFind NEQ "0"> AND a.State_ID = (#form.StateToFind#)</cfif>
			<cfif isDefined("form.smtofind") and form.smtofind NEQ 0> AND a.SM_ID = ('#form.smtofind#')</cfif>
			<cfif isDefined("form.DeputyToFind") and form.DeputyToFind NEQ 0> AND a.Portfolio_Deputy_ID = ('#form.DeputyToFind#')</cfif>
			<cfif isDefined("form.ChevronOpsToFind") and form.ChevronOpsToFind NEQ 0> AND a.Chevron_PM_ID = ('#form.ChevronOpsToFind#')</cfif>
			<cfif isDefined("form.MilestonePortfolioToFind") and form.MilestonePortfolioToFind NEQ "0"> AND c.Portfolio_ID = (#form.MilestonePortfolioToFind#)<cfelse>AND c.Portfolio_ID = (a.Portfolio_id)</cfif>
			<cfif isDefined("form.milestonetofind") and form.milestonetofind NEQ "0"> AND d.ID = (#form.milestonetofind#)</cfif>
			<cfif isDefined("form.taxationbasetofind") and form.taxationbasetofind NEQ "0"> AND h.Taxation_Base_ID = (#form.taxationbasetofind#)</cfif>
		ORDER BY f.State_Abbreviation, a.Site_ID, c.Period DESC
	</CFQUERY>
</cfif>
