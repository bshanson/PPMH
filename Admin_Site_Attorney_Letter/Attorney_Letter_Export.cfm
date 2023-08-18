<!--------------------------------------------------------------
Description:
	Attorney Letter report excel file

History:
	10/13/2022 - created
--------------------------------------------------------------->

<CFSET timestamp = dateformat(now(),"mm/dd/yyyy") & "&nbsp;&nbsp;" & timeformat(now(),"hh:mm:sstt")>
<cfset vExpandedRowCount = (getAttorneyLetters.RecordCount + 4)>
<cfset filterRowCount = getAttorneyLetters.RecordCount>
<cfset row = 0>

<!--- store the XML data --->
<cfsavecontent variable="XMLData">
<?xml version="1.0"?>
<?mso-application progid="Excel.Sheet"?>
<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:o="urn:schemas-microsoft-com:office:office"
 xmlns:x="urn:schemas-microsoft-com:office:excel"
 xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:html="http://www.w3.org/TR/REC-html40">
 <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
  <Author></Author>
  <LastAuthor></LastAuthor>
  <Created></Created>
  <LastSaved></LastSaved>
  <Version>16.00</Version>
 </DocumentProperties>
 <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">
  <AllowPNG/>
 </OfficeDocumentSettings>
 <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">
  <WindowHeight>9420</WindowHeight>
  <WindowWidth>17280</WindowWidth>
  <WindowTopX>1884</WindowTopX>
  <WindowTopY>1884</WindowTopY>
  <ProtectStructure>False</ProtectStructure>
  <ProtectWindows>False</ProtectWindows>
 </ExcelWorkbook>
 <Styles>
  <Style ss:ID="Default" ss:Name="Normal">
	 <Alignment ss:Vertical="Top" ss:WrapText="1"/>
   <Borders/>
	 <Font ss:FontName="Arial" ss:Size="9"/>
   <Interior/>
   <NumberFormat/>
  </Style>
  <Style ss:ID="s16">
   <Alignment ss:WrapText="1"/>
   <Font ss:FontName="Arial" ss:Size="9"/>
  </Style>
  <Style ss:ID="s17">
   <Alignment ss:Horizontal="Center"/>
   <Font ss:FontName="Arial" ss:Size="9" ss:Bold="1"/>
   <Interior ss:Color="#FFFF00" ss:Pattern="Solid"/>
  </Style>
  <Style ss:ID="s19">
   <Alignment ss:WrapText="1"/>
   <Font ss:FontName="Arial" ss:Size="9"/>
   <NumberFormat ss:Format="@"/>
  </Style>
  <Style ss:ID="s24">
   <Alignment ss:Horizontal="Left"/>
   <Font ss:FontName="Arial" ss:Size="9"/>
  </Style>
  <Style ss:ID="s25">
   <Alignment ss:Horizontal="Center" ss:WrapText="1"/>
   <Font ss:FontName="Arial" ss:Size="9"/>
  </Style>
  <Style ss:ID="s26">
   <Alignment ss:Horizontal="Right" ss:WrapText="1"/>
   <Font ss:FontName="Arial" ss:Size="9"/>
   <NumberFormat ss:Format="0.00"/>
  </Style>
	
  <Style ss:ID="s67">
   <Alignment ss:Horizontal="Center" ss:WrapText="1"/>
   <Font ss:FontName="Arial" ss:Size="9"/>
  </Style>

  <Style ss:ID="s70">
   <Alignment ss:Horizontal="Center" ss:WrapText="1"/>
   <Font ss:FontName="Arial" x:Family="Swiss" ss:Size="9" ss:Color="#FF0000"/>
  </Style>
 </Styles>
<cfoutput>
 <Worksheet ss:Name="Attorney Letters">
  <Names>
   <NamedRange ss:Name="_FilterDatabase" ss:RefersTo="=Attorney Letters!R2C1:R#filterRowCount#C6" ss:Hidden="1"/>
  </Names>
  <Table ss:ExpandedColumnCount="6" ss:ExpandedRowCount="#vExpandedRowCount#" x:FullColumns="1" x:FullRows="1" ss:DefaultRowHeight="14.4">
   <Column ss:Width="60"/>
   <Column ss:Width="200"/>
   <Column ss:Width="200"/>
   <Column ss:Width="100"/>
   <Column ss:Width="60"/>
   <Column ss:Width="150"/>
   <Row>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Site ID</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Site Name</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Address</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">City</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">State</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
    <Cell ss:StyleID="s17"><Data ss:Type="String">Site Manager</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
   </Row>
	 <cfloop query="getAttorneyLetters">
	   <Row>
	    <Cell ss:StyleID="s16"><Data ss:Type="String">#getAttorneyLetters.Admin_Site_ID#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="s19"><Data ss:Type="String">#getAttorneyLetters.Site_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="s19"><Data ss:Type="String">#getAttorneyLetters.Address#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="s16"><Data ss:Type="String">#getAttorneyLetters.City#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="s16"><Data ss:Type="String"><cfif len(getAttorneyLetters.State_Abbreviation) and getAttorneyLetters.State_Abbreviation NEQ "NA">#getAttorneyLetters.State_Abbreviation#</cfif></Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	    <Cell ss:StyleID="s16"><Data ss:Type="String">#getAttorneyLetters.SM_Name#</Data><NamedCell ss:Name="_FilterDatabase"/></Cell>
	   </Row>
	 </cfloop>
   <Row>
    <Cell ss:StyleID="s24"><Data ss:Type="String"></Data></Cell>
   </Row>
   <Row>
    <Cell ss:MergeAcross="1" ss:StyleID="s24"><Data ss:Type="String">Report Date: #DateFormat(Now(),"mm/dd/yyyy")# #TimeFormat(Now(),"HH:mm:ss")#</Data></Cell>
   </Row>
  </Table>
  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <PageSetup>
    <Header x:Margin="0.3"/>
    <Footer x:Margin="0.3"/>
    <PageMargins x:Bottom="0.75" x:Left="0.7" x:Right="0.7" x:Top="0.75"/>
   </PageSetup>
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
     <ActiveRow>3</ActiveRow>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
  <AutoFilter x:Range="R1C1:R#filterRowCount#C6" xmlns="urn:schemas-microsoft-com:office:excel">
  </AutoFilter>
 </Worksheet>
</Workbook>
</cfoutput>
</cfsavecontent>

<!---	write excel file --->
<CFFILE ACTION="WRITE" FILE="#Request.TempPath#\#FileName#" OUTPUT="#XMLData#">
