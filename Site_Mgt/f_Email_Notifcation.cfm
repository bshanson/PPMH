<!------------------------------------------------------- 
Description:
	email notification about uploaded milestones

History:
	2/19/2020 - created
-------------------------------------------------------->

<cfparam name="Attributes.Email" default="">
<cfparam name="Attributes.FirstName" default="">

<cfset Request.From = "#Request.Webmaster#">
<cfset Request.BCC = "brian.hanson@arcadis.com">
<cfset Request.Website = "#Request.Protocol#//#HTTP.Server_Name#/#Request.Site#">

<cfset Request.EmailDisclaimer = "This email was sent to you from the Portfolio & Project Management Hub web application, <a href='#Request.Website#'>#Request.Website#</a>.<br />"> 
<cfset Request.EmailDisclaimer = Request.EmailDisclaimer & "If you feel you have received this email in error, please contact <a href='mailto:brian.hanson@arcadis.com'>brian.hanson@arcadis.com</a>.<br />"> 
<cfset Request.EmailDisclaimer = Request.EmailDisclaimer & "Thank you."> 

<cfset Request.EmailSignature = "Brian Hanson<br /><br />"> 
<cfset Request.EmailSignature = Request.EmailSignature & "ARCADIS | Arcadis of New York, Inc./Arcadis CE, Inc.<br />"> 
<cfset Request.EmailSignature = Request.EmailSignature & "One Lincoln Center | 110 West Fayette Street, Suite 300 | Syracuse, NY 13202 | USA<br />"> 
<cfset Request.EmailSignature = Request.EmailSignature & "Tel: 315-671-9175<br />"> 
<cfset Request.EmailSignature = Request.EmailSignature & "Fax: 315-449-0017<br />"> 
<cfset Request.EmailSignature = Request.EmailSignature & "Email: brian.hanson@arcadis.com<br />"> 

<CFQUERY NAME="emailMilestones" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select a.Period, a.Year,
				 b.Milestone,
				 c.Site_ID, c.Site_Name
	from PPMH.dbo.Site_Milestones as a
		inner join PPMH.dbo.Milestones as b on a.Milestone_ID = b.id 
		inner join TurboScope.dbo.Admin_Site as c on a.Site_ID = c.id 
	WHERE a.ID = '#form.SiteMilestoneID#'
</CFQUERY>

<!--- Milestone Upload --->
<cfif attributes.NoticeType EQ "upload">
	<cfset Request.EmailSubject = "Portfolio & Project Management Hub Site Milestone Upload">
	<cfset Request.EmailText = "The following milstone has been claimed:<br />"> 

	<cfloop query="emailMilestones" >
		<cfset Request.EmailText = Request.EmailText & "<strong>Site ID</strong>: #emailMilestones.Site_ID#<br />"> 
		<cfset Request.EmailText = Request.EmailText & "<strong>Site Name</strong>: #emailMilestones.Site_Name#<br />"> 
		<cfset Request.EmailText = Request.EmailText & "<strong>Period</strong>: #emailMilestones.Period#<br />"> 
		<cfset Request.EmailText = Request.EmailText & "<strong>Milestone</strong>: #emailMilestones.Milestone#<br />"> 
		<cfset Request.EmailText = Request.EmailText & "<strong>Milestone Year</strong>: #emailMilestones.Year#<br /><br />"> 
	</cfloop>

<!---<CFMAIL type="HTML" FROM="#Request.From#" TO="brian.hanson@arcadis.com" BCC="#Request.BCC#" SUBJECT="#Request.EmailSubject#">--->
<CF_tag_SendGrid FROM="#Request.From#" TO="brian.hanson@arcadis.com" BCC="#Request.BCC#" SUBJECT="#Request.EmailSubject#">
<cfoutput>
		<img src="#Request.Website#/images/banner.jpg">
		<br /><br />
		<font face="Arial" point-size="10">
		Lynne - <br />
		<br />
		#Request.EmailText#<br />
		<br />
		#Request.EmailSignature#
		<br /><br /><br />
		#Request.EmailDisclaimer#<br />
		</font>
</cfoutput>
</CF_tag_SendGrid>
<!---</CFMAIL>--->
</cfif>
