<!--------------------------------------------------------------------------------------------------------------------------------
Description:
	query to add monthly site information

History:
	2/19/2020 - created
--------------------------------------------------------------------------------------------------------------------------------->

<!--- errorcheck --->
<cfinclude template="f_ErrorCheckMilestone.cfm">

<cfif not ArrayLen(errormsg)>
	<CFSET MilestoneFileName = "">
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
				<cfset newfilename = "milestone_" & form.AdminSiteID & "_" & form.MilestonePlanDate & "_" & form.milestoneID & "." & ext>
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
		<!--- update database --->
		<CFQUERY NAME="updMilestones" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
			insert into PPMH.dbo.Site_Status_Milestones
				(On_Track, <!---Skip,---> FCO, Deliverable, Notes, Milestone_Doc, Site_ID, Milestone_ID, Period, Milestone_Plan_Date, Milestone_Year, Claim)
			values
				(#form.OnTrack#
				<!---,<cfif isDefined("form.Skip")>1<cfelse>NULL</cfif>--->
				,<cfif len(form.FCO)>'#form.FCO#'<cfelse>NULL</cfif>
				,<cfif len(form.Deliverable)>'#form.Deliverable#'<cfelse>NULL</cfif>
				,<cfif len(form.Notes)>'#form.Notes#'<cfelse>NULL</cfif>
				,<cfif len(MilestoneFileName)>'#MilestoneFileName#'<cfelse>NULL</cfif>
				,'#form.AdminSiteID#'
				,#form.MilestoneID#
				,#PeriodClaimed#
				,'#form.MilestonePlanDate#'
				,#form.MilestoneYear#
				,#form.Claim#
				)
		</CFQUERY>
	
		<!--- send notice --->
		<cfif form.Claim EQ 1><CFModule template="f_Email_Notifcation.cfm" NoticeType="upload"></cfif>
		<cfset successmsg = "The information has been updated">
	</cfif>
</cfif>
