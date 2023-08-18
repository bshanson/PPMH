<!-------------------------------------------
Description:
	application footer

History:
	2/06/2020 - created
-------------------------------------------->

<CFOUTPUT>
	<TABLE CELLPADDING="0" CELLSPACING="1" BORDER="0" WIDTH="#Request.FooterWidth#" bgcolor="#Request.TableBorderColor#" align="center">
		<TR><TD>
			<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" WIDTH="#Request.FooterWidth#" bgcolor="#Request.TableBorderColor#" align="center">
				<TR VALIGN="top" BGCOLOR="#Request.FooterColor#">
			    <TD WIDTH="50%" CLASS="copyright">
						&nbsp;Copyright &copy; #DateFormat(Now(),"yyyy")# ARCADIS. All rights reserved.
					</TD>
			    <TD WIDTH="50%" CLASS="copyright" align="right">
						<a href="mailto:#Request.Webmaster#">Contact Us</a>&nbsp;
					</TD>
				</TR>
			</TABLE>
		</TD></TR>
	</TABLE>
</CFOUTPUT>
