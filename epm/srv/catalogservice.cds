using { liyon.db.master, liyon.db.transaction } from '../db/datamodel';
using { cappo.cds.cdsviews } from '../db/cdsviews';

//by default the name comes up only till the next upper word
//so to give it exact name add annotation
service CatalogService @(path:'CatalogService',
                        requires:'authenticated-user') {


    entity EmployeeSet 
    @(restrict : [
        //{grant:['READ'],to:'Viewer',where:'bankName = $user.BankName'},
        {grant:['READ'],to:'Display',where:'bankName = $user.BankName'},//change to scope name
        {grant:['WRITE'],to:'Editor'}

    ])
    as projection on master.employees;

    entity AddressSet 
    @(restrict:[
        {grant:['READ'],to:'Viewer',where:'country = $user.Country'}
    ])
    as projection on master.address;

    entity BusinessParnterSet as projection on master.businesspartner;

    //entity ProductSet as projection on master.product;- need to revist the error

    entity POs as projection on transaction.purchaseorder{
        *,
        case overall_status
            when 'A' then 'Approved'
            when 'X' then 'Rejected'
            when 'N' then 'New'
            else 'Pending'
        end as overall_status_text : String(10),
        //icon
        case overall_status
        when 'A' then 3
        when 'X' then 2
        when 'N' then 2
        else 2
        end as overall_status_icon : Integer,
    }
    actions {
        //bound action as it bound to an instance of PO
        //we will get the IDs of the POs in our implementation
        action boost() returns POs
    }

    entity POItems as projection on transaction.poitems;

    entity ProductViewSet as projection on cdsviews.ProductView;

    //unbound function
    //to return multiple write array of
    function mostExpensiveOrder() returns POs

}
