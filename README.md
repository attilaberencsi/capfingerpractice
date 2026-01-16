# Deployment Ready CAP Application -  Incidents

Project is not about functionality but proper build and deployment configuration.

`npm i`

`npm run "cf-build"`

`npm run "cf-deploy"`

## Common implementation steps

1. cds init
2. npm i
3. add file db/schema.cds
4. cds add hana --for production
5. add srv/services.cds
6. cds add xsuaa --for production
7. cds add workzone-standard
8. cds add mta
  1. Rename srv-api destination name to <meaningful-name>-srv-api (see below), which will be used in xs-app.json
  2. Remove unnecessary app-deployer dependencies under requires (see below)
  3. Add readiness health check (see below)
  4. Remove app-runtime, when no multitenancy or other BTP reuse services are incorporated
  5. add disk and memory quota
  6. exclude node_modules from packing
9. add role collections to xs-security.json or better to mta.yaml, which is not get overwritten/wipes and more flexible
10. Use Fiori Application Generator
11. mbt build
12. deploy

## MTA Configuration Remarks

### Readiness health check

Built in UP check provided by CAP Node.js. Used by CF to send requests to UP instances only, otherwise they are out from queue processing. 

Reason: UP <> STARTED.

```plaintext
  readiness-health-check-type: http
  readiness-health-check-http-endpoint: /health
```

### HTML5 Runtime

Not needed, due no multitenancy, no dynamic access through destinations, no special BTP reuse application components and services are incorporated.

```plaintext
  - name: incident-management-app-deployer
    type: com.sap.application.content
    path: gen
    requires:
      - name: incident-management-html5-repo-host
        parameters:
          content-target: true
          # Use when multitenancy/dynamic repo access is required          
          # config:
          #   HTML5Runtime_enabled: true   
```

```plaintext
  # Use when multitenancy/dynamic repo access is required
  # - name: incident-management-html5-runtime
  #   type: org.cloudfoundry.managed-service
  #   parameters:
  #     service: html5-apps-repo
  #     service-plan: app-runtime
```

### Frontend Deployment

Auth dependency is not required. Managed AppRouter does not need UAA, would just result in duplicate HTML5 Applications by destination GUID and Name.

[https://userapps.support.sap.com/sap/support/knowledge/en/3494998](https://userapps.support.sap.com/sap/support/knowledge/en/3494998)

```plaintext
# FRONTEND
  - name: incident-management-app-deployer
    type: com.sap.application.content
    path: gen
    requires:
      - name: incident-management-html5-repo-host
        parameters:
          content-target: true
          # Use when multitenancy/dynamic repo access is required          
          # config:
          #   HTML5Runtime_enabled: true          
    # NO srv-api
    # NO incident-management-auth
```

### Destinations

Renamed destination srv-api to incident-management-srv-api, so this has to be used in xs-app.json. Fiori Application Generator wizard provides to use that destination for deployment.

The best is to generate mta.yaml before using Fiori Application Generator, so that this is automatic, otherwise adding UI5 destination to mta.yaml as well to the xs-app.json of the Fiori applications is a manual task. 

```plaintext
  # DESTINATION
  - name: incident-management-destination
    type: org.cloudfoundry.managed-service
    parameters:
      service: destination
      service-plan: lite
      config:
        HTML5Runtime_enabled: true        
        init_data:
          instance:
            existing_destinations_policy: update
            destinations:
              # xs-app.json: "destination": "incident-management-srv-api",                
              - Name: incident-management-srv-api
                URL: "~{srv-api/srv-url}"
                Authentication: NoAuthentication
                Type: HTTP
                ProxyType: Internet
                HTML5.ForwardAuthToken: true
                HTML5.DynamicDestination: true
              # xs-app.json: "destination": "ui5"  
              - Name: ui5
                URL: "https://ui5.sap.com"
                Authentication: NoAuthentication
                Type: HTTP
                ProxyType: Internet
```

```json
    {
      "source": "^/resources/(.*)$",
      "target": "/resources/$1",
      "authenticationType": "none",
      "destination": "ui5"
    },
    {
      "source": "^/test-resources/(.*)$",
      "target": "/test-resources/$1",
      "authenticationType": "none",
      "destination": "ui5"
    },
```

### Disk and Memory Quota

Default is 1GB. To save costs use less when not needed. If your service doing mass processing via jobs, or handling big batches You need to increase most probably.

```plaintext
  parameters:
    buildpack: nodejs_buildpack
    readiness-health-check-http-endpoint: /health
    readiness-health-check-type: http
    disk-quota: 512M
    memory: 512M  
```

### Ignore adding node_modules folder of your workspace into the build

Actually it is not needed. During the deployment, after mtar upload is done, the node module installation takes place on BTP anyway based on the package.json. So node_mosules in your workspace has nothing to do with it. So you can reduce mtar file from 20MB to 173 KB and the time needed to upload your mtar will be less than a second.

```plaintext
    build-parameters:
      ignore:
        - "node_modules/"
```