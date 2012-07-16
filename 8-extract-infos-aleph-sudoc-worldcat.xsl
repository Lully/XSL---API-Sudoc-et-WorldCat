<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:bibo="http://purl.org/ontology/bibo/" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rdafrbr1="http://rdvocab.info/RDARelationshipsWEMI/" xmlns:marcrel="http://www.loc.gov/loc.terms/relators/" xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:gr="http://purl.org/goodrelations/v1#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:frbr="http://purl.org/vocab/frbr/core#" xmlns:isbd="http://iflastandards.info/ns/isbd/elements/" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:rdafrbr2="http://RDVocab.info/uri/schema/FRBRentitiesRDA/" xmlns:rdaelements="http://rdvocab.info/Elements/" xmlns:marc="http://www.loc.gov/MARC21/slim">
<xsl:param name="OclcApiKey"/>
<xsl:param name="UrlApiOpac"/>
<xsl:output indent="yes"/>
  <xsl:template match="/">
  <Livres>
    <xsl:for-each select="//Livre">
    <Livre>
        <xsl:attribute name="NumNot"><xsl:value-of select="@NumNot"/></xsl:attribute>
          <xsl:copy-of select="*[name() != 'aleph' and name() != 'ppn' and name() != 'ocn']"/>
          <xsl:if test="aleph">
                <xsl:for-each select="aleph">
                    <xsl:call-template name="aleph"/>
                </xsl:for-each>          
          </xsl:if>
          <xsl:if test="ppn">
              <xsl:for-each select="ppn">
                <xsl:call-template name="ppn"/>
              </xsl:for-each>
          </xsl:if>
          <xsl:if test="ocn">
          <xsl:variable name="sujet"><xsl:choose><xsl:when test="ppn">non</xsl:when>
                        <xsl:otherwise>oui</xsl:otherwise>
                      </xsl:choose></xsl:variable>
                <xsl:for-each select="ocn">
                  <xsl:call-template name="ocn">
                      <xsl:with-param name="sujet" select="$sujet">
                   </xsl:with-param>
                  </xsl:call-template>
              </xsl:for-each>
            </xsl:if>
            </Livre>
    </xsl:for-each>
    
  </Livres>
  </xsl:template>
  
  <xsl:template name="aleph">
  <xsl:variable name="url_api_cir"><xsl:value-of select="$UrlApiOpac"/>:8080/X?op=circ-status&amp;library=UNS01&amp;sys_no=<xsl:value-of select="substring-after(., 'UNS01')"/></xsl:variable>
  <xsl:variable name="items_list"><xsl:copy-of select="document($url_api_cir)//circ-status"/></xsl:variable>
  <xsl:variable name="nb_items"><xsl:value-of select="count($items_list//item-data)"/></xsl:variable>
  <xsl:variable name="items_loc">
  <loc>
    <xsl:for-each select="$items_list//item-data">
      <item><sublibrary><xsl:value-of select="sub-library"/></sublibrary>
        <localisation><xsl:value-of select="collection"/></localisation>
        <cote><xsl:value-of select="location"/></cote>
    </item>
    </xsl:for-each>
    </loc>
  </xsl:variable>
  <xsl:variable name="barcodes">
    <bc><xsl:for-each select="$items_list//barcode"><xsl:copy-of select="."/></xsl:for-each></bc>
  </xsl:variable>
  <xsl:variable name="last_loan_file">
  <last_loans>
    <xsl:for-each select="$barcodes//barcode">
    <xsl:variable name="url" select="concat($UrlApiOpac, ':8080/X?op=ill-item-by-bc&amp;barcode=', .)"/>
        <last_return><xsl:value-of select="document($url)//z30-date-last-return"/></last_return>
    </xsl:for-each>
    </last_loans>
  </xsl:variable>
  <aleph>
    <xsl:attribute name="ppn"><xsl:value-of select="@ppn"/></xsl:attribute>
    <no><xsl:value-of select="substring-after(., 'UNS01')"/></no>
    <nb_items><xsl:value-of select="$nb_items"/></nb_items>
    <xsl:copy-of select="$items_loc"/>
    <xsl:copy-of select="$last_loan_file"/>
  </aleph>

  </xsl:template>

  <xsl:template name="ppn">
  <xsl:variable name="url_api_sudoc_where"><xsl:value-of select="concat('http://www.sudoc.fr/services/multiwhere/', .)"/></xsl:variable>
  <xsl:variable name="nb_libraries"><xsl:value-of select="count(document($url_api_sudoc_where)//library)"/></xsl:variable>
  <ppn><xsl:if test="@ocn"><xsl:attribute name="ocn"><xsl:value-of select="@ocn"/></xsl:attribute></xsl:if>
    <no><xsl:value-of select="."/></no>
    <nb_libraries><xsl:value-of select="$nb_libraries"/></nb_libraries>
  <xsl:if test="not(../Mcl)">
    <xsl:variable name="rdf_file"><xsl:copy-of select="document(concat('http://www.sudoc.fr/', ., '.rdf'))//rdf:RDF"/></xsl:variable>
    <xsl:if test="$rdf_file//dc:subject">
      <xsl:for-each select="$rdf_file//dc:subject"><subject><xsl:value-of select="."/></subject></xsl:for-each>
    </xsl:if>
  </xsl:if>
</ppn>
  </xsl:template>
  
<xsl:template name="ocn">
<xsl:param name="sujet"/>

<xsl:variable name="ocn_url">http://www.worldcat.org/webservices/catalog/content/<xsl:value-of select="."/>?wskey=<xsl:value-of select="$OclcApiKey"/></xsl:variable>
<xsl:variable name="ocn_file"><xsl:copy-of select="document($ocn_url)//marc:record"/></xsl:variable>
<ocn>
<no><xsl:value-of select="."/></no>
  <xsl:choose>
    <xsl:when test="$sujet = 'non'">
      <xsl:if test="$ocn_file//marc:datafield[@tag='490']/marc:subfield[@code='a']"><collection><xsl:value-of select="$ocn_file//marc:datafield[@tag='490']/marc:subfield[@code='a']"/></collection></xsl:if>
    </xsl:when>
    <xsl:otherwise>
      <xsl:if test="$ocn_file//marc:datafield[@tag='490']/marc:subfield[@code='a']"><collection><xsl:value-of select="$ocn_file//marc:datafield[@tag='490']/marc:subfield[@code='a']"/></collection></xsl:if>
      <xsl:if test="$ocn_file//marc:datafield[@tag='650']/marc:subfield[@code='a']">
        <xsl:for-each select="$ocn_file//marc:datafield[@tag='650']/marc:subfield[@code='a']">
              <subject><xsl:value-of select="."/></subject>
        </xsl:for-each>
      </xsl:if>
    </xsl:otherwise>
  </xsl:choose>
  </ocn>

  </xsl:template>
  
  
  
</xsl:stylesheet>
