using workshop from '../db/schema';

@protocol: 'odata'
@path    : '/simple'
service Simple {
  entity Products as projection on workshop.Products;
  entity Suppliers as projection on workshop.Suppliers;
    entity Orders    as projection on workshop.Orders;

}