{% macro signed_quantity(operation_col, quantity_col) %}
    case 
        when {{ operation_col }} = 'BUY' then {{ quantity_col }}
        when {{ operation_col }} = 'SELL' then -{{ quantity_col }}
        else 0
    end
{% endmacro %}