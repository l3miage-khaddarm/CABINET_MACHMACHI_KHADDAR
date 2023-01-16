<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : patient_NOMPATIENT.xsl
    Created on : 15 novembre 2022, 15:35
    Author     : admin
    Description:
        Purpose of transformation follows.
-->

<xs:stylesheet xmlns:xs="http://www.w3.org/1999/XSL/Transform" 
                xmlns:vs="http://www.ujf-grenoble.fr/l3miage/medical"
                xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes"
                version="1.0">
    <xs:output method="xml"/>
     <xs:variable name="actes" select="document('actes.xml', /)/act:ngap"/>
    <xs:param name="destinedName" select="'Yvon'"/>
    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xs:template match="/">
        <patient>
            <xs:apply-templates select="//vs:patient"/>
        </patient>
    </xs:template>
    <xs:template match="vs:patient">
        <xs:if test="vs:prénom=$destinedName">
            <nom><xs:value-of select="vs:nom"/> </nom>
            <prénom> <xs:value-of select="vs:prénom"/></prénom>
            <sexe> <xs:value-of select="vs:sexe"/></sexe>
            <naissance> <xs:value-of select="vs:naissance"/></naissance>
            <numéroSS> <xs:value-of select="vs:numéro"/></numéroSS>
            <adresse>
                <rue><xs:value-of select="vs:adresse/vs:rue"/></rue>
                <ville><xs:value-of select="vs:adresse/vs:ville"/></ville>
                <codePostal><xs:value-of select="vs:adresse/vs:codePostal"/></codePostal>
            </adresse>
            <xs:apply-templates select="vs:visite"/>
        </xs:if> 
    </xs:template>
        
    <xs:template match="vs:visite">
        <visite>
            <xs:attribute name="date">
                <xs:value-of select="@date"/>
            </xs:attribute>
            <xs:variable name="idI" select="@intervenant"/>
             <intervenant>
                <nom><xs:value-of select="//vs:infirmier[@id=$idI]/vs:nom"/></nom>
                <prénom><xs:value-of select="//vs:infirmier[@id=$idI]/vs:prénom"/></prénom>
            </intervenant>
        </visite>
        <acte>
             <xs:apply-templates select="vs:acte"/>
        </acte>
    </xs:template>
    <xs:template match="vs:acte">
        <xs:variable name="idP" select="@id"/>
        <xs:value-of select ="$actes/act:actes/act:acte[@id=$idP]"/> 
    </xs:template>
</xs:stylesheet>