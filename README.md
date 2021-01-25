# SoftwareAG containers

This repository contains templates to build containers for some **SoftwareAG webMethods** products:
- Asset Build Environment
- API Gateway
- Broker
- Command Central
- Integration Server
- Microservices Runtime
- My webMethods Server
- Terracotta BigMemory Max
- Universal Messaging

It is inspired by the general layout and samples provided in the [SoftwareAG/sagdevops-templates](https://github.com/SoftwareAG/sagdevops-templates) repository, cleaned and simplified. Container images aim to be **production-ready** as much as possible, or to be used as stable base images to build upon. At this time, they have only been tested with the webMethods 10.5 release.

These tools are provided as-is and without warranty or support. They do not constitute part of the Software AG product suite, and are not endorsed by SoftwareAG. Users are free to use, fork and modify them, subject to the license agreement.

## Prerequisites

To build and run container images, make sure to install [Docker](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/) and have sufficient RAM available.

You will also need Empower credentials with access to the products you want to build, as well as valid license files in XML format.

## Building

### Infrastructure images

Go to the `infrastructure` directory and prepare your environment:

- Edit the `.env` file to fill in your Empower credentials (be careful, never commit them to GitHub!). Alternatively, you may also set them in your terminal or CI tool with `export REPO_USERNAME=your-username` and `export REPO_PASSWORD=your-password`.
- In the `cc-builder/target/licenses` subdirectory, create a `product_licenses.zip` file containing your license XML files. Alternatively, you may also set a `LICENSES_URL` environment variable to have it downloaded automatically during the build.

Then execute `docker-compose build` from the `infrastructure` directory to build 3 images:

- `base`: a simple CentOS 7 base layer with the `/opt/softwareag` install directory and `sagadmin` system user.
- `java`: an image with the JVM provided with SoftwareAG products, built on top of the `base` image. This image is used to share the JVM layer between subsequent product images.
- `cc-server`: this image includes Command Central and Platform Manager (SPM) in `/opt/sagtools`, which allow installing additional products according to templates.
- `cc-node`: this image contains an initial `/opt/softwareag` directory with infrastructure components such as the JVM, shared libraries and SPM.
- `cc-builder`: this image includes both previous images, with Command Central and Platform Manager (SPM) in `/opt/sagtools`, and a base installation directory in `/opt/softwareag`. Upon build, product/fix repositories and licenses will be automatically added to Command Central.

Once these images are built successfully, you may proceed with building individual product images.

### Product images

Go to the `containers` directory and execute `docker-compose build <product>` to create an image for one of the following products:

- `hello-world`: a simple Hello World showing build arguments and environment variables.
- `abe`: Asset Build Environment
- `apigw`: API Gateway
- `broker`: Broker Server
- `ids`: Internal Data Store (Elasticsearch)
- `is`: Integration Server (with CloudStreams, JDBC and Kafka Adapters)
- `msr`: Microservices Runtime (with CloudStreams, JDBC and Kafka Adapters)
- `mws`: My webMethods Server
- `tmc`: Terracotta Management Console
- `tsa`: Terracotta BigMemory Max
- `um`: Universal Messaging

Each directory contains a `Dockerfile` using multi-stage build to provision the product using the `cc-builder` image and a `builder/template.yaml` file, then copy the installation directory on top of the `java` image. The latest fixes are applied by default. The `target/entrypoint.sh` script starts the main product runtime.

Please refer to each `README.md` file for more details about ports, environment variables, volumes and useful links.

For more information about Command Central templates, please see the [official documentation](https://documentation.softwareag.com/webmethods/command_central/cce10-5/10-5_Command_Central_webhelp/index.html).

### Using Continuous Integration (CI) tools

Popular CI tools such as GitLab, Jenkins, or GitHub Actions can also be setup to build and push the images automatically whenever a commit is made.

Examples are provided for GitLab (see `.gitlab-ci.yml`) and GitHub Actions (see `.github/workflows/ci.yml`).

## Running

Once a product image is built, you may run it anywhere with Docker or container orchestration tools like Kubernetes. You will also probably want to build additional images on top of it, e.g. to customize configuration, add files, or add packages on Integration Server.

To test them locally, go to the `containers` directory and execute `docker-compose up -d <product>` with the same product names as described above. Refer to the `docker-compose.yml` file to see which ports are available.

You may also start the Command Central container with `docker-compose up -d cc`. If you start it before other containers, and if you set environment variable `CC_AUTO_REGISTER=1`, each product container will automatically register to it during startup. This can be useful to inspect the various configuration parameters supported by each product and export this configuration to YAML templates.
