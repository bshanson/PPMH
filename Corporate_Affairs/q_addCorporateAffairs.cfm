<!----------------------------------------------------------------------------------------------------------
Description:
	add Corporate Affairs action

History:
	1/11/2022 - created
----------------------------------------------------------------------------------------------------------->

<!--- error check --->
<cfinclude template="f_ErrorCheck.cfm" >

<cfif not ArrayLen(errormsg)>
	<!--- add reg action --->
	<CFQUERY NAME="addCorporateAffairs" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		insert into #Request.WebSite#.dbo.Corporate_Affairs
			(Site_ID, Tracking_Date, Trigger_Date, Description, Created_By)
		values
			(
				#form.AdminSiteID#
				,'#form.TrackingDate#'
				,'#form.TriggerDate#'
				,'#form.Description#'
				,#Session.Security.UserID#
			)
	</CFQUERY>

	<!--- get the id of the new record --->
	<CFQUERY NAME="getmaxid" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		select max(Corporate_Affairs_ID) as maxid from #Request.WebSite#.dbo.Corporate_Affairs
	</CFQUERY>
	<cfset form.CorporateAffairsID = getmaxid.maxid>
	<cfset form.edittype = "editCorpAffairs">

	<!--- add triggers --->
	<cfinclude template="q_getTriggerDescriptions.cfm" >
	<cfloop query="getTriggerDescriptions" >
		<cfif isDefined("form.td#getTriggerDescriptions.Trigger_Description_ID#")>
			<cfquery name="addTrigger" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
				insert into #Request.WebSite#.dbo.Corporate_Affairs_Trigger_List
					(Corporate_Affairs_ID, Trigger_Description_ID)
				values
					(#form.CorporateAffairsID#, #getTriggerDescriptions.Trigger_Description_ID#)
			</cfquery>
		</cfif>
	</cfloop>

	<!--- get new triggers --->
	<cfquery name="getNewTriggers" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		select Trigger_Description_ID
		from #Request.WebSite#.dbo.Corporate_Affairs_Trigger_List
		WHERE Corporate_Affairs_ID = '#form.CorporateAffairsID#'
	</cfquery>
	<!--- create list of new triggers --->
	<cfset NewTriggerList = valuelist(getNewTriggers.Trigger_Description_ID)>

	<!--- send notice --->
	<CFModule template="Corporate_Affairs_Notifcation.cfm" NoticeType="CorpAffairs" SID="#form.AdminSiteID#" CAID="#form.CorporateAffairsID#" TID="#NewTriggerList#">
</cfif>
