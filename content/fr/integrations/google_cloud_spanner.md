---
categories:
  - cloud
  - data store
  - google cloud
  - log collection
ddtype: crawler
dependencies: []
description: Surveillez l'utilisation des ressources de vos instances Spanner.
doc_link: 'https://docs.datadoghq.com/integrations/google_cloud_spanner/'
git_integration_title: google_cloud_spanner
has_logo: true
integration_title: "Google\_Spanner"
is_public: true
kind: integration
manifest_version: '1.0'
name: google_cloud_spanner
public_title: "Intégration Datadog/Google\_Spanner"
short_description: Surveillez l'utilisation des ressources de vos instances Spanner.
version: '1.0'
---
## Présentation
Google Cloud Spanner est le seul service de base de données relationnelle à disposer d'une cohérence forte et d'une évolutivité horizontale.

Recueillez des métriques de Google Spanner pour :

* Visualiser les performances de vos bases de données Spanner
* Corréler les performances de vos bases de données Spanner avec vos applications

## Implémentation
### Collecte de métriques
#### Installation

Si vous ne l'avez pas déjà fait, configurez d'abord [l'intégration Google Cloud Platform][1]. Aucune autre procédure d'installation n'est requise.

### Collecte de logs

Les logs Google Cloud Spanner sont recueillis avec Stackdriver et envoyés à un Cloud Pub/Sub via un redirecteur Push HTTP. Si vous ne l'avez pas déjà fait, configurez le [Cloud Pub/Sub à l'aide d'un redirecteur Push HTTP][4].

Une fois cette opération effectuée, exportez vos logs de Google Cloud Spanner depuis Stackdriver vers le Pub/sub :

1. Accédez à [la page Stackdriver][5] et filtrez les logs de Google Cloud Spanner.
2. Cliquez sur **Create Export** et nommez le récepteur.
3. Choisissez Cloud Pub/Sub comme destination et sélectionnez le Pub/Sub créé à cette fin. **Remarque** : le Pub/Sub peut se situer dans un autre projet.

{{< img src="integrations/google_cloud_spanner/export_spanner_instance.png" alt="Exportation des logs Google Cloud Spanner vers Pub Sub" responsive="true">}}

4. Cliquez sur **Create** et attendez que le message de confirmation s'affiche.

## Données collectées
### Métriques
{{< get-metrics-from-git "google_cloud_spanner" >}}


### Événements
L'intégration Google Cloud Spanner n'inclut aucun événement.

### Checks de service
L'intégration Google Cloud Spanner n'inclut aucun check de service.

## Dépannage
Besoin d'aide ? Contactez [l'assistance Datadog][3].

[1]: https://docs.datadoghq.com/fr/integrations/google_cloud_platform
[2]: https://github.com/DataDog/dogweb/blob/prod/integration/google_cloud_spanner/google_cloud_spanner_metadata.csv
[3]: https://docs.datadoghq.com/fr/help
[4]: https://docs.datadoghq.com/fr/integrations/google_cloud_platform/#log-collection
[5]: https://console.cloud.google.com/logs/viewer


{{< get-dependencies >}}