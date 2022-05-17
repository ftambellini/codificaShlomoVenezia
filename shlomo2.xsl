<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns:ixsl="http://saxonica.com/ns/interactiveXSLT"  
		xmlns:h="http://www.w3.org/1999/xhtml"
		xmlns:js="http://saxonica.com/ns/globalJS"
		xmlns:saxon="http://saxon.sf.net/"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="h ixsl js saxon xs"
        >

    <xsl:template name="main" match="/">
        <html>
        <head>
            <!--titolo della pagina-->
            <title><xsl:value-of select="//tei:title"/></title>
        </head>
        <body> 
        <xsl:result-document href="#metadatiAudio">   
            <xsl:apply-templates select="//tei:fileDesc" />
            <xsl:apply-templates select="//tei:profileDesc" />
        </xsl:result-document>
        <xsl:result-document href="#trascrizioneAudio">
            <br /> <br />
            <xsl:apply-templates select="//tei:text[@type='source']/tei:body/tei:div/tei:u" />
        </xsl:result-document>
        <xsl:result-document href="#timelineAudio">
            <br />
            <xsl:apply-templates select="//tei:timeline[@origin='1']/tei:when" />
        </xsl:result-document>
        </body>
        </html>
    </xsl:template>
<xsl:template match="//tei:fileDesc">
    <h1>
        <xsl:value-of select="tei:titleStmt/tei:title" />
    </h1>
<table> 
    <tr>
        <th><xsl:value-of select="tei:sourceDesc/tei:recordingStmt/tei:recording/tei:respStmt/tei:resp" /> :</th> <td> <xsl:value-of select="tei:sourceDesc/tei:recordingStmt/tei:recording/tei:respStmt/tei:name" /> </td>
    </tr>
    <tr>
        <th><xsl:text>Equipment:</xsl:text></th> <td><xsl:value-of select="//tei:equipment" /></td>
    </tr>
    <tr>
        <th><xsl:text>Edition:</xsl:text></th> <td><xsl:value-of select="//tei:edition" /></td>
    </tr>
    <tr>
        <th><xsl:value-of select="tei:editionStmt/tei:respStmt/tei:resp" /> :</th> <td> <xsl:value-of select="tei:editionStmt/tei:respStmt/tei:name" /> </td>
    </tr>
    <tr>
        <th><xsl:text> Publisher:</xsl:text></th> <td> <xsl:value-of select="tei:publicationStmt" /> </td>
    </tr>
</table>
</xsl:template>
<xsl:template match="//tei:profileDesc">
    <table>
        <tr>
            <th><xsl:text> Language:</xsl:text></th>
            <td>
            <xsl:for-each select="tei:langUsage/tei:language">
                <xsl:value-of select="." /> <br /> 
            </xsl:for-each>
            </td>
        </tr>
        <tr><th>LEGENDA:</th></tr>
        <tr>
            <th>Gap inaudibili nella registrazione</th>
                <td>[...]</td> 
        </tr>
        <tr>
            <th>Pause del parlante</th>
                <td>//</td>
        </tr>
        <tr>
            <th>--Interruzioni del discorso (ripetizioni e/o false partenze)--</th>
        </tr>
        <tr>
            <th>*Fenomeni vocali/non verbali e movimenti dei parlanti*</th>
        </tr>
        <tr>
            <th><span class="riferimentoPosti" style="border:2px solid red">Riferimenti a luoghi</span></th>
        </tr>
        <tr>
            <th><span class="riferimentoPersone" style="border:2px solid blue">Riferimenti a persone</span></th>
        </tr>
        <br/>
        <br/>
    </table>
</xsl:template>
<xsl:template match="//tei:text[@type='source']/tei:body/tei:div/tei:u" >
    <xsl:apply-templates select="//tei:text[@type='source']/tei:body/tei:div/tei:u"/>
</xsl:template>

    <!-- template per output in riga-->
    <xsl:template match="//tei:text[@type='source']/tei:body/tei:div/tei:u">
		<span class="frasi">
		<xsl:attribute name="idF">
        	<xsl:value-of select="@xml:id"/>
    	</xsl:attribute>
		<xsl:value-of select="substring-after(@who, '#')"/>
		<xsl:text>: </xsl:text>
		<xsl:apply-templates/>
		</span>
		<br />
    </xsl:template>
	<!-- template per output in riga della timeline-->
    <xsl:template match="//tei:timeline[@origin='1']/tei:when">
		<span class="minutaggio">
		<xsl:attribute name="idM">
        	<xsl:value-of select="substring-after(@synch, '#')"/>
    	</xsl:attribute>
		<xsl:text>--> </xsl:text>
		<xsl:value-of select="substring-after(@absolute, '')"/>
		<xsl:apply-templates/>
		</span>
		<br />
    </xsl:template>
    <!--<xsl:template match="//tei:u[@xml:id='S1']">
        <xsl:value-of select="substring-after(@who, '#')"/>:<span style="background-color:purple"><xsl:value-of select="."/><br/></span>
    </xsl:template>-->
	<!--template che prende i gap nella registrazione e le mette nella relativa classe-->
    <xsl:template match="//tei:gap">
	    <span class="gapRegistrazione">
		[...]
    </span>
    </xsl:template>
	<!--template che prende le pause nella registrazione e le mette nella relativa classe-->
    <xsl:template match="//tei:pause">
	    <span class="pauseDiscorso">
		//
        </span>
    </xsl:template>
	<!--template che prende le interruzioni del discorso nella registrazione e le mette nella relativa classe-->
    <xsl:template match="//tei:del">
	    <span class="interruzioni">--<xsl:value-of select="."/>--</span>
    </xsl:template>
	<!--template che prende i fenomeni vocali del discorso nella registrazione e le mette nella relativa classe-->
    <xsl:template match="//tei:vocal">
	    <span class="fenomenoVocale">*<xsl:value-of select="."/>*</span>
    </xsl:template>
    <!--template che prende i rumori della registrazione e li mette nella relativa classe-->
	<xsl:template match="//tei:incident">
	    <span class="rumori">*<xsl:value-of select="."/>*</span>
	</xsl:template>
	<!--template che prende i movimenti del parlante nel discorso nella registrazione e le mette nella relativa classe-->
    <xsl:template match="//tei:kinesic">
    	<span class="movimenti">*<xsl:value-of select="."/>*</span>
    </xsl:template>
	<!--template che prende i riferimenti a luoghi/persone nel discorso nella registrazione e le mette nella relativa classe-->
    <xsl:template match="//tei:rs[@type='place']">
    	<span style="border:2px solid red"><xsl:value-of select="."/></span>
    </xsl:template>
	<xsl:template match="//tei:rs[@type='person']">
    	<span style="border:2px solid blue"><xsl:value-of select="."/></span>
    </xsl:template>
</xsl:stylesheet>