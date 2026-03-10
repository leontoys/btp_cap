const cds = require('@sap/cds')

class Simple extends cds.ApplicationService { 
  
  init() {

  const { Products, Suppliers, Orders } = this.entities('Simple')

  this.on ('outOfStockProducts', async (req) => {
    console.log('On outOfStockProducts', req.data)
    return await SELECT.from(Products).where({stock:0})
  })

  return super.init()
}}

module.exports = {Simple}