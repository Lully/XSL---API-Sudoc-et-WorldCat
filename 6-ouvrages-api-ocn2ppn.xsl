<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:output indent="yes"/>
  <xsl:template match="/">
    <Livres>
      <xsl:for-each select="//Livre">
        <Livre>
        <xsl:attribute name="NumNot"><xsl:value-of select="@NumNot"/></xsl:attribute>
          <xsl:for-each select="*[name() != 'ocn']">
            <xsl:copy-of select="."/>
          </xsl:for-each>
          <xsl:for-each select="ocn">
            <xsl:variable name="ocn" select="."/>
            <xsl:variable name="api_ocn2ppn_url" select="concat('http://www.sudoc.fr/services/ocn2ppn/', .)"/>
            <xsl:variable name="api_ocn2ppn_result"><xsl:copy-of select="document($api_ocn2ppn_url)//sudoc"/></xsl:variable>
            <xsl:choose>
              <xsl:when test="$api_ocn2ppn_result//ppn">
                <xsl:for-each select="$api_ocn2ppn_result//ppn">
                  <ppn ocn="{$ocn}"><xsl:value-of select="."/></ppn>
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise><ocn><xsl:value-of select="."/></ocn></xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </Livre>
      </xsl:for-each>
    </Livres>
  </xsl:template>
</xsl:stylesheet>
