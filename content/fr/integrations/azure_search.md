---
categories:
  - cloud
  - azure
ddtype: crawler
dependencies: []
description: "Surveillez des métriques clés d'Azure\_Search."
doc_link: 'https://docs.datadoghq.com/integrations/azure_search/'
git_integration_title: azure_search
has_logo: true
integration_title: "Microsoft Azure\_Search"
is_public: true
kind: integration
manifest_version: 1
name: azure_search
public_title: "Intégration Datadog/Microsoft Azure\_Search"
short_description: "Surveillez des métriques clés d'Azure\_Search."
version: 1
---
## Présentation

Azure Search est une solution cloud de recherche en tant que service, qui offre aux développeurs des API et des outils permettant d'ajouter une expérience de recherche riche concernant du contenu privé et hétérogène dans les applications web, mobiles et d'entreprise.

Utilisez l'intégration Datadog/Azure pour recueillir les métriques d'Azure Search.

## Implémentation
### Installation

Si vous ne l'avez pas déjà fait, configurez d'abord [l'intégration Microsoft Azure][1]. Aucune autre procédure d'installation n'est requise.

## Données collectées
### Métriques
{{< get-metrics-from-git "azure_search" >}}


### Événements
L'intégration Azure Search n'inclut aucun événement.

### Checks de service
L'intégration Azure Search n'inclut aucun check de service.

## Dépannage
Besoin d'aide ? Contactez [l'assistance Datadog][3].

[1]: https://docs.datadoghq.com/fr/integrations/azure/
[2]: https://github.com/DataDog/dogweb/blob/prod/integration/azure_search/azure_search_metadata.csv
[3]: https://docs.datadoghq.com/fr/help/


{{< get-dependencies >}}