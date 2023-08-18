<!-------------------------------------------
Description:
	query to get the user info and reset password

History:
	1/11/2019 - created
-------------------------------------------->

<!--- build an array --->
<cfset arrValidChars = ListToArray("A,B,C,D,E,F,G,H,J,K,L,M,N,P,Q,R,S,T,U,V,W,X,Y,Z,2,3,4,5,6,7,8,9" &
										   ",a,b,c,d,e,f,g,h,i,j,k,m,n,o,p,q,r,s,t,u,v,w,x,y,z,$,@,!,-,_") />
<cfset strRandomPassword = "">
<!--- Shuffle the array --->
<cfset CreateObject("java","java.util.Collections").Shuffle(arrValidChars)/>
<cfset passwordLength = 7>
<!--- Build the password --->
<cfloop index="i" from="1" to="#passwordLength#">
	<cfset strRandomPassword = strRandomPassword & arrValidChars[#i#]>
</cfloop>
<cfset encEmail = trim(encrypt(lcase(strRandomPassword),request.seed))>

<!--- update --->
<CFQUERY NAME="updatePassword" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	update WebSite_Admin.dbo.Web_Site_Users
	set	Password = <cfqueryparam value="#encEmail#" cfsqltype="CF_SQL_VARCHAR">
		,Enc_User_ID = <cfqueryparam value="#strRandomPassword#" cfsqltype="CF_SQL_VARCHAR">
	where email = <cfqueryparam value="#trim(Form.Email)#" cfsqltype="CF_SQL_VARCHAR">
</CFQUERY>
<CFQUERY NAME="updatePassword" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	update ExxonMobilTeam.dbo.XOM_Users
	set	password = <cfqueryparam value="#encEmail#" cfsqltype="CF_SQL_VARCHAR">
		,Enc_User_ID = <cfqueryparam value="#strRandomPassword#" cfsqltype="CF_SQL_VARCHAR">
	where email = <cfqueryparam value="#trim(Form.Email)#" cfsqltype="CF_SQL_VARCHAR">
</CFQUERY>
<CFQUERY NAME="getUserInfo" datasource="#request.datasource#" username="#Request.DBUsername#" password="#Request.DBPassword#">
	SELECT First_Name, Last_Name, Email, Enc_User_ID
	FROM WebSite_Admin.dbo.Web_Site_Users
	WHERE email = <cfqueryparam value="#trim(Form.Email)#" cfsqltype="CF_SQL_VARCHAR">
</CFQUERY>
<cfinvoke component="Components.getMessageCode" method="getMessage" returnvariable="theMessage">
	<cfinvokeargument name="MessageCode" value="005" />
</cfinvoke>
