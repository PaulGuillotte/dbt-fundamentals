with orders as (
    SELECT * FROM  {{ ref('stg_orders') }}
),

payments as (
    SELECT * FROM  {{ ref('stg_payments') }}
),

order_payments as (
    SELECT
        order_id,
        SUM(CASE WHEN status = 'success' THEN amount END) AS amount
    FROM payments
    GROUP BY 1
),

final as (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_date,
        coalesce(op.amount, 0) AS amount
    FROM orders o LEFT JOIN order_payments op ON o.order_id = op.order_id
)

SELECT * FROM final