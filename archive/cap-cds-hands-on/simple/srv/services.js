const cds = require('@sap/cds')

class Simple extends cds.ApplicationService { 
  
  init() {

  const { Products, Suppliers, Orders } = this.entities('Simple')

  this.on ('outOfStockProducts', async (req) => {
    console.log('On outOfStockProducts', req.data)
    //return await SELECT.from(Products).where({stock:0})
  })


    this.on('applyDiscount', async (req) => {
      const result = await UPDATE(req.subject)
        .set`price_amount = price_amount * ${req.data.percent / 100}`
      if (!result) return failed(req)
      return await SELECT.columns`price_amount`.from(req.subject)
    })  

  return super.init()
}}

module.exports = {Simple}