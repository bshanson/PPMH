<!-------------------------------------------
Description:
	application banner

History:
	2/06/2020 - created
-------------------------------------------->

<cfoutput>
	<TABLE WIDTH="#Request.ApplicationWidth#" CELLSPACING="0" CELLPADDING="1" BGCOLOR="#Request.TableBorderColor#" align="center">
		<TR VALIGN="top">
			<TD ALIGN="left">
				<cfif isDefined("URL.TabID") and URL.TabID EQ 24>
				<A HREF="#Request.BaseURL#" TITLE="#Request.BaseURL#"><IMG SRC="images/banner-lt.jpg" ALT="" BORDER="0"></A>
				<cfelse>
				<A HREF="#Request.BaseURL#" TITLE="#Request.BaseURL#"><IMG SRC="images/banner.jpg" ALT="" BORDER="0"></A>
				</cfif>
			</TD>
		</TR>
	</TABLE>
</cfoutput>