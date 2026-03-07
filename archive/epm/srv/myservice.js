

const cdsCompile = require("@sap/cds/lib/compile/cds-compile")
const SELECT = require("@sap/cds/lib/ql/SELECT")
const req = require("express/lib/request")

const cds = require('@sap/cds')
const { employees }  = cds.entities('liyon.db.master')

module.exports = (srv) => {
    
    srv.on('helloworld',(req,res)=>{
        return `Hello ${req.data.input}`
    })

    srv.on('READ','EmployeeSrv',async(req,res)=>{
        console.log('---reading employees my service---')
// Use the fluent QL API for better readability
        const results = await SELECT.from(employees).where({
            salaryAmount: { '>' : 200 }
        })
        console.log('---results---',results)

        return results
    })
}