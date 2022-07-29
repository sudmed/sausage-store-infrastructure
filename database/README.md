### CREATE INDEX for 'order_product' table
`CREATE INDEX idx_order_product_id ON order_product (order_id);`  
`CREATE INDEX idx_order_product_product_id ON order_product (product_id);`

### CREATE INDEX for 'product' table
`CREATE INDEX idx_product_id ON product (id);`  
`CREATE INDEX idx_product_name ON product (name);`  
`CREATE INDEX idx_product_price ON product (price);`  

### CREATE INDEX for 'orders' table
`CREATE INDEX idx_orders_id ON orders (id);`  


### the database query:
```sql
select COUNT(*) from orders o INNER JOIN order_product op ON o.id = op.order_id INNER JOIN product p ON op.product_id = p.id WHERE p.id = 4;`
```

### Execution time
**before:**   `Time: 18527.650 ms (00:18.528)`  
**after:**    `Time: 10987.890 ms (00:10.988)`
