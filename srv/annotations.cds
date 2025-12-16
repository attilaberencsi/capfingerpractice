using {
    ProcessorService as ProcessorService,
    AdminService     as AdminService
} from './services';

annotate ProcessorService.Incidents with @(UI: {

    HeaderInfo         : {
        TypeName      : 'Incident',
        TypeNamePlural: 'Incidents',
        Title         : {Value: title}
    },

    SelectionFields    : [
        ID,
        customer_ID,
        customer,
        title
    ],

    LineItem           : [
        {Value: title},
        {Value: customer},
        {Value: urgency_code},
        {Value: status_code},
        {Value: createdAt},
        {Value: createdBy}
    ],

    Identification     : [
        {Value: title},
        {Value: customer}
    ],

    Facets             : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Details',
            Target: '@UI.FieldGroup#Details'
        },
        {
            $Type          : 'UI.ReferenceFacet',
            ID             : 'Conversations',
            Label          : 'Conversations',
            Target         : 'conversation/@UI.LineItem'
        }

    ],

    FieldGroup #Details: {Data: [
        {Value: title},
        {Value: urgency_code},
        {Value: status_code},
        {Value: createdBy},
        {Value: createdAt}
    ]}
});


annotate ProcessorService.Incidents.conversation with @(UI: {
    LineItem           : [
        {Value: author},
        {Value: message},
        {Value: timestamp},
    ]   
});

annotate ProcessorService.Customers with @(UI: {
    HeaderInfo         : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Customer',
        TypeNamePlural: 'Customers',
        Title         : {Value: name}
    },

    LineItem           : [
        {Value: firstName},
        {Value: lastName},
        {Value: name},
        {Value: email},
        {Value: phone},
        {Value: creditCardNo}
    ],

    Identification     : [
        {Value: firstName},
        {Value: lastName}
    ],

    Facets             : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Details',
            Target: '@UI.FieldGroup#Details'
        },
        {
            $Type          : 'UI.ReferenceFacet',
            ID             : 'CustomerAddresses',
            Label          : 'Addresses',
            Target         : 'addresses/@UI.LineItem',
            TargetQualifier: ''
        }
    ],

    FieldGroup #Details: {Data: [
        {Value: email},
        {Value: phone},
        {Value: creditCardNo}
    ]}

});

annotate ProcessorService.Addresses with @(UI: {
    HeaderInfo         : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Address',
        TypeNamePlural: 'Addresses',
        Title         : {value: city}
    },

    LineItem           : [
        {Value: city},
        {Value: postCode},
        {Value: streetAddress}
    ],

    Identification     : [{Value: city}],

    Facets             : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'Details',
        Target: '@UI.FieldGroup#Details'
    }],

    FieldGroup #Details: {Data: [
        {Value: postCode},
        {Value: streetAddress}
    ]}
});

annotate AdminService.Incidents with @(UI: {

    HeaderInfo         : {
        TypeName      : 'Incident',
        TypeNamePlural: 'Incidents',
        Title         : {Value: title}
    },

    SelectionFields    : [
        ID,
        customer_ID,
        customer,
        title
    ],

    LineItem           : [
        {Value: title},
        {Value: customer},
        {Value: urgency_code},
        {Value: status_code},
        {Value: createdAt},
        {Value: createdBy}
    ],

    Identification     : [
        {Value: title},
        {Value: customer}
    ],

    Facets             : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Details',
            Target: '@UI.FieldGroup#Details'
        },
        {
            $Type          : 'UI.ReferenceFacet',
            ID             : 'Conversations',
            Label          : 'Conversations',
            Target         : 'conversation/@UI.LineItem'
        }

    ],

    FieldGroup #Details: {Data: [
        {Value: title},        
        {Value: urgency_code},
        {Value: status_code},
        {Value: createdBy},
        {Value: createdAt}
    ]}
});

annotate AdminService.Incidents.conversation with @(UI: {
    LineItem           : [
        {Value: author},
        {Value: message},
        {Value: timestamp},
    ]   
});

annotate AdminService.Customers with @(UI: {
    HeaderInfo         : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Customer',
        TypeNamePlural: 'Customers',
        Title         : {Value: name}
    },

    LineItem           : [
        {Value: firstName},
        {Value: lastName},
        {Value: name},
        {Value: email},
        {Value: phone},
        {Value: creditCardNo}
    ],

    Identification     : [
        {Value: firstName},
        {Value: lastName}
    ],

    Facets             : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Details',
            Target: '@UI.FieldGroup#Details'
        },
        {
            $Type          : 'UI.ReferenceFacet',
            ID             : 'CustomerAddresses',
            Label          : 'Addresses',
            Target         : 'addresses/@UI.LineItem',
            TargetQualifier: ''
        }
    ],

    FieldGroup #Details: {Data: [
        {Value: email},
        {Value: phone},
        {Value: creditCardNo}
    ]}

});

annotate AdminService.Addresses with @(UI: {
    HeaderInfo         : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Address',
        TypeNamePlural: 'Addresses',
        Title         : {value: city}
    },

    LineItem           : [
        {Value: city},
        {Value: postCode},
        {Value: streetAddress}
    ],

    Identification     : [{Value: city}],

    Facets             : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'Details',
        Target: '@UI.FieldGroup#Details'
    }],

    FieldGroup #Details: {Data: [
        {Value: postCode},
        {Value: streetAddress}
    ]}
});
