<!----------------------------------------------------------------------------------------------------------
Description:
	query to get the change records

History:
	4/3/2020 - created
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
		SELECT a.Change_Log_ID, a.Site_ID as Admin_Site_ID, a.Date_Logged, a.Initiating_Entity_ID, a.Change_Type_ID, a.Change_Reason_ID, 
					 a.Reason_Detail_ID, a.Additional_Information, a.Milestone_List, a.Change_Value, a.Assumptions, 
					 a.Performance_Period_End_Date, a.Portfolio_Manager_Approval_Date, a.Portfolio_Manager_ID, a.Chevron_PM_Approval_Date, 
					 a.Chevron_PM_ID, a.Amendment, a.Arcadis_PM_ID, a.Email_Reference, a.Oracle_Update, a.Internal_Status, a.Change_Type_Other,
					 a.Approval_Description, a.Reason_Detail_Other, a.Chevron_Approval_Status, a.FCO_File_Name, a.Actual_Change_Log_ID, a.Milestone_Update_Status,
					 b.Portfolio_Deputy_ID,
					 b.Site_ID, b.Site_Name, b.Address, b.City, b.State_ID, b.Zip_Code,
					 c.Portfolio as Log_Portfolio, 
					 d.First_Name + ' ' + d.Last_Name as SMName,
					 e.First_Name + ' ' + e.Last_Name as PortfolioManagerName,
					 f.First_Name + ' ' + f.Last_Name as ChevronPMName,
					 g.State_Abbreviation,
					 k.Initiating_Entity,
					 l.Portfolio as Site_Portfolio
		FROM PPMH.dbo.Change_Log_V1 as a 
				 inner join TurboScope.dbo.Admin_Site as b on a.Site_ID = b.ID
				 left join TurboScope.dbo.Admin_Portfolio as c on a.Portfolio_ID = c.Portfolio_ID
				 left join WebSite_Admin.dbo.Web_Site_Users as d on a.Arcadis_PM_ID = d.User_ID
				 inner join WebSite_Admin.dbo.Web_Site_Users as e on a.Portfolio_Manager_ID = e.User_ID
				 left join WebSite_Admin.dbo.Web_Site_Users as f on a.Chevron_PM_ID = f.User_ID
				 inner join TurboScope.dbo.Admin_State as g on b.State_ID = g.State_ID
				 inner join PPMH.dbo.Change_Log_Entity_V1 as k on a.Initiating_Entity_ID = k.Initiating_Entity_ID
				 left join TurboScope.dbo.Admin_Portfolio as l on b.Portfolio_ID = l.Portfolio_ID
		WHERE a.Change_Log_ID is not null
					<cfif isDefined("URL.CLID")> AND a.Change_Log_ID = '#URL.CLID#'</cfif>
					<cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind NEQ 0> AND b.Portfolio_ID = '#form.SitePortfolioToFind#'</cfif>
					<cfif len(RegionsToFind)> and b.COP_Region_ID in (#RegionsToFind#)</cfif>
					<cfif isDefined("form.SiteIDtofind")> and b.Site_ID like '%#form.SiteIDtofind#%'</cfif>
					<cfif isDefined("form.SiteNameToFind")> and b.Site_Name like '%#form.SiteNameToFind#%'</cfif>
					<cfif isDefined("form.addresstofind") and len(form.addresstofind)> AND b.Address like ('%#form.addresstofind#%')</cfif>
					<cfif isDefined("form.citytofind") and len(form.citytofind)> AND b.City like ('%#form.citytofind#%')</cfif>
					<cfif isDefined("form.statetofind") and form.statetofind NEQ 0> AND b.State_ID = #form.statetofind#</cfif>
					<cfif isDefined("form.smtofind") and form.smtofind NEQ 0> AND a.Arcadis_PM_ID = #form.smtofind#</cfif>
					<cfif isDefined("form.DeputyToFind") and form.DeputyToFind NEQ 0> AND b.Portfolio_Deputy_ID = #form.DeputyToFind#</cfif>
					<cfif isDefined("form.ChevronOpsToFind") and form.ChevronOpsToFind NEQ 0> AND a.Chevron_PM_ID = #form.ChevronOpsToFind#</cfif>
					<cfif isDefined("form.ChevApvlStatusToFind") and len(form.ChevApvlStatusToFind)> AND a.Chevron_Approval_Status = '#form.ChevApvlStatusToFind#'</cfif>
					<cfif isDefined("form.IntStatusToFind") and len(form.IntStatusToFind)> AND a.Internal_Status = '#form.IntStatusToFind#'</cfif>
					<cfif isDefined("form.MilestoneStatusToFind") and len(form.MilestoneStatusToFind)> AND a.Milestone_Update_Status = '#form.MilestoneStatusToFind#'</cfif>
					<cfif isDefined("form.FromDateToFind") and len(form.FromDateToFind)> AND a.Date_Logged >= '#form.FromDateToFind#'</cfif>
					<cfif isDefined("form.ToDateToFind") and len(form.ToDateToFind)> AND a.Date_Logged <= '#form.ToDateToFind#'</cfif>
					<cfif isDefined("form.LogPortfolioToFind") and form.LogPortfolioToFind NEQ 0> AND a.Portfolio_ID = '#form.LogPortfolioToFind#'</cfif>
					<cfif isDefined("form.LogIDSort") and form.LogIDSort EQ 1>ORDER BY a.Change_Log_ID, a.Actual_Change_Log_ID, a.Date_Logged</cfif>
					<cfif isDefined("form.LogIDSort") and form.LogIDSort EQ 2>ORDER BY a.Change_Log_ID desc, a.Actual_Change_Log_ID desc, a.Date_Logged desc</cfif>
	</cfquery>
</cfif>
