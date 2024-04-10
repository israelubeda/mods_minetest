-- Esta función se llama cada vez que se genera un nuevo pedazo del mapa
minetest.register_on_generated(function(minp, maxp, seed)
    -- Define las coordenadas donde quieres colocar el bloque especial
    local pos = {x = 100, y = 10, z = 100}  -- Debes ajustar esto según la ubicación deseada

    -- Verifica si las coordenadas están dentro del pedazo del mapa generado
    if pos.x >= minp.x and pos.x <= maxp.x and
       pos.y >= minp.y and pos.y <= maxp.y and
       pos.z >= minp.z and pos.z <= maxp.z then
        -- Coloca el bloque especial en las coordenadas definidas
        minetest.set_node(pos, {name = "mymod:bloque_especial"})
    end
end)


