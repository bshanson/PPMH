<!--------------------------------------------------------------------------------------------------------------------------------
Description:
	query to update monthly site information

History:
	2/19/2020 - created
--------------------------------------------------------------------------------------------------------------------------------->

<!--- errorcheck --->
<cfinclude template="f_ErrorCheckMilestone.cfm">

<cfif not ArrayLen(errormsg)>
	<CFQUERY NAME="getMilestoneDoc" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		select Milestone_Doc
		from PPMH.dbo.Site_Milestones
		WHERE ID = '#form.SiteMilestoneID#'
	</CFQUERY>
	<CFSET MilestoneFileName = getMilestoneDoc.Milestone_Doc>
	<!--- delete an uploaded file --->
	<cfif isDefined("form.DeleteDoc")>
		<cfif FileExists("#Request.UploadPath#\#getMilestoneDoc.Milestone_Doc#")>
			<CFFILE 
				action="DELETE" 
				file="#Request.UploadPath#\#getMilestoneDoc.Milestone_Doc#">
			</cfif>
		<CFSET MilestoneFileName = "">
	</cfif>
	
	<!--- upload file --->
	<cfif (isDefined("form.MilestoneDoc")) and (len(evaluate("form.MilestoneDoc")))>
		<cftry>
			<CFFILE 
				ACTION="UPLOAD"
				FILEFIELD="form.MilestoneDoc"
				DESTINATION="#Request.UploadPath#\"
				nameconflict="OVERWRITE">
		
			<!--- get the filename and extension --->
			<CFSET ServerFileName = cffile.serverfile>
			<cfset ext = listlast(ServerFileName,".")>
			<!--- is it a jpg, png, pdf --->
			<cfif (ext EQ "jpg") or (ext EQ "png") or (ext EQ "pdf")>
				<!--- create new name and rename --->
				<cfset newfilename = "milestone_" & form.AdminSiteID & "_" & form.MilestonePlanDate & "_" & form.milestoneID & "_" & form.SiteMilestoneID & "." & ext>
				<!--- rename newly uploaded file --->
				<CFFILE 
					action="RENAME" 
					source="#Request.UploadPath#\#ServerFileName#"
					DESTINATION="#Request.UploadPath#\#newfilename#">

				<CFSET MilestoneFileName = newfilename>
			<cfelse>
				<!--- if not proper format --->
				<CFFILE action="DELETE" file="#Request.UploadPath#\#ServerFileName#">
				<cfset msgSuccess = "">
				<cfset ArrayAppend(errormsg, "upload jpg, png or pdf files, only") />
			</cfif>
			<cfcatch type="Any">
				<cfset msgSuccess = "">
				<cfif findnocase("Path specifications cannot include '..'",cfcatch.detail)>
					<cfset ArrayAppend(errormsg, "There was an error uploading the file. A file name cannot include '..'. Please rename your file and upload again.") />
				<cfelse>
					<cfset ArrayAppend(errormsg, "there was an error uploading the file") />
				</cfif>
			</cfcatch>
		</cftry>
	</cfif>

	<cfif not ArrayLen(errormsg)>
		<cfset ClaimMonth = form.MonthClaimed>
		<cfif form.MonthClaimed LT 10><cfset ClaimMonth = "0" & ClaimMonth></cfif>
		<cfset PeriodClaimed = form.YearClaimed & ClaimMonth>
		<cfif len(form.Notes)><cfset form.Notes = replace(form.Notes,"\","/","all")></cfif>
		<cfif len(form.Notes)><cfset form.Notes = replace(form.Notes,"""","'","all")></cfif>
		<!--- update database --->
		<CFQUERY NAME="updMilestones" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
			update PPMH.dbo.Site_Milestones
			set
				Delay_Reason_ID = #form.DelayReasonID#
				<!---,Skip = <cfif isDefined("form.Skip")>1<cfelse>NULL</cfif>--->
				,FCO = <cfif len(form.FCO)>'#form.FCO#'<cfelse>NULL</cfif>
				,Deliverable = <cfif len(form.Deliverable)>'#form.Deliverable#'<cfelse>NULL</cfif>
				,Notes = <cfif len(form.Notes)>'#form.Notes#'<cfelse>NULL</cfif>
				,Milestone_Doc = <cfif len(MilestoneFileName)>'#MilestoneFileName#'<cfelse>NULL</cfif>
				,Period = <cfif form.Claim EQ 1>#PeriodClaimed#<cfelse>NULL</cfif>
				,Claim = #form.Claim#
			WHERE ID = '#form.SiteMilestoneID#'
		</CFQUERY>
	
		<!--- send notice --->
		<cfset successmsg = "The information has been updated">
	</cfif>
</cfif>
