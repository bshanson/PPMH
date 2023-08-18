<!----------------------------------------------------------------------------------------------------------
Description:
	update public affairs record

History:
	5/24/2021 - created
----------------------------------------------------------------------------------------------------------->

<!--- error check --->
<cfinclude template="f_ErrorCheck.cfm" >

<cfif not ArrayLen(errormsg)>
	<!--- update Public Affairs action --->
	<cfquery name="updPublicAffairs" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		UPDATE PPMH.dbo.Public_Affairs
		SET 
			q1 = #form.q1#
			,q2 = #form.q2#
			,q3 = #form.q3#
			,q4 = #form.q4#
			,q5 = #form.q5#
			,q6 = #form.q6#
			,q7 = #form.q7#
			,q8 = #form.q8#
			,q1_describe = '#form.q1describe#'
			,q2_describe = '#form.q2describe#'
			,q3_describe = '#form.q3describe#'
			,q4_describe = '#form.q4describe#'
			,q5_describe = '#form.q5describe#'
			,q6_describe = '#form.q6describe#'
			,q7_describe = '#form.q7describe#'
			,q8_describe = '#form.q8describe#'
			,Assessment_Date = '#form.AssessmentDate#'
			,User_ID = #Session.Security.UserID#
			,Comments_Date = <cfif len(form.CommentsDate)>'#form.CommentsDate#'<cfelse>NULL</cfif>
			,Comments = '#form.Comments#'
		WHERE Public_Affairs_ID = '#form.PublicAffairsID#'
	</cfquery>

	<!--- send email notice --->
	<cfset actionCnt = 0>
	<cfset action = "">
	<cfif form.Q1 EQ 1><cfset actionCnt = actionCnt+1></cfif>
	<cfif form.Q2 EQ 1><cfset actionCnt = actionCnt+1></cfif>
	<cfif form.Q3 EQ 1><cfset actionCnt = actionCnt+1></cfif>
	<cfif form.Q4 EQ 1><cfset actionCnt = actionCnt+1></cfif>
	<cfif form.Q5 EQ 1><cfset actionCnt = actionCnt+1></cfif>
	<cfif form.Q6 EQ 1><cfset actionCnt = actionCnt+1></cfif>
	<cfif actionCnt EQ 2><cfset action = "Public affairs consult required"></cfif>
	<cfif actionCnt GTE 3><cfset action = "Detailed assessment required"></cfif>
	<cfif actionCnt GTE 2 and not len(form.CommentsDate)>
		<CFModule template="../Components/f_Email_Notifcation.cfm" NoticeType="publicaffairs" SiteID="#form.SiteID#" SiteName="#form.SiteName#" Action="#Action#" Address="#form.Address#" City="#form.City#" State="#form.StateAbbreviation#">
	</cfif>
</cfif>
