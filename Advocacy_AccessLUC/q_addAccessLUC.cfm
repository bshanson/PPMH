<!----------------------------------------------------------------------------------------------------------
Description:
	add AccessLUC record

History:
	2/11/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- error check --->
<cfinclude template="f_ErrorCheck.cfm" >

<cfif not ArrayLen(errormsg)>
	<!--- upload document --->
	<cfif isDefined("form.FinalDocument") and len(form.FinalDocument)>
		<cfif len(form.FinalDocument)>
<!---			<cftry>--->
				<CFFILE 
					ACTION="UPLOAD" 
					FILEFIELD="FinalDocument"
					DESTINATION="#Request.LUCUploadPath#\"
					nameconflict="overwrite" >
	
				<!--- get the filename and extension --->
				<CFSET tmpLUCDocName = cffile.serverfile>
				<CFSET LUCDocName = replace(tmpLUCDocName, "##", "", "all" )>
				<!--- rename the file --->
				<CFFILE 
					ACTION="rename"
					Source="#Request.LUCUploadPath#\#tmpLUCDocName#"
					DESTINATION="#Request.LUCUploadPath#\#LUCDocName#">
<!---				<cfcatch type="Any" >
					<cfset msgSuccess = "">
					<cfset ArrayAppend(errormsg, "there was an error uploading the document") />
				</cfcatch>
			</cftry>--->
		</cfif>
	</cfif>
</cfif>

<cfif not ArrayLen(errormsg)>
	<!--- add reg action --->
	<CFQUERY NAME="addAccessLUC" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		insert into #Request.WebSite#.dbo.AccessLUC
				(Site_ID, Onsite, Agreement_Type_ID, Arcadis_Chevron_Form_ID, SPL_ID, Priority_ID, Outside_Counsel_Involved, 
				Milestone_In_Place_ID, Stage_ID, Expiration_Date, Field_Work_Notification, Term_Letter_Sent_ID, SPL_Notes, Complete_Date, Complete, Until_Completion 
				<cfif isDefined("form.FinalDocument") and len(form.FinalDocument)>,Final_Document</cfif>
				,Access_Property
				)
		values
				(<cfqueryparam value="#form.AdminSiteID#" cfsqltype="cf_sql_integer" >
				,<cfqueryparam value="#form.Onsite#" cfsqltype="cf_sql_bit" >
				,<cfqueryparam value="#form.AgreementTypeID#" cfsqltype="cf_sql_integer" >
				,<cfqueryparam value="#form.ArcadisChevronFormID#" cfsqltype="cf_sql_integer" >
				,<cfif isDefined("form.SPLID")><cfqueryparam value="#form.SPLID#" cfsqltype="cf_sql_integer" ><cfelse>NULL</cfif>
				,<cfif isDefined("form.PriorityID")><cfqueryparam value="#form.PriorityID#" cfsqltype="cf_sql_integer" ><cfelse>NULL</cfif>
				,<cfif isDefined("form.OutsideCounselInvolved")><cfqueryparam value="#form.OutsideCounselInvolved#" cfsqltype="cf_sql_bit" ><cfelse>NULL</cfif>
				,<cfif isDefined("form.MilestoneInPlaceID")><cfqueryparam value="#form.MilestoneInPlaceID#" cfsqltype="cf_sql_integer" ><cfelse>NULL</cfif>
				,<cfqueryparam value="#form.StageID#" cfsqltype="cf_sql_integer" >
				,<cfif len(form.ExpirationDate)><cfqueryparam value="#form.ExpirationDate#" cfsqltype="cf_sql_varchar" ><cfelse>NULL</cfif>
				,<cfif isDefined("form.FieldWorkNotification")><cfqueryparam value="#form.FieldWorkNotification#" cfsqltype="cf_sql_bit" ><cfelse>NULL</cfif>
				,<cfif isDefined("form.TermLetterSentID")><cfqueryparam value="#form.TermLetterSentID#" cfsqltype="cf_sql_integer" ><cfelse>NULL</cfif>
				,<cfqueryparam value="#form.SPLNotes#" cfsqltype="cf_sql_varchar" >
				,<cfif len(form.CompleteDate)>'#form.CompleteDate#'<cfelse>NULL</cfif>
				,<cfif len(form.CompleteDate)>1<cfelse>0</cfif>
				,<cfif isDefined("form.UntilCompletion")><cfqueryparam value="#form.UntilCompletion#" cfsqltype="cf_sql_bit" ><cfelse>NULL</cfif>
				<cfif isDefined("form.FinalDocument") and len(form.FinalDocument)>,<cfqueryparam value="#LUCDocName#" cfsqltype="cf_sql_varchar" ></cfif>
				,<cfif len(form.AccessProperty)><cfqueryparam value="#form.AccessProperty#" cfsqltype="cf_sql_varchar" ><cfelse>NULL</cfif>
				)
	</CFQUERY>

	<!--- get the id of the new record --->
	<CFQUERY NAME="getmaxid" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		select max(id) as maxid from #Request.WebSite#.dbo.AccessLUC
	</CFQUERY>
	<cfset form.AccessLUCID = getmaxid.maxid>
	<cfset form.edittype = "editAccessLUC">
</cfif>
