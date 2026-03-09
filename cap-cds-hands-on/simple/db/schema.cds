using {Currency,
//cuid, 
//managed
} from '@sap/cds/common';

namespace workshop;

aspect cuid {
  key ID : Integer;
}

type Price {
  amount   : Decimal;
  currency : Currency;
}

entity Products : cuid, 
//managed 
{
  //key ID    : Integer;
      name  : String;
      stock : Integer;
      price : Price;
      supplier : Association to Suppliers;
}

entity Suppliers : cuid, 
//managed 
{
  //key ID      : Integer;
      company : String;
      products : Association to many Products
      on products.supplier = $self
}