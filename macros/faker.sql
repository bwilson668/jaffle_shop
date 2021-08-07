{% macro faker(
        model,
        create = 100
    ) %}
    {% for name,
        factory in model.items() %}
        {% if loop.first %}
            WITH
        {% else %},
        {% endif %}

        WITH {{ name }} AS (
            {{ factory }}
        )
    {% endfor %}
SELECT
    {% for name,
        factory in model.items() %}
        {{ name }}.val AS {{ name }}

        {% if not loop.last %},
        {% endif %}
    {% endfor %}
FROM
    generate_series(
        1,
        {{ create }}
    ) AS rnum

    {% for name,
    factory in model.items() %}
    JOIN {{ name }}
    ON {{ name }}.rnum = rnum.rnum
{% endfor %}
{% endmacro %}
