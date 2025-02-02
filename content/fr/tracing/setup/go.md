---
title: Tracer des applications Go
kind: documentation
aliases:
  - /fr/tracing/go/
  - /fr/tracing/languages/go
  - /fr/agent/apm/go/
further_reading:
  - link: 'https://github.com/DataDog/dd-trace-go/tree/v1'
    tag: GitHub
    text: Code source
  - link: 'https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/ddtrace'
    tag: GoDoc
    text: Page sur les packages
  - link: tracing/visualization/
    tag: Documentation
    text: 'Explorer vos services, ressources et traces'
  - link: tracing/advanced/
    tag: Utilisation avancée
    text: Utilisation avancée
---
## Installation et démarrage

Pour obtenir des instructions de configuration et des détails sur l'utilisation de l'API, consultez la [documentation sur l'API][1] de Datadog. Pour l'instrumentation manuelle, utilisez la [section Intégrations](#integrations) ci-dessous pour en savoir plus sur les bibliothèques Go et les frameworks qui prennent en charge l'instrumentation automatique.

Pour connaître la définition des termes utilisés dans l'APM, consultez la [section Débuter avec l'APM][2]. Pour en savoir plus sur les contributions, consultez le référentiel officiel [README.md][3].

Consultez le [document sur la migration][4] si vous devez migrer d'une ancienne version du traceur (p. ex. v<0.6.x) vers la dernière version.

### Installation
<div class="alert alert-info">Si vous avez déjà un compte Datadog, vous trouverez des instructions détaillées dans nos guides intégrés à l'application pour les configurations <a href="https://app.datadoghq.com/apm/docs?architecture=host-based&language=go" target=_blank> basées sur un host</a> et les configurations <a href="https://app.datadoghq.com/apm/docs?architecture=container-based&language=go" target=_blank>basées sur un conteneur</a>.</div>

Commencez par [installer et configurer l'Agent Datadog][5]. Consultez la documentation supplémentaire relative au [traçage d'applications Docker][6] ou au [traçage d'applications Kubernetes][7].

Installez ensuite le traceur Go depuis son chemin d'importation canonique :

```go
go get gopkg.in/DataDog/dd-trace-go.v1/ddtrace
```

Vous êtes alors prêt à importer le traceur et à commencer l'instrumentation de votre code.

## Instrumentation automatique

Datadog propose un ensemble de paquets prêts à l'emploi qui prennent en charge l'instrumentation d'un certain nombre de bibliothèques et de frameworks. Vous trouverez la liste des [intégrations](#integrations) ci-dessous.

## Compatibilité
Pour commencer à tracer vos applications Go, votre environnement doit :

* Exécuter l'Agent Datadog `>= 5.21.1`.
* Utiliser Go `1.9+`


### Intégrations

#### Compatibilité des frameworks

Intégrez le traceur go avec la liste de frameworks Web ci-dessous via l'un des paquets d'assistance suivants :

| Framework         | Type de prise en charge    | Documentation GoDoc de Datadog                                              |
|-------------------|-----------------|--------------------------------------------------------------------------|
| [Gin][8]          | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/gin-gonic/gin][9]               |
| [Gorilla Mux][10] | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/gorilla/mux][11]                |
| [gRPC][12]        | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/google.golang.org/grpc][13]     |
| [gRPC v1.2][14]   | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/google.golang.org/grpc.v12][15] |

#### Compatibilité des bibliothèques

Le traceur Go prend en charge les datastores et les bibliothèques suivants.

| Bibliothèque                 | Type de prise en charge    | Exemples et documentation                                                      |
|-------------------------|-----------------|---------------------------------------------------------------------------------|
| [AWS SDK][16]           | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/aws/aws-sdk-go/aws][17]                |
| [Elasticsearch][18]     | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/olivere/elastic][19]                   |
| [Cassandra][20]         | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/gocql/gocql][21]                       |
| [GraphQL][22]           | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/graph-gophers/graphql-go][23]          |
| [HTTP][24]              | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/net/http][25]                          |
| [HTTP router][26]       | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/julienschmidt/httprouter][27]          |
| [Redis (go-redis)][28]  | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/go-redis/redis][29]                    |
| [Redis (redigo)][30]    | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/garyburd/redigo][31]                   |
| [SQL][32]               | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/database/sql][33]                      |
| [SQLx][34]              | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/jmoiron/sqlx][35]                      |
| [MongoDB][36]           | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/go.mongodb.org/mongo-driver/mongo][37] |
| [BuntDB][38]            | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/tidwall/buntdb][39]                    |
| [LevelDB][40]           | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/syndtr/goleveldb/leveldb][41]          |
| [miekg/dns][42]         | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/miekg/dns][43]                         |
| [Kafka (confluent)][44] | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/confluentinc/confluent-kafka-go][45]   |
| [Kafka (sarama)][46]    | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/Shopify/sarama][47]                    |
| [Google API][48]        | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/google.golang.org/api][49]             |
| [go-restful][50]        | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/emicklei/go-restful][51]               |
| [Twirp][52]             | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/twitchtv/twirp][53]                    |
| [Vault][54]             | Prise en charge complète | [gopkg.in/DataDog/dd-trace-go.v1/contrib/hashicorp/vault][55]                   |


**Remarque** : la [documentation sur les intégrations][56] contient une description détaillée des paquets pris en charge et de leurs API, ainsi que des exemples d'utilisation.

Les paquets doivent être importés de la façon suivante :

```go
import "gopkg.in/DataDog/dd-trace-go.v1/contrib/<répertoire_paquet>/<nom_paquet>"
```

## Configuration

Le traceur est configuré avec des paramètres d'option lorsque la fonction `Start` est appelée. Voici un exemple de configuration permettant de générer une trace via la bibliothèque HTTP :

```go
package main

import (
    "net/http"
    "strings"
    "log"
    httptrace "gopkg.in/DataDog/dd-trace-go.v1/contrib/net/http"
    "gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer"
)

func sayHello(w http.ResponseWriter, r *http.Request) {
  message := r.URL.Path
  message = strings.TrimPrefix(message, "/")
  message = "Hello " + message
  w.Write([]byte(message))
}

func main() {
    // démarrer le traceur avec 0 option ou plus
    tracer.Start(tracer.WithServiceName("test-go"))
    defer tracer.Stop()

    mux := httptrace.NewServeMux() // initialiser le traceur http
    mux.HandleFunc("/", sayHello) // utiliser le traceur pour gérer les URL

    err := http.ListenAndServe(":9090", mux) // définir le port d'écoute
    if err != nil {
        log.Fatal("ListenAndServe: ", err)
    }
}
```

Pour découvrir toutes les options disponibles pour le traceur, consultez la [documentation de configuration][57].

### Extraction et injection d'en-têtes B3

Le traceur de l'APM Datadog prend en charge [l'extraction et l'injection d'en-têtes B3][58] pour le tracing distribué.

L'injection et l'extraction distribuées d'en-têtes sont contrôlées en configurant des styles d'injection/extraction. Deux styles sont actuellement pris en charge : `Datadog` et `B3`.

Configurez les styles d'injection via la variable d'environnement `DD_PROPAGATION_STYLE_INJECT=Datadog,B3`

Configurez les styles d'extraction via la variable d'environnement `DD_PROPAGATION_STYLE_EXTRACT=Datadog,B3`

Ces variables d'environnement prennent comme valeur une liste des styles d'en-tête autorisés pour l'injection ou l'extraction, séparés par des virgules. Par défaut, seul le style d'extraction `Datadog` est activé.

Si plusieurs styles d'extraction sont activés, les tentative d'extraction sont effectuées dans l'ordre selon lequel ces styles ont été configurés, et la première valeur extraite avec succès est utilisée.

## Modifier le hostname de l'Agent

Configurez vos traceurs d'applications de façon à envoyer des traces à un hostname d'Agent personnalisé :

Le module de tracing Go recherche automatiquement les variables d'environnement `DD_AGENT_HOST` et `DD_TRACE_AGENT_PORT` puis s'initialise avec celles-ci.

```go
package main

import (
    "net"
    "os"

    "gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer"
)

func main() {
    addr := net.JoinHostPort(
        os.Getenv("DD_AGENT_HOST"),
        os.Getenv("DD_TRACE_AGENT_PORT"),
    )
    tracer.Start(tracer.WithAgentAddr(addr))
    defer tracer.Stop()
}

```

## Pour aller plus loin

{{< partial name="whats-next/whats-next.html" >}}

[1]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/ddtrace
[2]: /fr/tracing/visualization
[3]: https://github.com/DataDog/dd-trace-go/tree/v1#contributing
[4]: https://github.com/DataDog/dd-trace-go/tree/v1/MIGRATING.md
[5]: /fr/tracing/send_traces
[6]: /fr/tracing/setup/docker
[7]: /fr/agent/kubernetes/daemonset_setup/#trace-collection
[8]: https://gin-gonic.com
[9]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/gin-gonic/gin
[10]: http://www.gorillatoolkit.org/pkg/mux
[11]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/gorilla/mux
[12]: https://github.com/grpc/grpc-go
[13]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/google.golang.org/grpc
[14]: https://github.com/grpc/grpc-go
[15]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/google.golang.org/grpc.v12
[16]: https://aws.amazon.com/sdk-for-go
[17]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/aws/aws-sdk-go/aws
[18]: https://github.com/olivere/elastic
[19]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/olivere/elastic
[20]: https://github.com/gocql/gocql
[21]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/gocql/gocql
[22]: https://github.com/graph-gophers/graphql-go
[23]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/graph-gophers/graphql-go
[24]: https://golang.org/pkg/net/http
[25]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/net/http
[26]: https://github.com/julienschmidt/httprouter
[27]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/julienschmidt/httprouter
[28]: https://github.com/go-redis/redis
[29]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/go-redis/redis
[30]: https://github.com/garyburd/redigo
[31]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/garyburd/redigo
[32]: https://golang.org/pkg/database/sql
[33]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/database/sql
[34]: https://github.com/jmoiron/sqlx
[35]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/jmoiron/sqlx
[36]: https://github.com/mongodb/mongo-go-driver
[37]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/go.mongodb.org/mongo-driver/mongo
[38]: https://github.com/tidwall/buntdb
[39]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/tidwall/buntdb
[40]: https://github.com/syndtr/goleveldb
[41]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/syndtr/goleveldb/leveldb
[42]: https://github.com/miekg/dns
[43]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/miekg/dns
[44]: https://github.com/confluentinc/confluent-kafka-go
[45]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/confluentinc/confluent-kafka-go
[46]: https://github.com/Shopify/sarama
[47]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/Shopify/sarama
[48]: https://github.com/googleapis/google-api-go-client
[49]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/google.golang.org/api
[50]: https://github.com/emicklei/go-restful
[51]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/emicklei/go-restful
[52]: https://github.com/twitchtv/twirp
[53]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/twitchtv/twirp
[54]: https://github.com/hashicorp/vault
[55]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib/hashicorp/vault
[56]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/contrib
[57]: https://godoc.org/gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer#StartOption
[58]: https://github.com/openzipkin/b3-propagation