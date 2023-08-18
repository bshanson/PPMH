<!------------------------------------------------------------------------------------
Description:
	AccessLUC requirements xml version

History:
	2/11/2020 - created
------------------------------------------------------------------------------------->

<CFSET timestamp = dateformat(now(),"mm/dd/yyyy") & "&nbsp;&nbsp;" & timeformat(now(),"hh:mm:sstt")>
<cfset expRowCount = getAccessLUC.RecordCount + 1>

<!--- store the XML data --->
<cfsavecontent variable="XMLData">
<cfoutput>
	<!--- XML declaration  --->
	<?xml version="1.0"?>
	<?mso-application progid="Excel.Sheet"?>
 
	<!--- the workbook root element stores characteristics and properties of the workbook --->
	<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
		xmlns:o="urn:schemas-microsoft-com:office:office"
		xmlns:x="urn:schemas-microsoft-com:office:excel"
		xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
		xmlns:html="http://www.w3.org/TR/REC-html40">
 
		<!--- DocumentProperties stores metadata related to the document --->
		<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
			<Author></Author>
		</DocumentProperties>
 
		<!--- workbook-level characteristics and properties of the document --->
		<ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">
			<WindowHeight>12000</WindowHeight>
			<WindowWidth>21000</WindowWidth>
			<WindowTopX>0</WindowTopX>
			<WindowTopY>0</WindowTopY>
			<ProtectStructure>False</ProtectStructure>
			<ProtectWindows>False</ProtectWindows>
		</ExcelWorkbook>
	
		<!--- styles of components of the workbook --->
		<Styles>
			<Style ss:ID="Default" ss:Name="Normal">
				<Alignment ss:Vertical="Top" ss:WrapText="1"/>
				<Borders/>
				<Font ss:FontName="Arial" ss:Size="9"/>
				<Interior/>
				<NumberFormat/>
				<Protection/>
			</Style>
			<Style ss:ID="frmtGreenHeader">
		    <Alignment ss:Horizontal="Center" ss:Vertical="Top"/>
				<Font ss:FontName="Arial" ss:Bold="1" ss:Size="9"/>
			  <Interior ss:Color="##CCFFCC" ss:Pattern="Solid"/>
				<Borders>
					<Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
					<Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
					<Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
					<Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
				</Borders>
			</Style>
			<Style ss:ID="s69">
			 <Alignment ss:Horizontal="Center" ss:Vertical="Top" ss:WrapText="1"/>
			 <Borders/>
			 <Font ss:FontName="Arial" ss:Size="9"/>
			 <Interior/>
			 <NumberFormat ss:Format="Short Date"/>
			 <Protection/>
			</Style>
		  <Style ss:ID="s70">
		   <Alignment ss:Horizontal="Center" ss:Vertical="Top" ss:WrapText="1"/>
		  </Style>
		  <Style ss:ID="sGreen">
		   <Alignment ss:Horizontal="Center" ss:Vertical="Top" ss:WrapText="1"/>
		   <Borders/>
		   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="##FFFFFF"/>
		   <Interior ss:Color="##00B050" ss:Pattern="Solid"/>
		   <NumberFormat/>
		   <Protection/>
		  </Style>
		  <Style ss:ID="sRed">
		   <Alignment ss:Horizontal="Center" ss:Vertical="Top" ss:WrapText="1"/>
		   <Borders/>
		   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="##FFFFFF"/>
		   <Interior ss:Color="##FF0000" ss:Pattern="Solid"/>
		   <NumberFormat/>
		   <Protection/>
		  </Style>
		</Styles>
 
		<Worksheet ss:Name="Advocacy">
			<!--- define columns --->
			<Table ss:ExpandedColumnCount="24" ss:ExpandedRowCount="#expRowCount#" x:FullColumns="1" x:FullRows="1">
			<Column ss:Width="70"/>
			<Column ss:Width="150"/>
	    <Column ss:Width="150"/>
	    <Column ss:Width="100"/>
			<Column ss:Width="70"/>
			<Column ss:Width="70"/>
			<Column ss:Width="150"/>
			<Column ss:Width="100"/>
			<Column ss:Width="100"/>
			<Column ss:Width="200"/>
			<Column ss:Width="150"/>
			<Column ss:Width="130"/>
			<Column ss:Width="120"/>
			<Column ss:Width="150"/>
			<Column ss:Width="150"/>
			<Column ss:Width="170"/>
			<Column ss:Width="150"/>
			<Column ss:Width="130"/>
			<Column ss:Width="150"/>
			<Column ss:Width="125"/>
			<Column ss:Width="70"/>
			<Column ss:Width="150"/>
			<Column ss:Width="500"/>
			<Column ss:Width="70"/>
	
			<!--- header --->
		  <Row ss:AutoFitHeight="0">
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Site ID</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Site Name</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Address</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">City</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">State</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Zip Code</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Site Manager</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Portfolio</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">On-site / Off-site</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Access Property</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Agreement Type</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Arcadis / Chevron Form</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Milestone in Place</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">SPL</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Outside Counsel Involved</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Field Work Notification Required</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Until Completion Of Work</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Term Letter Sent</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Stage</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Expiration Date</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Priority</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Forecast Closure Date</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">SPL Notes</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Complete</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
			</Row>
		 
			<!--- data --->
			<cfloop query="getAccessLUC">
				<cfset vComplete = "No">
				<cfif getAccessLUC.Complete EQ 1><cfset vComplete = "Yes"></cfif>
				<Row>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getAccessLUC.Site_ID#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getAccessLUC.Site_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getAccessLUC.Address#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getAccessLUC.City#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s70"><Data ss:Type="String">#getAccessLUC.State_Abbreviation#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getAccessLUC.Zip_Code#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getAccessLUC.SM_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s70"><Data ss:Type="String">#getAccessLUC.Portfolio#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s70"><Data ss:Type="String"><cfif getAccessLUC.Onsite EQ 1>On-site</cfif><cfif getAccessLUC.Onsite EQ 0>Off-site</cfif></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getAccessLUC.Access_Property#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getAccessLUC.Agreement_Type#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getAccessLUC.Arcadis_Chevron_Form#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s70"><Data ss:Type="String">#getAccessLUC.Milestone_In_Place#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getAccessLUC.SPL_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s70"><Data ss:Type="String">#YesNoFormat(getAccessLUC.Outside_Counsel_Involved)#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s70"><Data ss:Type="String">#YesNoFormat(getAccessLUC.Field_Work_Notification)#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s70"><Data ss:Type="String">#YesNoFormat(getAccessLUC.Until_Completion)#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s70"><Data ss:Type="String">#getAccessLUC.Term_Letter_Sent#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="Default"><Data ss:Type="String">#getAccessLUC.Stage#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s69"><cfif len(getAccessLUC.Expiration_Date)><Data ss:Type="DateTime">#dateformat(getAccessLUC.Expiration_Date,"yyyy-mm-dd")#T00:00:00.000<cfelse><Data ss:Type="String"></cfif></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<cfModule template="q_getForecastInfo.cfm" SiteID="#getAccessLUC.Admin_Site_ID#" ForecastInfo="getForecastInfo">
					<cfset vForecast = "">
					<cfif len(getForecastInfo.maxYear) and len(getForecastInfo.maxQuarter)><cfset vForecast = getForecastInfo.maxYear & " Q" & getForecastInfo.maxQuarter></cfif>
					<Cell ss:StyleID="s70"><Data ss:Type="String">#getAccessLUC.Priority#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s70"><Data ss:Type="String">#vForecast#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<cfmodule template="../components/f_ReplaceCharacters.cfm" FieldName="#getAccessLUC.SPL_Notes#" varNewValue="vNotes">
					<Cell ss:StyleID="Default"><Data ss:Type="String">#vNotes#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s70"><Data ss:Type="String">#vComplete#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				</Row>
			</cfloop>
 		 	</Table>

  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <Selected/>
   <FreezePanes/>
   <FrozenNoSplit/>
   <SplitHorizontal>1</SplitHorizontal>
   <TopRowBottomPane>1</TopRowBottomPane>
   <ActivePane>2</ActivePane>
   <Panes>
    <Pane>
     <Number>3</Number>
    </Pane>
    <Pane>
     <Number>2</Number>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
  <AutoFilter x:Range="R1C1:R#expRowCount#C24" xmlns="urn:schemas-microsoft-com:office:excel">
  </AutoFilter>
 </Worksheet>
</Workbook>
</cfoutput>
</cfsavecontent>

<!---	write excel file --->
<CFFILE ACTION="WRITE" FILE="#Request.TempPath#\#FileName#" OUTPUT="#XMLData#">
