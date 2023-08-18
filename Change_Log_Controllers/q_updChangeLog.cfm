<!----------------------------------------------------------------------------------------------------------
Description:
	update Change action record

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
	<!--- delete document --->
	<cfif isDefined("form.FCODocDelete")>
		<!--- get the FCO document name --->
		<CFQUERY NAME="getFCODoc" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
			select FCO_File_Name
			from PPMH.dbo.Change_Log_V1
			WHERE Change_Log_ID = '#form.editChangeLogID#'
		</CFQUERY>
		
		<!--- delete the FCO document --->
		<cfif len(getFCODoc.FCO_File_Name)>
			<cfif FileExists("#Request.FCOUploadPath#\#getFCODoc.FCO_File_Name#")>
				<CFFILE 
					action="DELETE" 
					file="#Request.FCOUploadPath#\#getFCODoc.FCO_File_Name#">
			</cfif>
		</cfif>
		<CFSET FCODocName = "">
	</cfif>

	<!--- file has been selected for uploading --->
	<cfif len(form.FCOFileName)>
		<!--- get the FCO document name --->
		<CFQUERY NAME="getFCODoc" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
			select FCO_File_Name
			from PPMH.dbo.Change_Log_V1
			WHERE Change_Log_ID = '#form.editChangeLogID#'
		</CFQUERY>
		
		<!--- delete the FCO document --->
		<cfif len(getFCODoc.FCO_File_Name)>
			<cfif FileExists("#Request.FCOUploadPath#\#getFCODoc.FCO_File_Name#")>
				<CFFILE 
					action="DELETE" 
					file="#Request.FCOUploadPath#\#getFCODoc.FCO_File_Name#">
			</cfif>
		</cfif>

		<!--- upload the FCO document --->
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

	<!--- update Change action --->
	<cfquery name="updChange" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		UPDATE PPMH.dbo.Change_Log_V1
		SET Date_Logged = <cfqueryparam value="#form.DateLogged#" cfsqltype="cf_sql_varchar" >
				,Initiating_Entity_ID = <cfqueryparam value="#form.InitiatingEntityID#" cfsqltype="cf_sql_integer" >
				,Change_Type_ID = <cfqueryparam value="#form.listChangeType#" cfsqltype="cf_sql_varchar" >
				,Change_Type_Other = <cfif listfind(form.listChangeType,"9")><cfqueryparam value="#form.ChangeTypeOther#" cfsqltype="cf_sql_varchar" ><cfelse>NULL</cfif>
				,Change_Reason_ID = <cfqueryparam value="#form.listChangeReason#" cfsqltype="cf_sql_varchar" >
				,Reason_Detail_ID = <cfqueryparam value="#form.listReasonDetail#" cfsqltype="cf_sql_varchar" >
				,Reason_Detail_Other = <cfif listfind(form.listReasonDetail,"21")><cfqueryparam value="#form.ReasonDetailOther#" cfsqltype="cf_sql_varchar" ><cfelse>NULL</cfif>
				,Change_Value = <cfqueryparam value="#form.ChangeValue#" cfsqltype="cf_sql_double" >
				,Additional_Information = <cfqueryparam value="#form.AdditionalInformation#" cfsqltype="cf_sql_longvarchar" >
				,Milestone_List = <cfqueryparam value="#form.MilestoneList#" cfsqltype="cf_sql_longvarchar" >
				,Assumptions = <cfqueryparam value="#form.Assumptions#" cfsqltype="cf_sql_varchar" >
				,Performance_Period_End_Date = <cfqueryparam value="#form.PerformancePeriodEndDate#" cfsqltype="cf_sql_varchar" >
				,Portfolio_Manager_ID = <cfqueryparam value="#form.PortfolioManagerID#" cfsqltype="cf_sql_integer" >
				,Portfolio_Manager_Approval_Date = <cfqueryparam value="#form.PortfolioManagerApprovalDate#" cfsqltype="cf_sql_varchar" >
				,Approval_Description = <cfqueryparam value="#form.ApprovalDescription#" cfsqltype="cf_sql_longvarchar" >
				,Chevron_PM_ID = <cfqueryparam value="#form.ChevronPMID#" cfsqltype="cf_sql_integer" >
				,Chevron_PM_Approval_Date = <cfqueryparam value="#form.ChevronPMApprovalDate#" cfsqltype="cf_sql_varchar" >
				,Amendment = <cfqueryparam value="#form.Amendment#" cfsqltype="cf_sql_varchar" >
				,Arcadis_PM_ID = <cfqueryparam value="#form.ArcadisPMID#" cfsqltype="cf_sql_integer" >
				,Email_Reference = <cfqueryparam value="#form.EmailReference#" cfsqltype="cf_sql_varchar" >
				,Oracle_Update = <cfqueryparam value="#form.OracleUpdate#" cfsqltype="cf_sql_varchar" >
				,Internal_Status = <cfqueryparam value="#form.InternalStatus#" cfsqltype="cf_sql_varchar" >
				,Chevron_Approval_Status= <cfqueryparam value="#form.ChevronApprovalStatus#" cfsqltype="cf_sql_varchar" >
				<cfif isDefined("FCODocName")>,FCO_File_Name = <cfif len(FCODocName)><cfqueryparam value="#FCODocName#" cfsqltype="cf_sql_varchar" ><cfelse>NULL</cfif></cfif>
				,Actual_Change_Log_ID = <cfqueryparam value="#form.ActualChangeLogID#" cfsqltype="cf_sql_varchar" >
				,Site_ID = <cfqueryparam value="#form.AdminSiteID#" cfsqltype="cf_sql_varchar" >
				,Portfolio_ID = <cfqueryparam value="#form.PortfolioID#" cfsqltype="cf_sql_integer" >
				,Milestone_Update_Status = <cfqueryparam value="#form.MilestoneUpdateStatus#" cfsqltype="cf_sql_varchar" >
		WHERE Change_Log_ID = '#form.editChangeLogID#'
	</cfquery>
</cfif>
