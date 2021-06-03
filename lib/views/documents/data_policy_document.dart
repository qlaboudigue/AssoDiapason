import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class DataPolicyDocument extends StatelessWidget {

  final Color titleColor;
  final Color subTitleColor;
  final Color textColor;

  DataPolicyDocument({@required this.titleColor, @ required this.subTitleColor, @required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RegulationTitleText('1. Introduction', color: titleColor,),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'Dans le cadre de son activité quotidienne, l\'association Diapason est amenée à '
                'traiter des informations vous concernant. Par exemple, lors de votre inscription ou '
                'encore lorsque vous indiquez votre participation à nos événements. Vous nous transmettez '
                'des informations dont certaines sont de nature à vous identifier ("données personnelles").',
            color: textColor,
          ),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'La présente Politique de confidentialité vous informe de la manière dont nous recueillons et traitons vos données personnelles. '
                'Nous vous invitons à la lire attentivement.',
            color: textColor,
          ),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'Nous n\'utilisons vos données personnelles que dans les cas prévus par la réglementation en vigueur :',
            color: textColor,
          ),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            '- L\'exécution d\'un contrat que nous avons conclu avec vous, et/ou',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Le respect d\'une obligation légale, et/ou',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Votre consentement à l\'utilisation de vos données, et/ou',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- L\'existence d\'un intérêt légitime à utiliser vos données. L\'intérêt légitime est un ensemble de raisons '
                'commerciales ou d\'affaires qui justifie l\'utilisation de vos données par l\'Association Diapason.',
            color: textColor,
          ),
          SizedBox(height: 10.0,),
          RegulationTitleText('2. Qui est le responsable des traitements mentionnées dans le présent document ?', color: titleColor,),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'Le responsable des traitements mentionnés par le présent document est l\'Association Diapason '
                'dont le siège social est situé 3 avenue Alsace Lorraine, 38000 Grenoble déclarée à la préfecture de l\'Isère '
                'sous le numéro de SIREN 853 215 804 dont Monsieur Jouanneau Sylvain président de l\'association est le '
                'représentant légal. Le délégué à la protection des données de l\'association Diapason est Mr Laboudigue Quentin.',
            color: textColor,
          ),
          SizedBox(height: 10.0,),
          RegulationTitleText('3. Quelles sont les données que nous recueillons sur vous et dans quelles circonstances les '
              'collectons-nous ?', color: titleColor,
          ),
          SizedBox(height: 5.0,),
          RegulationSubTitleText(
            '3.1. Les données que vous nous transmettez directement', color: subTitleColor,
          ),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'Vous êtes amené.e à nous communiquer des informations personnelles lors de votre adhésion à l\'association. '
                'Ces données sont notamment : ',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Nom, prénom',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Adresse postale, adresse mail, numéro de téléphone',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Mot de passe crypté',
            color: textColor,
          ),
          SizedBox(height: 5.0,),
          RegulationSubTitleText(
            '3.2. Les données que nous recueillons automatiquement', color: subTitleColor,
          ),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'Lors de chacune de vos visites dans l\'application mobile, nous recueillons des informations relatives '
                'à votre connexion et à votre navigation ainsi que certaines données fournies par les appareils '
                'mobiles :',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Le type d\'équipement que vous utilisez et son système d\'exploitation.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- En fonction des autorisations que vous avez accordées à l\'application mobile et que vous pouvez '
                'modifier à tout moment comme "Notifications" ou "Géolocalisation", ces données nécessaires '
                'au bon fonctionnement de l\'application mobile sont traitées automatiquement par notre hébergeur (Google Firebase) et '
                'ceux de nos partenaires (GoogleCloud).',
            color: textColor,
          ),
          SizedBox(height: 5.0,),
          RegulationSubTitleText(
            '3.3. Données relatives aux mineurs', color: subTitleColor,
          ),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'En principe, nos services s\'adressent à des personnes majeures. La récolte des données personnelles comme le numéro de téléphone, l\'adresse postale'
                ' et une photo personnelle n\'est possible que si l\'utilisateur adhère à l\'association. Cette adhésion '
                'nécessite l\'intervention physique d\'un administrateur de Diapason qui s\'assure de l\'âge de l\'utilisateur. '
                'Aucune donnée personnelle d\'un utilisateur mineur ne sera donc collectée.',
            color: textColor,
          ),
          SizedBox(height: 5.0,),
          RegulationSubTitleText(
            '3.4. Exclusion de toute donnée sensible', color: subTitleColor,
          ),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'L\'association Diapason ne collecte aucune donnée sensible vous concernant. Sont considérées comme '
                'données sensibles : l\'origine raciale ou ethnique, les opinions politiques, les croyances '
                'religieuses ou philosophiques, l\'adhésion à un syndicat, les données relatives à la santé ou '
                'l\'orientation sexuelle. Si de telles informations étaient d\'une manière ou d\'une autre '
                'communiquées à l\'association Diapason, elles seront supprimées.',
            color: textColor,
          ),
          SizedBox(height: 10.0,),
          RegulationTitleText('4. Pour quelles finalités utilisons-nous vos données ?', color: titleColor,),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'Le présent article vous indique les principales finalités pour lesquelles nous utilisons les '
                'données mentionnées à l\'article 3 : ',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Prise en compte de votre adhésion.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Envoi d\'informations sur la modification ou l\'évolution de nos services.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Gestion de l\'exercice de vos droits sur vos données personnelles, dans les conditions prévues à l\'article 9.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Adaptation de la présentation de l\'application aux préférences '
                'd\’affichage de votre terminal (langue utilisée, résolution d\’affichage, système d’exploitation, etc.) '
                'lors de vos visites, selon les matériels et les logiciels de visualisation ou de lecture que votre terminal comporte.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Connexion automatique aux espaces réservés ou personnels de notre site, tels que votre compte, '
                'grâce à des identifiants ou des données que vous nous avez antérieurement confiées.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Gestion de nos plates-formes et réalisation d\’opérations techniques internes dans le '
                'cadre de résolution de problèmes, analyse de données, tests, recherches, analyses, études et sondages.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Mise en œuvre de mesures de sécurité.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Mesurer l’efficacité de nos campagnes publicitaires et propositions de services.',
            color: textColor,
          ),
          SizedBox(height: 10.0,),
          RegulationTitleText('5. Pendant combien de temps conservons-nous vos données ?', color: titleColor,),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'Vos données personnelles sont conservées pendant une durée conforme aux dispositions '
                'légales ou proportionnelles aux finalités pour lesquelles elles ont été enregistrées. '
                'Certaines durées de conservation répondent à l\’intérêt légitime de l\'association Diapason '
                'tel que spécifié en introduction. ',
            color: textColor,
          ),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'En tout état de cause, nous révisons régulièrement les informations que nous détenons. '
                'Lorsque leur conservation n\’est plus justifiée par des exigences légales, commerciales '
                'ou liées à la gestion de votre compte client, ou si vous avez fait usage d’un droit '
                'de modification ou d’effacement, nous les supprimerons de façon sécurisée.',
            color: textColor,
          ),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'Les durées de conservation varient selon que nous avons une relation '
                'de nature contractuelle en cours (vous êtes un client actif), que nous '
                'avons eu avec vous par le passé une relation contractuelle (vous êtes un client inactif). ',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- Les données relatives à un client actif sont conservées pendant toute la durée '
                'de sa relation contractuelle avec l\'association.',
            color: textColor,
          ),
          SharedRegularTextWidget(
              '- Les données relatives à un client inactif pour l\'envoi d\'informations sur l\'évolution de nos services, '
                  'sont conservées 5 ans après la fin du contrat ou le dernier contact émanant du client inactif.',
            color: textColor,
          ),
          SizedBox(height: 10.0,),
          RegulationTitleText('6. Qui est susceptible d\'avoir accès aux données que nous recueillons ?', color: titleColor,),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'L\’accès à vos données se fait sur la base d\’autorisations '
                'd\’accès individuelles et limitées. Les personnels pouvant accéder aux '
                'données personnelles sont soumis à une obligation de confidentialité '
                '(par un engagement nominal et personnel de confidentialité). Sont susceptibles '
                'd\'avoir accès à certaines de vos données, le délégué à la protection des données également '
                'concepteur de l\'application : Laboudigue Quentin, l\'ensemble des membres du bureau : '
                'Jouanneau Sylvain, Jouanneau Clément ainsi que notre coordinateur.',
            color: textColor,
          ),
          SizedBox(height: 10.0,),
          RegulationTitleText('7. Vos données sont-elles transférées en dehors de l\'union européenne  ?', color: titleColor,),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'Nous conservons vos données personnelles dans l\’Union européenne. Toutefois, '
                'il est possible de manière marginale que les données que nous recueillons '
                'lorsque vous utilisez nos plates-formes ou dans le cadre de nos services '
                'soient transférées à des sous-traitants ou partenaires commerciaux situés '
                'dans d’autres pays, certains d’entre eux pouvant avoir une législation sur '
                'la protection des données personnelles moins protectrice que celle en vigueur '
                'dans le pays où vous résidez. En cas de transfert de ce type, nous nous assurons '
                'de ce que le traitement soit effectué conformément à la présente politique de '
                'confidentialité et qu\’il soit encadré par les clauses contractuelles types de'
                ' la Commission européenne qui permettent de garantir un niveau de protection'
                ' suffisant de la vie privée et des droits fondamentaux des personnes.',
            color: textColor,
          ),
          SizedBox(height: 10.0,),
          RegulationTitleText('8. Comment vos données sont-elles protégées ?', color: titleColor,),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'En tant que responsable de traitements, nous mettons en œuvre des '
                'mesures techniques et organisationnelles appropriées conformément '
                'aux dispositions légales applicables, pour protéger vos données personnelles'
                ' contre l\’altération, la perte accidentelle ou illicite, l\’utilisation, '
                'la divulgation ou l\’accès non autorisé, et notamment :',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- La nomination d\'un délégué à la protection des données.',
            color: textColor,
          ),
          SharedRegularTextWidget(
            '- La sensibilisation aux exigences de confidentialité de nos collaborateurs amenés à accéder '
                'à vos données personnelles.',
            color: textColor,
          ),
          SharedRegularTextWidget(
              '- La sécurisation de l’accès à nos locaux et à nos plates-formes informatiques.',
            color: textColor,
          ),
          SizedBox(height: 10.0,),
          RegulationTitleText('9. Quels sont vos droits ?', color: titleColor,),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'Vous avez le droit d’accéder à vos données personnelles et de '
                'demander qu’elles soient rectifiées, complétées ou mises à jour. '
                'Vous pouvez également demander l’effacement de vos données ou '
                'vous opposer à leur traitement, à condition de justifier d’un motif légitime.',
            color: textColor,
          ),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'Vous pouvez demander à exercer votre droit à la portabilité de vos données, '
                'c’est-à-dire le droit de recevoir les données personnelles que vous '
                'nous avez fournies dans un format structuré, couramment utilisé et le '
                'droit de transmettre ces données à un autre responsable de traitements.',
            color: textColor,
          ),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'Vous pouvez enfin formuler des directives relatives à la conservation, à '
                'l\’effacement et à la communication de vos données à caractère personnel après votre décès.',
            color: textColor,
          ),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'Vous pouvez exercer vos droits auprès de la déléguée à la protection des données '
                'personnelles de l\'association Diapason à l\’adresse suivante : '
                '3 avenue alsace lorraine, 38000 Grenoble ou par mail : diapason.grenoble@gmail.com',
            color: textColor,
          ),
          SizedBox(height: 5.0,),
          SharedRegularTextWidget(
            'Avant de répondre à votre demande, nous sommes susceptibles de vérifier '
                'votre identité et/ou vous demander de nous fournir davantage '
                'd\’informations pour répondre à votre demande. Nous nous efforcerons '
                'de donner suite à votre demande dans un délai raisonnable et, '
                'en tout état de cause, dans les délais fixés par la loi. En cas de réponse insatisfaisante, '
                'vous pouvez introduire une réclamation auprès de la Commission nationale de '
                'l\’informatique et des libertés (CNIL) : https://www.cnil.fr/fr/plaintes ',
            color: textColor,
          ),
        ],
      ),
    );
  }
}
