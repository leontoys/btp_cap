const cds = require('@sap/cds')
module.exports = cds.service.impl(async function () {
    //objects of entities we can read
    //console.log(this.entities)
    const { EmployeeSet, POs } = this.entities;

    this.before('UPDATE', EmployeeSet, (req, res) => {
        console.log('---before update---', req.data)
        const { salaryAmount } = req.data
        if (parseFloat(salaryAmount) >= 100000) {
            req.error(500, "Hello Mate! Salary cannot be above 1 million")
        }
    })

    this.before('READ', EmployeeSet, async (req) => {
        console.log("---Before reading---User Attributes:---", req.user.attr);
    })

    this.after('READ', EmployeeSet, (req, res) => {
        console.log('---after read---', JSON.stringify(res?.results))
        if (res?.results) {
            for (let index = 0; index < res?.results.length; index++) {
                const element = res?.results[index];
                //Remember - this only changes in the read, not in the db
                element.salaryAmount = element?.salaryAmount * 10

            }
        }

    })

    this.on('mostExpensiveOrder', async (req, res) => {
        console.log(JSON.stringify(req))
        try {
            //create new transaction object to talk to db
            const tx = await cds.tx(req);

            //use tx to read data
            const result = await tx.read(POs).orderBy({
                gross_amount: 'DESC'
            }).limit(1)

            return result

        } catch (error) {
            console.error(error)
            return 'Server Error'
        }
    })

    this.on('boost', async (req, res) => {
        try {
            console.log(req.params)

            //check authorization programatically
            req.user.is('Editor') || req.reject(403)

            const id = req.params[0]
            const tx = await cds.tx(req)
            await tx.update(POs).with({
                'gross_amount': { '+=': 2000 }
            }).where(id)
            let result = await tx.read(POs).where(id)
            return result

        } catch (error) {
            console.error(error)
            return 'Server Error'
        }
    })
}) 