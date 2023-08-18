<!----------------------------------------------------------------------------------------------------------
Description:
	create uniquely name copy of uploaded document and open in new window

History:
	8/9/2022 - created
----------------------------------------------------------------------------------------------------------->

<cfparam name="URL.DocType" default="ALuc">

<cfswitch expression="#DocType#">
	<cfcase value="ALuc">
		<cfquery name="getAccessLUCDoc" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
			SELECT a.ID as AccessLUC_ID, a.Final_Document
			FROM #Request.WebSite#.dbo.AccessLUC as a
			WHERE a.ID = #AccessLUCID#
		</cfquery>
		<cfset DocPath = Request.LUCPath>
		<cfset SrcPath = "#Request.LUCUploadPath#" >
		<cfset DestPath = "#Request.LUCUploadPath#" >
		<cfset SrcDoc = "#getAccessLUCDoc.Final_Document#">
		<cfset SrcExt = listlast(getAccessLUCDoc.Final_Document, ".")>
	</cfcase>

	<cfcase value="ChangeLogV1">
		<cfquery name="getChangeLogDoc" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
			SELECT a.Change_Log_ID, a.FCO_File_Name
			FROM PPMH.dbo.Change_Log_V1 as a
			WHERE a.Change_Log_ID = #editChangeLogID#
		</cfquery>
		<cfset DocPath = Request.FCOPath>
		<cfset SrcPath = "#Request.FCOUploadPath#" >
		<cfset DestPath = "#Request.FCOUploadPath#" >
		<cfset SrcDoc = "#getChangeLogDoc.FCO_File_Name#">
		<cfset SrcExt = listlast(getChangeLogDoc.FCO_File_Name, ".")>
	</cfcase>

	<cfcase value="ChangeLogV2">
		<cfquery name="getChangeLogDoc" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
			SELECT a.Change_Log_ID, a.Compiled_FCO
			FROM PPMH.dbo.Change_Log as a
			WHERE a.Change_Log_ID = #editChangeLogID#
		</cfquery>
		<cfset DocPath = Request.FCOPath>
		<cfset SrcPath = "#Request.FCOUploadPath#" >
		<cfset DestPath = "#Request.FCOUploadPath#" >
		<cfset SrcDoc = "#getChangeLogDoc.Compiled_FCO#">
		<cfset SrcExt = listlast(getChangeLogDoc.Compiled_FCO, ".")>
	</cfcase>

	<cfcase value="SiteMileStone">
		<cfquery name="getSiteMilestoneDoc" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
			SELECT a.Milestone_ID, a.Milestone_Doc
			FROM PPMH.dbo.Site_Milestones AS a
			WHERE a.ID = #SiteMilestoneID#
 		</cfquery>
		<cfset DocPath = Request.MileStonePath>
		<cfset SrcPath = "#Request.UploadPath#" >
		<cfset DestPath = "#Request.UploadPath#" >
		<cfset SrcDoc = "#getSiteMilestoneDoc.Milestone_Doc#">
		<cfset SrcExt = listlast(getSiteMilestoneDoc.Milestone_Doc, ".")>
	</cfcase>

	<cfcase value="Attorney">
		<cfquery name="getAttorneyDoc" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
			SELECT a.ID, a.File_Name
			FROM TurboScope.dbo.Admin_Site_Attorney_Letter AS a
			WHERE a.ID = #AttorneyLetterID#
 		</cfquery>
		<cfset DocPath = Request.AttorneyPath>
		<cfset SrcPath = "#Request.AttorneyUploadPath#" >
		<cfset DestPath = "#Request.AttorneyUploadPath#" >
		<cfset SrcDoc = "#getAttorneyDoc.File_Name#">
		<cfset SrcExt = listlast(getAttorneyDoc.File_Name, ".")>
	</cfcase>
</cfswitch>

<cfoutput>
	<cftry>
		<cfset UniqueUUID = "tmp_" & left(CreateUUID(),10) & "." & SrcExt>
		<cffile action="copy" source="#SrcPath#\#SrcDoc#" destination="#DestPath#\#UniqueUUID#">
		<cfcatch type="any">
			<cfdump var="#cfcatch#">
			<cfabort>
		</cfcatch>
	</cftry>

	<div align="center">
		<p>Opening...
		<br>If the file does not open, click <a href="#DocPath#/#UniqueUUID#">here</a> to download the file.
	</div>
	<script language="JavaScript">window.location = "#DocPath#/#UniqueUUID#";</script>
</cfoutput>
