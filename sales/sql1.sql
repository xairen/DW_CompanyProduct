select customer.name, customer.addr1, customer.addr2, customer.city, customer.state, customer.zip, 
invoicehdr.invoiceID, invoicehdr.salesDate
from customer join invoicehdr on customer.customerID = invoicehdr.customerID
join invoicedtl on invoicedtl.invoiceID = invoicedtl.invoiceID 
join product on invoicedtl.prodID = product.prodID where customer.name ="Scp Pool Corp";