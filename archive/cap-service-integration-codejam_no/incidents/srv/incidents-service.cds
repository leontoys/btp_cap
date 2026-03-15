using { acme.incmgt } from '../db/schema';
//using { API_BUSINESS_PARTNER as external } from './external/API_BUSINESS_PARTNER';


service IncidentsService {
  //entity Customers as projection on external.A_BusinessPartner;
  entity Incidents      as projection on incmgt.Incidents;
  entity Appointments   as projection on incmgt.Appointments;
  entity ServiceWorkers as projection on incmgt.ServiceWorkers;
}
