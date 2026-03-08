using workshop from '../db/schema';

service Simple {
  entity Products as projection on workshop.Products;
}