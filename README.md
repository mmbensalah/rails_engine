# RAILS ENGINE

Blog post outlining my thoughts on the project: https://medium.com/@mmbensalah/rails-engine-part-ii-2e63e6f24768

RailsEngine is the first week’s project of the third (of four) learning modules at Turing School of Engineering and Design. 

* Ruby version
    * 2.4.1 
* Rails version
    * 5.2.1

## Project Objective: 

1. Write a rake task to import CSV data for tables for Merchant, Customer, Invoice, Item, InvoiceItem, Transaction	
2. Build out index and show API endpoints for the above tables
3. Build out index/show API endpoints for the relationships between the tables i.e. “/api/v1/merchants/1/items will return all the items sold by merchant with id = 1
4. Utilize [Fast_JSONAPI](https://github.com/Netflix/fast_jsonapi) serializers to format the API outputs to the project specifications to comply with the JSON 1.0 spec.
5. Create Active Record queries to find the data requested by the project spec

## Getting Started: 
1. Clone down the project and run 
  1. `$ bundle`
  2. `$ rails db:{create,migrate}`	
  3. `$ rake import_csv`
  4. `$ rake :update_invoice_total`
2. Now you can run `rails s` from the terminal to visit all of the endpoints outlined below!
3. To run the test suite, execute `rspec`

## Endpoints: 

### Merchants: 

**Base Endpoints** 

`GET  /api/v1/merchants`                                                          
`GET  /api/v1/merchants/:id`

**Search Endpoints**

`GET  /api/v1/merchants/find`                                                      
`GET  /api/v1/merchants/find_all`      

**Relationship Endpoints**

`GET  /api/v1/merchants/:id/items`                                                 
`GET  /api/v1/merchants/:id/invoices`    
 
**Business Intelligence Endpoints**

`GET  /api/v1/merchants/most_revenue`                                              
`GET  /api/v1/merchants/most_items`                                                
`GET  /api/v1/merchants/revenue`       
 
### Customers:

**Base Endpoints** 

`GET  /api/v1/customers` 
`GET  /api/v1/customers/:id`  

**Search Endpoints**

`GET  /api/v1/customers/find`                                                          
`GET  /api/v1/customers/find_all`    

**Relationship Endpoints**

`GET  /api/v1/customers/:id/invoices`                                                  
`GET  /api/v1/customers/:id/transactions`    

### Items:

**Base Endpoints** 

`GET  /api/v1/items`                                                                  
`GET  /api/v1/items/:id` 

**Search Endpoints**

`GET  /api/v1/items/find`                                                             
`GET  /api/v1/items/find_all`   

**Relationship Endpoints**

`GET  /api/v1/items/:id/invoice_items`                                                 
`GET  /api/v1/items/:id/merchant`  

**Business Intelligence Endpoints**

`GET  /api/v1/items/most_revenue`                                                     
`GET  /api/v1/items/most_items`                                                      
`GET  /api/v1/items/:id/best_day`    

### Invoices: 

**Base Endpoints** 

`GET  /api/v1/invoices`                                                               
`GET  /api/v1/invoices/:id` 
 
**Search Endpoints**

`GET  /api/v1/invoices/find`                                                          
`GET  /api/v1/invoices/find_all`    
 
**Relationship Endpoints**

`GET  /api/v1/invoices/:id/transactions`                                             
`GET  /api/v1/invoices/:id/invoice_items`                                            
`GET  /api/v1/invoices/:id/items`                                                   
`GET  /api/v1/invoices/:id/customer`                                                
`GET  /api/v1/invoices/:id/merchant`     

### Invoice Items:

**Base Endpoints** 

`GET  /api/v1/invoice_items`                                                         
`GET  /api/v1/invoice_items/:id` 

**Search Endpoints**

`GET  /api/v1/invoice_items/find`                                                     
`GET  /api/v1/invoice_items/find_all`   
 
**Relationship Endpoints**

`GET  /api/v1/invoice_items/:id/item`                                                  
`GET  /api/v1/invoice_items/:id/invoice`       

### Transactions: 

**Base Endpoints** 

`GET  /api/v1/transactions`                                                           
`GET  /api/v1/transactions/:id`   
 
**Search Endpoints**

`GET  /api/v1/transactions/find`                                                       
`GET  /api/v1/transactions/find_all`   
 
**Relationship Endpoints**

`GET  /api/v1/transactions/:id/invoice`    
