using { API_BUSINESS_PARTNER } from './API_BUSINESS_PARTNER';

namespace s4.simple;

entity Customers as projection on API_BUSINESS_PARTNER.A_BusinessPartner {
  key BusinessPartner as ID,
  BusinessPartnerFullName as name
}