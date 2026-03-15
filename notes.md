# To compile CDL to DDL
cds compile db/schema.cds --to sql
cds compile db --to sql
- <field> : Assosciation to <entity> will create a field <field_key>,
- but when we do backlinking Association to <entity> on it won't create
- also association also won't create

# mixin
- key word for loose coupling , lazy loading, load data only when requested

# Steps to connect to sqlite db
- add { "cds": { "requires": {
   "db": {
      "kind": "sqlite",
      "credentials": { "url": "db.sqlite" } 
   }
}}}
- then do cds deploy
- connect using sql tools in BAS

# Steps to connect to HANA CLOUD DB during design time from BAS
- use booster to create sap hana cloud subscription and allow connection from all ips
- cf login
- cds add hana
- npm install
- cds build --production
- cds deploy --to hana:mickey
- cdsrc-private.jso contains connection details to container
- cds watch --hybrid profile

# To configure roles
- Application Security Descriptor Configuration Syntax
- https://help.sap.com/docs/SAP_HANA_PLATFORM/cf8b4c5847374960a68b55cb86eae013/6d3ed64092f748cbac691abc5fe52985.html?locale=en-US
- cds add xsuaa
- npm install
- copy and update xs-security.json
- create mock strategy and test users with roles in package.json

# Deploy App to Cloud
- cds add mta
- cds add xsuaa
- npm install
- right click and build mta
- right click and deploy mtar
- "cf dmol -i da518ead-0a08-11f1-af6d-eeee0a990376" to check logs
- cf logs <modulename> --recent
- get token url, append /oauth/token in, client id, secret from BTP and 
- call GET from POSTMAN tool using above
- Create role collection in BTP and assign to user
- cds bind -2 mycapapp-auth - to bind our local BAS dev to deployed BTP so that we can test locally

# App Router
- cd mycapapp/app to go inside app folder where we create app router
- npm init creates pacage.json
- npm install @sap/approuter
- in the package.json add start script ie, start : node node_modules/@sap/approuter/approuter.js
now we need to add config to tell app router about end points
- create xs-app.json inside (app) folder  and create routes inside
- in mta.yaml add ui module
- build mta.yaml and deploy we can do using cf deploy inside mta_archives folder
- we can add more users and give role collection and test

# Configure Identity Services
- Add Cloud Identity Services in instances and subscription
- https://bulkresizephotos.com/ for resizing logo
- To use buildworkzone it is mandadtory to use Cloud Identity 
- Create new user in User Management with different identity
- Establish Trust to new domain
- Give role collection to new user

# labeling
- i18n file to be created in db folder
- GEThttps://port4004-workspaces-ws-yebxs.us10.trial.applicationstudio.cloud.sap/liyon.po.managepo/index.html?sap-ui-language=ml

# Deploy Fiori App to Cloud
- add route to managepo in app router config 
- make sure mta.yaml has 'app' info
- do mta build and deploy

# Creating dev,qlt,prd
- Create qlt, prd spaces in subaccount
- Go to HANA Cloud instance -> configuration -> instance mapping -> 
manage configuration -> instance mapping -> sigin to cloud foundry
- A button 'add mapping' appears
- select the spaces and add mapping

# CI/CD
- Subscribe to Continuous Integration Delivery Service
- Grant the admin user CICD developer and admin roles
- Launch the service
- create credentials for btp a/c
- create credentials for github
- Now add github repo to be used for ci/cd
- generate webhook credentials in BTP, keep this safe, click on add
- from webhook data get payload url
- go to github repo->settings->webhook and give webhook url and credentials, make application/json
- the webhook in github repo will turn green if success
- create job in BTP, go to resources and give API endpoint, org, 

# Cloud Transport Service
- subscribe to CTS service - both subscription and instance
- add CTS admin role collection to your user 
- Create a new role collection to create approve/reject Transport request ie,To allow user to access the app
- ie,Go to security role collections - select Transport Operator - alm roles
- Create service key in instance of CTS
- and update that in CI service go to credentials in CI service
- Create destination for qlt and prod
- https://help.sap.com/docs/cloud-transport-management/sap-cloud-transport-management/create-transport-destinations?locale=en-US
- Note down domain, org guid, space guid
- Go to CTMS subscription and Configure landscape dev-qlt-prod 
- ie, Create nodes in CTMS for quality and prod and connect qlt to prod
- Enable the job to perform transport action in CI service
- Note : Retry 3 transport request
- domain - us10-001.hana.ondemand.com
- quality - 33350394-cd1c-49e6-8911-b8ad5dd8f5b2
- production - d5b37c77-09b4-45ec-952d-453571102e7d
- https://deploy-service.cf.us10-001.hana.ondemand.com/slprot/33350394-cd1c-49e6-8911-b8ad5dd8f5b2/slp
- https://deploy-service.cf.us10-001.hana.ondemand.com/slprot/d5b37c77-09b4-45ec-952d-453571102e7d/slp

# Serverless Fiori App
- create a new destination for CAPM srv. We have to create separate for dev,q and p 
- The type should be oAuth2UserTokenExchange
- Read client id, secret etc from mycap auth dev service bind
- test in Bas - user: mycapapp $ curl MyCapAppDest.dest
dial tcp: lookup MyCapAppDest.dest on 100.64.0.10:53: no such host
- Note - This started working the next day without any change

# Build Workzone
- watch video sap build workzone subscription failed
- create cloud identity services subscription
- create build workzone subscription
- it creates 2 entries for admin in user in the users section
- add launchpad roles to admin to use this service
- create site from buildwokrzone
- if you get error deploying, do it via cf CLI
- Site directory -> Channel manager and Refresh. This failed
- We can also add CAP ui apps manually
- Create catalog, group, role
- Add role to the user from user management

# Side by Side Extension
- https://github.com/SAP-samples/teched2023-AD264/tree/main/exercises/ex2
- https://learning.sap.com/courses/develop-extensions-with-cap-following-the-sap-btp-developer-s-guide/exercise-adding-an-external-service_d73e2e9b-3002-41dc-bb0b-b390048eaf4c
- https://developers.sap.com/tutorials/remote-service-intro.html
- https://community.sap.com/t5/technology-blog-posts-by-sap/develop-a-side-by-side-cap-based-extension-application-following-the-sap/ba-p/13720441
- https://community.sap.com/t5/technology-blog-posts-by-sap/how-to-build-side-by-side-extensions-for-sap-s-4hana-public-cloud-with-sap/ba-p/
- https://github.com/SAP-samples/btp-side-by-side-extension-learning-journey
- https://community.sap.com/t5/technology-blog-posts-by-sap/how-to-build-side-by-side-extensions-for-sap-s-4hana-public-cloud-with-sap/ba-p/14235644

# Git
- git reset . -> removes unstaged changes
- git clean -f -> removes untracked files

# Code Review
- https://github.com/SAP-samples/cap-cds-hands-on/tree/main/exercises/04 - In CAP, domain -> data element ->
field kind of definition is considered bad and instead keep it simple

# Handson
https://github.com/SAP-samples/cap-cds-hands-on
https://github.com/SAP-samples/cap-service-integration-codejam
- import edmx file and then do cds import it creates srv/external csn file for external service
- we can naively expose this service by just adding it in our service file and do cds run, but it gives error
- saying this has cds.persistance.skip as it is an external service and not translated to db. so we need to mock
- if we use cds watch , it mocks everything including external service so we get blank output instead of error
- this mocking we can check in the registry file .cds-services.json
- we can run cds mock external service --port 5005 and run cds w in another terminal, this will create
- separate mocking for external service at 5005 port and main service will be served from 4004
- so create a projection of the external service, and annotate and extend the main service using this
- using sap cloud sdk we delegate the request to the remote service running in a separate process


# TODO
- https://cap.cloud.sap/docs/get-started/learn-more#the-capire-documentation
- https://github.com/SAP-samples/teched2023-AD264
- https://github.com/SAP-samples/partner-reference-application
- https://github.com/SAP-samples/btp-cap-multitenant-saas
- https://github.com/SAP-samples/cloud-cap-hana-swapi
- https://learning.sap.com/courses?lsc_product=SAP+Cloud+Application+Programming+Model&page=1
- https://help.sap.com/docs/btp/btp-developers-guide/tutorials-for-sap-cloud-application-programming-model?locale=en-US
- https://discovery-center.cloud.sap/missionCatalog/?product=32&search=cap
