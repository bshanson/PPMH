<!----------------------------------------------------------------------------
Description:
	replace special characters with HTML decimal codes for export functions

History:
	11/17/2010 - created
------------------------------------------------------------------------------>

<cfparam name="Attributes.FieldName" default="">
<cfparam name="Attributes.varNewValue" default="">

<cfset varNewValue = Replace(Attributes.FieldName, "&", "&##38;","ALL")>
<cfset varNewValue = Replace(varNewValue, "<", "&##60;", "ALL")>
<cfset varNewValue = Replace(varNewValue, ">", "&##62;", "ALL")>
<cfset varNewValue = Replace(varNewValue, "±", "&##177;", "ALL")>
<cfset varNewValue = Replace(varNewValue, "•", "&##8226;", "ALL")>
<cfset varNewValue = Replace(varNewValue, "“", "&##8220;", "ALL")>
<cfset varNewValue = Replace(varNewValue, "”", "&##8221;", "ALL")>
<cfset varNewValue = Replace(varNewValue, "‘", "&##8216;", "ALL")>
<cfset varNewValue = Replace(varNewValue, "’", "&##8217;", "ALL")>
<cfset varNewValue = Replace(varNewValue, "…", "&##8230;", "ALL")>
<cfset varNewValue = Replace(varNewValue, "—", "&##8212;", "ALL")>
<cfset varNewValue = Replace(varNewValue, "–", "&##8211;", "ALL")>
<cfset varNewValue = Replace(varNewValue, "†", "&##8224;", "ALL")>
<cfset varNewValue = Replace(varNewValue, """", "&##34;", "ALL")>
<cfset varNewValue = Replace(varNewValue, chr(10), "&##10;", "ALL")>

<CFSET "Caller.#Attributes.varNewValue#" = varNewValue>
