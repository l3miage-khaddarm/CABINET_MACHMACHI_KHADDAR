<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : PagePatient_HTML.xsl
    Created on : 16 novembre 2022, 00:31
    Author     : admin
    Description:
        Purpose of transformation follows.
-->

<xs:stylesheet xmlns:xs="http://www.w3.org/1999/XSL/Transform" 
               xmlns="http://www.ujf-grenoble.fr/l3miage/medical"
               xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes"
               version="1.0">
    <xs:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xs:template match="/">
        <html>
            <head>
                <title>PagePatient_HTML.xsl</title>
                <h1>Fiche Patient:</h1>
                <link rel="stylesheet" href="../css/PagePatient.css" />
            </head>
            <body>
                <xs:apply-templates select="patient"/>
            </body>
        </html>
    </xs:template>
    <xs:template match="patient">
        <p>
            <h4>Renseignements patient :</h4> 
            <br/>
            Nom :  <xs:value-of select="nom"/><br/>
            Prénom:<xs:value-of select="prénom"/><br/>
            Date de Naissance :<xs:value-of select="naissance"/><br/>
            Numéro Sécurité Sociale :<xs:value-of select="numéroSS"/><br/>
           <b>Adresse complète :</b><br/>Rue : <xs:value-of select="adresse/rue"/><br/>
            Ville : <xs:value-of select="adresse/ville"/><br/>
            Code Postal : <xs:value-of select="adresse/codePostal"/>
        </p>
        <h4>Tableau de visite(s)</h4>
        <table class="t1 t2">
            <tr>
                <th>Visite</th>
                <th>date</th>
                <th>Acte</th>
                <th>Nom de l'intervenant </th>
            </tr>
            <tr>
               <xs:apply-templates select="visite"/>
            </tr>
        </table>
    </xs:template>
    <xs:template match="visite">
         <td> <xs:value-of select="position()"/> </td>
         <td> <xs:value-of select="@date"/> </td>
         <td> <xs:value-of select="//acte/text()"/> </td>
         <td> <xs:value-of select="intervenant"/> </td>
    </xs:template>
</xs:stylesheet>
