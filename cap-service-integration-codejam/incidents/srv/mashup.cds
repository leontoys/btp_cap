using { IncidentsService } from './incidents-service';
using { s4 } from './external';

extend service IncidentsService with {
  entity Customers as projection on s4.simple.Customers;
}