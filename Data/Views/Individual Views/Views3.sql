--The average and sum of the donations by volunteer and volunteer group leader
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