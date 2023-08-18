<!----------------------------------------------------------------------------------------------------------
Description:
	add Change record

History:
	4/3/2020 - created
----------------------------------------------------------------------------------------------------------->

<!--- create folder name, subfolder name, sharepoint doc name --->
<cfinclude template="q_getSiteInfo.cfm" >
<!--- set FCOFolder --->
<cfif not len(getSiteInfo.City)><cfset vCity = "NoCity"><cfelse><cfset vCity = getSiteInfo.City></cfif>
<cfif not len(getSiteInfo.Region)><cfset vRegion = "NoRegion"><cfelse><cfset vRegion = getSiteInfo.Region></cfif>
<cfset FCOFolder = getSiteInfo.Portfolio_Name & "_" & vRegion & "_" & getSiteInfo.Site_ID & "_"  & getSiteInfo.State_Abbreviation & "_" & vCity>
<!--- set FCOSubFolder --->
<cfset FCOSubFolder = dateformat(now(), 'mmddyyyy') & "_" & form.FCOName>
<!--- set Template_Name --->
<cfset TemplateName = FCOFolder & "_" & form.FCOName & "_" & dateformat(now(), 'mmddyyyy') & ".docx">

<!--- error check --->
<cfinclude template="f_ErrorCheck.cfm" >

<cfif not ArrayLen(errormsg)>
	<!--- add Change log --->
	<CFQUERY NAME="addChangeLog" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		insert into #Request.WebSite#.dbo.Change_Log
			(Site_ID, Portfolio_ID, Date_Logged, 
			Current_Status_ID, Update_Status_ID,
			<!---Current_Action_ID,---> <!---Request_Action_ID,---> 
			Assigned_To_ID,Send_To_ID, 
			Creator_User_ID, Update_Date, FCO_Name,
			Template_Name, FCO_Folder, FCO_SubFolder,
			User_ID, Email, Time_Logged, Status_Action_Send_Date)
		values
			(<cfqueryparam value="#form.AdminSiteID#" cfsqltype="cf_sql_varchar" >
			,<cfqueryparam value="#form.PortfolioID#" cfsqltype="cf_sql_integer" > 
			,<cfqueryparam value="#dateformat(now(), 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" > 
			,<cfqueryparam value="1" cfsqltype="cf_sql_integer" > 
			,<cfqueryparam value="1" cfsqltype="cf_sql_integer" > 
<!---			,<cfqueryparam value="1" cfsqltype="cf_sql_integer" >---> 
<!---			,<cfqueryparam value="1" cfsqltype="cf_sql_integer" >---> 
			,<cfqueryparam value="9" cfsqltype="cf_sql_integer" > 
			,<cfqueryparam value="9" cfsqltype="cf_sql_integer" >
			,<cfqueryparam value="#Session.Security.UserID#" cfsqltype="cf_sql_integer" >
			,<cfqueryparam value="#dateformat(now(), 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" > 
			,<cfqueryparam value="#form.FCOName#" cfsqltype="cf_sql_varchar">
			,<cfqueryparam value="#TemplateName#" cfsqltype="cf_sql_varchar">
			,<cfqueryparam value="#FCOFolder#" cfsqltype="cf_sql_varchar">
			,<cfqueryparam value="#FCOSubFolder#" cfsqltype="cf_sql_varchar">
			,<cfqueryparam value="#Session.Security.UserID#" cfsqltype="cf_sql_integer" >
			,<cfqueryparam value="#Session.Security.Email#" cfsqltype="cf_sql_varchar">
			,<cfqueryparam value="#CreateODBCDateTime(now())#" cfsqltype="cf_sql_timestamp" > 
			,<cfqueryparam value="#dateformat(now(), 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" > 
			)
	</CFQUERY>

	<CFQUERY NAME="getmaxid" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		select max(change_log_id) as maxid from #Request.WebSite#.dbo.Change_Log
	</CFQUERY>
	<cfset form.editChangeLogID = getmaxid.maxid>
	<!--- update Change log history --->
	<cfquery name="updChangeLogHistory" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		insert into #Request.WebSite#.dbo.Change_Log_History
			(Change_Log_ID, Status_ID, <!---Action_ID,---> Team_ID, Status_Date, User_ID)
			values
			(<cfqueryparam value="#form.editChangeLogID#" cfsqltype="cf_sql_integer" >
			,<cfqueryparam value="1" cfsqltype="cf_sql_integer" >
<!---			,<cfqueryparam value="1" cfsqltype="cf_sql_integer" >--->
			,<cfqueryparam value="9" cfsqltype="cf_sql_integer" >
			,<cfqueryparam value="#dateformat(now(), 'mm/dd/yyyy')#" cfsqltype="cf_sql_date" >
			,#Session.Security.UserID#)
	</cfquery>
	<CFModule template="Change_Log_Notifcation.cfm" NoticeType="1" CLID="#form.editChangeLogID#" SiteID="#getSiteInfo.Site_ID#" SiteName="#getSiteInfo.Site_Name#" Address="#getSiteInfo.Address#" City="#getSiteInfo.City#" State="#getSiteInfo.State_Abbreviation#">
</cfif>
