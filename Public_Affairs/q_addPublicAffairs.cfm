<!----------------------------------------------------------------------------------------------------------
Description:
	add public affairs record

History:
	5/24/2021 - created
----------------------------------------------------------------------------------------------------------->

<!--- error check --->
<cfinclude template="f_ErrorCheck.cfm" >

<cfif not ArrayLen(errormsg)>
	<!--- add reg action --->
	<CFQUERY NAME="addPublicAffairs" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		insert into PPMH.dbo.Public_Affairs
			(Site_ID, q1, q2, q3, q4, q5, q6, q7, q8, q1_describe, q2_describe, q3_describe, q4_describe, q5_describe, 
			q6_describe, q7_describe, q8_describe, Assessment_Date, User_ID, Comments_Date, Comments)
		values
			('#form.AdminSiteID#'
			,#form.q1#
			,#form.q2#
			,#form.q3#
			,#form.q4#
			,#form.q5#
			,#form.q6#
			,#form.q7#
			,#form.q8#
			,'#form.q1describe#'
			,'#form.q2describe#'
			,'#form.q3describe#'
			,'#form.q4describe#'
			,'#form.q5describe#'
			,'#form.q6describe#'
			,'#form.q7describe#'
			,'#form.q8describe#'
			,'#form.AssessmentDate#'
			,#Session.Security.UserID#
			,<cfif len(form.CommentsDate)>'#form.CommentsDate#'<cfelse>NULL</cfif>
			,'#form.Comments#'
			)
	</CFQUERY>

	<!--- get the id of the new record --->
	<CFQUERY NAME="getmaxid" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		select max(Public_Affairs_ID) as maxid from PPMH.dbo.Public_Affairs
	</CFQUERY>
	<cfset form.PublicAffairsID = getmaxid.maxid>
	<cfset form.edittype = "editPublicAffairs">

	<!--- get site ID info--->
	<CFQUERY NAME="getSiteID" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		select a.Site_ID, a.Site_Name, a.Address, a.City, b.State_Abbreviation
		from TurboScope.dbo.Admin_Site as a 
			inner join TurboScope.dbo.Admin_State as b on a.State_id = b.State_id
		where a.id = #form.AdminSiteID#
	</CFQUERY>

	<!--- send email notice --->
	<cfset actionCnt = 0>
	<cfset action = "">
	<cfif form.Q1 EQ 1><cfset actionCnt = actionCnt+1></cfif>
	<cfif form.Q2 EQ 1><cfset actionCnt = actionCnt+1></cfif>
	<cfif form.Q3 EQ 1><cfset actionCnt = actionCnt+1></cfif>
	<cfif form.Q4 EQ 1><cfset actionCnt = actionCnt+1></cfif>
	<cfif form.Q5 EQ 1><cfset actionCnt = actionCnt+1></cfif>
	<cfif form.Q6 EQ 1><cfset actionCnt = actionCnt+1></cfif>
	<cfif form.Q7 EQ 0><cfset actionCnt = actionCnt+1></cfif>
	<cfif form.Q8 EQ 0><cfset actionCnt = actionCnt+1></cfif>
	<cfif actionCnt EQ 2><cfset action = "Public affairs consult required"></cfif>
	<cfif actionCnt GTE 3><cfset action = "Detailed assessment required"></cfif>
	<cfif actionCnt GTE 2 and not len(form.CommentsDate)>
		<CFModule template="../Components/f_Email_Notifcation.cfm" NoticeType="publicaffairs" SiteID="#getSiteID.Site_ID#" SiteName="#getSiteID.Site_Name#" Action="#Action#" Address="#getSiteID.Address#" City="#getSiteID.City#" State="#getSiteID.State_Abbreviation#">
	</cfif>
</cfif>
