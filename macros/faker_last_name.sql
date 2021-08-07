{% macro faker_last_name(
        create = 100
    ) %}
SELECT
    last_name AS val,
    ROW_NUMBER() over () AS rnum
FROM
    (
        SELECT
            ROW_NUMBER() over () AS rnum,
            last_name
        FROM
            jaffle.dbt_baw.fake_names
    ) t
    INNER JOIN (
        SELECT
            CEIL(RANDOM() * (
        SELECT
            COUNT(*)
        FROM
            jaffle.dbt_baw.fake_names)) AS rnum
        FROM
            generate_series(
                1,
                100
            )
    ) r
    ON t.rnum = r.rnum
{% endmacro %}
