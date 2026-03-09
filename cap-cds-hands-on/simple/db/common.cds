type Currency : Association to sap.common.Currencies;

context sap.common {
    
    entity Currencies : CodeList {
        key code : String(3);
            symbol : String(5);
            minorUnit : Int16;
    }

    aspect CodeList{
        name : String(255);
        descr : String(1000);
    }
}