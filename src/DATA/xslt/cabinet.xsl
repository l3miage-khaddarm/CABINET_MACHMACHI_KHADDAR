<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : CabinetInfimier.xsl
    Created on : 9 novembre 2022, 09:25
    Author     : admin
    Description:
        Purpose of transformation follows.
-->

<xs:stylesheet xmlns:xs="http://www.w3.org/1999/XSL/Transform" 
                version="1.0"
                xmlns:vs="http://www.ujf-grenoble.fr/l3miage/medical"
                xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes">
    <xs:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <!-- variable actes qui comporte les noeuds ngap(liste des soins) du doc actes.xml -->
    <xs:variable name="actes" select="document('actes.xml', /)/act:ngap"/>
     <!-- parametre destineID contenant 001 par défaut(numéro infirmière) -->
    <xs:param name="destinedId" select="001"/>
     <!-- variable visiteDuJour contenant l'ensemble des noeuds visite correspondant à l'infirmière -->
    <xs:variable name="visiteDuJour" select="//vs:patient/vs:visite[@intervenant=$destinedId]"/>
    <!--template qui match sur la racine -->
    <xs:template match="/">
        <html>
            <head>
                <title>PageInfirmière.xsl</title>
                <link rel="stylesheet" href="../css/PageInfirmiere.css" />
                <script type="text/javascript">
                      <![CDATA[ function openFacture(prenom, nom, actes) {
                        var width  = 500;
                        var height = 300;
                        if(window.innerWidth) {
                            var left = (window.innerWidth-width)/2;
                            var top = (window.innerHeight-height)/2;
                        }
                        else {
                            var left = (document.body.clientWidth-width)/2;
                            var top = (document.body.clientHeight-height)/2;
                        }
                        var factureWindow = window.open('','facture','menubar=yes, scrollbars=yes, top='+top+', left='+left+', width='+width+', height='+height+'');
                        factureText = "Facture pour : " + prenom + " " + nom;
                        factureWindow.document.write(factureText);
                    }]]> 
                </script>
            </head>
            <body>
                <h1>Page Infirmière</h1>
                 <!-- ici on affiche le prénom de l'infirmière -->
                <p>
                Bonjour <xs:value-of select="vs:cabinet/vs:infirmiers/vs:infirmier/vs:prénom/text()"/><br/>
                 <!-- ici on compte grâce à count l'ensemble des patients que l'infirmière va consulter pour ce jour -->
                Aujourd'hui, vous avez <xs:value-of select="count($visiteDuJour)"/> patient(s).<br/>
                 </p>
                 <h2>Les Patients :</h2>
                <xs:apply-templates select="vs:cabinet/vs:patients/vs:patient/vs:visite[@intervenant=$destinedId]"/>
            </body>      
        </html>
    </xs:template>
    <!-- cette template associe sur visite pour afficher le nom , prénom ,adresse et la liste des soins correspondant au patient-->
    <xs:template match="vs:visite">
        <h4>Patient N° <xs:value-of select="position()"/></h4><br/>
         <p>Nom :<xs:value-of select="../vs:nom/text()"/> <br/>
         Prénom :<xs:value-of select="../vs:prénom/text()"/> 
         <br/>
         </p>
         <p> <xs:apply-templates select="../vs:adresse"/></p>
         <p>Liste des soins :<xs:apply-templates select="vs:acte"/><br/>
         </p>
         <p> <button>
                <xs:attribute name="onclick">
                openFacture('<xs:value-of select="../vs:prénom/text()"/>',
                            '<xs:value-of select="../vs:nom/text()"/>',
                            '<xs:value-of select="/acte"/>')
                </xs:attribute> FACTURE
         </button> <br/>
         </p>
    </xs:template>
    <!--cette template match sur l'adresse du patient pour l'afficher en détails (numéro , étage , code postal ...) -->
    <xs:template match="vs:adresse">
        <i>Adresse Complète</i><br/>
        Etage :<xs:value-of select="vs:étage/text()"/><br/>
        Numéro : <xs:value-of select="vs:numéro/text()"/><br/>
        Rue: <xs:value-of select="vs:rue/text()"/><br/>
        Ville : <xs:value-of select="vs:ville/text()"/><br/>
        Code Postal :<xs:value-of select="vs:codePostale/text()"/><br/>
      
    </xs:template>
    <xs:template match="vs:acte">
        <!--création d'une variable idActe contenant l'id soin du patient-->
       <xs:variable name="idActe" select="@id"/>
       <!--comparaison de l'id du patient avec celui dans le fichier actes.xml-->
       <xs:value-of select="$actes/act:actes/act:acte[@id=$idActe]/text()"/>
    </xs:template>
</xs:stylesheet>
