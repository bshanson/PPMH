<!--------------------------------------------------------------------------
Description:
	creates a menu along the top for client related websites

History:
	12/23/2015 - created
--------------------------------------------------------------------------->
 
<CFSET TDWidth = "14%">

<cfoutput>
	<TABLE WIDTH="#Request.ApplicationWidth#" CELLSPACING="0" CELLPADDING="0" border="0" align="center" bgcolor="##ffffff" >
		<tr>
			<td>
				<TABLE WIDTH="100%" CELLSPACING="1" CELLPADDING="0" border="0" align="center">
					<TR>
						<TD NOWRAP ALIGN="center" bgcolor="#Request.MenuColor#" width="#tdwidth#" class="websitemenu">
							<a href="https://arcadiso365.sharepoint.com/teams/Chevron" target="_blank">Chevron Global Team Site</a>  
						</TD>
						<TD NOWRAP ALIGN="center" bgcolor="#Request.MenuColor#" width="#tdwidth#" class="websitemenu">
							<a href="/SSMS/">SSMS</a>  
						</TD>
						<TD NOWRAP ALIGN="center" bgcolor="#Request.MenuColor#" width="#tdwidth#" class="websitemenu">
							<a href="/fieldcalendar/">Field Calendar</a>  
						</TD>
						<TD NOWRAP ALIGN="center" bgcolor="#Request.MenuColor#" width="#tdwidth#" class="websitemenu">
							<a href="/STMS/">STMS</a>  
						</TD>
						<TD NOWRAP ALIGN="center" bgcolor="#Request.MenuColor#" width="#tdwidth#" class="websitemenu">
							<a href="/TurboScope/">TurboScope</a>  
						</TD>
						<TD NOWRAP ALIGN="center" bgcolor="#Request.MenuColor#" width="#tdwidth#" class="websitemenu">
							<a href="/SIMS/">SIMS</a>  
						</TD>
						<TD NOWRAP ALIGN="center" bgcolor="#Request.MenuColor#" width="#tdwidth#" class="websitemenuselected">
							<a href="/PPMH/">PPMH</a>  
						</TD>
					</TR>
				</TABLE>
			</td>
		</tr>
</cfoutput>
