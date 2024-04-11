-- Definir un nuevo bloque llamado "bloque_especial"
minetest.register_node("mymod:bloque_especial", {
	description = "Bloque Especial",
	tiles = {"mi_mod_bloque_especial.png"},
	groups = {cracky = 3, stone = 1},
})

-- Escuchar el evento de cavar un nodo
minetest.register_on_dignode(function(pos, oldnode, digger)
	if not digger or not digger:is_player() then
		return
	end

	if oldnode.name == "mymod:bloque_especial" then
		-- Incrementar los puntos del jugador cuando cava el bloque especial
		local nombre_jugador = digger:get_player_name()
		local puntos = digger:get_meta():get_int("puntos") + 1
		digger:get_meta():set_int("puntos", puntos)

		minetest.chat_send_player(nombre_jugador, "Has ganado un punto! Ahora tienes " .. puntos .. " puntos.")
	end
end)




--casa
minetest.register_node("mymod:bloque_piso", {
	description = "Bloque de Piso",
	tiles = {"bloque_piso.png"},
	groups = {cracky = 3, oddly_breakable_by_hand = 1},
	-- Más propiedades pueden ser definidas aquí
})

minetest.register_node("mymod:bloque_pared", {
	description = "Bloque de Pared",
	tiles = {"bloque_pared.png"},
	groups = {cracky = 3, oddly_breakable_by_hand = 1},
	-- Más propiedades pueden ser definidas aquí
})

minetest.register_node("mymod:bloque_techo", {
	description = "Bloque de Techo",
	tiles = {"bloque_techo.png"},
	groups = {cracky = 3, oddly_breakable_by_hand = 1},
	-- Más propiedades pueden ser definidas aquí
})





-- Definir la función para construir una casa
local function construir_casa(pos)
    local ancho = 10
    local largo = 10
    local alto = 5

    -- Construir el piso
    for dx = 0, ancho - 1 do
        for dz = 0, largo - 1 do
            local p = {x = pos.x + dx, y = pos.y, z = pos.z + dz}
            minetest.set_node(p, {name = "mymod:bloque_piso"})
        end
    end

    -- Construir las paredes
    for y = 1, alto do
        for dx = 0, ancho - 1 do
            minetest.set_node({x = pos.x + dx, y = pos.y + y, z = pos.z}, {name = "mymod:bloque_pared"})
            minetest.set_node({x = pos.x + dx, y = pos.y + y, z = pos.z + largo - 1}, {name = "mymod:bloque_pared"})
        end
        for dz = 1, largo - 2 do
            minetest.set_node({x = pos.x, y = pos.y + y, z = pos.z + dz}, {name = "mymod:bloque_pared"})
            minetest.set_node({x = pos.x + ancho - 1, y = pos.y + y, z = pos.z + dz}, {name = "mymod:bloque_pared"})
        end
    end

    -- Construir el techo
    for dx = -1, ancho do
        for dz = -1, largo do
            local p = {x = pos.x + dx, y = pos.y + alto, z = pos.z + dz}
            minetest.set_node(p, {name = "mymod:bloque_techo"})
        end
    end
end

-- Coordenadas donde quieres que la casa sea construida
local pos_casa = {x = 108.3, y = 5, z = 149.3}

-- Registrar el comando para construir la casa
minetest.register_chatcommand("construir_casa", {
    description = "Construye una casa en las coordenadas especificadas",
    func = function(name, param)
        construir_casa(pos_casa)
        return true, "Casa construida en la posición (".. pos_casa.x ..",".. pos_casa.y ..",".. pos_casa.z ..")"
    end,
})

