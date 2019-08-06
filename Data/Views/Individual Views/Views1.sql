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
