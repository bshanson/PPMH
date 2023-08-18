<!-------------------------------------------
Description:
	application pre-banner information

History:
	2/06/2020 - created
-------------------------------------------->

<cfoutput>
	<TABLE BORDER="0" WIDTH="#Request.ApplicationWidth#" CELLSPACING="0" CELLPADDING="0" align="center">
		<TR>
			<td class="mediumText" width="50%" align="left">Today is: #dateformat(now(),"mm/dd/yyyy")#</td>
			<td class="mediumText" width="50%" align="right">
				<cfif isDefined("Session.Security.LoggedIn") and isDefined("Session.Security.UserID")>
					<CFINCLUDE TEMPLATE="PreBanner_Links.cfm">
					<cfif Session.Security.UserID EQ 1>
						| 
						<A HREF="https://solutions.arcadis-us.com">Launch Pad</A>
					</cfif>
				</cfif>
			</td>
		</TR>
		<tr><td></td></tr>
	</table>
</cfoutput>