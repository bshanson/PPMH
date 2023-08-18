<!------------------------------------------------------------------------------------
Description:
	Public Affairs xml version

History:
	5/24/2021 - created
------------------------------------------------------------------------------------->

<CFSET timestamp = dateformat(now(),"mm/dd/yyyy") & "&nbsp;&nbsp;" & timeformat(now(),"hh:mm:sstt")>
<cfset expRowCount = getPublicAffairs.RecordCount + 1>

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
			 <Alignment ss:Vertical="Bottom"/>
			 <Borders/>
			 <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="##000000"/>
			 <Interior/>
			 <NumberFormat/>
			 <Protection/>
			</Style>
			<Style ss:ID="s62">
			 <NumberFormat ss:Format="@"/>
			</Style>
			<Style ss:ID="s63">
			 <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
			 <NumberFormat ss:Format="@"/>
			</Style>
			<Style ss:ID="s64">
			 <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
			 <NumberFormat ss:Format="Short Date"/>
			</Style>
			<Style ss:ID="s65">
			 <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
			 <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="##000000"
			  ss:Bold="1"/>
			 <Interior ss:Color="##FFFF00" ss:Pattern="Solid"/>
			 <NumberFormat ss:Format="@"/>
			</Style>
			<Style ss:ID="s66">
			 <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
			 <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="##000000"
			  ss:Bold="1"/>
			 <Interior ss:Color="##FFFF00" ss:Pattern="Solid"/>
			 <NumberFormat ss:Format="Short Date"/>
			</Style>
			<Style ss:ID="s67">
		  	<Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="##000000"/>
				<NumberFormat ss:Format="@"/>
			</Style>
			<Style ss:ID="s68">
			 <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
			 <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="##000000"/>
			 <NumberFormat ss:Format="@"/>
			</Style>
			<Style ss:ID="s69">
			 <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
			 <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="##000000"/>
			 <NumberFormat ss:Format="Short Date"/>
			</Style>
			<!--- Assmnt reqd --->
			<Style ss:ID="StatRed">
			 <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
			 <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="##FFFFFF"/>
			 <Interior ss:Color="##FF0000" ss:Pattern="Solid"/>
			 <NumberFormat ss:Format="@"/>
			</Style>
			<!--- monitor --->
			<Style ss:ID="StatGreen">
			 <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
			 <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="##FFFFFF"/>
			 <Interior ss:Color="##00B050" ss:Pattern="Solid"/>
			 <NumberFormat ss:Format="@"/>
			</Style>
			<!--- Consult reqd --->
			<Style ss:ID="StatYellow">
			 <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>
			 <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="##000000"/>
			 <Interior ss:Color="##FFFF00" ss:Pattern="Solid"/>
			 <NumberFormat ss:Format="@"/>
			</Style>
		</Styles>
	 
		<!--- Worksheet --->
		<Worksheet ss:Name="Data">
		<Names>
		 <NamedRange ss:Name="_FilterDatabase" ss:RefersTo="=Data!R1C1:R2C26" ss:Hidden="1"/>
		</Names>
		<Table ss:ExpandedColumnCount="26" ss:ExpandedRowCount="#expRowCount#" x:FullColumns="1" x:FullRows="1" ss:DefaultRowHeight="14.55">
		 <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="67.2"/>
		 <Column ss:StyleID="s62" ss:Width="240"/>
		 <Column ss:StyleID="s62" ss:Width="84"/>
		 <Column ss:StyleID="s62" ss:Width="84"/>
		 <Column ss:StyleID="s63" ss:Width="55"/>
		 <Column ss:StyleID="s63" ss:Width="70"/>
		 <Column ss:StyleID="s63" ss:AutoFitWidth="0" ss:Width="70"/>
		 <Column ss:StyleID="s63" ss:AutoFitWidth="0"/>
		 <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="275"/>
		 <Column ss:StyleID="s63" ss:AutoFitWidth="0"/>
		 <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="275"/>
		 <Column ss:StyleID="s63" ss:AutoFitWidth="0"/>
		 <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="275"/>
		 <Column ss:StyleID="s63" ss:AutoFitWidth="0"/>
		 <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="275"/>
		 <Column ss:StyleID="s63" ss:AutoFitWidth="0"/>
		 <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="275"/>
		 <Column ss:StyleID="s63" ss:AutoFitWidth="0"/>
		 <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="275"/>
		 <Column ss:StyleID="s63" ss:AutoFitWidth="0"/>
		 <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="275"/>
		 <Column ss:StyleID="s63" ss:AutoFitWidth="0"/>
		 <Column ss:StyleID="s62" ss:AutoFitWidth="0" ss:Width="275"/>
		 <Column ss:StyleID="s64" ss:Width="106.2"/>
		 <Column ss:StyleID="s62" ss:Width="85"/>
		 <Column ss:StyleID="s62" ss:Width="85"/>
			<!--- column headers --->
		 <Row ss:AutoFitHeight="0">
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Site ID</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Site Name</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Address</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">City</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">State</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Zip Code</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Action</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Q1</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Q1 Describe</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Q2</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Q2 Describe</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Q3</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Q3 Describe</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Q4</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Q4 Describe</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Q5</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Q5 Describe</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Q6</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Q6 Describe</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Q7</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Q7 Describe</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Q8</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Q8 Describe</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s66"><Data ss:Type="String">Assessment Date</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">Last Name</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s65"><Data ss:Type="String">First Name</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		 </Row>
			<!--- data --->
			<cfloop query="getPublicAffairs" >
			<cfset action = "">
			<cfset actionCnt = 0>
			<cfif getPublicAffairs.Q1 EQ 1><cfset actionCnt = actionCnt+1></cfif>
			<cfif getPublicAffairs.Q2 EQ 1><cfset actionCnt = actionCnt+1></cfif>
			<cfif getPublicAffairs.Q3 EQ 1><cfset actionCnt = actionCnt+1></cfif>
			<cfif getPublicAffairs.Q4 EQ 1><cfset actionCnt = actionCnt+1></cfif>
			<cfif getPublicAffairs.Q5 EQ 1><cfset actionCnt = actionCnt+1></cfif>
			<cfif getPublicAffairs.Q6 EQ 1><cfset actionCnt = actionCnt+1></cfif>
			<cfif actionCnt LTE 1><cfset action = "Monitor"><cfset actionClass = "StatGreen"></cfif>
			<cfif actionCnt EQ 2><cfset action = "Consult reqd"><cfset actionClass = "StatYellow"></cfif>
			<cfif actionCnt GTE 3><cfset action = "Assmnt reqd"><cfset actionClass = "StatRed"></cfif>
		 <Row ss:AutoFitHeight="0">
		  <Cell ss:StyleID="s67"><Data ss:Type="String">#getPublicAffairs.Site_ID#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s67"><Data ss:Type="String">#getPublicAffairs.Site_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s67"><Data ss:Type="String">#getPublicAffairs.Address#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s67"><Data ss:Type="String">#getPublicAffairs.City#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s68"><Data ss:Type="String">#getPublicAffairs.State_Abbreviation#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s68"><Data ss:Type="String">#getPublicAffairs.Zip_Code#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="#actionClass#"><Data ss:Type="String">#action#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s68"><Data ss:Type="String">#yesnoformat(getPublicAffairs.Q1)#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s67"><Data ss:Type="String">#getPublicAffairs.Q1_Describe#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s68"><Data ss:Type="String">#yesnoformat(getPublicAffairs.Q2)#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s67"><Data ss:Type="String">#getPublicAffairs.Q2_Describe#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s68"><Data ss:Type="String">#yesnoformat(getPublicAffairs.Q3)#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s67"><Data ss:Type="String">#getPublicAffairs.Q3_Describe#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s68"><Data ss:Type="String">#yesnoformat(getPublicAffairs.Q4)#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s67"><Data ss:Type="String">#getPublicAffairs.Q4_Describe#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s68"><Data ss:Type="String">#yesnoformat(getPublicAffairs.Q5)#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s67"><Data ss:Type="String">#getPublicAffairs.Q5_Describe#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s68"><Data ss:Type="String">#yesnoformat(getPublicAffairs.Q6)#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s67"><Data ss:Type="String">#getPublicAffairs.Q6_Describe#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s68"><Data ss:Type="String">#yesnoformat(getPublicAffairs.Q7)#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s67"><Data ss:Type="String">#getPublicAffairs.Q7_Describe#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s68"><Data ss:Type="String">#yesnoformat(getPublicAffairs.Q8)#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s67"><Data ss:Type="String">#getPublicAffairs.Q8_Describe#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s69"><Data ss:Type="DateTime">#dateformat(getPublicAffairs.Assessment_Date,"yyyy-mm-dd")#T00:00:00.000</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s67"><Data ss:Type="String">#getPublicAffairs.Last_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		  <Cell ss:StyleID="s67"><Data ss:Type="String">#getPublicAffairs.First_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
		 </Row>
			</cfloop>
		</Table>
		<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
		 <PageSetup>
		  <Header x:Margin="0.3"/>
		  <Footer x:Margin="0.3"/>
		  <PageMargins x:Bottom="0.75" x:Left="0.7" x:Right="0.7" x:Top="0.75"/>
		 </PageSetup>
		 <Unsynced/>
		 <Print>
		  <ValidPrinterInfo/>
		  <HorizontalResolution>600</HorizontalResolution>
		  <VerticalResolution>600</VerticalResolution>
		 </Print>
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
		<AutoFilter x:Range="R1C1:R#expRowCount#C26" xmlns="urn:schemas-microsoft-com:office:excel">
		</AutoFilter>
		</Worksheet>
</Workbook>
</cfoutput>
</cfsavecontent>

<!---	write excel file --->
<CFFILE ACTION="WRITE" FILE="#Request.TempPath#\#FileName#" OUTPUT="#XMLData#">
