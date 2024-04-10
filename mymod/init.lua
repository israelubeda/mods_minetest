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

