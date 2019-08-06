-- VIEW 1
--The average and sum of the donation by day, month, year
CREATE OR REPLACE VIEW time_sum_avg AS 
SELECT
    round(AVG(f.donation_amount), 2) AS cur_avg
    , SUM(f.donation_amount) AS cur_sum
    , don_day
    , don_month
    , don_year
FROM
    (
        SELECT
            d_id AS don_id
            , EXTRACT(DAY FROM(donation_date)) AS don_day
            , EXTRACT(MONTH FROM(donation_date)) AS don_month
            , EXTRACT(YEAR FROM(donation_date)) AS don_year
        FROM
            dim_date
        GROUP BY (
            donation_date
            , d_id
        )
    )
    INNER JOIN fact_don f ON f.d_id = don_id
GROUP BY
    CUBE(don_day
    , don_month
    , don_year)
ORDER BY
    don_year
    , don_month
    , don_day;

-- VIEW 2
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

-- VIEW 3        
--The average and sum of the donations by volunteer and volunteer group leader
-- CONNECT BY PRIOR MIGHT HAVE A USE HERE, COMPLAINS ABOUT RECURSION HOWEVER
CREATE OR REPLACE VIEW volunteer_sum_avg AS
SELECT
    round(AVG(donation_amount), 2) AS cur_avg
    , sum(donation_amount) AS cur_sum
    , first_name
    , last_name
    , group_leader
FROM
    fact_don        f
    INNER JOIN dim_volunteer   v ON v.v_id = f.v_id
GROUP BY
    ROLLUP(
        group_leader
    , (first_name
    , last_name)
    )
ORDER BY
    group_leader;