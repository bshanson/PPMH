<!----------------------------------------------------------------------------------------------------------
Description:
	update Change action record

History:
	4/3/2020 - created
----------------------------------------------------------------------------------------------------------->

<cfset sendNotice = "false">
<cfset adminNotice = "false">
<cfset OracleNotice = "false">
<cfset StatusActionSendDate = "">
<cfset AssignToUserID = "">
<cfif isDefined("form.AssignToUserID") and len(form.AssignToUserID)><cfset AssignToUserID = form.AssignToUserID></cfif>

<!--- error check --->
<cfinclude template="f_ErrorCheck.cfm" >

<!--- query to see if these fields are changing --->
<CFQUERY NAME="getSendTo" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select Assigned_To_ID, Assign_To_User_ID, Send_To_ID, Current_Status_ID, Oracle_Status
	from #Request.WebSite#.dbo.Change_Log
	WHERE Change_Log_ID = '#form.editChangeLogID#'
</CFQUERY>
<cfif getSendTo.Send_To_ID NEQ form.SendToID><cfset sendNotice = "true"></cfif>
<cfif getSendTo.Assign_To_User_ID NEQ AssignToUserID><cfset sendNotice = "true"></cfif>
<cfif getSendTo.Current_Status_ID NEQ 1 and form.UpdateStatusID EQ 4><cfset adminNotice = "true"></cfif>
<cfif (getSendTo.Assigned_To_ID NEQ form.SendToID) or (getSendTo.Current_Status_ID NEQ form.UpdateStatusID)><cfset StatusActionSendDate = dateformat(now(), 'mm/dd/yyyy')></cfif>
<cfif (form.OracleStatus EQ "G" and getSendTo.Oracle_Status NEQ form.OracleStatus)><cfset OracleNotice = "true"></cfif>

<cfif not ArrayLen(errormsg)>
	<!--- delete document --->
	<cfif (isDefined("form.CompiledFCO") and len(form.CompiledFCO))>
		<!--- get the FCO document name --->
		<CFQUERY NAME="getFCODoc" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
			select Compiled_FCO
			from #Request.WebSite#.dbo.Change_Log
			WHERE Change_Log_ID = <cfqueryparam value="#form.editChangeLogID#" cfsqltype="cf_sql_integer" >
		</CFQUERY>
		<!--- delete the FCO document name --->
		<CFQUERY NAME="delFCODoc" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
			update #Request.WebSite#.dbo.Change_Log
			set Compiled_FCO = NULL
			WHERE Change_Log_ID = <cfqueryparam value="#form.editChangeLogID#" cfsqltype="cf_sql_integer" >
		</CFQUERY>
		<!--- delete the FCO document --->
		<cfif len(getFCODoc.Compiled_FCO)>
			<cfif FileExists("#Request.FCOUploadPath#\#getFCODoc.Compiled_FCO#")>
				<CFFILE 
					action="DELETE" 
					file="#Request.FCOUploadPath#\#getFCODoc.Compiled_FCO#">
			</cfif>
		</cfif>
	</cfif>
	<!--- upload document --->
	<cfif isDefined("form.CompiledFCO") and len(form.CompiledFCO)>
		<cfif len(form.CompiledFCO)>
			<cftry>
				<CFFILE 
					ACTION="UPLOAD" 
					FILEFIELD="CompiledFCO"
					DESTINATION="#Request.FCOUploadPath#\" 
					nameconflict="overwrite" >

				<!--- get the filename and extension --->
				<CFSET tmpFCODocName = cffile.serverfile>
				<CFSET FCODocName = replace(tmpFCODocName, "##", "", "all" )>
				<!--- rename the file --->
				<CFFILE 
					ACTION="rename"
					Source="#Request.FCOUploadPath#\#tmpFCODocName#"
					DESTINATION="#Request.FCOUploadPath#\#FCODocName#">
				<cfcatch type="Any" >
					<cfset msgSuccess = "">
					<cfset ArrayAppend(errormsg, "there was an error uploading the document") />
				</cfcatch>
			</cftry>
		</cfif>
	</cfif>
</cfif>

<cfif not ArrayLen(errormsg)>
		<cfif len(form.DraftChangeValue)>
		<cfset vA = replace(form.DraftChangeValue, "$", "", "all" )>
		<cfset vA = replace(vA, ",", "", "all" )>
		<cfset vA = replace(vA, ")", "", "all" )>
		<cfset vA = replace(vA, "(", "-", "all" )>
	<cfelse>
		<cfset vA = form.DraftChangeValue>
	</cfif>
	<!--- update Change log --->
	<cfquery name="updChangeLog" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		UPDATE #Request.WebSite#.dbo.Change_Log
		SET Site_ID = <cfqueryparam value="#form.AdminSiteID#" cfsqltype="cf_sql_varchar" >
				,Portfolio_ID = <cfqueryparam value="#form.CLPortfolioID#" cfsqltype="cf_sql_integer" >
				,Site_Project_ID = <cfqueryparam value="#form.SiteProjectID#" cfsqltype="cf_sql_integer" >
				<cfif isDefined("form.ActualChangeLogID")>,Actual_Change_Log_ID = <cfqueryparam value="#form.ActualChangeLogID#" cfsqltype="cf_sql_varchar" ></cfif>
				,Current_Status_ID = <cfqueryparam value="#form.UpdateStatusID#" cfsqltype="cf_sql_varchar" >
				,Assign_To_User_ID = <cfif len(AssignToUserID)><cfqueryparam value="#AssignToUserID#" cfsqltype="cf_sql_integer" ><cfelse>NULL</cfif>
				,Update_Status_ID = <cfqueryparam value="#form.UpdateStatusID#" cfsqltype="cf_sql_varchar" >
				,Assigned_To_ID = <cfqueryparam value="#form.SendToID#" cfsqltype="cf_sql_varchar" >
				,Send_To_ID = <cfqueryparam value="#form.SendToID#" cfsqltype="cf_sql_varchar" >
				,Update_Date = <cfqueryparam value="#dateformat(now(), 'mm/dd/yyyy')#" cfsqltype="cf_sql_varchar" >
				,Draft_Change_Value = <cfif len(VA)><cfqueryparam value="#VA#" cfsqltype="cf_sql_real"><cfelse>NULL</cfif>
				,Due_Date_For_Client = <cfif len(form.DueDateForClient)><cfqueryparam value="#dateformat(form.DueDateForClient, 'mm/dd/yyyy')#" cfsqltype="cf_sql_varchar" ><cfelse>NULL</cfif>
				,FCO_Notes = <cfif len(form.FCONotes)><cfqueryparam value="#form.FCONotes#" cfsqltype="cf_sql_varchar"><cfelse>NULL</cfif>
				,User_ID = <cfqueryparam value="#Session.Security.UserID#" cfsqltype="cf_sql_integer" >
				,Email = <cfqueryparam value="#Session.Security.Email#" cfsqltype="cf_sql_varchar">
				<cfif len(StatusActionSendDate)>,Status_Action_Send_Date = <cfqueryparam value="#StatusActionSendDate#" cfsqltype="cf_sql_varchar" ></cfif>
				,Oracle_Status = <cfqueryparam value="#form.OracleStatus#" cfsqltype="cf_sql_varchar" >
				,Milestone_Update_Status = <cfqueryparam value="#form.MilestoneUpdateStatus#" cfsqltype="cf_sql_varchar" >
				,Chevron_PM_Approval_Date = <cfif len(form.ChevronPMApprovalDate)><cfqueryparam value="#dateformat(form.ChevronPMApprovalDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_varchar" ><cfelse>NULL</cfif>
				<cfif isDefined("form.CompiledFCO") and len(form.CompiledFCO)>,Compiled_FCO = <cfqueryparam value="#FCODocName#" cfsqltype="cf_sql_varchar" ></cfif>
		WHERE Change_Log_ID = #form.editChangeLogID#
	</cfquery>

	<!--- update Change log history --->
	<cfif len(StatusActionSendDate)>
		<cfquery name="updChangeLogHistory" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
			insert into #Request.WebSite#.dbo.Change_Log_History
				(Change_Log_ID, Status_ID, Team_ID, Status_Date, User_ID)
				values
				(#form.editChangeLogID#
				,#form.UpdateStatusID#
				,#form.SendToID#
				,'#dateformat(now(),"mm/dd/yyyy")#'
				,#Session.Security.UserID#)
		</cfquery>
	</cfif>

	<!--- send notice --->
	<cfif sendNotice>
		<cfinclude template="q_getSiteInfo.cfm" >
		<CFModule template="Change_Log_Notifcation.cfm" NoticeType="#form.SendToID#" AID="#AssignToUserID#" CLID="#form.editChangeLogID#" SiteID="#getSiteInfo.Site_ID#" SiteName="#getSiteInfo.Site_Name#" Address="#getSiteInfo.Address#" City="#getSiteInfo.City#" State="#getSiteInfo.State_Abbreviation#">
	</cfif>
	<cfif adminNotice>
		<cfinclude template="q_getSiteInfo.cfm" >
		<CFModule template="Change_Log_Notifcation.cfm" NoticeType="adminNotice" AID="#AssignToUserID#" CLID="#form.editChangeLogID#" SiteID="#getSiteInfo.Site_ID#" SiteName="#getSiteInfo.Site_Name#" Address="#getSiteInfo.Address#" City="#getSiteInfo.City#" State="#getSiteInfo.State_Abbreviation#">
	</cfif>
	<cfif OracleNotice>
		<cfinclude template="q_getSiteInfo.cfm" >
		<CFModule template="Change_Log_Notifcation.cfm" NoticeType="OracleNotice" AID="#AssignToUserID#" CLID="#form.editChangeLogID#" SiteID="#getSiteInfo.Site_ID#" SiteName="#getSiteInfo.Site_Name#" Address="#getSiteInfo.Address#" City="#getSiteInfo.City#" State="#getSiteInfo.State_Abbreviation#">
	</cfif>
</cfif>
