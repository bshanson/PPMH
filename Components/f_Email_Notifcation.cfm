<!------------------------------------------------------- 
Description:
	email notifications to users informing them of their account information

History:
	01/05/2018 - created
-------------------------------------------------------->

<cfparam name="Attributes.Email" default="">
<cfparam name="Attributes.FirstName" default="">
<CFModule template="../Components/q_getPage.cfm" WebSite="PPMH" Database="PPMH" Label="Public Affairs" AccessLevel="3" RETURN="PublicAffairsLink">


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

<!--- new acccount email --->
<cfif attributes.NoticeType EQ "accountnew">
	<cfset Request.EmailSubject = "Portfolio & Project Management Hub Account Information">
	<cfset Request.EmailText = "An account for you has been created on the Portfolio & Project Management Hub web application, <a href='#Request.Website#'>#Request.Website#</a>.<br />"> 
	<cfset Request.EmailText = Request.EmailText & "Your email is set to <strong>#lcase(Attributes.Email)#</strong>.<br />"> 
	<cfset Request.EmailText = Request.EmailText & "Your password is set to <strong>#lcase(Attributes.pwd)#</strong> in all lowercase characters.<br />"> 
	<cfset Request.EmailText = Request.EmailText & "After you log-on, you may reset your password by clicking the <strong>My Password</strong> link in the upper right corner of the web page.<br />"> 
	<cfset Request.EmailText = Request.EmailText & "The new password must be at least 6 characters in length.<br /><br />"> 
	<cfset Request.EmailText = Request.EmailText & "Feel free to contact me with any questions or problems."> 
	
<CF_tag_SendGrid FROM="#Request.From#" TO="#Attributes.Email#" BCC="#Request.BCC#" SUBJECT="#Request.EmailSubject#">
<cfoutput>
	<img src="#Request.Website#/images/banner.jpg">
	<br /><br />
	<font face="Arial" point-size="10">
	#Attributes.FirstName# - <br />
	<br />
	#Request.EmailText#<br />
	<br />
	#Request.EmailSignature#
	<br /><br /><br />
	#Request.EmailDisclaimer#<br />
	</font>
</cfoutput>
</CF_tag_SendGrid>
</cfif>

<!--- reset acccount email --->
<cfif attributes.NoticeType EQ "accountreset">
	<cfset Request.EmailSubject = "Portfolio & Project Management Hub Account Information">
	
	<cfset Request.EmailText = "Your password has been reset.<br />"> 
	<cfset Request.EmailText = Request.EmailText & "Your email is set to <strong>#lcase(Attributes.Email)#</strong>.<br />"> 
	<cfset Request.EmailText = Request.EmailText & "Your password is set to <strong>#lcase(Attributes.pwd)#</strong> in all lowercase characters.<br />"> 
	<cfset Request.EmailText = Request.EmailText & "After you log-on, you may reset your password by clicking the <strong>My Password</strong> link in the upper right corner of the web page.<br />"> 
	<cfset Request.EmailText = Request.EmailText & "The new password must be at least 6 characters in length.<br /><br />"> 
	<cfset Request.EmailText = Request.EmailText & "Feel free to contact me with any questions or problems."> 
	
<CF_tag_SendGrid FROM="#Request.From#" TO="#Attributes.Email#" BCC="#Request.BCC#" SUBJECT="#Request.EmailSubject#">
<cfoutput>
	<img src="#Request.Website#/images/banner.jpg">
	<br /><br />
	<font face="Arial" point-size="10">
	#Attributes.FirstName# - <br />
	<br />
	#Request.EmailText#<br />
	<br />
	#Request.EmailSignature#
	<br /><br /><br />
	#Request.EmailDisclaimer#<br />
	</font>
</cfoutput>
</CF_tag_SendGrid>
</cfif>

<!--- public affairs email --->
<cfif attributes.NoticeType EQ "publicaffairs">
	<cfset Request.EmailSubject = "Portfolio & Project Management Hub - Public Affairs Notification">
	<cfset Request.EmailText = "The following site requires your attention:<br />"> 
	<cfset Request.EmailText = Request.EmailText & "Site ID: #Attributes.SiteID#<br />"> 
	<cfset Request.EmailText = Request.EmailText & "Site Name: #Attributes.SiteName	#<br />"> 
	<cfset Request.EmailText = Request.EmailText & "Address: #Attributes.Address#, #Attributes.City#, #Attributes.State#<br /><br />"> 
	<cfset Request.EmailText = Request.EmailText & "Action: #Attributes.Action#<br /><br />"> 
	<cfset Request.EmailText = Request.EmailText & "Link: #PublicAffairsLink#&SID=#Attributes.SiteID#<br />"> 
	
<CF_tag_SendGrid FROM="#Request.From#" TO="steven.perry@arcadis.com; bridget.butterly@arcadis.com" BCC="#Request.BCC#" SUBJECT="#Request.EmailSubject#">
<cfoutput>
	<img src="#Request.Website#/images/banner.jpg">
	<br /><br />
	<font face="Arial" point-size="10">
	Steve, Bridget - <br />
	<br />
	#Request.EmailText#<br />
	<br />
	#Request.EmailSignature#
	<br /><br /><br />
	#Request.EmailDisclaimer#<br />
	</font>
</cfoutput>
</CF_tag_SendGrid>
</cfif>

<!--- locked account email --->
<cfif attributes.NoticeType EQ "lockedaccount">
	<cfparam name="Attributes.UID" default="">
	<cfif not len(Attributes.Email)><cfset Attributes.Email = "Unknown"></cfif>
	<cfif not len(Attributes.UID)><cfset Attributes.UID = "Unknown"></cfif>
	<cfset Request.EmailSubject = "User lock out">
	<cfset Request.EmailText = "The following user has been locked out:</br>">
	<cfset Request.EmailText = Request.EmailText & "UID: #Attributes.UID#<br />"> 
	<cfset Request.EmailText = Request.EmailText & "Email: #Attributes.Email#<br />"> 
	<cfset Request.EmailText = Request.EmailText & "IP Address: #cgi.remote_addr#<br />"> 
	<cfset Request.EmailText = Request.EmailText & "Web Site: #Request.Website#<br />"> 
	<cfset Request.EmailText = Request.EmailText & "Date & Time: #dateTimeFormat(now(),"mm/dd/yyyy h:mm:ss tt")#<br />"> 

<CF_tag_SendGrid FROM="#Request.From#" TO="brian.hanson@arcadis.com" CC="" SUBJECT="#Request.EmailSubject#">
<cfoutput>
		<img src="#Request.Website#/images/banner.jpg">
		<br /><br />
		<font face="Arial" point-size="10">
		Brian - <br />
		<br />
		#Request.EmailText#<br />
		<br />
		#Request.EmailSignature#
		<br /><br /><br />
		#Request.EmailDisclaimer#<br />
		</font>
</cfoutput>
</CF_tag_SendGrid>
</cfif>
