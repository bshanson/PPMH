<!----------------------------------------------------------------------------------------------------------
Description:
	update AccessLUC record

History:
	2/11/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- error check --->
<cfinclude template="f_ErrorCheck.cfm" >

<cfif not ArrayLen(errormsg)>
	<!--- delete document --->
	<cfif isDefined("form.FinalDocDelete") or (isDefined("form.FinalDocument") and len(form.FinalDocument))>
		<!--- get the LUC document name --->
		<CFQUERY NAME="getLUCDoc" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
			select Final_Document
			from #Request.WebSite#.dbo.AccessLUC
			WHERE ID = <cfqueryparam value="#form.AccessLUCID#" cfsqltype="cf_sql_integer" >
		</CFQUERY>
		
		<!--- delete the LUC document name --->
		<CFQUERY NAME="delLUCDoc" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
			update #Request.WebSite#.dbo.AccessLUC
			set Final_Document = NULL
			WHERE ID = <cfqueryparam value="#form.AccessLUCID#" cfsqltype="cf_sql_integer" >
		</CFQUERY>
		
		<!--- delete the LUC document --->
		<cfif len(getLUCDoc.Final_Document)>
			<cfif FileExists("#Request.LUCUploadPath#\#getLUCDoc.Final_Document#")>
				<CFFILE 
					action="DELETE" 
					file="#Request.LUCUploadPath#\#getLUCDoc.Final_Document#">
			</cfif>
		</cfif>
	</cfif>

	<!--- upload document --->
	<cfif isDefined("form.FinalDocument") and len(form.FinalDocument)>
		<cfif len(form.FinalDocument)>
			<cftry>
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
				<cfcatch type="Any" >
					<cfset msgSuccess = "">
					<cfset ArrayAppend(errormsg, "there was an error uploading the document") />
				</cfcatch>
			</cftry>
		</cfif>
	</cfif>
</cfif>

<cfif not ArrayLen(errormsg)>
	<!--- update AccessLUC action --->
	<cfquery name="updAccessLUC" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		UPDATE #Request.WebSite#.dbo.AccessLUC
		SET 
				Site_ID = <cfqueryparam value="#form.AdminSiteID#" cfsqltype="cf_sql_integer" >
				,Onsite = <cfqueryparam value="#form.Onsite#" cfsqltype="cf_sql_bit" >
				,Agreement_Type_ID = <cfqueryparam value="#form.AgreementTypeID#" cfsqltype="cf_sql_integer" >
				,Arcadis_Chevron_Form_ID = <cfqueryparam value="#form.ArcadisChevronFormID#" cfsqltype="cf_sql_integer" >
				<cfif isDefined("form.SPLID")>,SPL_ID = <cfqueryparam value="#form.SPLID#" cfsqltype="cf_sql_integer" ></cfif>
				<cfif isDefined("form.PriorityID")>,Priority_ID = <cfqueryparam value="#form.PriorityID#" cfsqltype="cf_sql_integer" ></cfif>
				<cfif isDefined("form.OutsideCounselInvolved")>,Outside_Counsel_Involved = <cfqueryparam value="#form.OutsideCounselInvolved#" cfsqltype="cf_sql_bit" ></cfif>
				<cfif isDefined("form.MilestoneInPlaceID")>,Milestone_In_Place_ID = <cfqueryparam value="#form.MilestoneInPlaceID#" cfsqltype="cf_sql_integer" ></cfif>
				,Stage_ID = <cfqueryparam value="#form.StageID#" cfsqltype="cf_sql_integer" >
				,Expiration_Date = <cfif len(form.ExpirationDate)><cfqueryparam value="#form.ExpirationDate#" cfsqltype="cf_sql_varchar" ><cfelse>NULL</cfif>
				<cfif isDefined("form.FieldWorkNotification")>,Field_Work_Notification = <cfqueryparam value="#form.FieldWorkNotification#" cfsqltype="cf_sql_bit" ></cfif>
				<cfif isDefined("form.TermLetterSentID")>,Term_Letter_Sent_ID = <cfqueryparam value="#form.TermLetterSentID#" cfsqltype="cf_sql_integer" ></cfif>
				,SPL_Notes = <cfqueryparam value="#form.SPLNotes#" cfsqltype="cf_sql_varchar" >
				<cfif isDefined("form.UntilCompletion")>,Until_Completion = <cfqueryparam value="#form.UntilCompletion#" cfsqltype="cf_sql_bit" ></cfif>
				<cfif isDefined("form.FinalDocument") and len(form.FinalDocument)>,Final_Document = <cfqueryparam value="#LUCDocName#" cfsqltype="cf_sql_varchar" ></cfif>
				,Complete_Date = <cfif len(form.CompleteDate)>'#form.CompleteDate#'<cfelse>NULL</cfif>
				,Complete = <cfif len(form.CompleteDate)>1<cfelse>0</cfif>
				,Access_Property = <cfif len(form.AccessProperty)><cfqueryparam value="#form.AccessProperty#" cfsqltype="cf_sql_varchar" ><cfelse>NULL</cfif>
		WHERE ID = <cfqueryparam value="#form.AccessLUCID#" cfsqltype="cf_sql_integer" >
	</cfquery>
</cfif>
