const cds = require('@sap/cds')

module.exports = cds.service.impl (async function() {
    const S4bupa = await cds.connect.to('API_BUSINESS_PARTNER')

    this.on('READ', 'Customers', (req) => {
      console.log('>> delegating to remote service...')
      return S4bupa.run(req.query)
    })
})

