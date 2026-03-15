using { cuid, managed } from '@sap/cds/common';


namespace incidents.mgt;

entity Incidents : cuid,managed {
    title : String;
}