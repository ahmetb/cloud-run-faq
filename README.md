# [Google Cloud Run][run] - FAQ

> ⚠️ Beware: This is a **community-maintained** informal knowledge base.
>
> * It **does not reflect** Google’s product roadmap. (Please don't ask when a
>   feature will ship)
> * Refer to the [**Cloud Run documentation**][docs] for the most up-to-date
>   information.
>
> **Googlers:** If you find this repo useful, you should recognize the work
> internally, as I actively fight for alternative forms of content like this.

- **Is this repo useful?** Please **⭑Star** this repository and share the love.
- **Curious about something?** Open an [issue], someone may be able to add it to
  the FAQ.
- **Contribute** if you learned something interesting about Cloud Run.
- **Trouble using Cloud Run?** Ask a question [on Stack  Overflow][so].
- **Check out** [awesome-cloudrun][awesome] for a curated list of Cloud Run
  articles, tools and examples.
- **Follow me** [on Twitter][twitter] as I frequently share Cloud Run news
  and tips.

[issue]: https://github.com/ahmetb/cloud-run-faq/issues
[run]: https://cloud.google.com/run/
[docs]: https://cloud.google.com/run/docs
[so]: https://stackoverflow.com/questions/ask?tags=google-cloud-run
[awesome]: https://github.com/steren/awesome-cloudrun
[twitter]: https://twitter.com/ahmetb

-----

<!--
  ⚠️ DO NOT UPDATE THE TABLE OF CONTENTS MANUALLY ️️⚠️
  run `npx markdown-toc -i README.md`.

  Please stick to 80-character line wraps as much as you can.
-->

<!-- toc -->

- [Basics](#basics)
  * [What is Cloud Run?](#what-is-cloud-run)
  * [How is it different than App Engine Flexible?](#how-is-it-different-than-app-engine-flexible)
  * [How is it different than Google Cloud Functions?](#how-is-it-different-than-google-cloud-functions)
  * [How does it compare to AWS Fargate?](#how-does-it-compare-to-aws-fargate)
  * [How does it compare to Azure Container Instances?](#how-does-it-compare-to-azure-container-instances)
  * [What is "Cloud Run for Anthos"?](#what-is-cloud-run-for-anthos)
  * [Is Cloud Run a "hosted Knative"?](#is-cloud-run-a-hosted-knative)
- [Developing Applications](#developing-applications)
  * [Which applications are suitable for Cloud Run?](#which-applications-are-suitable-for-cloud-run)
  * [What if my application is doing background work outside of request processing?](#what-if-my-application-is-doing-background-work-outside-of-request-processing)
  * [Which languages can I run on Cloud Run?](#which-languages-can-i-run-on-cloud-run)
  * [Can I run my own system libraries and tools?](#can-i-run-my-own-system-libraries-and-tools)
  * [Where do I get started to deploy a HTTP web server container?](#where-do-i-get-started-to-deploy-a-http-web-server-container)
  * [How do I make my web application compatible with Cloud Run?](#how-do-i-make-my-web-application-compatible-with-cloud-run)
  * [Can Cloud Run receive events?](#can-cloud-run-receive-events)
  * [How to configure secrets for Cloud Run applications?](#how-to-configure-secrets-for-cloud-run-applications)
  * [How can I have cronjobs on Cloud Run?](#how-can-i-have-cronjobs-on-cloud-run)
  * [Can I mount storage volumes or disks on Cloud Run?](#can-i-mount-storage-volumes-or-disks-on-cloud-run)
- [Deploying](#deploying)
  * [How do I continuously deploy to Cloud Run?](#how-do-i-continuously-deploy-to-cloud-run)
  * [Which container registries can I deploy from?](#which-container-registries-can-i-deploy-from)
  * [How can I deploy from other GCR registries?](#how-can-i-deploy-from-other-gcr-registries)
  * [How to do canary or blue/green deployments on Cloud Run?](#how-to-do-canary-or-bluegreen-deployments-on-cloud-run)
  * [How can I specify Google credentials in Cloud Run applications?](#how-can-i-specify-google-credentials-in-cloud-run-applications)
  * [Can I use `kubectl` to deploy to Cloud Run?](#can-i-use-kubectl-to-deploy-to-cloud-run)
  * [Can I use Terraform to deploy to Cloud Run?](#can-i-use-terraform-to-deploy-to-cloud-run)
- [Cold Starts](#cold-starts)
  * [Does Cloud Run have cold starts?](#does-cloud-run-have-cold-starts)
  * [When will my service scale to zero?](#when-will-my-service-scale-to-zero)
  * [How do I minimize the cold start latencies?](#how-do-i-minimize-the-cold-start-latencies)
  * [Do I get "warmup requests" like in App Engine?](#do-i-get-warmup-requests-like-in-app-engine)
  * [How to keep a Cloud Run service “warm”?](#how-to-keep-a-cloud-run-service-warm)
  * [How can I tell if a request was a “cold start”?](#how-can-i-tell-if-a-request-was-a-cold-start)
- [Container Lifecycle](#container-lifecycle)
  * [How does Cloud Run tell if my container is ready?](#how-does-cloud-run-tell-if-my-container-is-ready)
  * [Does Cloud Run have readiness or liveness checks/probes?](#does-cloud-run-have-readiness-or-liveness-checksprobes)
  * [What happens if my container exits/crashes?](#what-happens-if-my-container-exitscrashes)
  * [What is the termination signal for Cloud Run services?](#what-is-the-termination-signal-for-cloud-run-services)
- [Serving Traffic](#serving-traffic)
  * [Which network protocols are supported on Cloud Run?](#which-network-protocols-are-supported-on-cloud-run)
  * [Customizing port number on Cloud Run?](#customizing-port-number-on-cloud-run)
  * [What's the maximum request execution time limit?](#whats-the-maximum-request-execution-time-limit)
  * [Does my service get a domain name on Cloud Run?](#does-my-service-get-a-domain-name-on-cloud-run)
  * [Are all Cloud Run services publicly accessible?](#are-all-cloud-run-services-publicly-accessible)
  * [Can I run Cloud Run applications on a private IP?](#can-i-run-cloud-run-applications-on-a-private-ip)
  * [How much additional latency does running on Cloud Run add?](#how-much-additional-latency-does-running-on-cloud-run-add)
  * [Does my application get multiple requests concurrently?](#does-my-application-get-multiple-requests-concurrently)
  * [What if my application can’t handle concurrent requests?](#what-if-my-application-cant-handle-concurrent-requests)
  * [How do I find the right concurrency level for my application?](#how-do-i-find-the-right-concurrency-level-for-my-application)
  * [Can I make request to a specific container instance?](#can-i-make-request-to-a-specific-container-instance)
  * [Can I add Cloud Run services as backends to Cloud HTTP(S) Load Balancer?](#can-i-add-cloud-run-services-as-backends-to-cloud-https-load-balancer)
  * [How does Cloud Run’s load balancing compare with Cloud Load Balancer (GCLB)](#how-does-cloud-runs-load-balancing-compare-with-cloud-load-balancer-gclb)
  * [How can I configure CDN for Cloud Run services?](#how-can-i-configure-cdn-for-cloud-run-services)
  * [Does Cloud Run offer SSL/TLS certificates (HTTPS)?](#does-cloud-run-offer-ssltls-certificates-https)
  * [How can I use my own TLS certificates for Cloud Run?](#how-can-i-use-my-own-tls-certificates-for-cloud-run)
  * [How can I redirect all HTTP traffic to HTTPS?](#how-can-i-redirect-all-http-traffic-to-https)
  * [Is traffic between my app and Cloud Run’s load balancer encrypted?](#is-traffic-between-my-app-and-cloud-runs-load-balancer-encrypted)
  * [Is HTTP/2 supported on Cloud Run?](#is-http2-supported-on-cloud-run)
  * [Does Cloud Run support load balancing among multiple regions?](#does-cloud-run-support-load-balancing-among-multiple-regions)
  * [Can my application server run on HTTP/2 protocol?](#can-my-application-server-run-on-http2-protocol)
  * [Is gRPC supported on Cloud Run?](#is-grpc-supported-on-cloud-run)
  * [Are WebSockets supported on Cloud Run?](#are-websockets-supported-on-cloud-run)
- [Microservices](#microservices)
  * [How do two Cloud Run services connect each other privately?](#how-do-two-cloud-run-services-connect-each-other-privately)
  * [Does Cloud Run have DNS service discovery?](#does-cloud-run-have-dns-service-discovery)
- [Autoscaling](#autoscaling)
  * [Does my Cloud Run service scale to zero?](#does-my-cloud-run-service-scale-to-zero)
  * [How can I limit the total number of instances for my application?](#how-can-i-limit-the-total-number-of-instances-for-my-application)
  * [What’s the upper scaling limit for Cloud Run?](#whats-the-upper-scaling-limit-for-cloud-run)
- [Runtime](#runtime)
  * [Which operating system Cloud Run applications run on?](#which-operating-system-cloud-run-applications-run-on)
  * [Can I use the local filesystem?](#can-i-use-the-local-filesystem)
  * [Which system calls are supported?](#which-system-calls-are-supported)
  * [Which executable ABIs are supported?](#which-executable-abis-are-supported)
  * [Where can I find the "instance ID" of my container?](#where-can-i-find-the-instance-id-of-my-container)
  * [How can I find the number of instances running?](#how-can-i-find-the-number-of-instances-running)
  * [How can my service tell it is running on Cloud Run?](#how-can-my-service-tell-it-is-running-on-cloud-run)
  * [Is there a way to get static IP for outbound requests?](#is-there-a-way-to-get-static-ip-for-outbound-requests)
- [VPC Support](#vpc-support)
  * [Can I place my Cloud Run application inside a VPC network?](#can-i-place-my-cloud-run-application-inside-a-vpc-network)
  * [How to connect IPs in a VPC network from Cloud Run?](#how-to-connect-ips-in-a-vpc-network-from-cloud-run)
  * [Are VPC Service Controls supported for Cloud Run?](#are-vpc-service-controls-supported-for-cloud-run)
  * [Are "Shared VPCs" supported by VPC Access connector?](#are-shared-vpcs-supported-by-vpc-access-connector)
- [Monitoring and Logging](#monitoring-and-logging)
  * [Where do I write my application logs?](#where-do-i-write-my-application-logs)
  * [How can I have structured logs?](#how-can-i-have-structured-logs)
  * [Is Cloud Run integrated with Stackdriver APM?](#is-cloud-run-integrated-with-stackdriver-apm)
  * [How can I do Tracing on Cloud Run?](#how-can-i-do-tracing-on-cloud-run)
- [Pricing](#pricing)
  * [Is there a “Free Tier”?](#is-there-a-free-tier)
  * [When am I charged?](#when-am-i-charged)
  * [How is billed time calculated?](#how-is-billed-time-calculated)
  * [What do I pay for on Cloud Run?](#what-do-i-pay-for-on-cloud-run)

<!-- tocstop -->

-----

## Basics

### What is Cloud Run?

[Cloud Run][run] is a service by Google Cloud Platform to run your stateless
HTTP containers without worrying about provisioning machines, clusters or
autoscaling.

With Cloud Run, you go from a "container image" to a fully managed web
application running on a domain name with TLS certificate that auto-scales with
requests in a single command. You only [pay](#pricing) while a request is
handled.

### How is it different than App Engine Flexible?

[GAE Flexible](https://cloud.google.com/appengine/docs/flexible/) and [Cloud
Run][run] are very similar. They both accept container images as deployment input,
they both auto-scale, and manage the infrastructure your code runs
on for you. However:

* GAE Flexible is built on VMs, therefore is slower to deploy and scale.
* GAE Flexible does not scale to zero, at least 1 instance must be running.
* GAE Flexible billing has 1 minute granularity, Cloud Run in 0.1 second.
* GAE Flexible supports
  [Websockets](https://cloud.google.com/blog/products/application-development/introducing-websockets-support-for-app-engine-flexible-environment)
  in beta, unlike Cloud Run.

Read more about [choosing a container option on
GCP](https://cloud.google.com/container-options/).

### How is it different than Google Cloud Functions?

[GCF](https://cloud.google.com/functions) lets you deploy snippets of code
(functions) written in a limited set of programming languages, to natively
handle HTTP requests or events from many GCP sources.

Cloud Run lets you deploy using any programming language, since it accepts
container images (more flexible, but also potentially more tedious to develop).
It also allows using any tool or system library from your application (see
[here](#can-i-run-my-own-system-libraries-and-tools)) and GCF doesn’t let you
use such custom system executables.

Cloud Run can only receive HTTP requests or [Pub/Sub push events](https://cloud.google.com/pubsub/docs/push).
(See [this tutorial](https://cloud.google.com/run/docs/tutorials/pubsub)).

Both services auto-scale your code, manage the infrastructure your code runs on
and they both run on GCP’s serverless infrastructure.

Read more about [choosing between GCP's serverless options](https://cloud.google.com/serverless-options/#header_3)

### How does it compare to AWS Fargate?

[AWS Fargate](https://aws.amazon.com/fargate/) and Cloud Run both let you run
containers without managing the underlying infrastructure.

- Fargate can run a wide range of container workloads, including but not limited
  to HTTP servers, background or long running tasks.
- Fargate requires an ECS cluster to run tasks on. This cluster doesn't expose
  the underlying VM infrastructure to you. However, while using Fargate, you
  still need to configure infrastructure aspects like VPCs, subnets, load
  balancers, auto-scaling, health checks and service discovery.
- Fargate also has a fairly more complex resource model than Cloud Run, it
  doesn't allow request-based autoscaling, scale-to-zero, concurrency control,
  and it exposes container instances and their lifecycle to you.

Cloud Run is a standalone compute platform, abstracting cluster management and
focusing on fast automatic scaling. Cloud Run supports running only HTTP
servers, and therefore can do request-aware autoscaling, as well as
scale-to-zero.

The pricing model is also different:

- On Cloud Run, you only pay while a request is being handled.
- On AWS Fargate, you pay for CPU/memory while containers are running, and since
  Fargate doesn't support scale-to-zero, a service receiving no traffic will
  still incur costs.

### How does it compare to Azure Container Instances?

[Azure Container
Instances](https://azure.microsoft.com/en-us/services/container-instances/) and
Cloud Run both let you run containers without managing the underlying
infrastructure (VMs, clusters). Both ACI and Cloud Run give you a publicly
accessible endpoint after deploying the application.

Cloud Run supports running only HTTP servers and offers auto-scaling, and scale
to zero. ACI is
for long-running containers. Therefore, the pricing model is different. On Cloud
Run, you only pay while a request is being handled.

### What is "Cloud Run for Anthos"?

["Cloud Run for Anthos"][crogke] gives you the same Cloud Run experience on your
[Kubernetes](https://kubernetes.io) clusters on [Anthos] (either on GCP with
[GKE], or on-prem/other clouds). This gives you the freedom to choose where you
want to deploy your applications.

"Cloud Run" and "Cloud Run for Anthos" are the same product, but running in
different places:

* the same application format (container images)
* the same deployment/management experience (`gcloud` or Cloud Console)
* the same API ([Knative serving API][knative]).

Look at [this diagram](https://twitter.com/ahmetb/status/1116041166359654400),
or [**watch this video**](https://www.youtube.com/watch?v=RVdhyprptTQ) to decide
how to choose between the two.

![](https://storage.googleapis.com/gweb-cloudblog-publish/images/developer_and_operator.0316026505360460.max-700x700.png)

Cloud Run for Anthos basically installs and manages a Knative installation (with
some additional GCP-specific components for monitoring etc) on your Kubernetes
cluster so that you don’t have to worry about installing and managing Knative
yourself.

[knative]: https://www.knative.dev/
[GKE]: https://cloud.google.com/kubernetes-engine/
[Anthos]: https://cloud.google.com/anthos/

### Is Cloud Run a "hosted Knative"?

Sort of.

Cloud Run implements most parts of the [Knative Serving
API](https://www.knative.dev/docs/reference/serving-api/). However, the
underlying implementation of the functionality could differ from the open source
[Knative][knative] implementation.

With [Cloud Run for Anthos](#what-is-cloud-run-on-anthos), you actually get a
Knative installation (managed by Google) on your Kubernetes/[GKE] cluster

## Developing Applications

### Which applications are suitable for Cloud Run?

[Cloud Run][run] is designed to run **stateless** request-driven containers.

This means you can deploy:

* publicly accessible applications: web applications, APIs or webhooks
* private microservices: internal microservices, data transformation, background
jobs, potentially triggered asynchronously by Pub/Sub events or Cloud Tasks.

Other kinds of applications may not be fit for Cloud Run.

If your application is doing **processing while it’s not handling
requests** or storing in-memory state, it may not be suitable.

### What if my application is doing background work outside of request processing?

Your application’s CPU is **[significantly throttled][cpu]** nearly down to zero
while it's not handling a request.

Therefore, your application should limit CPU usage outside request processing to
a minimum. It might not be entirely possible since the programming language you
use might do _garbage collection_ or similar runtime tasks in the background.

### Which languages can I run on Cloud Run?

If an application can be packaged into a container image that can run on Linux
(x86-64), it can be executed on Cloud Run.

Web applications written in languages like Node.js, Python, Go, Java, Ruby, PHP,
Rust, Kotlin, Swift, C/C++, C# can work on Cloud Run. 

🍄 Users managed to run web servers written in x86 assembly, or [22-year old
Python
1.3](https://dev.to/di/ministry-of-silly-runtimes-vintage-python-on-cloud-run-3b9d)
on Cloud Run.

### Can I run my own system libraries and tools?

Yes, see the section above. Since Cloud Run accepts container images as the
deployment unit, you can add arbitrary executables (like `grep`, `ffmpeg`,
`imagemagick`) or system libraries (`.so`, `.dll`) to your container image and
use them in your application.

See [this tutorial](https://cloud.google.com/run/docs/tutorials/system-packages)
using Graphviz `dot` that generates PNG diagrams.

### Where do I get started to deploy a HTTP web server container?

See [Cloud Run
Quickstart](https://cloud.google.com/run/docs/quickstarts/build-and-deploy)
which has sample applications written in many languages.

### How do I make my web application compatible with Cloud Run?

Your existing applications must listen on the `PORT` environment variable to
work on Cloud Run (see [container contract][container-contract]). This
environment variable is given to your app by Cloud Run. It currently defaults to
`8080` (but you should not rely on this) and you can [customize this port
number](#customizing-port-number-on-cloud-run).

### Can Cloud Run receive events?

Yes.

Cloud Run integrates securely with Pub/Sub push subscriptions:

* Events are delivered via HTTP to the endpoint of your Cloud Run service.
* Pub/Sub automatically validates the ownership of the `*.run.app` Cloud Run
URLs 
* You can leverage [Pub/Sub push authentication](https://cloud.google.com/pubsub/docs/push#setting_up_for_push_authentication)
to securely and privately push events to Cloud Run services, without exposing
them publicly to the internet.

Many GCP services like Google Cloud Storage are able to [send events to a 
Pub/Sub topic](https://cloud.google.com/storage/docs/pubsub-notifications).
You can publish your own events to a Pub/Sub topic and push them to a Cloud
Run service.

Follow [this tutorial](https://cloud.google.com/run/docs/tutorials/pubsub) for
instructions about how to push Pub/Sub events to Cloud Run services.

### How to configure secrets for Cloud Run applications?

You can use [Secret Manager](https://cloud.google.com/secret-manager/docs/) with
Cloud Run. Read how to write code and set permissions to access the secrets from
your Cloud Run app in the
[documentation](https://cloud.google.com/secret-manager/docs/creating-and-accessing-secrets).

Alternatively, if you'd like to store secrets in Cloud Storage (GCS) using Cloud
KMS envelope encryption, check out the
[Berglas](https://github.com/GoogleCloudPlatform/berglas) tool and library
(Berglas also has support for Secret Manager).

### How can I have cronjobs on Cloud Run?

If you need to invoke your Cloud Run applications periodically, use
[Google Cloud Scheduler](https://cloud.google.com/scheduler/). It can make a
request to your application’s specific URL at an interval you specify.

### Can I mount storage volumes or disks on Cloud Run?

Cloud Run currently doesn’t offer a way to bind mount additional storage volumes
(like FUSE, or [persistent disks][pd]) on your filesystem. If you’re reading
data from Google Cloud Storage, instead of using solutions like `gcsfuse`, you
should use the supported Google Cloud Storage client libraries.

However, Cloud Run **for Anthos** allows you to mount Kubernetes [Secrets] and
[ConfigMaps], but **this is not yet fully supported**. See an example
[here][sec-ex] about mounting [Secrets] to a Service running on GKE.

[pd]: https://cloud.google.com/persistent-disk/
[vols]: https://cloud.google.com/kubernetes-engine/docs/concepts/volumes
[Secrets]: https://cloud.google.com/kubernetes-engine/docs/concepts/secret
[ConfigMaps]: https://cloud.google.com/kubernetes-engine/docs/concepts/configmap
[sec-ex]: https://knative.dev/docs/serving/samples/secrets-go/

## Deploying

### How do I continuously deploy to Cloud Run?

- A lot of CI/CD tutorials at [awesome-cloudrun repo](https://github.com/steren/awesome-cloudrun#cicd)
- Documentation: [Continuous Deployment using Google Cloud Build](https://cloud.google.com/cloud-build/docs/deploying-builds/deploy-cloud-run)
- Blog: [Deploy using GitLab CI/CD](https://viggy28.dev/article/cloudrun-cicd/)

_(If you know of articles about other CI/CD system integrations, add them here.)_

For other CI/CD systems, roughly the steps you should follow look like:

1. Create a new service account with a JSON key.
1. Give the service account [IAM permissions to deploy to Cloud Run](https://cloud.google.com/run/docs/reference/iam/roles).
      * `roles/run.admin` to deploy applications
      * `roles/iam.serviceAccountUser` on the service account that your app will use
      
1. Upload the JSON key to the CI/CD environment, and authenticate to `gcloud`
   by calling:

       gcloud auth activate-service-account --key-file=[KEY_JSON_FILE]

1. Deploy the app by calling:

       gcloud run deploy [MY_SERVICE] --image=[...] [...]

[gcb]: https://cloud.google.com/cloud-build/

### Which container registries can I deploy from?

Cloud Run currently only allows deploying images hosted on Google Container
Registry (`*.gcr.io/*`).

### How can I deploy from other GCR registries?

If you're deploying from GCR registries on another GCP project:

- public registries: should be deploying without additional configuration
- private registries: need to give GCR access to service account used by Cloud
  Run.

To give access, go to [IAM&Admin](https://console.cloud.google.com/iam-admin/iam) on
Cloud Console, and find the email for "Google Cloud Run Service Agent". Then
follow [this
document](https://cloud.google.com/container-registry/docs/access-control#granting_users_and_other_projects_access_to_a_registry)
to give this service account GCR access on the other project.

### How to do canary or blue/green deployments on Cloud Run?

If you updated your Cloud Run service, you probably realized it creates a new
[revision](https://cloud.google.com/run/docs/managing/revisions) for every new
configuration of your service.

Cloud Run allows you to [**split traffic** between multiple
revisions](https://cloud.google.com/run/docs/rollouts-rollbacks-traffic-migration),
so you can do gradual rollouts such as canary deployments or blue/green
deployments.

### How can I specify Google credentials in Cloud Run applications?

For applications running on Cloud Run, you don't need to deliver JSON keys for
IAM Service Accounts, or set `GOOGLE_APPLICATION_CREDENTIALS` environment
variable.

Just specify the service account (`--service-account`) you want your application
to use automatically while deploying the app. See [configuring service
identity][ident].

[ident]: https://cloud.google.com/run/docs/securing/service-identity

### Can I use `kubectl` to deploy to Cloud Run?

Cloud Run supports the [Knative][knative] Serving API. However, currently some
parts of Kubernetes Discovery API required by `kubectl` are not yet offered on
Cloud Run API.

As a solution, you can write your [Knative `Service`][ksvc] resource as a .yaml
file and use the following command to deploy to Cloud Run:

```sh
gcloud run services replace --platform=managed <file.yaml>
```

Since "Cloud Run for Anthos" runs [Knative][knative] natively, you can use
`kubectl` to deploy [Knative `Service`s][ksvc] to your GKE cluster by writing YAML
manifests and running `kubectl apply`. See Knative tutorials for more info.

[kubeconfig]: https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/
[ksvc]: https://www.knative.dev/docs/reference/serving-api/#Service

### Can I use Terraform to deploy to Cloud Run?

Yes. Terraform provides
[resources](https://www.terraform.io/docs/providers/google/r/cloud_run_service.html)
to define a Cloud Run deployment in Terraform. Also see [this blog
post](https://www.sethvargo.com/configuring-cloud-run-with-terraform/) and
[sample app](https://github.com/sethvargo/terraform-cloud-run-demo).

## Cold Starts

### Does Cloud Run have cold starts?

Yes. If a Cloud Run service does not receive requests for a long time, it will
take some time to start it again. This will add additional delay to the first
request.

Cold start latency depends on [many
factors](https://cloud.google.com/run/docs/tips#optimizing_performance), however
it is independent of the image size.

### When will my service scale to zero?

Cloud Run does not provide any guarantees on how long it will keep a service
"warm". It depends on factors like capacity and Google’s implementation
details.

### How do I minimize the cold start latencies?

See [performance optimization
tips](https://cloud.google.com/run/docs/tips#starting_services_quickly),
basically:

- minimize the number and size of the dependencies that your app loads
- keep your app’s "time to listen for requests" startup time short
- prevent your application process from crashing

(The size of your container image has almost no impact on cold starts).


### Do I get "warmup requests" like in App Engine?

Cloud Run does not have the notion of [App Engine warmup
requests](https://cloud.google.com/appengine/docs/standard/python/configuring-warmup-requests).
You can perform initialization of your application (such as loading data) until
you start listening on the port number.

Note that delaying the listening on the port number causes longer _cold starts_,
so consider [lazily
computing/fetching](https://cloud.google.com/run/docs/tips#performing_lazy_initialization_of_global_variables)
the data you need to reduce cold start latencies.

### How to keep a Cloud Run service “warm”?

You can work around "cold starts" by periodically making requests to your Cloud
Run service which can help prevent the container instances from scaling to
zero.

Use [Google Cloud Scheduler](https://cloud.google.com/scheduler) to make
requests every few minutes.

### How can I tell if a request was a “cold start”?

> **UPDATE:** Cloud Run no longer marks request logs with information
> about whether they caused a cold start or not.

~~Each request to Cloud Run services is logged to Stackdriver logging, with an
indicator whether instance was "warm" or "cold" during that request (see
[Viewing Logs][logging]).~~

[logging]: https://cloud.google.com/run/docs/logging

~~If you view logs from Cloud Run console, these requests are marked (and if you
view them in Stackdriver Logging, you can see the structured log label
indicating "cold" request):~~

![Cold Start Log](img/cold-start-log.png)

## Container Lifecycle

### How does Cloud Run tell if my container is ready?

Cloud Run starts sending traffic to your application once you start listening
on the port number (given to you via `PORT` environment variable).

### Does Cloud Run have readiness or liveness checks/probes?

Cloud Run does not offer user-configurable liveness checks or probes like
Kubernetes, as explained in previous question, the moment your server starts
listening on the port number, you indicate that your application is ready to
receive traffic.

### What happens if my container exits/crashes?

If the entrypoint process of a container exits, the container is stopped. A
crashed container triggers [cold start](#cold-starts) while the container is
restarted. Avoid exiting/crashing your server process by handling exceptions.
See [development tips](https://cloud.google.com/run/docs/tips#reporting_errors).

### What is the termination signal for Cloud Run services?

Currently, Cloud Run terminates containers while [scaling to
zero](#does-my-cloud-run-service-scale-to-zero) with unix signal 15 (`SIGTERM`).
`SIGTERM` is trappable (capturable) by applications. If handled, CPU is allocated 
for 10s max.


## Serving Traffic

### Which network protocols are supported on Cloud Run?

Cloud Run only supports HTTP/1.x and HTTP/2 (including gRPC) over TLS. Other
TCP and UDP based protocols are not supported. This means, you can't run your
arbitrary TCP based application, or a Redis/Memcached server on Cloud Run.

Also see: [HTTP/2](#is-http2-supported-on-cloud-run),
[gRPC](#is-grpc-supported-on-cloud-run)

### Customizing port number on Cloud Run?

Cloud Run now allows you to [customize which port
number](https://cloud.google.com/run/docs/configuring/containers#configure-port)
your application serves traffic on. This is for applications that cannot
change the server port by reading the `PORT` environment variable passed by
Cloud Run. (Upon customizing, `PORT` value will have the specified value.)

### What's the maximum request execution time limit?

Currently, a request times out after **15 minutes**. See [limits][lim].

### Does my service get a domain name on Cloud Run?

Yes, every Cloud Run service gets a `*.run.app` domain name for free. You can
also use [your domain names][custom-domains].

[custom-domains]: https://cloud.google.com/run/docs/mapping-custom-domains

### Are all Cloud Run services publicly accessible?

No. Cloud Run allows services to be either **publicly accessible** to anyone on
the Internet, or **private services** that require [authentication].

[authentication]: https://cloud.google.com/run/docs/securing/authenticating

### Can I run Cloud Run applications on a private IP?

Currently no. Cloud Run applications always have a `*.run.app` public hostname
and they cannot be placed inside a VPC (Virtual Private Cloud) network.

If any other private service (e.g. GCE VMs, GKE) needs to call your Cloud Run
application, they need to use this public hostname. However, despite you’re
making requests to public IP from a GCE VM in the same region (or possibly on
cross-region if you're on  GCP Premium network tier), the traffic won’t leave
Google’s own network.

### How much additional latency does running on Cloud Run add?

> TODO(ahmetb): Write this section. Ideally we should link to some blog posts
> doing an analysis of this.

### Does my application get multiple requests concurrently?

Contrary to most serverless products, Cloud Run is able to send multiple
requests to be handled
[simultaneously](https://cloud.google.com/run/docs/about-concurrency) to
your container instances.

Each container instance on Cloud Run is (currently) allowed to handle [up to
80][lim] concurrent requests. This is also the default value.

### What if my application can’t handle concurrent requests?

If your application cannot handle this number, you
can configure this number while deploying your service in `gcloud` or Cloud
Console.

Most of the popular programming languages can process multiple requests at the
same time thanks to multi-threading. But some languages may need additional
components to do concurrent requests (e.g. PHP with
[Apache](https://hub.docker.com/_/php), or Python with
[gunicorn](https://github.com/knative/docs/blob/7c4ff1c98e072b3c61649f35e6cafb11b00c6ab0/docs/serving/samples/hello-world/helloworld-python/Dockerfile#L11)).

[lim]: https://cloud.google.com/run/quotas

### How do I find the right concurrency level for my application?

Each application and language can process different levels of simultaneously
without having them time out. That's why Cloud Run allows you to
[configure](https://cloud.google.com/run/docs/about-concurrency) concurrency
per service.

You should do "load testing" to find out where your application should stop
handling additional request and additional instances should be created. Read
[Tuning concurrency](https://cloud.google.com/run/docs/tips#using_concurrency)
for more.

### Can I make request to a specific container instance?

No, Cloud Run does not offer a "sticky session" primitive. All requests are
load balanced between available container instances.

### Can I add Cloud Run services as backends to Cloud HTTP(S) Load Balancer?

**UPDATE (July 10, 2020):** Yes, [this is now in **beta**][neg].

You need to [add serverless network endpoint groups][neg-setup] behind a [Cloud
HTTP(S) Load Balancer (GCLB)][https-lb] to achieve this. The "serverless NEG" concepts
allows Cloud Run services to be added behind a load balancer, just like a VM
or GCS bucket.

[https-lb]: https://cloud.google.com/load-balancing/docs/https/
[neg]: https://cloud.google.com/load-balancing/docs/negs/serverless-neg-concepts
[neg-setup]: https://cloud.google.com/load-balancing/docs/negs/setting-up-serverless-negs

### How does Cloud Run’s load balancing compare with Cloud Load Balancer (GCLB)

Cloud Run applications [can be added][neg-setup] behind a [Cloud HTTP(s) load
balancer (GCLB)][https-lb]. However you might wonder, aren't Cloud Run endpoints
already _load-balanced_? Yes, they are.

However, GCLB offers a wide variety of options that you might need, such as:

- Support for configuring GCLB products like Cloud CDN and Cloud Armor (Cloud IAP is not yet supported)
- Routing to multiple backends (VM, GCS bucket, Run/GCF apps) on a single domain
- Bringing your own certificates
- Having a static IP (IPv4 or IPv6) for your domains

### How can I configure CDN for Cloud Run services?

Yes, see previous question. With  [Cloud HTTP(S) Load Balancer (GCLB)][https-lb] integration,
you need to add the Cloud Run service as a NEG to the load balancer.

You can also have CDN from other services if you don't want to use Cloud HTTP(S) Load Balancer:

- [Firebase Hosting](https://firebase.google.com/docs/hosting/) by:
  - responding to requests with a [`Cache-Control`
    header](https://firebase.google.com/docs/hosting/manage-cache#set_cache-control),
    and
  - configuring a [rewrite configuration in
    `firebase.json`](https://firebase.google.com/docs/hosting/cloud-run#direct_requests_to_container)
    of your Firebase app.

> **WARNING:** If you are using [Cloudflare](https://cloudflare.com/) with proxying
> capabilities, [follow the guide here](https://cloud.google.com/run/docs/mapping-custom-domains).

### Does Cloud Run offer SSL/TLS certificates (HTTPS)?

Yes. If you’re using the domain name provided by Cloud Run (`*.run.app`), your
application is immediately ready to serve on `https://` protocol.

If you’re using your own [custom domain] name, Cloud Run provisions a TLS
certificate for your domain name. This may take ~15 minutes to provision and
serve traffic on `https://`. Cloud Run uses [Let’s
Encrypt](https://letsencrypt.org/) to get a certificate for your domains.

[custom domain]: https://cloud.google.com/run/docs/mapping-custom-domains

### How can I use my own TLS certificates for Cloud Run?

When you use custom domain mapping feature of Cloud Run, it will provision a TLS
certificate for your domain. However, if you want to use custom features, check
out the [Cloud HTTP(S) Load Balancer (GCLB) integration][setup-neg].

### How can I redirect all HTTP traffic to HTTPS?

This is built in and required. To make Cloud Run secure by default, Cloud Run
services will only be accessible via HTTPS.

Any HTTP requests are automatically returned an HTTP 302 response pointing to
the HTTPS version of the current URL. This was rolled out as a change in the
beta service in August 2019.

### Is traffic between my app and Cloud Run’s load balancer encrypted?

Since your app serves traffic on `PORT` (by default 8080) unencrypted, you might
think the connection between Cloud Run’s load-balanced endpoint and your
application is unencrypted.

However, the transit between Google’s frontend/load balancer and your Cloud Run
container instance is encrypted. Google terminates TLS/HTTPS connections before
they reach your application, so that you don’t have to handle TLS yourself.

### Is HTTP/2 supported on Cloud Run?

Yes. Cloud Run’s gateway will upgrade any HTTP/1 server you write to HTTP/2. If
you query your application with `https://`, you should be seeing HTTP/2 protocol
used:

```
$ curl --http2 https://<url>
...
< HTTP/2 200
...
```

### Does Cloud Run support load balancing among multiple regions?

Not natively. Cloud Run services are regional. But it's possible to do it
yourself.

Using the [Cloud Load Balancer (GCLB)][setup-neg] integration, deploying your
service to multiple regions and adding them behind the load balancer, the
clients connecting to the load balancer IP/domain will be routed to the Cloud
Run service **closest** Cloud Run service to the client.

### Can my application server run on HTTP/2 protocol?

If you develop an app that **only** speaks HTTP/2, Cloud Run can still work with
that. However, note that Cloud Run requires your application
to serve on an **unencrypted** endpoint –and HTTP/2 by default requires TLS.

If your application can serve traffic unencrypted using the `h2c` (unencrypted
HTTP/2) protocol, the traffic between `user <=> Cloud Run <=> your app` can be
fully HTTP/2 without ever being downgraded to HTTP/1. (This is how gRPC works
on Cloud Run, after all.)

For example in Go, you can use https://godoc.org/golang.org/x/net/http2/h2c
package to force your HTTP server to serve on `h2c`. (See [this StackOverflow
answer for
more](https://stackoverflow.com/questions/61231930/can-i-have-my-cloudrun-server-receive-http-2-requests)).

### Is gRPC supported on Cloud Run?

Yes. Cloud Run (fully managed) can run [gRPC](https://grpc.io/) services with
[server-streaming RPCs](https://grpc.io/docs/guides/concepts/#server-streaming-rpc)
and send partial responses in a single request. Cloud Run also supports
[unary (non-streaming) RPCs](https://grpc.io/docs/guides/concepts/#unary-rpc). 

Since [Cloud Run for Anthos][crogke] runs on GCE networking stack, gRPC works
natively on that platform.

[crogke]: https://cloud.google.com/run/docs/gke/setup

### Are WebSockets supported on Cloud Run?

[WebSockets](https://en.wikipedia.org/wiki/WebSocket) are currently not
supported on Cloud Run fully managed.

However, running WebSockets currently works on [Cloud Run for Anthos][crogke]
because of its GCE-based native networking layer.

## Microservices

### How do two Cloud Run services connect each other privately?

To make requests to Cloud Run applications privately, you need to obtain an
identity token, and add it to the Authorization header of the outbound request
of the target service. You can find [documentation and examples
here](https://cloud.google.com/run/docs/authenticating/service-to-service)

### Does Cloud Run have DNS service discovery?

If you're using Kubernetes or similar systems, you might be used to calling
another service directly by name (e.g. `http://hello/`). However, Cloud Run does
not support this yet. Therefore you must use the full (`*.run.app`) URL.
However, this is subject to change soon.

## Autoscaling

### Does my Cloud Run service scale to zero?

Yes. When your service is not receiving requests, you are not paying for
anything.

Therefore, after not receiving any requests for a while, the first request may
observe [cold start](#cold-starts) latency.

### How can I limit the total number of instances for my application?

By setting the `Maximum number of instances` parameter when deploying a new revision.

### What’s the upper scaling limit for Cloud Run?

Each Cloud Run service can scale by default [up to 1000 container instances][lim], a limit that
can be increase via a quota request. Each container instance can handle [up to 80 simultaneous
requests][lim].

## Runtime

### Which operating system Cloud Run applications run on?

Linux.

However, since you bring your own container image, you get to decide
your system libraries like libs (e.g. musl libc in alpine, or glibc in debian
based images).

Your applications run on [gVisor](https://gvisor.dev/docs/) which only supports
Linux (currently).

### Can I use the local filesystem?

Yes, **however** files written to the local filesystem **count towards available
memory** and may cause container instance to go out-of-memory and crash.

Therefore, writing files to local filesystem are discouraged, with the exception
of [`/var/log/*` path for logging](https://cloud.google.com/run/docs/logging).

### Which system calls are supported?

Cloud Run applications run on [gVisor](https://gvisor.dev) container sandbox,
which executes Linux kernel system calls made by your application in userspace.

gVisor does not implement all system calls (see
[here](https://gvisor.dev/docs/user_guide/compatibility/amd64/)). If your app
has such a system call (**quite rare**), it will not work on Cloud Run. Such an
event [is logged](https://cloud.google.com/run/docs/troubleshooting#sandbox) and
you can [use
`strace`](https://cloud.google.com/run/docs/troubleshooting/tracing-system-calls)
to determine when the system call was made in your app.

### Which executable ABIs are supported?

Applications compiled for 64-bit Linux are supported. To be precise, ELF
executables compiled to [x84-64](https://en.wikipedia.org/wiki/X86-64). See
[Container Contract][container-contract].

[container-contract]: https://cloud.google.com/run/docs/reference/container-contract
[cpu]: https://cloud.google.com/run/docs/reference/container-contract#cpu


### Where can I find the "instance ID" of my container?

The [logs][logging] collected from a container instance specify the unique
instance ID of the container when the logs are viewed on Stackdriver Logging.
This instance ID is not made available to the application.

To identify your container instance while it’s running, generate a random UUID
during the startup of your process and store it in a variable.

### How can I find the number of instances running?

You can't see the number of instances running at a time on Cloud Run.

However, you can use the **Billable container instance time** metric on Cloud
Run service dashboard to infer this information.

Ideally you should not care about "instant value" of number of instances in a
serverless world, since your applications autoscale based on traffic patterns
better and you only pay while a request is being handled (not the idle instance
time).

### How can my service tell it is running on Cloud Run?

Cloud Run provides some [environment variables][container-contract] standard in
[Knative][knative]. Ideally you should explicitly deploy your app with an
environment variable indicating it is running on Cloud Run.

You can also access [instance
metadata](https://cloud.google.com/appengine/docs/standard/java/accessing-instance-metadata)
endpoints like
`http://metadata.google.internal/computeMetadata/v1/project/project-id` to
determine if you are on Cloud Run. However, this will not distinguish "Cloud
Run" vs "Cloud Run for Anthos" as the metadata service is available on GKE nodes
as well.

### Is there a way to get static IP for outbound requests?

Yes, this involves configuring a Cloud Router and Cloud NAT
for a VPC network and using VPC connector with your Cloud Run service.
Read [documentation](https://cloud.google.com/run/docs/configuring/connecting-vpc#egress)
and [follow setup guide](https://cloud.google.com/run/docs/configuring/static-outbound-ip).

## VPC Support

### Can I place my Cloud Run application inside a VPC network?

Cloud Run **can connect to** private IPs in VPC networks ([see
below](#how-to-connect-ips-in-a-vpc-network-from-cloud-run)).

However, you currently cannot place a Cloud Run app into a VPC so it can have a
private IP address to be accessible from only within the VPC (see
[here](#can-i-run-cloud-run-applications-on-a-private-ip)).

### How to connect IPs in a VPC network from Cloud Run?

Cloud Run **now has [beta support][vpc-doc]** for "Serverless VPC Access". This
feature allows Cloud Run applications to be able to connect private IPs in the
VPC (but not the other way).

This way your Cloud Run applications can connect to private VPC IP addresses
running:

- GCE VMs
- Cloud SQL instances
- Cloud Memorystore instances
- Kubernetes Pods/Services (on GKE public or private clusters)
- Internal Load Balancers

To learn more [read my blog post
here](https://ahmet.im/blog/cloud-run-vpc-to-kubernetes/) or [refer to the
official
documentation][vpc-doc].

[vpc-doc]: https://cloud.google.com/run/docs/configuring/connecting-vpc

### Are VPC Service Controls supported for Cloud Run?

[VPC-SC](https://cloud.google.com/vpc-service-controls) allows you to define
which endpoints your applications can connect to (to prevent exfiltration
risks).

However, Cloud Run applications currently cannot be placed inside a VPC network
(see [above](#can-i-place-my-cloud-run-application-inside-a-vpc-network)),
therefore this feature is currently not available.

### Are "Shared VPCs" supported by VPC Access connector?

[Currently
not](https://cloud.google.com/vpc/docs/configure-serverless-vpc-access).

## Monitoring and Logging

### Where do I write my application logs?

Anything your application writes to standard output (stdout) or standard error
(stderr) is collected as logs by Cloud Run.

Some existing apps might not be complying with that (e.g. nginx writes logs to
`/var/log/nginx/error.log`). Therefore any files written under `/var/log/*` are
also aggregated. [Learn more here][logging].

### How can I have structured logs?

All your log lines must be JSON objects with fields [recognized by Stackdriver
Logging](https://cloud.google.com/logging/docs/agent/configuration#special-fields),
such as `timestamp`, `severity`, `message`.

### Is Cloud Run integrated with Stackdriver APM?

Yes. See [this document](https://cloud.google.com/run/docs/monitoring) on how to
view various metrics about your Cloud Run container instances.

### How can I do Tracing on Cloud Run?

TODO(ahmetb): Write this section.

## Pricing

> [Cloud Run Pricing documentation][pricing] has the most up-to-date
> information.

[pricing]: https://cloud.google.com/run/pricing

### Is there a “Free Tier”?

Yes! See [Pricing documentation][pricing].

### When am I charged?

You only pay **while a request is being handled** on your container instance.

This means an application that is not getting traffic is **free of charge**.

### How is billed time calculated?

Based on "time serving requests" on each instance. If your service handles
multiple requests simultaneously, you do not pay for them separately. (This is a
**cost saver!**)

Each billable timeslice is **rounded up** to the nearest **100
milliseconds**.

Read how the [billable
time](https://cloud.google.com/run/pricing#billable_time) is calculated, it is
basically like this:

```
          request1            response1
                |   request2     ʌ      response2
                |        |       |       ʌ
                v........|......./       |
                         |               |
                         v.............../

|-----FREE-----|----------BILLED----------|----FREE...
```

### What do I pay for on Cloud Run?

You are paying for CPU, memory and the traffic sent to the client from your
application (egress traffic).

-----

This is not an official Google project or roadmap. Refer to the [Cloud Run
documentation][docs] for the authoritative information. This project is
[licensed](./LICENSE) under Creative common Attribution 4.0 International (CC BY
4.0) license.

> **Your question not answered here?** Open an [issue] and see if we can answer.
