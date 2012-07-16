<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>

  <xsl:template match="/">
  <Livres>
    <xsl:for-each select="//Livre">
    <xsl:choose>
      <xsl:when test="ppn">
        <xsl:copy-of select="."/>
      </xsl:when>
      <xsl:when test="not(IsbnPropre)">
        <xsl:copy-of select="."/>
      </xsl:when>
      <xsl:otherwise>
      <xsl:variable name="url_api_sudoc_isbn2ppn">http://www.sudoc.fr/services/isbn2ppn/<xsl:value-of select="IsbnPropre"/></xsl:variable>
      <xsl:variable name="resultat_api_sudoc_isbn2ppn"><xsl:copy-of select="document($url_api_sudoc_isbn2ppn)//sudoc"/></xsl:variable>
        <Livre>
       <xsl:attribute name="NumNot"><xsl:value-of select="@NumNot"/></xsl:attribute>
            <xsl:for-each select="*"><xsl:copy-of select="."/></xsl:for-each>
               <xsl:for-each select="$resultat_api_sudoc_isbn2ppn//ppn"><xsl:copy-of select="."/></xsl:for-each>
         </Livre>
      </xsl:otherwise>
    </xsl:choose>
    </xsl:for-each>
  </Livres>
  </xsl:template>
</xsl:stylesheet>
