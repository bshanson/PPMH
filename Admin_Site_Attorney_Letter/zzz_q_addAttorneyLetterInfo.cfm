<!--------------------------------------------------------------------------------------------------------------------------------
Description:
	query to add site Attorney Letter information

History:
	10/13/2022 - created
--------------------------------------------------------------------------------------------------------------------------------->

<!--- errorcheck --->
<cfinclude template="f_errorCheck.cfm">

<cfif not ArrayLen(errormsg)>
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

<cfif not ArrayLen(arrErrors)>
	<!--- update database --->
	<CFQUERY NAME="addAttorneyLetter" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		insert 
		into TurboScope.dbo.Admin_Site_Attorney_Letter
		(Site_ID, Document_Name, File_Name) 
		values
		(
		<cfqueryparam value="#form.SiteID#" cfsqltype="cf_sql_integer" >
		<cfqueryparam value="#form.DocumentName#" cfsqltype="cf_sql_varchar" >
		<cfqueryparam value="#form.FileName#" cfsqltype="cf_sql_varchar" >
		)
	</CFQUERY>

	<!--- get the id of the new record --->
	<CFQUERY NAME="getmaxid" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		select max(id) as maxid TurboScope.dbo.Admin_Site_Attorney_Letter
	</CFQUERY>
	<cfset form.edtAttorneyLetterID = getmaxid.maxid>
	<cfset form.edittype = "EditAttorneyLetterRecord">

	<cfset msgSuccess = "The information has been updated">
</cfif>
