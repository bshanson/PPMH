<!-------------------------------------------
Description:
	query to get the TaxationBase

History:
	3/26/2020 - created
-------------------------------------------->

<CFQUERY NAME="getTaxationBase" datasource="#request.datasource#" username="#Request.UN#" password="#Request.PW#">
	select Taxation_Base_ID, Bill_Set_Label
	from TurboScope.dbo.Admin_Taxation_Base
	where Active = 1
	order by Taxation_Base_ID
</CFQUERY>
