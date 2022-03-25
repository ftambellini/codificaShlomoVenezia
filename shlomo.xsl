<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
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
    <xsl:output method="html" encoding="UTF-8" indent="yes" />
	<xsl:template match="/" >
        <html>
            <head>
                <!--titolo della pagina-->
                <title><xsl:value-of select="//tei:title"/></title>
                <!--documento css-->
                <link rel="stylesheet" href="shlomo.css"/>
				<script type="text/javascript" src="saxon-js/SaxonJS2.rt.js"></script>
				<script type="text/javascript" src="shlomo.js"></script>
            </head>
            <body>
				<header>
					<!-- titolo -->
					<h1 id="desc">
						<xsl:value-of select="//tei:fileDesc/tei:titleStmt/tei:title"/>
					</h1>
				</header>
                <div class="metadatiAudio" style="border:5px solid grey">
					<h3>Descrizione della fonte audio</h3>
					<p>Testimonianza audio del deportato Shlomo Venezia</p>
					<p>Responsabile registrazione: <xsl:value-of select="//tei:fileDesc/tei:sourceDesc/tei:recordingStmt/tei:recording/tei:respStmt/tei:name"/></p>
					<p>Anno registrazione: <xsl:value-of select="//tei:fileDesc/tei:sourceDesc/tei:recordingStmt/tei:recording/tei:date"/></p>
					<p>Registrato tramite: <xsl:value-of select="//tei:equipment"/></p>
					<p>Lingua: <xsl:value-of select="//tei:language"/></p>
					<p>Codifica a cura di: <xsl:value-of select="//tei:fileDesc/tei:editionStmt/tei:respStmt/tei:name"/></p>
				</div>
				<article class="legenda" style="border:5px solid grey">
					<h3>Legenda</h3>
					<span class="gap">[...] - Gap inaudibili nella registrazione</span><br/>
					<span class="pause">// - Pause del parlante</span><br/>
					<span class="interr">--Interruzioni del discorso (ripetizioni e/o false partenze)--</span><br/>
					<span class="fenomeni">*Fenomeni vocali/non verbali e movimenti dei parlanti*</span><br/>
					<span class="riferimentoPosti" style="border:2px solid red">Riferimenti a luoghi</span><br/>
					<span class="riferimentoPersone" style="border:2px solid blue">Riferimenti a persone</span>
					<br/>
					<br/>
					<a href="trascrizioneVenezia.txt" download="trascrizione.txt" target="_blank"><button type="button">Scarica la trascrizione</button></a>
				</article>

                <!--applico il template alle utterance-->
                <div id="trascrizioneAudio" class="testi">
					<h2>Trascrizione</h2>
					<xsl:apply-templates select="//tei:text[@type='source']/tei:body/tei:div/tei:u"/>
					<br/>
					<br/>
				</div>
				<div id="timelineAudio" class="testi">
					<h2>Timeline (minutaggio assoluto):</h2>
					<xsl:apply-templates select="//tei:timeline[@origin='1']/tei:when"/>
				</div>
                <footer>
				<xsl:value-of select="//tei:editionStmt/tei:edition"/><br/>
				<xsl:value-of select="//tei:editionStmt/tei:respStmt/tei:resp"/>
				<xsl:value-of select="//tei:editionStmt/tei:respStmt/tei:name"/>
			    </footer>
		    </body>
	    </html>
    </xsl:template>
    <!-- template per output in riga-->
    <xsl:template match="//tei:text[@type='source']/tei:body/tei:div/tei:u">
		<xsl:value-of select="substring-after(@who, '#')"/>
		<xsl:text>: </xsl:text>
		<xsl:apply-templates/>
		<br />
    </xsl:template>
	<!-- template per output in riga della timeline-->
    <xsl:template match="//tei:timeline[@origin='1']/tei:when">
		<span class="minutaggio">
		<xsl:text>--> </xsl:text>
		<xsl:value-of select="substring-after(@absolute, '')"/>
		<xsl:apply-templates/>
		</span>
		<br />
    </xsl:template>
	<!--tasto download-->
	<xsl:template match="somethingthatgeneratesalink">
  		<a href="http://google.com/">This is a link to example.com</a>
	</xsl:template>
	<!--template che prende i gap nella registrazione e le mette nella relativa classe-->
    <xsl:template match="//tei:gap">
	    <span class="gapRegistrazione"></span>
		[...]
    </xsl:template>
	<!--template che prende le pause nella registrazione e le mette nella relativa classe-->
    <xsl:template match="//tei:pause">
	    <span class="pauseDiscorso"></span>
		//
    </xsl:template>
	<!--template che prende le interruzioni del discorso nella registrazione e le mette nella relativa classe-->
    <xsl:template match="//tei:del">
	    <span class="interruzioni">--<xsl:value-of select="."/>--</span>
    </xsl:template>
	<!--template che prende i fenomeni vocali del discorso nella registrazione e le mette nella relativa classe-->
    <xsl:template match="//tei:vocal">
	    <span class="fenomenoVocale">*<xsl:value-of select="."/>*</span>
    </xsl:template>
	<!--template che prende i movimenti del parlante nel discorso nella registrazione e le mette nella relativa classe-->
    <xsl:template match="//tei:kinesic">
    	<span class="movimenti">*<xsl:value-of select="."/>*</span>
    </xsl:template>
	<!--template che prende i riferimenti a luoghi/persone nel discorso nella registrazione e le mette nella relativa classe-->
    <xsl:template match="//tei:rs[@type='place']">
    	<span class="riferimentoPosti" style="border:2px solid red"><xsl:value-of select="."/></span>
    </xsl:template>
	<xsl:template match="//tei:rs[@type='person']">
    	<span class="riferimentoPersone" style="border:2px solid blue"><xsl:value-of select="."/></span>
    </xsl:template>
</xsl:stylesheet>