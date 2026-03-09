using workshop from '../db/schema';

service Simple {
  entity Products as projection on workshop.Products;
  entity Suppliers as projection on workshop.Suppliers;
}