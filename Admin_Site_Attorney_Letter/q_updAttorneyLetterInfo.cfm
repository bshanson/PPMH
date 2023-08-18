<!--------------------------------------------------------------------------------------------------------------------------------
Description:
	query to update site Attorney Letter information

History:
	10/13/2022 - created
--------------------------------------------------------------------------------------------------------------------------------->

<cfset msgSuccess = "The information has been updated">

<!--- error check --->
<cfinclude template="f_errorCheck.cfm">

<cfif not ArrayLen(arrErrors)>
	<cfif form.edittype EQ "EditAttorneyLetterRecord">
		<cfif not len(form.FileName)>
			<!--- update database --->
			<CFQUERY NAME="updAttorneyLetter" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
				update 
					TurboScope.dbo.Admin_Site_Attorney_Letter
				set 
					Document_Name = <cfqueryparam value="#form.DocumentName#" cfsqltype="cf_sql_varchar" >
				WHERE ID = <cfqueryparam value="#form.edtAttorneyLetterID#" cfsqltype="cf_sql_integer" >
			</CFQUERY>
		<cfelse>
			<!--- get the Attorney file name --->
			<CFQUERY NAME="getAttorneyFile" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
				select File_Name
				from TurboScope.dbo.Admin_Site_Attorney_Letter
				WHERE ID = <cfqueryparam value="#form.edtAttorneyLetterID#" cfsqltype="cf_sql_integer" >
			</CFQUERY>
			<!--- get the Attorney file name --->
			<CFQUERY NAME="getAttorneyFile" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
				select File_Name
				from TurboScope.dbo.Admin_Site_Attorney_Letter
				WHERE ID = <cfqueryparam value="#form.edtAttorneyLetterID#" cfsqltype="cf_sql_integer" >
			</CFQUERY>
			<!--- delete the Attorney file --->
			<cfif len(getAttorneyFile.File_Name)>
				<cfif FileExists("#Request.AttorneyUploadPath#\#getAttorneyFile.File_Name#")>
					<CFFILE 
						action="DELETE" 
						file="#Request.AttorneyUploadPath#\#getAttorneyFile.File_Name#">
				</cfif>
			</cfif>
			<!--- delete record --->
			<CFQUERY NAME="delAttorneyFile" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
				delete
				from TurboScope.dbo.Admin_Site_Attorney_Letter
				WHERE ID = <cfqueryparam value="#form.edtAttorneyLetterID#" cfsqltype="cf_sql_integer" >
			</CFQUERY>
		</cfif>
	</cfif>
	<cfif form.edittype EQ "EditAttorneyLetterRecord" or form.edittype EQ "AddAttorneyLetterRecord">
		<!--- upload document --->
		<cfif isDefined("form.FileName") and len(form.FileName)>
			<cfif len(form.FileName)>
				<CFQUERY NAME="getSiteID" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
					select Site_ID
					from TurboScope.dbo.Admin_Site
					WHERE ID = <cfqueryparam value="#form.SiteID#" cfsqltype="cf_sql_integer" >
				</CFQUERY>
				<CFQUERY NAME="getmaxid" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
					select max(id) as maxid from TurboScope.dbo.Admin_Site_Attorney_Letter
				</CFQUERY>
				<cfif not len(getmaxid.maxid)><cfset recno = 1><cfelse><cfset recno = getmaxid.maxid + 1></cfif>
				<cftry>
					<CFFILE 
						ACTION="UPLOAD" 
						FILEFIELD="FileName"
						DESTINATION="#Request.TmpDocFiles#\" 
						nameconflict="overwrite" >
		
					<!--- get the filename and extension --->
					<CFSET tmpAttorneyFile = cffile.serverfile>
					<CFSET AttorneyFile = replace(tmpAttorneyFile, "##", "", "all" )>
					<CFSET AttorneyFile = "AttorneyFile" & "_" & #getSiteID.Site_ID# & "_" & #recno# & "." & #cffile.serverfileext#>
					<cfset ext = cffile.serverfileext>

					<!--- is it a PDF --->
					<cfif (ext NEQ "pdf")>
						<!--- if not PDF delete uploaded file --->
						<CFFILE action="DELETE" file="#Request.TmpDocFiles#\#tmpAttorneyFile#">
						<cfset successmsg = "">
						<cfset ArrayAppend(arrErrors, "Please upload only PDF files") />
					<cfelse>
						<!--- rename the file --->
						<CFFILE 
							ACTION="rename"
							Source="#Request.TmpDocFiles#\#tmpAttorneyFile#"
							DESTINATION="#Request.TmpDocFiles#\#AttorneyFile#">
						<!--- move the file --->
						<CFFILE 
							ACTION="move"
							Source="#Request.TmpDocFiles#\#AttorneyFile#"
							DESTINATION="#Request.AttorneyUploadPath#\#AttorneyFile#">
					</cfif>

					<cfcatch type="Any" >
						<cfset msgSuccess = "">
						<cfset ArrayAppend(arrErrors, "there was an error uploading the document") />
					</cfcatch>
				</cftry>
			</cfif>

			<cfif not ArrayLen(arrErrors)>
				<!--- update database --->
				<CFQUERY NAME="updAttorneyLetter" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
					insert into TurboScope.dbo.Admin_Site_Attorney_Letter
						(Site_ID, Document_Name, File_Name)
					values
					(
						<cfqueryparam value="#form.SiteID#" cfsqltype="cf_sql_integer" >
						,<cfqueryparam value="#form.DocumentName#" cfsqltype="cf_sql_varchar" >
						,<cfqueryparam value="#AttorneyFile#" cfsqltype="cf_sql_varchar" >
					)
				</CFQUERY>
	
				<!--- get the id of the new record --->
				<CFQUERY NAME="getmaxid" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
					select max(id) as maxid from TurboScope.dbo.Admin_Site_Attorney_Letter
				</CFQUERY>
				<cfset form.edtAttorneyLetterID = getmaxid.maxid>
			</cfif>
		</cfif>
	</cfif>
</cfif>
