//definition
using { liyon.db.master.employees } from '../db/datamodel';


service MyService {

    function helloworld(input:String) returns String;

    //I had to do cds deploy , only then cds w works
    entity EmployeeSrv as projection on employees;

}