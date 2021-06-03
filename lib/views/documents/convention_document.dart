import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class ConventionDocument extends StatelessWidget {

  final Color titleColor;
  final Color subTitleColor;
  final Color textColor;

  ConventionDocument({@required this.titleColor, @ required this.subTitleColor, @required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RegulationTitleText('Préambule', color: titleColor,),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'Le présent texte détaille les conditions d\'utilisations de l\'application Diapason en accord avec les statuts de l\'association '
                'et sa charte en vigueur.',
            color: textColor,
          ),
          SizedBox(height: 10.0,),
          // End of first article
          RegulationTitleText('1. La mission de l\'association Diapason', color: titleColor,),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget('Créer, expérimenter, accompagner et faciliter des expériences de tout ordre (culturelles, artistiques, sportives, de loisirs, professionnelles, etc.).'
              ' Rechercher, développer et valoriser des méthodes d\'enrichissement des expériences et rendre ces pratiques accessibles au plus grand nombre.'
              ' Promouvoir médiatiquement cette démarche, les potentiels du territoire et ses acteurs. Les moyens d\'action de l\'association sont notamment : ',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- L\'acquisition et la mise en commun des compétences et des ressources nécessaires.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- L\'organisation d\'événements et d\'animations.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- La vente de produits divers, de publications et de prestations.',
            color: textColor,
          ),
          SizedBox(height: 10.0,),
          // End of first article
          RegulationTitleText('2. L\'application Diapason', color: titleColor,),
          SizedBox(height: 5.0,),
          RegulationSubTitleText(
            '2.1. Les services que nous proposons',
            color: subTitleColor,
          ),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'Cet outil a pour but de faciliter les interactions entre les adhérents de l\'association '
                'et d\'offrir une plate-forme de distribution de nos contenus médiatiques. Il permet '
                'actuellement de : ',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Consulter les événements à venir, créés par les administrateurs.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Indiquer ou non sa participation aux événements.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Visualiser les projets réalisés jusqu\'à maintenant.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Visualiser les activités pratiquées par les membres.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Consulter le matériel mis en commun.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Contacter au besoin tous les adhérents de l\'association.',
            color: textColor,
          ),
          SizedBox(height: 5.0,),
          RegulationSubTitleText(
            '2.2. Notre politique de confidentialité',
            color: subTitleColor,
          ),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'Consultable à tout moment dans l\'onglet "Politique de confidentialité", elle précise '
                'les données que nous récoltons, qui y a accès, comment nous les conservons et les traitons '
                'ainsi que vos droits par rapport à ces mêmes données.',
            color: textColor,
          ),
          SizedBox(height: 5.0,),
          RegulationSubTitleText(
            '2.3. Les types d\'utilisateur',
            color: subTitleColor,
          ),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'L\'application offre 3 niveaux d\'accès aux informations à ses utilisateurs :',
            color: textColor,
          ),
          SharedRegularTextWidget(
            "- Le visiteur : Non adhérent mais inscrit sur l\'application, il peut accèder aux informations publiques de l\'association. C\'est-à-dire "
                'les événements à venir, notre bilan d\'activité, les activités pratiquées ainsi que le matériel mis en commun. Il peut consulter la liste des administrateurs, voyant leur photo et leur prénom mais il '
                'n\'a accès à aucune autre donnée personnelle des adhérents.es.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- L\'adhérent.e : Il/Elle peut consulter les projets à venir, le bilan d\'activité, le matériel mis en commun ainsi que les données personnelles des autres adhérents.es. '
                'Il peut indiquer sa présence ou non aux événements de l\'association.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- L\'administrateur.trice : Soit membre du conseil d\'administration, soit adhérent actif en ayant fait la demande, l\'administrateur.trice '
                'est créateur de contenu sur l\'application en plus de pouvoir consulter le reste des informations mentionnées jusqu\'ici. Il est modérateur des '
                'contenus inappropriés signalés par les utilisateurs de l\'application.',
            color: textColor,
          ),
          SizedBox(height: 10.0,),
          RegulationTitleText('3. Contenu présent dans l\'application', color: titleColor,),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'De part la nature de l\'association, le contenu visible dans l\'application est susceptible d\'être très varié '
                'mais il ne devra jamais :',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Faire l\'apologie de la violence, de la haine et/ou du terrorisme.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Comporter des références ou des images à caractère sexuel.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Comporter de fausses informations et présenter des comportements trompeurs.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Enfreindre le droit de propriété intellectuelle.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            'Si vous observez un contenu en lien avec les sujets mentionnés ci-dessus, nous vous invitons à nous '
                'le signaler via l\'onglet "Signaler un contenu" dans l\'application.',
            color: textColor,
          ),
          SizedBox(height: 10.0,),
          RegulationTitleText('4. Les adhérents.tes Diapason', color: titleColor,),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'Suivant leur implication dans Diapason et leur compréhension du projet associatif, les adhérents.tes doivent'
                ' déclarer l\'un des statuts ci-dessous. Ce statut est indicatif, évolutif dans le temps et '
                'permet seulement une meilleure organisation des expériences.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Membre actif',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Participant.e occasionnel',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Membre d\'honneur',
            color: textColor,
          ),
          SizedBox(height: 10.0,),
          RegulationTitleText('4. L\'attitude', color: titleColor,),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'Il est attendu de la part des adhérents.tes une certaine attitude pendant les expériences vis à vis des participant.e.s et des organisateurs.trices :',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- De la bienveillance en évitant tout jugement moral et critique, ',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- de l\'ouverture d\'esprit, le bénéfice du doute et le goût de la curiosité (jouer le jeu),',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- de la pro-activité et la volonté de co-construire les expériences,',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- de la ponctualité.',
            color: textColor,
          ),
          SizedBox(height: 10.0,),
          RegulationTitleText('5. Le matériel', color: titleColor,),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'Il est possible que du matériel soit mis à disposition des adhérent.e.s. '
                'Chaque objet devra être rendu dans les temps et en état à son propriétaire ou au coordinateur.',
            color: textColor,
          ),
          SizedBox(height: 10.0,),
          RegulationTitleText('6. Règles de sécurité', color: titleColor,),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'Certaines activités se déroulant en "milieu spécifique" nécessitent un.e encadrant.e diplômé.e. '
                'Aucune sortie de ce type ne sera organisée de manière autonome entre les membres de l\'association. Cependant, '
                'organiser une sortie ponctuelle dans une structure encadrante ou emprunter du matériel pour '
                'votre pratique personnelle reste possible et n\'engage que le membre dans sa pratique.',
            color: textColor,
          ),
        ],
      ),
    );
  }
}
