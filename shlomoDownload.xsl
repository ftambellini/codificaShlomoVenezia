<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="text" encoding="UTF-8" indent="yes" />
	<xsl:template match="tei:teiHeader" />

	<xsl:template name="main" match="/">
    <xsl:result-document href="#modale">
        <br /> <br />
        <xsl:apply-templates select="//tei:text[@type='source']/tei:body/tei:div/tei:u" />
    </xsl:result-document>
	</xsl:template>
    <!-- template per output in riga-->
    <xsl:template match="//tei:text[@type='source']/tei:body/tei:div/tei:u">
		<xsl:value-of select="substring-after(@who, '#')"/>
		<xsl:text>: </xsl:text>
		<xsl:apply-templates/>
		<br />
		<br/>
    </xsl:template>
	<xsl:template match="//tei:gap">
		
    </xsl:template>
	<!--template che prende le pause nella registrazione e le mette nella relativa classe-->
    <xsl:template match="//tei:pause">
		
    </xsl:template>
	<!--template che prende le interruzioni del discorso nella registrazione e le mette nella relativa classe-->
    <xsl:template match="//tei:del">
	    
    </xsl:template>
	<!--template che prende i fenomeni vocali del discorso nella registrazione e le mette nella relativa classe-->
    <xsl:template match="//tei:vocal">
	    
    </xsl:template>
    <!--template che prende i rumori della registrazione e li mette nella relativa classe-->
	<xsl:template match="//tei:incident">
	    
	</xsl:template>
	<!--template che prende i movimenti del parlante nel discorso nella registrazione e le mette nella relativa classe-->
    <xsl:template match="//tei:kinesic">
    	
    </xsl:template>
</xsl:stylesheet>
   
