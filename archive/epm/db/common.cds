namespace liyon.common;
using { Currency } from '@sap/cds/common';


//enumerator
type Gender : String(1) enum{
    male = 'M';
    female = 'F';
    undisclosed = 'U'
};

//as we have an amount field like salary amount
//we are telling its corresponding unit is currency_code
//which will be created via the code list
type AmountT : Decimal(10, 2)@(
    Semantics.amount.currencyCode : 'CURRENCY_CODE',
    sap.unit : 'CURRENCY_CODE'
);

type Amount : {
    currency : Currency;
    gross_amount : AmountT @title : 'Gross Amount';
    net_amount : AmountT @title : 'Net Amount';
    tax_amount : AmountT @title : 'Tax Amount'
}

type PhoneNumber : String(30);

type Email : String(255);

type Guid : String(32);
