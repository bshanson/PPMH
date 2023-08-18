<!------------------------------------------------------------------------------------
Description:
	Corporate Affairs requirements xml version

History:
	1/11/2022 - created
------------------------------------------------------------------------------------->

<CFSET timestamp = dateformat(now(),"mm/dd/yyyy") & "&nbsp;&nbsp;" & timeformat(now(),"hh:mm:sstt")>

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
			<Table ss:ExpandedColumnCount="13" ss:ExpandedRowCount="#expRowCount#" x:FullColumns="1" x:FullRows="1">
			<Column ss:Width="80"/>
			<Column ss:Width="100"/>
			<Column ss:Width="100"/>
			<Column ss:Width="150"/>
			<Column ss:Width="70"/>
			<Column ss:Width="70"/>
	    <Column ss:Width="150"/>
	    <Column ss:Width="100"/>
			<Column ss:Width="70"/>
			<Column ss:Width="150"/>
			<Column ss:Width="150"/>
			<Column ss:Width="310"/>
			<Column ss:Width="500"/>
	
			<!--- header --->
		  <Row ss:AutoFitHeight="0">
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Trigger Date</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Notification Date</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Site ID</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Site Name</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Portfolio</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Region</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Address</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">City</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">State</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Corporate Affairs Lead</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Operations Lead</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Category</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Description</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
			</Row>
		 
			<!--- data --->
			<cfloop query="getDistinctCorporateAffairs">
				<cfmodule template="q_getCorporateAffairs.cfm" CAID="#getDistinctCorporateAffairs.Corporate_Affairs_ID#" Return="getCorporateAffairs">
				<cfloop query="getCorporateAffairs">
					<Row>
						<Cell ss:StyleID="s69"><Data ss:Type="DateTime">#dateformat(getDistinctCorporateAffairs.Trigger_Date,"yyyy-mm-dd")#T00:00:00.000</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="s69"><Data ss:Type="DateTime">#dateformat(getDistinctCorporateAffairs.Tracking_Date,"yyyy-mm-dd")#T00:00:00.000</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="Default"><Data ss:Type="String">#getDistinctCorporateAffairs.Site_ID#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="Default"><Data ss:Type="String">#getDistinctCorporateAffairs.Site_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="Default"><Data ss:Type="String">#getDistinctCorporateAffairs.Portfolio#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="Default"><Data ss:Type="String">#getDistinctCorporateAffairs.Region#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="Default"><Data ss:Type="String">#getDistinctCorporateAffairs.Address#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="Default"><Data ss:Type="String">#getDistinctCorporateAffairs.City#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="Default"><Data ss:Type="String">#getDistinctCorporateAffairs.State_Abbreviation#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="Default"><Data ss:Type="String">#getDistinctCorporateAffairs.Corporate_Affairs_Advisor#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="Default"><Data ss:Type="String">#getDistinctCorporateAffairs.Ops_Lead#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="Default"><Data ss:Type="String">#getCorporateAffairs.Trigger_Category_ID#. #getCorporateAffairs.Trigger_Category#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
						<Cell ss:StyleID="Default"><Data ss:Type="String">#getCorporateAffairs.Trigger_Description#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					</Row>
				</cfloop>
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
  <AutoFilter x:Range="R1C1:R#expRowCount#C13" xmlns="urn:schemas-microsoft-com:office:excel">
  </AutoFilter>
 </Worksheet>
</Workbook>
</cfoutput>
</cfsavecontent>

<!---	write excel file --->
<CFFILE ACTION="WRITE" FILE="#Request.TempPath#\#FileName#" OUTPUT="#XMLData#">
