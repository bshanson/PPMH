<!------------------------------------------------------------------------------------
Description:
	regulatory requirements xml version

History:
	2/7/2020 - created
------------------------------------------------------------------------------------->

<CFSET timestamp = dateformat(now(),"mm/dd/yyyy") & "&nbsp;&nbsp;" & timeformat(now(),"hh:mm:sstt")>
<cfset expRowCount = getRegulatory.RecordCount + 1>

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

			<!--- no fill --->
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
			<Style ss:ID="s71">
				<Alignment ss:Vertical="Top" ss:WrapText="1"/>
				<Borders/>
				<Font ss:FontName="Arial" ss:Size="9"/>
				<Interior/>
				<NumberFormat/>
				<Protection/>
			</Style>
			<!--- yellow fill --->
			<Style ss:ID="s69y">
			 <Alignment ss:Horizontal="Center" ss:Vertical="Top" ss:WrapText="1"/>
			 <Borders/>
			 <Font ss:FontName="Arial" ss:Size="9"/>
		   <Interior ss:Color="##FFFF00" ss:Pattern="Solid"/>
			 <NumberFormat ss:Format="Short Date"/>
			 <Protection/>
			</Style>
		  <Style ss:ID="s70y">
		   <Alignment ss:Horizontal="Center" ss:Vertical="Top" ss:WrapText="1"/>
		   <Interior ss:Color="##FFFF00" ss:Pattern="Solid"/>
		  </Style>
			<Style ss:ID="s71y">
				<Alignment ss:Vertical="Top" ss:WrapText="1"/>
				<Borders/>
				<Font ss:FontName="Arial" ss:Size="9"/>
		   	<Interior ss:Color="##FFFF00" ss:Pattern="Solid"/>
				<NumberFormat/>
				<Protection/>
			</Style>
			<!--- red fill --->
			<Style ss:ID="s69r">
			 <Alignment ss:Horizontal="Center" ss:Vertical="Top" ss:WrapText="1"/>
			 <Borders/>
			 <Font ss:FontName="Arial" ss:Size="9"/>
		   <Interior ss:Color="##FF0000" ss:Pattern="Solid"/>
			 <NumberFormat ss:Format="Short Date"/>
			 <Protection/>
			</Style>
		  <Style ss:ID="s70r">
		   <Alignment ss:Horizontal="Center" ss:Vertical="Top" ss:WrapText="1"/>
		   <Interior ss:Color="##FF0000" ss:Pattern="Solid"/>
		  </Style>
			<Style ss:ID="s71r">
				<Alignment ss:Vertical="Top" ss:WrapText="1"/>
				<Borders/>
				<Font ss:FontName="Arial" ss:Size="9"/>
		    <Interior ss:Color="##FF0000" ss:Pattern="Solid"/>
				<NumberFormat/>
				<Protection/>
			</Style>
		</Styles>
 
		<Worksheet ss:Name="Advocacy">
			<!--- define columns --->
			<Table ss:ExpandedColumnCount="12" ss:ExpandedRowCount="#expRowCount#" x:FullColumns="1" x:FullRows="1">
			<Column ss:Width="70"/>
			<Column ss:Width="150"/>
	    <Column ss:Width="150"/>
	    <Column ss:Width="100"/>
			<Column ss:Width="70"/>
			<Column ss:Width="70"/>
			<Column ss:Width="150"/>
			<Column ss:Width="150"/>
			<Column ss:Width="150"/>
			<Column ss:Width="300"/>
			<Column ss:Width="70"/>
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
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Regulatory Agency</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Agency Contact</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Regulatory Action</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Date</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
				<Cell ss:StyleID="frmtGreenHeader"><Data ss:Type="String">Complete</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
			</Row>
		 
			<!--- data --->
			<cfloop query="getRegulatory">
				<cfmodule template="../components/f_ReplaceCharacters.cfm" FieldName="#getRegulatory.Regulatory_Action#" varNewValue="vRegulatoryAction">
				<cfset vComplete = "No">
				<cfif getRegulatory.Complete EQ 1><cfset vComplete = "Yes"></cfif>
				<cfset c = "">
				<cfif not getRegulatory.Complete and now() - getRegulatory.Regulatory_Date GTE 60>
					<cfset c = "r">
				<cfelseif not getRegulatory.Complete and now() - getRegulatory.Regulatory_Date GTE 30>
					<cfset c = "y">
				</cfif>
				<Row>
					<Cell ss:StyleID="s71#c#"><Data ss:Type="String">#getRegulatory.Site_ID#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s71#c#"><Data ss:Type="String">#getRegulatory.Site_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s71#c#"><Data ss:Type="String">#getRegulatory.Address#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s71#c#"><Data ss:Type="String">#getRegulatory.City#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s70#c#"><Data ss:Type="String">#getRegulatory.State_Abbreviation#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s71#c#"><Data ss:Type="String">#getRegulatory.Zip_Code#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s71#c#"><Data ss:Type="String">#getRegulatory.Last_Name#, #getRegulatory.First_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<cfinclude template="q_getSiteAgencyInfo.cfm" >
					<Cell ss:StyleID="s71#c#"><Data ss:Type="String">#getSiteAgencyInfo.Regulatory_Agency#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s71#c#"><Data ss:Type="String">#getSiteAgencyInfo.Agency_Person#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s71#c#"><Data ss:Type="String">#vRegulatoryAction#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s69#c#"><Data ss:Type="DateTime">#dateformat(getRegulatory.Regulatory_Date,"yyyy-mm-dd")#T00:00:00.000</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
					<Cell ss:StyleID="s70#c#"><Data ss:Type="String">#vComplete#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
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
  <AutoFilter x:Range="R1C1:R#expRowCount#C12" xmlns="urn:schemas-microsoft-com:office:excel">
  </AutoFilter>
 </Worksheet>
</Workbook>
</cfoutput>
</cfsavecontent>

<!---	write excel file --->
<CFFILE ACTION="WRITE" FILE="#Request.TempPath#\#FileName#" OUTPUT="#XMLData#">
