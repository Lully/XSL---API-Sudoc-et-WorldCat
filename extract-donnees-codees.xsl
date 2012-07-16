<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="text" omit-xml-declaration="yes"/>
  <xsl:template match="/">
"FmtNotice";"LastAcct";"TypVis";"CodeSE";"TypRef";"Typ";"Ex:Statut";"Ex:Pret";
  <xsl:for-each select="//Livre">
  "<xsl:value-of select="FmtNotice"/>";"<xsl:value-of select="LastAcct"/>";"<xsl:value-of select="TypVis"/>";"<xsl:value-of select="CodeSE"/>";"<xsl:value-of select="TypRef"/>";"<xsl:value-of select="Typ"/>";"<xsl:value-of select="Ex[1]/Statut"/>";"<xsl:value-of select="Ex[1]/Pret"/>";</xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
