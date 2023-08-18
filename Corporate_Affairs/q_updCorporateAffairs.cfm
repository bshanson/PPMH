<!----------------------------------------------------------------------------------------------------------
Description:
	update Corporate Affairs action record

History:
	1/11/2022 - created
----------------------------------------------------------------------------------------------------------->

<!--- error check --->
<cfinclude template="f_ErrorCheck.cfm" >

<cfif not ArrayLen(errormsg)>
	<!--- get current triggers --->
	<cfquery name="getOldTriggers" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		select Trigger_Description_ID
		from #Request.WebSite#.dbo.Corporate_Affairs_Trigger_List
		WHERE Corporate_Affairs_ID = '#form.CorporateAffairsID#'
	</cfquery>
	<!--- create list of old triggers --->
	<cfset OldTriggerList = valuelist(getOldTriggers.Trigger_Description_ID)>

	<!--- delete triggers --->
	<cfquery name="delTriggerList" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		delete from #Request.WebSite#.dbo.Corporate_Affairs_Trigger_List
		where Corporate_Affairs_ID = #form.CorporateAffairsID#
	</cfquery>

	<!--- update corporate affairs record --->
	<cfquery name="updCorporateAffairs" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		UPDATE #Request.WebSite#.dbo.Corporate_Affairs
		SET 
				Site_ID = #form.AdminSiteID#
				,Tracking_Date = '#form.TrackingDate#'
				,Trigger_Date = '#form.TriggerDate#'
				,Description = '#form.Description#'
				,Created_By = #Session.Security.UserID#
		WHERE Corporate_Affairs_ID = #form.CorporateAffairsID#
	</cfquery>

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

	<!--- create list of changed triggers --->
	<cfset changeTriggers = NewTriggerList>
	<cfloop list="#OldTriggerList#" index="t" >
		<cfset posTrigger = listfind(changeTriggers,t)>
		<cfif posTrigger GT 0>
			<cfset changeTriggers = listdeleteat(changeTriggers,posTrigger)>
		</cfif>
	</cfloop>

	<!--- send notice --->
	<cfif len(changeTriggers)>
		<CFModule template="Corporate_Affairs_Notifcation.cfm" NoticeType="CorpAffairs" SID="#form.AdminSiteID#" CAID="#form.CorporateAffairsID#" TID="#changeTriggers#">
	</cfif>
</cfif>
