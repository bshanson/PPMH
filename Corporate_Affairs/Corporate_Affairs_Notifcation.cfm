<!-----------------------------------------------------------------
Description:
	email notifications

History:
	07/27/2022 - created
------------------------------------------------------------------>

<cfparam name="Attributes.Email" default="">
<cfparam name="Attributes.FirstName" default="">
<CFModule template="../Components/q_getPage.cfm" WebSite="#Request.Site#" Database="#Request.WebSite#" Label="Corporate Affairs" AccessLevel="3" RETURN="CorporateAffairsLink">

<cfset Request.From = "#Request.Webmaster#">
<cfset Request.BCC = "brian.hanson@arcadis.com">
<cfset Local.Website = "#Request.Protocol#//#HTTP.Server_Name#/#Request.Site#">

<cfset Request.EmailDisclaimer = "This email was sent to you from the Portfolio & Project Management Hub web application, <a href='#Local.Website#'>#Local.Website#</a>.<br />"> 
<cfset Request.EmailDisclaimer = Request.EmailDisclaimer & "If you feel you have received this email in error, please contact <a href='mailto:brian.hanson@arcadis.com'>brian.hanson@arcadis.com</a>.<br />"> 
<cfset Request.EmailDisclaimer = Request.EmailDisclaimer & "Thank you."> 

<cfset Request.EmailSignature = "#Session.Security.Firstname# #Session.Security.LastName#<br />"> 
<cfset Request.EmailSignature = Request.EmailSignature & "ARCADIS<br />"> 
<cfset Request.EmailSignature = Request.EmailSignature & "Email: #Session.Security.Email#<br />"> 


<!--- corporate affairs email --->
<cfif attributes.NoticeType EQ "CorpAffairs">
	<!--- get site info --->
	<cfquery name="getTrigger" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
		SELECT a.Corporate_Affairs_ID, a.Tracking_Date, Trigger_Date, a.Description, a.Created_By,
					 b.Site_ID, b.Site_Name, b.Address, b.City, b.Corporate_Affairs_Advisor_ID,
					 c.State_Abbreviation, d.Portfolio_Name,
					 e.Email as Advisor_Email, e.First_Name as Advisor_First_Name,
					 f.Email as Ops_Lead_Email, f.First_Name as Ops_Lead_First_Name,
					 g.Email as SM_Email, g.First_Name as SM_First_Name,
					 h.Email as Deputy_Email, h.First_Name as Deputy_First_Name
		FROM #Request.WebSite#.dbo.Corporate_Affairs as a
				 inner join TurboScope.dbo.Admin_Site as b on a.site_ID = b.ID
				 inner join TurboScope.dbo.Admin_State as c on b.State_id = c.State_id
				 left join TurboScope.dbo.Admin_Portfolio as d on b.Portfolio_ID = d.Portfolio_ID
				 left join WebSite_Admin.dbo.Web_Site_Users as e on b.Corporate_Affairs_Advisor_ID = e.User_ID
				 left join WebSite_Admin.dbo.Web_Site_Users as f on b.Chevron_PM_ID = f.User_ID
				 left join WebSite_Admin.dbo.Web_Site_Users as g on b.SM_ID = g.User_ID
				 left join WebSite_Admin.dbo.Web_Site_Users as h on b.Portfolio_Deputy_ID = h.User_ID
		WHERE a.Corporate_Affairs_ID = #Attributes.CAID#
	</cfquery>

	<cfset Request.EmailText = "The following site has new / updated notification and trigger information:<br />"> 
	<cfset Request.EmailText = Request.EmailText & "<strong>COP:</strong> #getTrigger.Portfolio_Name#<br />"> 
	<cfset Request.EmailText = Request.EmailText & "<strong>Site ID:</strong> #getTrigger.Site_ID#<br />"> 
	<cfset Request.EmailText = Request.EmailText & "<strong>Site Name:</strong> #getTrigger.Site_Name#<br />"> 
	<cfset Request.EmailText = Request.EmailText & "<strong>Address:</strong> #getTrigger.Address#, #getTrigger.City#, #getTrigger.State_Abbreviation#<br />"> 
	<cfset Request.TriggerDate = "<strong>Trigger Date:</strong> #dateformat(getTrigger.Trigger_Date,'mm/dd/yyyy')#<br />"> 
	<cfset Request.TriggerDescription = "<strong>Description:</strong> #getTrigger.Description#<br />"> 
	
	<cfloop list="#attributes.TID#" index="t">
		<cfmodule template="../Corporate_Affairs/q_getCategoryDescription.cfm" TD="#t#" Return="getCategoryDescription">
		<cfloop query="getCategoryDescription">
			<cfset Request.EmailSubject = "Trigger Notification: #getTrigger.Portfolio_Name# Site #getTrigger.Site_ID# - #getCategoryDescription.Trigger_Category#">
			<cfset Request.TriggerTable = "<TABLE WIDTH='100%' CELLPADDING='0' CELLSPACING='0' border='1'>
																<tr>
																	<td width='50%'><span style='font-family:Arial; point-size:10; font-weight: bold;'>Trigger Category</span></td>
																	<td width='50%'><span style='font-family:Arial; point-size:10; font-weight: bold;'>Trigger Description</span></td>
															">
			<cfset Request.TriggerTable = Request.TriggerTable & "</tr>
															<td width='50%'><span style='font-family:Arial; point-size:10;'>#getCategoryDescription.Trigger_Category#</span></td>
															<td width='50%'><span style='font-family:Arial; point-size:10;'>#getCategoryDescription.Trigger_Description#</span></td>
													">
			<cfset Request.TriggerTable = Request.TriggerTable & "</tr>
															</table>
															">

<cfset EmailTo = getTrigger.Advisor_Email>
<cfif getTrigger.Corporate_Affairs_Advisor_ID EQ 10260><cfset EmailTo = getTrigger.Advisor_Email & "; tommy.lyles@chevron.com"></cfif>
<cfset BCCto = Session.Security.Email & "; " & Request.BCC>
<cfif getTrigger.SM_Email EQ Session.Security.Email><cfset BCCto = Request.BCC></cfif>
<CF_tag_SendGrid FROM="#Request.From#" TO="#EmailTo#" CC="#getTrigger.SM_Email#" BCC="#BCCto#" SUBJECT="#Request.EmailSubject#">
<cfoutput>
			<img src="#Local.Website#/images/banner.jpg">
			<br /><br />
			<font face="Arial" point-size="10">
			#getTrigger.Advisor_First_Name# - <br />
			<br />
			#Request.EmailText#
			<br />
			#Request.TriggerDate#
			#Request.TriggerDescription#<br />
			#Request.TriggerTable#<br />
			<br />
			#Request.EmailSignature#
			<br /><br /><br />
			#Request.EmailDisclaimer#<br />
			</font>
</cfoutput>
</CF_tag_SendGrid>
<CF_tag_SendGrid FROM="#Request.From#" TO="#getTrigger.Ops_Lead_Email#" CC="#getTrigger.Deputy_Email#" BCC="#Request.BCC#" SUBJECT="#Request.EmailSubject#">
<cfoutput>
			<img src="#Local.Website#/images/banner.jpg">
			<br /><br />
			<font face="Arial" point-size="10">
			#getTrigger.Ops_Lead_First_Name# - <br />
			<br />
			#Request.EmailText#
			<br />
			#Request.TriggerDate#
			#Request.TriggerDescription#<br />
			#Request.TriggerTable#<br />
			<br />
			#Request.EmailSignature#
			<br /><br /><br />
			#Request.EmailDisclaimer#<br />
			</font>
</cfoutput>
</CF_tag_SendGrid>
		</cfloop>
	</cfloop>
</cfif>
