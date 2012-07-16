<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output indent="yes"/>
  <xsl:template match="/">
  <Livres>
    <xsl:for-each select="//Livre">
      <Livre><xsl:attribute name="NumNot"><xsl:value-of select="@NumNot"/></xsl:attribute>
        <xsl:for-each select="*"><xsl:copy-of select="."/></xsl:for-each>

        <xsl:if test="contains(RefImpt, 'SUDoc')">
          <ppn>
          <xsl:choose>
          <xsl:when test="contains(RefImpt,' ')"><xsl:value-of select="normalize-space(substring-before(substring-after(RefImpt,'SUDoc:'), ' '))"/></xsl:when>
          <xsl:otherwise><xsl:value-of select="normalize-space(substring-after(RefImpt, ':'))"/></xsl:otherwise>
          </xsl:choose>
        </ppn>
      </xsl:if>
      </Livre>
    </xsl:for-each>
  </Livres>
  </xsl:template>
</xsl:stylesheet>
