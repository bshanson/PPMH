<!----------------------------------------------------------------------------------------------------------
Description:
	add Change record

History:
	4/3/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- error check --->
<cfinclude template="f_ErrorCheck.cfm" >

<cfset form.ChangeValue = replace(form.ChangeValue, "$", "", "all" )>
<cfset form.ChangeValue = replace(form.ChangeValue, ",", "", "all" )>
<cfset form.ChangeValue = replace(form.ChangeValue, ")", "", "all" )>
<cfset form.ChangeValue = replace(form.ChangeValue, "(", "-", "all" )>
<cfif form.PerformancePeriodEndDate EQ "NA"><cfset form.PerformancePeriodEndDate = "1/1/1900"></cfif> 

<!--- change type --->
<cfset form.listChangeType = "">
<cfloop query="getChangeLogChangeType">
	<cfif isDefined("ChangeTypeID#getChangeLogChangeType.Change_Type_ID#")>
		<cfset form.listChangeType = listappend(form.listChangeType,getChangeLogChangeType.Change_Type_ID)>
	</cfif>
</cfloop>

<!--- change reason --->
<cfset form.listChangeReason = "">
<cfloop query="getChangeLogChangeReason">
	<cfif isDefined("ChangeReasonID#getChangeLogChangeReason.Change_Reason_ID#")>
		<cfset form.listChangeReason = listappend(form.listChangeReason,getChangeLogChangeReason.Change_Reason_ID)>
	</cfif>
</cfloop>

<!--- reason detail --->
<cfset form.listReasonDetail = "">
<cfloop query="getChangeLogReasonDetail">
	<cfif isDefined("ReasonDetailID#getChangeLogReasonDetail.Reason_Detail_ID#")>
		<cfset form.listReasonDetail = listappend(form.listReasonDetail,getChangeLogReasonDetail.Reason_Detail_ID)>
	</cfif>
</cfloop>

<cfif not ArrayLen(errormsg)>
	<CFSET FCODocName = "">
	<!--- file has been selected --->
	<cfif len(form.FCOFileName)>
		<CFFILE 
			ACTION="UPLOAD"
			FILEFIELD="form.FCOFileName"
			DESTINATION="#Request.FCOUploadPath#\"
			nameconflict="makeunique">

		<CFSET tmpFCODocName = cffile.serverfile>
		<CFSET FCODocName = replace(tmpFCODocName, "##", "", "all" )>
		<CFFILE 
			ACTION="rename"
			Source="#Request.FCOUploadPath#\#tmpFCODocName#"
			DESTINATION="#Request.FCOUploadPath#\#FCODocName#">
	</cfif>

	<!--- add reg action --->
	<CFQUERY NAME="addChangeLog" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		insert into PPMH.dbo.Change_Log_V1
			(Site_ID, Date_Logged, Initiating_Entity_ID, Change_Type_ID, Change_Type_Other, Change_Reason_ID, Reason_Detail_ID, Reason_Detail_Other, Change_Value, 
			Additional_Information, Milestone_List, Assumptions, Performance_Period_End_Date, Portfolio_Manager_ID, Portfolio_Manager_Approval_Date, Approval_Description, 
			Chevron_PM_ID, Chevron_PM_Approval_Date, Amendment, Arcadis_PM_ID, Email_Reference, Oracle_Update, Internal_Status, Chevron_Approval_Status, FCO_File_Name, 
			Actual_Change_Log_ID, Portfolio_ID, Milestone_Update_Status)
		values
			(<cfqueryparam value="#form.AdminSiteID#" cfsqltype="cf_sql_varchar" >
			,<cfqueryparam value="#form.DateLogged#" cfsqltype="cf_sql_varchar" >
			,<cfqueryparam value="#form.InitiatingEntityID#" cfsqltype="cf_sql_integer" >
			,<cfqueryparam value="#form.listChangeType#" cfsqltype="cf_sql_varchar" >
			,<cfif listfind(form.listChangeType,"9")><cfqueryparam value="#form.ChangeTypeOther#" cfsqltype="cf_sql_varchar" ><cfelse>NULL</cfif>
			,<cfqueryparam value="#form.listChangeReason#" cfsqltype="cf_sql_varchar" >
			,<cfqueryparam value="#form.listReasonDetail#" cfsqltype="cf_sql_varchar" >
			,<cfif listfind(form.listReasonDetail,"21")><cfqueryparam value="#form.ReasonDetailOther#" cfsqltype="cf_sql_varchar" ><cfelse>NULL</cfif>
			,<cfqueryparam value="#form.ChangeValue#" cfsqltype="cf_sql_double" >
			,<cfqueryparam value="#form.AdditionalInformation#" cfsqltype="cf_sql_longvarchar" >
			,<cfqueryparam value="#form.MilestoneList#" cfsqltype="cf_sql_longvarchar" >
			,<cfqueryparam value="#form.Assumptions#" cfsqltype="cf_sql_varchar" >
			,<cfqueryparam value="#form.PerformancePeriodEndDate#" cfsqltype="cf_sql_varchar" >
			,<cfqueryparam value="#form.PortfolioManagerID#" cfsqltype="cf_sql_integer" >
			,<cfqueryparam value="#form.PortfolioManagerApprovalDate#" cfsqltype="cf_sql_varchar" >
			,<cfqueryparam value="#form.ApprovalDescription#" cfsqltype="cf_sql_longvarchar" >
			,<cfqueryparam value="#form.ChevronPMID#" cfsqltype="cf_sql_integer" >
			,<cfqueryparam value="#form.ChevronPMApprovalDate#" cfsqltype="cf_sql_varchar" >
			,<cfqueryparam value="#form.Amendment#" cfsqltype="cf_sql_varchar" >
			,<cfqueryparam value="#form.ArcadisPMID#" cfsqltype="cf_sql_integer" >
			,<cfqueryparam value="#form.EmailReference#" cfsqltype="cf_sql_varchar" >
			,<cfqueryparam value="#form.OracleUpdate#" cfsqltype="cf_sql_varchar" >
			,<cfqueryparam value="#form.InternalStatus#" cfsqltype="cf_sql_varchar" >
			,<cfqueryparam value="#form.ChevronApprovalStatus#" cfsqltype="cf_sql_varchar" >
			,<cfqueryparam value="#FCODocName#" cfsqltype="cf_sql_varchar" >
			,<cfqueryparam value="#form.ActualChangeLogID#" cfsqltype="cf_sql_varchar" >
			,<cfqueryparam value="#form.PortfolioID#" cfsqltype="cf_sql_integer" >
			,<cfqueryparam value="#form.MilestoneUpdateStatus#" cfsqltype="cf_sql_varchar" >
			)
	</CFQUERY>

	<CFQUERY NAME="getmaxid" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		select max(change_log_id) as maxid from PPMH.dbo.Change_Log_V1
	</CFQUERY>
	<cfset form.editChangeLogID = getmaxid.maxid>
</cfif>
