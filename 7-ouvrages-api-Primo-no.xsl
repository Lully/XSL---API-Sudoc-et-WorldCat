<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:primo_api="http://www.exlibrisgroup.com/xsd/primo/primo_nm_bib" xmlns:sear="http://www.exlibrisgroup.com/xsd/jaguar/search">
<xsl:output indent="yes"/>
<xsl:param name="UrlApiOpac"/>
<xsl:template match="/">
  <Livres>
    <xsl:for-each select="//Livre">
      <Livre>
        <xsl:attribute name="NumNot"><xsl:value-of select="@NumNot"/></xsl:attribute>
        <xsl:copy-of select="*[name() != 'ppn']"/>
        <xsl:for-each select="ppn">
             <xsl:variable name="api_primo_url" select="concat($UrlApiOpac,':1701/PrimoWebServices/xservice/search/brief?institution=UNS&amp;onCampus=false&amp;query=any,contains,PPN', ., '&amp;indx=1&amp;bulkSize=10&amp;dym=true&amp;highlight=false&amp;lang=fre')"/>
        <xsl:variable name="results"><xsl:copy-of select="document($api_primo_url)//sear:DOC"/></xsl:variable>
        <xsl:variable name="no_aleph"><xsl:copy-of select="$results//primo_api:ilsapiid"/></xsl:variable>
        <xsl:choose>
          <xsl:when test="$no_aleph != ''"><aleph>
            <xsl:attribute name="ppn"><xsl:value-of select="."/></xsl:attribute>
            <xsl:if test="@ocn"><xsl:attribute name="ocn" ><xsl:value-of select="@ocn"/></xsl:attribute></xsl:if>
          <xsl:value-of select="$no_aleph"/></aleph></xsl:when>
          <xsl:otherwise>
                  <ppn><xsl:if test="@ocn"><xsl:attribute name="ocn" ><xsl:value-of select="@ocn"/></xsl:attribute></xsl:if><xsl:value-of select="."/></ppn>
          </xsl:otherwise>
        </xsl:choose>
        </xsl:for-each>
      </Livre>
    </xsl:for-each>
  </Livres>
  </xsl:template>
</xsl:stylesheet>
