<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:output indent="yes"/>
<xsl:variable name="isbnspropres"><xsl:copy-of select="//isbns"/></xsl:variable>
  <xsl:template match="/">
  <Livres>
      <xsl:for-each select="//Livre[Ex/Cote != '000000' and Tit1]">
      <xsl:variable name="no" select="@NumNot"/>
        <Livre><xsl:attribute name="NumNot"><xsl:value-of select="@NumNot"/></xsl:attribute>
          <xsl:for-each select="*"><xsl:copy-of select="."/></xsl:for-each>
          <xsl:copy-of select="$isbnspropres//item[no=$no]/IsbnPropre"/>
          <xsl:if test="not(IssnCol)"><xsl:copy-of select="$isbnspropres//item[no=$no]/IssnColl"/></xsl:if>
        </Livre>
        </xsl:for-each>
  </Livres>
  </xsl:template>
</xsl:stylesheet>
