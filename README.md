# Deployment Ready CAP Application -  Incidents

Project is not about functionality but proper build and deployment configuration.

`npm i`

`npm run "cf-build"`

`npm run "cf-deploy"`

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

Added UI5 to mta.yaml as well to the xs-app.json of the Fiori applications.

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