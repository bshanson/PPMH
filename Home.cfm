<!-------------------------------------------
Description:
	home page

History:
	2/06/2020 - created
-------------------------------------------->

<cfoutput>
	<table width="100%" cellpadding="0" cellspacing="0">
		<tr><td colspan="2" class="largeText">&nbsp;</td></tr>
		<tr valign="top">
			<td  valign="top" align="center" width="30%" class="largeText">
				<img src="images/home.jpg" border="0">
			</td>
			<td valign="top" class="largeText">
				<strong>Welcome to the Portfolio & Project Management Hub web application</strong>
				<br><br>
				Use this site to manage and report the Portfolio & Project Management Hub information.
				<br><br>
				<strong>Dashboards</strong><br>
				<cfif Session.Security.CompanyID EQ 1><a href="https://app.powerbi.com/groups/21da6b41-f101-42d2-9c24-bf9ce3190667/reports/2fff44a9-f283-41df-ad48-59873ae95149/ReportSection3c21a8ebda3d4d5006ce" target="_blank">Chevron KPI Dashboard</a><br></cfif>
				<a href="https://app.powerbi.com/groups/21da6b41-f101-42d2-9c24-bf9ce3190667/reports/5c8d3b4f-861c-448b-ae0b-e12a1355badf?ctid=7f90057d-3ea0-46fe-b07c-e0568627081b&pbi_source=linkShare" target="_blank">Chevron Milestone Dashboard - External</a><br>
				<a href="https://app.powerbi.com/groups/21da6b41-f101-42d2-9c24-bf9ce3190667/reports/1204071e-502d-4593-a523-4b9467f588e1?ctid=7f90057d-3ea0-46fe-b07c-e0568627081b&pbi_source=linkShare" target="_blank">Chevron FCO Dashboard (draft)</a><br>

				<cfif Session.Security.CompanyID EQ 253>
					<br>
					<strong>Field Calendar</strong><br>
					<a href="https://solutions.arcadis-us.com/fieldcalendar/" target="_blank">Open the Field Calendar</a><br>
				</cfif>
			</td>
		</tr>
		<tr><td colspan="2" class="largeText">&nbsp;</td></tr>
	</table>
</cfoutput>