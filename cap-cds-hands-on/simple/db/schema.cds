using Currency from './common';

namespace workshop;

type Price {
  amount   : Decimal;
  currency : Currency;
}

entity Products {
  key ID    : Integer;
      name  : String;
      stock : Integer;
      price : Price;
}