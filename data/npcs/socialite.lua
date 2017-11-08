local ActorTalents = require("engine.interface.ActorTalents")

local char_list = {
	--Ogham
	"ᚁ","ᚂ","ᚃ","ᚄ","ᚅ","ᚆ","ᚇ","ᚈ","ᚉ","ᚊ","ᚋ","ᚌ","ᚍ","ᚎ","ᚏ","ᚐ","ᚑ","ᚒ",
	"ᚓ","ᚔ","ᚕ","ᚖ","ᚗ","ᚘ","ᚙ","ᚚ","᚛","᚜",
	--Armenian
	"Ա","Բ","Գ","Դ","Ե","Զ","Է","Ը","Թ","Ժ","Ի","Լ","Խ","Ծ","Կ","Հ","Ձ",
	"Ղ","Ճ","Մ","Յ","Ն","Շ","Ո","Չ","Պ","Ջ","Ռ","Ս","Վ","Ր","Ց","Ւ","Փ","Ք","Ֆ",
	--Lao
	"ກ","ຂ","ຄ","ງ","ຈ","ຊ","ຍ","ດ","ຕ","ຖ","ທ","ນ","ບ","ປ","ຜ","ຝ","ພ",
	"ຟ","ມ","ຢ","ຣ","ລ","ວ","ສ","ອ","ຮ","ຯ"}

newEntity{ 
	define_as = "NPC_SOCIALITE",
	type = "?", subtype = "?",
	display = resolvers.rngtable(char_list),
	ai = "dumb_talented_simple", ai_state = { talent_in=1, },
	name = "socialite", 
	level_range = {1, 20}, exp_worth = 1,
	rarity = 8,
	max_life = resolvers.rngavg(13,16),
	clade = "Hominidae",
	genus = "orangutan",
	desc = [[An orangutan.]],
	resolvers.color(),
	resolvers.species()
}


