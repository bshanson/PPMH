<!--------------------------------------------------------------------------
Description:
	Returns messages related to log-in results

History:
	1/11/2019 - created
--------------------------------------------------------------------------->

<cfcomponent>
	<cffunction name="getMessage"
			  			hint="get the message" 
			  			returntype="String">

			<CFSWITCH EXPRESSION="#arguments.MessageCode#">
				<CFCASE VALUE="001">
					<cfset theMessage = "Login unsuccessful. Please re-enter your username and password.">
				</CFCASE>
				
				<CFCASE VALUE="002">
					<cfset theMessage = "Your password has been updated.">
				</CFCASE>
				
				<CFCASE VALUE="003">
					<cfset theMessage = "An account with that email does not exist in the system.">
				</CFCASE>
				
				<CFCASE VALUE="004">
					<cfset theMessage = "Your account has been updated.">
				</CFCASE>
			
				<CFCASE VALUE="005">
					<cfset theMessage = "Your password has been reset.">
				</CFCASE>
					
				<CFCASE VALUE="006">
					<cfset theMessage = "You have exceeded the number of login attempts.  Your account has been locked.">
				</CFCASE>
					
				<CFDEFAULTCASE>
					<CFSET theMessage = "">
				</CFDEFAULTCASE>
			</CFSWITCH>

		<cfreturn theMessage>
	</cffunction>
</cfcomponent>
