const cds = require('@sap/cds')

module.exports = class CatalogService extends cds.ApplicationService { init() {

  const { Books } = cds.entities('CatalogService')

  this.before (['CREATE', 'UPDATE'], Books, async (req) => {
    console.log('Before CREATE/UPDATE Books', req.data)
  })
  this.after ('READ', Books, async (books, req) => {
    console.log('After READ Books', books)
  })

  // Action handler for submitOrder
  this.on ('submitOrder', async req => {
    let { book:id, quantity } = req.data
    let affected = await UPDATE (Books,id)
      .with `stock = stock - ${quantity}`
      .where `stock >= ${quantity}`
    if (!affected) req.error `${quantity} exceeds stock for book #${id}`
  })
  return super.init()
}}
