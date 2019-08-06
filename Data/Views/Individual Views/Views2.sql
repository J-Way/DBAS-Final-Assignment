--The average and sum of the donations by address, postal code
-- needs working postal codes / can't really test at moment
CREATE OR REPLACE VIEW address_sum_avg AS 
    SELECT
        round(AVG(donation_amount),2) AS cur_avg
        , SUM(donation_amount) AS cur_sum
        , a.street_number
        , street_name
        , postal_code
    FROM
        fact_don      f
        INNER JOIN dim_address   a ON f.a_id = a.a_id
    GROUP BY
        CUBE(postal_code
        , street_number
        , street_name)
    ORDER BY
        street_name
        , street_number
        , postal_code;