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

<!--- creation date error --->
<cfif isDefined("form.FromDateToFind") and len(form.FromDateToFind) and not isValid("usdate", form.FromDateToFind)>
	<cfset FromError = "Invalid Creation From Date">
<cfelseif isDefined("form.FromDateToFind") and len(form.FromDateToFind) and isValid("usdate", form.FromDateToFind)>
	<cfset form.FromDateToFind = dateformat((CreateODBCDate(form.FromDateToFind)),"mm/dd/yyyy")>
</cfif>

<cfif isDefined("form.ToDateToFind") and len(form.ToDateToFind) and not isValid("usdate", form.ToDateToFind)>
	<cfset ToError = "Invalid Creation To Date">
<cfelseif isDefined("form.ToDateToFind") and len(form.ToDateToFind) and isValid("usdate", form.ToDateToFind)>
	<cfset form.ToDateToFind = dateformat((CreateODBCDate(form.ToDateToFind)),"mm/dd/yyyy")>
</cfif>

<!--- approval date error --->
<cfif isDefined("form.ApprovalFromDateToFind") and len(form.ApprovalFromDateToFind) and not isValid("usdate", form.ApprovalFromDateToFind)>
	<cfset ApprovalFromError = "Invalid Approval From Date">
<cfelseif isDefined("form.ApprovalFromDateToFind") and len(form.ApprovalFromDateToFind) and isValid("usdate", form.ApprovalFromDateToFind)>
	<cfset form.ApprovalFromDateToFind = dateformat((CreateODBCDate(form.ApprovalFromDateToFind)),"mm/dd/yyyy")>
</cfif>

<cfif isDefined("form.ApprovalToDateToFind") and len(form.ApprovalToDateToFind) and not isValid("usdate", form.ApprovalToDateToFind)>
	<cfset ApprovalToError = "Invalid Approval To Date">
<cfelseif isDefined("form.ApprovalToDateToFind") and len(form.ApprovalToDateToFind) and isValid("usdate", form.ApprovalToDateToFind)>
	<cfset form.ApprovalToDateToFind = dateformat((CreateODBCDate(form.ApprovalToDateToFind)),"mm/dd/yyyy")>
</cfif>

<!--- days to find error --->
<cfif isDefined("form.DaysToFind") and len(form.DaysToFind) and not isNumeric(form.DaysToFind)>
	<cfset DaysError = "Invalid Days Since Last Action number">
</cfif>

<!--- is user in FCO Team list or ACS list --->
<cfset FCOReviewer = 0>
<cfset ACSReviewer = 0>
<cfset SeniorReviewer = 0>
<cfset MilestoneManager = 0>
<cfset FCOTeamLead = 0>
<cfquery name="getSiteUsersAttributes" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	SELECT DISTINCT a.FCO_Team, a.ACS_Reviewer, a.Senior_Reviewer, a.FCO_Team_Lead, b.Milestone_Manager_ID
	FROM PPMH.dbo.Site_Users_Attributes as a
	left join turboscope.dbo.Admin_portfolio as b on a.User_ID = b.Milestone_Manager_ID
	WHERE (a.User_ID = #Session.Security.UserID#) 
</cfquery>
<cfif getSiteUsersAttributes.RecordCount NEQ 0>
	<cfif getSiteUsersAttributes.FCO_Team EQ 1><cfset FCOReviewer = 1></cfif>
	<cfif getSiteUsersAttributes.ACS_Reviewer EQ 1><cfset ACSReviewer = 1></cfif>
	<cfif getSiteUsersAttributes.Senior_Reviewer EQ 1><cfset SeniorReviewer = 1></cfif>
	<cfif len(getSiteUsersAttributes.Milestone_Manager_ID)><cfset MilestoneManager = 1></cfif>
	<cfif len(getSiteUsersAttributes.FCO_Team_Lead)><cfset FCOTeamLead = 1></cfif>
</cfif>

<cfif not len(FromError) and not len(ToError) and not len(ApprovalFromError) and not len(ApprovalToError)>
	<cfquery name="getChangeLogs" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT a.Change_Log_ID, a.Site_ID as Admin_Site_ID, a.Date_Logged, a.Due_Date_For_Client
					 ,a.Actual_Change_Log_ID, a.FCO_Processed
					 ,a.Current_Status_ID, a.Assigned_To_ID, a.Update_Status_ID, a.Send_To_ID
					 ,a.Update_Date, Draft_Change_Value, a.Oracle_Status, a.Milestone_Update_Status
					 ,a.Sharepoint_File_Name, a.FCO_Folder, a.FCO_SubFolder, a.Status_Action_Send_Date
					 ,a.Compiled_FCO
					 ,DateDiff(day, a.Status_Action_Send_Date, getdate()) as DaysSinceLastAction, a.Assign_To_User_ID
					 ,b.SM_ID
					 ,b.Portfolio_Deputy_ID
					 ,b.Site_ID, b.Site_Name, b.Address, b.City, b.State_ID, b.Zip_Code
					 ,c.Portfolio as Log_Portfolio
					 ,d.First_Name + ' ' + d.Last_Name as SMName
					 ,g.State_Abbreviation
					 ,l.Portfolio as Site_Portfolio, l.Portfolio_Manager_ID, l.Project_Controller_ID, l.Milestone_Manager_ID
					 ,m.Status as current_status, m.color
					 ,o.team
					 ,p.First_Name + ' ' + p.Last_Name as DeputyName
					 ,q.First_Name + ' ' + q.Last_Name as PortMgrName
					 ,r.First_Name + ' ' + r.Last_Name as OpsLeadName
					 ,s.Project_PM_ID
					 ,t.First_Name + ' ' + t.Last_Name as AssignedToName
		FROM PPMH.dbo.Change_Log as a 
				 inner join TurboScope.dbo.Admin_Site as b on a.Site_ID = b.ID
				 left join TurboScope.dbo.Admin_Portfolio as c on a.Portfolio_ID = c.Portfolio_ID <!--- Log Portfolio --->
				 left join WebSite_Admin.dbo.Web_Site_Users as d on b.SM_ID = d.User_ID
				 inner join TurboScope.dbo.Admin_State as g on b.State_ID = g.State_ID
				 left join TurboScope.dbo.Admin_Portfolio as l on b.Portfolio_ID = l.Portfolio_ID <!--- site Portfolio --->
				 left join PPMH.dbo.Change_Log_Status as m on a.Current_Status_ID = m.Status_ID
				 left join PPMH.dbo.Change_Log_Team as o on a.Send_To_ID = o.team_ID
				 left join WebSite_Admin.dbo.Web_Site_Users as p on b.Portfolio_Deputy_ID = p.User_ID
				 left join WebSite_Admin.dbo.Web_Site_Users as q on l.Portfolio_Manager_ID = q.User_ID
				 left join WebSite_Admin.dbo.Web_Site_Users as r on b.Chevron_PM_ID = r.User_ID
				 left join TurboScope.dbo.Site_Project as s on a.Site_Project_ID = s.ID
				 left join WebSite_Admin.dbo.Web_Site_Users as t on a.Assign_To_User_ID = t.User_ID
		WHERE a.Change_Log_ID is not null
					AND (a.Current_Status_ID <> 4 or ((FCO_Processed = 2) AND (Current_Status_ID = 4)))
					<cfif isDefined("URL.CLID")> AND a.Change_Log_ID = '#URL.CLID#'</cfif>
					<cfif isDefined("form.SitePortfolioToFind") and form.SitePortfolioToFind NEQ 0> AND b.Portfolio_ID = '#form.SitePortfolioToFind#'</cfif>
					<cfif isDefined("form.LogPortfolioToFind") and form.LogPortfolioToFind NEQ 0> AND a.Portfolio_ID = '#form.LogPortfolioToFind#'</cfif>
					<cfif isDefined("form.LogPortfolioToFind") and form.LogPortfolioToFind EQ 0> AND a.Portfolio_ID = b.Portfolio_ID</cfif>
					<cfif len(RegionsToFind)> and b.COP_Region_ID in (#RegionsToFind#)</cfif>
					<cfif isDefined("form.SiteIDtofind")> and b.Site_ID like '%#form.SiteIDtofind#%'</cfif>
					<cfif isDefined("form.SiteNameToFind")> and b.Site_Name like '%#form.SiteNameToFind#%'</cfif>
					<cfif isDefined("form.addresstofind") and len(form.addresstofind)> AND b.Address like ('%#form.addresstofind#%')</cfif>
					<cfif isDefined("form.citytofind") and len(form.citytofind)> AND b.City like ('%#form.citytofind#%')</cfif>
					<cfif isDefined("form.statetofind") and form.statetofind NEQ 0> AND b.State_ID = #form.statetofind#</cfif>
					<cfif isDefined("form.smtofind") and form.smtofind NEQ 0> AND b.SM_ID = #form.smtofind#</cfif>
					<cfif isDefined("form.DeputyToFind") and form.DeputyToFind NEQ 0> AND b.Portfolio_Deputy_ID = #form.DeputyToFind#</cfif>
					<cfif isDefined("form.PortMgrToFind") and form.PortMgrToFind NEQ 0> AND l.Portfolio_Manager_ID = #form.PortMgrToFind#</cfif>
					<cfif isDefined("form.ChevronOpsToFind") and form.ChevronOpsToFind NEQ 0> AND b.Chevron_PM_ID = #form.ChevronOpsToFind#</cfif>
					<cfif isDefined("form.statustofind") and form.statustofind NEQ 0> AND a.Current_Status_ID = #form.statustofind#</cfif>
					<cfif isDefined("form.AssignedToToFind") and form.AssignedToToFind NEQ 0> AND a.Send_To_ID = #form.AssignedToToFind#</cfif>
					<cfif isDefined("form.TMToFind") and form.TMToFind NEQ 0> AND a.Assign_To_User_ID = #form.TMToFind#</cfif>
					<cfif isDefined("form.FromDateToFind") and len(form.FromDateToFind)> AND a.Date_Logged >= '#form.FromDateToFind#'</cfif>
					<cfif isDefined("form.ToDateToFind") and len(form.ToDateToFind)> AND a.Date_Logged <= '#form.ToDateToFind#'</cfif>
					<cfif isDefined("form.AssignedToMe")>
						 and (a.Creator_User_ID = #Session.Security.UserID# 
						 			or (a.Send_To_ID = 1 and b.SM_ID = #Session.Security.UserID#)
		 							<cfif FCOReviewer EQ 1>or (a.Send_To_ID = 2)</cfif>
						 			or (a.Send_To_ID = 3 and b.Portfolio_Deputy_ID = #Session.Security.UserID#)
		 							<cfif ACSReviewer EQ 1>or (a.Send_To_ID = 4)</cfif>
						 			or (a.Send_To_ID = 5 and l.Portfolio_Manager_ID = #Session.Security.UserID#)
									<cfif FCOTeamLead EQ 1>or (a.Send_To_ID = 6)</cfif>
									or (a.Send_To_ID = 9 and a.Creator_User_ID = #Session.Security.UserID#)
		 							<cfif SeniorReviewer EQ 1>or (a.Send_To_ID = 7)</cfif>
						 			or (a.Send_To_ID = 8 and l.Project_Controller_ID = #Session.Security.UserID#)
						 			or (a.Send_To_ID = 11 and l.Milestone_Manager_ID = #Session.Security.UserID#)
						 			) 
					</cfif>
					<cfif isDefined("form.AssociatedWithMe")>
						and (b.SM_ID = #Session.Security.UserID# or b.Portfolio_Deputy_ID = #Session.Security.UserID# or s.Project_PM_ID = #Session.Security.UserID#)
					</cfif>
			ORDER BY 
				<cfif form.SortBy EQ 1>a.Actual_Change_Log_ID</cfif>
				<cfif form.SortBy EQ 2>b.Site_ID</cfif>
				<cfif form.SortBy EQ 3>a.Date_Logged</cfif>
				<cfif form.SortBy EQ 4>a.Due_Date_For_Client</cfif>
				<cfif form.SortBy EQ 5>DaysSinceLastAction</cfif>
				<cfif form.SortBy EQ 6>m.Status</cfif>
				<cfif form.SortBy EQ 8>o.team</cfif>
				<cfif form.SortBy EQ 9>AssignedToName</cfif>
	</cfquery>
</cfif>
