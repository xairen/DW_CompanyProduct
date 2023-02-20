SELECT businessunit.name, sum(product.price2) as 'sales', businessunit.abbrev, invoicehdr.salesDate
from businessunit join prodtype on businessunit.BUID = prodtype.BUID
join product on prodtype.prodTypeID = product.prodTypeID
join invoicedtl on product.prodID = invoicedtl.prodID
join invoicehdr on invoicedtl.invoiceID = invoiccustomerehdr.invoiceID;