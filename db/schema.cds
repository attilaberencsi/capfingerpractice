using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';

namespace sap.capire.incidents;

/**
* Incidents created by Customers.
*/
entity Incidents : cuid, managed {
    customer     : Association to Customers @title: 'Customer';
    title        : String                             @title: 'Title';
    urgency      : Association to Urgency default 'M' @title: 'Urgency';
    status       : Association to Status default 'N'  @title: 'Status';
    conversation : Composition of many {
                       key ID        : UUID @title: 'ID';
                           timestamp : type of managed : createdAt @title: 'Date / Time';
                           author    : type of managed : createdBy @title: 'Author';
                           message   : String @title: 'Message';
                   };
}

/**
* Customers entitled to create support Incidents.
*/
entity Customers : managed {
    key ID           : String;
        firstName    : String       @title: 'First Name';
        lastName     : String       @title: 'Last Name';
        name         : String = trim(firstName || ' ' || lastName) @title: 'Full Name';
        email        : EMailAddress @title: 'eMail';
        phone        : PhoneNumber  @title: 'Pone';
        incidents    : Association to many Incidents
                           on incidents.customer = $self;
        creditCardNo : String(16)   @assert.format: '^[1-9]\d{15}$'  @title: 'Credit Card Number';
        addresses    : Composition of many Addresses
                           on addresses.customer = $self;
}

entity Addresses : cuid, managed {
    customer      : Association to Customers @title: 'Customer';
    city          : String @title: 'City';
    postCode      : String @title: 'Postal Code';
    streetAddress : String @title: 'Street Address';
}

entity Status : CodeList {
    key code        : String @title: 'Code' enum {
            new = 'N';
            assigned = 'A';
            in_process = 'I';
            on_hold = 'H';
            resolved = 'R';
            closed = 'C';
        };
        criticality : Integer;
}

entity Urgency : CodeList {
    key code : String @title: 'Code' enum {
            high = 'H';
            medium = 'M';
            low = 'L';
        };
}

type EMailAddress : String;
type PhoneNumber  : String;
