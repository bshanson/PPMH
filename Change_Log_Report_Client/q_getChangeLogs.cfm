<!----------------------------------------------------------------------------------------------------------
Description:
	query to get the change records

History:
	9/20/2022 - created
----------------------------------------------------------------------------------------------------------->

<cfset RegionsToFind = "">
<!--- get COP regions --->
<cfinclude template="../components/q_getRegions.cfm">
<!--- set RegionsToFind --->
<cfloop query="getRegions">
	<cfif isDefined("form.RegionToFind#getRegions.COP_Region_ID#")><cfset RegionsToFind = listappend(RegionsToFind,getRegions.COP_Region_ID)></cfif>
</cfloop>

<cfif isDefined("form.FromDateToFind") and len(form.FromDateToFind) and not isValid("usdate", form.FromDateToFind)>
	<cfset FromError = "Invalid From Date">
<cfelseif isDefined("form.FromDateToFind") and len(form.FromDateToFind) and isValid("usdate", form.FromDateToFind)>
	<cfset form.FromDateToFind = dateformat((CreateODBCDate(form.FromDateToFind)),"mm/dd/yyyy")>
</cfif>

<cfif isDefined("form.ToDateToFind") and len(form.ToDateToFind) and not isValid("usdate", form.ToDateToFind)>
	<cfset ToError = "Invalid To Date">
<cfelseif isDefined("form.ToDateToFind") and len(form.ToDateToFind) and isValid("usdate", form.ToDateToFind)>
	<cfset form.ToDateToFind = dateformat((CreateODBCDate(form.ToDateToFind)),"mm/dd/yyyy")>
</cfif>

<cfif not len(FromError) and not len(ToError)>
	<cfquery name="getChangeLogs" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT a.Change_Log_ID, 
			a.Change_Value,
			a.Site_ID as Admin_Site_ID, 
			a.Actual_Change_Log_ID, 
			a.Chevron_PM_Approval_Date as Date_Logged, 
			a.Internal_Status,
			a.Milestone_Update_Status,
			'' as Current_Status_ID,
			a.Change_Type_Other,
			b.Site_ID, b.Site_Name, b.Address, b.City, b.State_ID, b.Zip_Code,
			d.First_Name + ' ' + d.Last_Name as SMName,
			g.State_Abbreviation,
			a.Chevron_PM_ID, 
			a.FCO_File_Name as CompiledFCO, 
			c.Portfolio as Log_Portfolio, 
			l.Portfolio as Site_Portfolio,
			a.Chevron_Approval_Status,
			'V1' as FCO_Type
		FROM #Request.WebSite#.dbo.Change_Log_V1 as a 
			inner join TurboScope.dbo.Admin_Site as b on a.Site_ID = b.ID
			left join TurboScope.dbo.Admin_Portfolio as c on a.Portfolio_ID = c.Portfolio_ID
			left join WebSite_Admin.dbo.Web_Site_Users as d on a.Arcadis_PM_ID = d.User_ID
			inner join TurboScope.dbo.Admin_State as g on b.State_ID = g.State_ID
			left join TurboScope.dbo.Admin_Portfolio as l on b.Portfolio_ID = l.Portfolio_ID
		WHERE a.Change_Log_ID is not null
			and (a.Internal_Status = 'G') AND (Chevron_Approval_Status = 'g')
			<cfif isDefined("URL.CLID")> AND a.Change_Log_ID = '#URL.CLID#'</cfif>
			<cfif isDefined("form.SiteIDtofind")> and b.Site_ID like '%#form.SiteIDtofind#%'</cfif>
			<cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind NEQ 0> AND b.Portfolio_ID = '#form.SitePortfolioToFind#'</cfif>
			<cfif len(RegionsToFind)> and b.COP_Region_ID in (#RegionsToFind#)</cfif>
			<cfif isDefined("form.SiteNameToFind")> and b.Site_Name like '%#form.SiteNameToFind#%'</cfif>
			<cfif isDefined("form.addresstofind") and len(form.addresstofind)> AND b.Address like ('%#form.addresstofind#%')</cfif>
			<cfif isDefined("form.citytofind") and len(form.citytofind)> AND b.City like ('%#form.citytofind#%')</cfif>
			<cfif isDefined("form.statetofind") and form.statetofind NEQ 0> AND b.State_ID = #form.statetofind#</cfif>
			<cfif isDefined("form.smtofind") and form.smtofind NEQ 0> AND a.Arcadis_PM_ID = #form.smtofind#</cfif>
			<cfif isDefined("form.DeputyToFind") and form.DeputyToFind NEQ 0> AND b.Portfolio_Deputy_ID = #form.DeputyToFind#</cfif>
			<cfif isDefined("form.ChevronOpsToFind") and form.ChevronOpsToFind NEQ 0> AND a.Chevron_PM_ID = #form.ChevronOpsToFind#</cfif>
			<cfif isDefined("form.FromDateToFind") and len(form.FromDateToFind)> AND a.Chevron_PM_Approval_Date >= '#form.FromDateToFind#'</cfif>
			<cfif isDefined("form.ToDateToFind") and len(form.ToDateToFind)> AND a.Chevron_PM_Approval_Date <= '#form.ToDateToFind#'</cfif>
			<cfif isDefined("form.LogPortfolioToFind") and form.LogPortfolioToFind NEQ 0> AND a.Portfolio_ID = '#form.LogPortfolioToFind#'</cfif>

UNION

		SELECT a.Change_Log_ID, 
			a.Draft_Change_Value as Change_Value,
			a.Site_ID as Admin_Site_ID, 
			a.Actual_Change_Log_ID, 
			a.Chevron_PM_Approval_Date as Date_Logged, 
			a.Oracle_Status as Internal_Status,
			a.Milestone_Update_Status,
			a.Current_Status_ID,
			'' as Change_Type_Other,
			b.Site_ID, b.Site_Name, b.Address, b.City, b.State_ID, b.Zip_Code,
			d.First_Name + ' ' + d.Last_Name as SMName, 
			g.State_Abbreviation,
			b.Chevron_PM_ID, 
			a.Compiled_FCO as CompiledFCO, 
			c.Portfolio as Log_Portfolio, 
			l.Portfolio as Site_Portfolio,
			m.Status as Chevron_Approval_Status,
			'V2' as FCO_Type
		FROM #Request.WebSite#.dbo.Change_Log as a 
			inner join TurboScope.dbo.Admin_Site as b on a.Site_ID = b.ID
			left join TurboScope.dbo.Admin_Portfolio as c on a.Portfolio_ID = c.Portfolio_ID
			left join WebSite_Admin.dbo.Web_Site_Users as d on b.SM_ID = d.User_ID
			inner join TurboScope.dbo.Admin_State as g on b.State_ID = g.State_ID
			left join TurboScope.dbo.Admin_Portfolio as l on b.Portfolio_ID = l.Portfolio_ID
			left join PPMH.dbo.Change_Log_Status as m on a.Current_Status_ID = m.Status_ID
		WHERE a.Change_Log_ID is not null
			and ((a.Current_Status_ID = 4 and a.FCO_Processed = 3) or (a.Current_Status_ID = 6))
			<cfif isDefined("URL.CLID")> AND a.Change_Log_ID = '#URL.CLID#'</cfif>
			<cfif isDefined("form.SiteIDtofind")> and b.Site_ID like '%#form.SiteIDtofind#%'</cfif>
			<cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind NEQ 0> AND b.Portfolio_ID = '#form.SitePortfolioToFind#'</cfif>
			<cfif len(RegionsToFind)> and b.COP_Region_ID in (#RegionsToFind#)</cfif>
			<cfif isDefined("form.SiteNameToFind")> and b.Site_Name like '%#form.SiteNameToFind#%'</cfif>
			<cfif isDefined("form.addresstofind") and len(form.addresstofind)> AND b.Address like ('%#form.addresstofind#%')</cfif>
			<cfif isDefined("form.citytofind") and len(form.citytofind)> AND b.City like ('%#form.citytofind#%')</cfif>
			<cfif isDefined("form.statetofind") and form.statetofind NEQ 0> AND b.State_ID = #form.statetofind#</cfif>
			<cfif isDefined("form.smtofind") and form.smtofind NEQ 0> AND b.SM_ID = #form.smtofind#</cfif>
			<cfif isDefined("form.DeputyToFind") and form.DeputyToFind NEQ 0> AND b.Portfolio_Deputy_ID = #form.DeputyToFind#</cfif>
			<cfif isDefined("form.ChevronOpsToFind") and form.ChevronOpsToFind NEQ 0> AND b.Chevron_PM_ID = #form.ChevronOpsToFind#</cfif>
			<cfif isDefined("form.FromDateToFind") and len(form.FromDateToFind)> AND a.Chevron_PM_Approval_Date >= '#form.FromDateToFind#'</cfif>
			<cfif isDefined("form.ToDateToFind") and len(form.ToDateToFind)> AND a.Chevron_PM_Approval_Date <= '#form.ToDateToFind#'</cfif>
			<cfif isDefined("form.LogPortfolioToFind") and form.LogPortfolioToFind NEQ 0> AND a.Portfolio_ID = '#form.LogPortfolioToFind#'</cfif>
			GROUP BY a.Change_Log_ID, a.Draft_Change_Value, a.Site_ID, a.Chevron_PM_Approval_Date,
						a.Actual_Change_Log_ID, 
						a.Oracle_Status,
						a.Milestone_Update_Status,
						a.Current_Status_ID,
						b.Site_ID, b.Site_Name, b.Address, b.City, b.State_ID, b.Zip_Code,
						d.First_Name, d.Last_Name, 
						g.State_Abbreviation,
						b.Chevron_PM_ID, 
						a.Compiled_FCO, 
						c.Portfolio, 
						l.Portfolio,
						m.Status			
		ORDER BY Date_Logged
	</cfquery>
</cfif>
