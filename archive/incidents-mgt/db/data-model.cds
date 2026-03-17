using {
    cuid,
    managed
} from '@sap/cds/common';
using {sap.common.CodeList} from '@sap/cds/common';

namespace incidents.mgt;

entity Incidents : cuid, managed {
    title        : String(100) @title : 'Title'; 
    conversations : Composition of many Conversations
                       on conversations.incidents = $self;
    urgency   : Association to Urgency;
    status    : Association to Status;
}

entity Conversations : cuid, managed {
    timestamp : DateTime;
    author    : String(100);
    message   : String;
    incidents : Association to Incidents;
}

entity Status : CodeList {
    key code : String;
}

entity Urgency : CodeList {
    key code : String;
}
