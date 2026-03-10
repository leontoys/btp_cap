using workshop from '../db/schema';

@protocol: 'odata'
@path    : '/simple'
service Simple {
  @cds.redirection.target
  entity Products as projection on workshop.Products;
  entity Suppliers as projection on workshop.Suppliers;
  entity Orders    as projection on workshop.Orders;
  //function outOfStockProducts() returns many Products;
  entity outOfStockProducts as projection on workshop.Products[stock <= 0];
}

service Accounting {

  entity Valuations as projection on workshop.Products{
    ID as ProductID,
    name as ProductName,
    stock * price.amount as StockValue : Decimal,
    price.currency.name as Currency,
    supplier.company as Source
  };

}