SELECT 
    id  as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status,
    amount/100 AS amount, -- converted from cents to dollars
    created as created_at,
FROM dbt-tutorial.stripe.payment