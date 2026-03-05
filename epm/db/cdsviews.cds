namespace cappo.cds;

//creates alias from the last dot ie, master and transaction
using { liyon.db.master, liyon.db.transaction  } from './datamodel';

context cdsviews {
    //for dbs to respect the case, we need to put the names in ![]
    //in sqlite it works without this
    define view ![POWorklist] as 
        select from transaction.purchaseorder {
            key po_id as ![PurchaseOrderId],
            key items.po_item_pos as ![ItemPosition],
            partner_guid.bp_id as ![ParnterId],
            partner_guid.company_name as ![CompanyName],
            gross_amount as ![GrossAmount],
            net_amount as ![NetAmount],
            tax_amount as ![TaxAmount],
            currency as ![CurrencyCode],
            overall_status as ![Status],
            items.product_guid.product_id as ![ProductId],
            items.product_guid.description as ![ProductName],
            partner_guid.address_guid.city as ![City],
            partner_guid.address_guid.country as ![Country]
        };

        define view ![ProductValueHelp] as 
        select from master.product{
            product_id as ![ProductId],
            description as ![Description]
        };

        //added key to Item View , parent key and product guid for this to work
        define view ![ItemView] as 
        select from transaction.poitems{
            key parent_key.partner_guid.node_key as ![CustomerId],
            key product_guid.node_key as ![ProductId],
            currency as ![CurrencyCode],
            gross_amount as ![GrossAmount],
            net_amount as ![NetAmount],
            tax_amount as ![TaxAmount],
            parent_key.overall_status as ![Status]
        };

        //mixin - lazy loading - it will load dependent view only on demand
        define view ProductView as select from master.product
        mixin{
            //view on view, we can also give Association to [*]
            //left side refers to item view above, and right side refers to the list of fields below
            po_order : Association to many ItemView on po_order.ProductId = $projection.ProductId
        }
        into{
            node_key as ![ProductId],
            description as ![Description],
            category as ![Category],
            price as ![Price],
            supplier_guid.bp_id as ![SupplierId],
            supplier_guid.company_name as ![SupplierName],
            supplier_guid.address_guid.city as ![City],
            supplier_guid.address_guid.country as ![Country],
            //exposed assosciation @runtime data will be loaded on demand lazy loading  
            po_order as ![To_Items]
        }

        define view CProductValuesView as 
        select from ProductView{
            ProductId,
            Country,
            round(sum(To_Items.GrossAmount),2) as ![TotalPurchaseAmount] : Decimal(10,2),
            To_Items.CurrencyCode as ![CurrencyCode]
        } group by ProductId,Country, To_Items.CurrencyCode;
}