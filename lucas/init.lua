-- Función para colocar bloques en una forma específica para crear la palabra "LUCAS"
function crear_palabra_lucas(pos)
    local material = "mymod:bloque_techo"  -- El material con el que se construirá la palabra
    local set_node = minetest.set_node
    
    -- Letra L
    for i = 0, 4 do
        set_node({x = pos.x, y = pos.y - i, z = pos.z}, {name = material})
    end
    set_node({x = pos.x + 1, y = pos.y - 4, z = pos.z}, {name = material})
    
    -- Letra U
    for i = 0, 3 do
        set_node({x = pos.x + 3, y = pos.y - i, z = pos.z}, {name = material})
        set_node({x = pos.x + 5, y = pos.y - i, z = pos.z}, {name = material})
    end
    set_node({x = pos.x + 4, y = pos.y - 4, z = pos.z}, {name = material})

    -- Letra C
    for i = 0, 4 do
        set_node({x = pos.x + 7, y = pos.y - i, z = pos.z}, {name = material})
    end
    set_node({x = pos.x + 8, y = pos.y, z = pos.z}, {name = material})
    set_node({x = pos.x + 8, y = pos.y - 4, z = pos.z}, {name = material})

    -- Letra A
    for i = 1, 4 do
        set_node({x = pos.x + 10, y = pos.y - i, z = pos.z}, {name = material})
        set_node({x = pos.x + 12, y = pos.y - i, z = pos.z}, {name = material})
    end
    set_node({x = pos.x + 11, y = pos.y, z = pos.z}, {name = material})  -- Top of A
    set_node({x = pos.x + 11, y = pos.y - 2, z = pos.z}, {name = material})  -- Middle of A

    -- Letra S
    -- La posición inicial de S parece incorrecta, y también faltan bloques
    for i = 0, 4 do  -- Recorrer cada nivel de altura de la S
        if i == 0 or i == 2 or i == 4 then
            for j = 0, 2 do
                set_node({x = pos.x + 14 + j, y = pos.y - i, z = pos.z}, {name = material})
            end
        else
            if i == 1 then
                set_node({x = pos.x + 14, y = pos.y - i, z = pos.z}, {name = material})
            else
                set_node({x = pos.x + 16, y = pos.y - i, z = pos.z}, {name = material})
            end
        end
    end
end

-- Comando para generar la palabra "LUCAS"
minetest.register_chatcommand("lucas", {
    description = "Genera la palabra LUCAS",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Jugador no encontrado"
        end

        local pos = vector.add(player:get_pos(), {x=0, y=2, z=2})  -- Ajuste para que la palabra no aparezca dentro del jugador
        crear_palabra_lucas(pos)
        return true, "Palabra LUCAS creada"
    end,
})
