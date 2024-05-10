io.stdout:setvbuf("no")

love.graphics.setDefaultFilter("nearest")

if arg[#arg] == ".debug" then
  require("modebug").start()
end

heros = {}

math.randomseed(love.timer.getTime())

-- Listes d'éléments
liste_sprites = {}
liste_tirs = {}
liste_aliens = {}

-- Image des tuiles :
imgTuiles = {}

local n
for n = 1, 3 do
  imgTuiles[n] = love.graphics.newImage("Image/tuile_" .. n .. ".png")
end

-- Création du niveau / Fenêtre = 800 / 600 -> Tuiles = 32px x 32px = 25 x 18,75

Niveau = {}
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 1, 2, 2, 1, 1, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 2, 2, 3, 0, 0, 3, 1, 2, 1, 1, 1, 2, 2, 1, 3, 0, 0, 3, 3, 3, 3, 0, 0, 0})
table.insert(Niveau, {0, 3, 2, 2, 3, 0, 0, 3, 1, 1, 1, 2, 1, 1, 1, 2, 3, 0, 0, 3, 1, 2, 3, 0, 0, 0})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 1, 2, 2, 1, 1, 1, 2, 1, 3, 3, 3, 3, 1, 1, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 2, 2, 1, 1, 1, 2, 2, 3, 1, 1, 1, 1, 2, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1, 1, 2, 1, 2, 3, 1, 1, 2, 2, 2, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 2, 1, 1, 2, 2, 2, 3, 3, 3, 3, 2, 1, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 2, 1, 1, 1, 2, 1, 1, 3, 0, 0, 3, 3, 3, 3, 0, 0, 0})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 2, 1, 1, 1, 1, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 1, 1, 3, 0, 0, 3, 1, 1, 2, 2, 2, 2, 1, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 1, 1, 3, 0, 0, 3, 1, 1, 1, 1, 1, 1, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 1, 1, 1, 1, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 2, 1, 1, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 2, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 3, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 3, 2, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 2, 1, 1, 1, 2, 1, 3, 0, 0, 0, 0, 0, 3, 2, 2, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 2, 1, 1, 1, 2, 2, 1, 3, 0, 0, 0, 0, 3, 2, 2, 2, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 2, 1, 2, 1, 2, 2, 1, 3, 0, 0, 0, 3, 2, 2, 2, 2, 3})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 1, 2, 2, 1, 1, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 2, 2, 3, 0, 0, 3, 1, 2, 1, 1, 1, 2, 2, 1, 3, 0, 0, 3, 3, 3, 3, 0, 0, 0})
table.insert(Niveau, {0, 3, 2, 2, 3, 0, 0, 3, 1, 1, 1, 2, 1, 1, 1, 2, 3, 0, 0, 3, 1, 2, 3, 0, 0, 0})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 1, 2, 2, 1, 1, 1, 2, 1, 3, 3, 3, 3, 1, 1, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 2, 2, 1, 1, 1, 2, 2, 3, 1, 1, 1, 1, 2, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1, 1, 2, 1, 2, 3, 1, 1, 2, 2, 2, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 2, 1, 1, 2, 2, 2, 3, 3, 3, 3, 2, 1, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 2, 1, 1, 1, 2, 1, 1, 3, 0, 0, 3, 3, 3, 3, 0, 0, 0})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 2, 1, 1, 1, 1, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 1, 1, 3, 0, 0, 3, 1, 1, 2, 2, 2, 2, 1, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 1, 1, 3, 0, 0, 3, 1, 1, 1, 1, 1, 1, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 1, 1, 1, 1, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 2, 1, 1, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 2, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 3, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 3, 2, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 2, 1, 1, 1, 2, 1, 3, 0, 0, 0, 0, 0, 3, 2, 2, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 2, 1, 1, 1, 2, 2, 1, 3, 0, 0, 0, 0, 3, 2, 2, 2, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 2, 1, 2, 1, 2, 2, 1, 3, 0, 0, 0, 3, 2, 2, 2, 2, 3})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 1, 2, 2, 1, 1, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 2, 2, 3, 0, 0, 3, 1, 2, 1, 1, 1, 2, 2, 1, 3, 0, 0, 3, 3, 3, 3, 0, 0, 0})
table.insert(Niveau, {0, 3, 2, 2, 3, 0, 0, 3, 1, 1, 1, 2, 1, 1, 1, 2, 3, 0, 0, 3, 1, 2, 3, 0, 0, 0})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 1, 2, 2, 1, 1, 1, 2, 1, 3, 3, 3, 3, 1, 1, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 2, 2, 1, 1, 1, 2, 2, 3, 1, 1, 1, 1, 2, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1, 1, 2, 1, 2, 3, 1, 1, 2, 2, 2, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 2, 1, 1, 2, 2, 2, 3, 3, 3, 3, 2, 1, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 2, 1, 1, 1, 2, 1, 1, 3, 0, 0, 3, 3, 3, 3, 0, 0, 0})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 2, 1, 1, 1, 1, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 1, 1, 3, 0, 0, 3, 1, 1, 2, 2, 2, 2, 1, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 1, 1, 3, 0, 0, 3, 1, 1, 1, 1, 1, 1, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 1, 1, 1, 1, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 2, 1, 1, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 2, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 3, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 3, 2, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 2, 1, 1, 1, 2, 1, 3, 0, 0, 0, 0, 0, 3, 2, 2, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 2, 1, 1, 1, 2, 2, 1, 3, 0, 0, 0, 0, 3, 2, 2, 2, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 2, 1, 2, 1, 2, 2, 1, 3, 0, 0, 0, 3, 2, 2, 2, 2, 3})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 1, 2, 2, 1, 1, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 2, 2, 3, 0, 0, 3, 1, 2, 1, 1, 1, 2, 2, 1, 3, 0, 0, 3, 3, 3, 3, 0, 0, 0})
table.insert(Niveau, {0, 3, 2, 2, 3, 0, 0, 3, 1, 1, 1, 2, 1, 1, 1, 2, 3, 0, 0, 3, 1, 2, 3, 0, 0, 0})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 1, 2, 2, 1, 1, 1, 2, 1, 3, 3, 3, 3, 1, 1, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 2, 2, 1, 1, 1, 2, 2, 3, 1, 1, 1, 1, 2, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1, 1, 2, 1, 2, 3, 1, 1, 2, 2, 2, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 2, 1, 1, 2, 2, 2, 3, 3, 3, 3, 2, 1, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 2, 1, 1, 1, 2, 1, 1, 3, 0, 0, 3, 3, 3, 3, 0, 0, 0})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 2, 1, 1, 1, 1, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 1, 1, 3, 0, 0, 3, 1, 1, 2, 2, 2, 2, 1, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 1, 1, 3, 0, 0, 3, 1, 1, 1, 1, 1, 1, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 1, 1, 1, 1, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 2, 1, 1, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 2, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 3, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 3, 2, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 2, 1, 1, 1, 2, 1, 3, 0, 0, 0, 0, 0, 3, 2, 2, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 2, 1, 1, 1, 2, 2, 1, 3, 0, 0, 0, 0, 3, 2, 2, 2, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 2, 1, 2, 1, 2, 2, 1, 3, 0, 0, 0, 3, 2, 2, 2, 2, 3})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 1, 2, 2, 1, 1, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 2, 2, 3, 0, 0, 3, 1, 2, 1, 1, 1, 2, 2, 1, 3, 0, 0, 3, 3, 3, 3, 0, 0, 0})
table.insert(Niveau, {0, 3, 2, 2, 3, 0, 0, 3, 1, 1, 1, 2, 1, 1, 1, 2, 3, 0, 0, 3, 1, 2, 3, 0, 0, 0})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 1, 2, 2, 1, 1, 1, 2, 1, 3, 3, 3, 3, 1, 1, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 2, 2, 1, 1, 1, 2, 2, 3, 1, 1, 1, 1, 2, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1, 1, 2, 1, 2, 3, 1, 1, 2, 2, 2, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 2, 1, 1, 2, 2, 2, 3, 3, 3, 3, 2, 1, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 2, 1, 1, 1, 2, 1, 1, 3, 0, 0, 3, 3, 3, 3, 0, 0, 0})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 2, 1, 1, 1, 1, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 1, 1, 3, 0, 0, 3, 1, 1, 2, 2, 2, 2, 1, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 1, 1, 3, 0, 0, 3, 1, 1, 1, 1, 1, 1, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 1, 1, 1, 1, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 2, 1, 1, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 2, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 3, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 3, 2, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 2, 1, 1, 1, 2, 1, 3, 0, 0, 0, 0, 0, 3, 2, 2, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 2, 1, 1, 1, 2, 2, 1, 3, 0, 0, 0, 0, 3, 2, 2, 2, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 2, 1, 2, 1, 2, 2, 1, 3, 0, 0, 0, 3, 2, 2, 2, 2, 3})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 1, 2, 2, 1, 1, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 2, 2, 3, 0, 0, 3, 1, 2, 1, 1, 1, 2, 2, 1, 3, 0, 0, 3, 3, 3, 3, 0, 0, 0})
table.insert(Niveau, {0, 3, 2, 2, 3, 0, 0, 3, 1, 1, 1, 2, 1, 1, 1, 2, 3, 0, 0, 3, 1, 2, 3, 0, 0, 0})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 1, 2, 2, 1, 1, 1, 2, 1, 3, 3, 3, 3, 1, 1, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 2, 2, 1, 1, 1, 2, 2, 3, 1, 1, 1, 1, 2, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1, 1, 2, 1, 2, 3, 1, 1, 2, 2, 2, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 2, 1, 1, 2, 2, 2, 3, 3, 3, 3, 2, 1, 3, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 2, 1, 1, 1, 2, 1, 1, 3, 0, 0, 3, 3, 3, 3, 0, 0, 0})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 2, 1, 1, 1, 1, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 1, 1, 3, 0, 0, 3, 1, 1, 2, 2, 2, 2, 1, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 1, 1, 3, 0, 0, 3, 1, 1, 1, 1, 1, 1, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 3, 3, 3, 3, 0, 0, 3, 1, 1, 1, 1, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 2, 1, 1, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 2, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 3, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 1, 1, 2, 1, 2, 1, 2, 3, 0, 0, 0, 0, 0, 0, 3, 2, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 2, 1, 1, 1, 2, 1, 3, 0, 0, 0, 0, 0, 3, 2, 2, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 2, 1, 1, 1, 2, 2, 1, 3, 0, 0, 0, 0, 3, 2, 2, 2, 3})
table.insert(Niveau, {0, 0, 0, 0, 0, 0, 0, 3, 2, 2, 1, 2, 1, 2, 2, 1, 3, 0, 0, 0, 3, 2, 2, 2, 2, 3})
table.insert(Niveau, {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3})

camera = {}
camera.y = 32
camera.v = 1

-- Chargement des images des explosions
imgExplosions = {}
for n = 1, 5 do
  imgExplosions[n] = love.graphics.newImage("Image/explode_" .. n .. ".png")
end

victory = false
timerVictory = 0
score = 0

-- Ecran courant
ecran_courant = "menu"
-- Il vaut mieux streamer une musique que de l'importer en mémoire. Stream = stream
-- Il vaut mieux charger un Son plutôt que le streamer. Charger = static
SonShoot = love.audio.newSource("Son/shoot.wav", "static")
SonExplode = love.audio.newSource("Son/explode_touch.wav", "static")

imgMenu = love.graphics.newImage("Image/menujpg800px.jpg")

imgGameOver = love.graphics.newImage("Image/gameover.jpg")

imgVictory = love.graphics.newImage("Image/victory.jpg")

function math.angle(x1, y1, x2, y2)
  return math.atan2(y2 - y1, x2 - x1)
end

-- Step6 atelier Shootem-Up
function collide(a1, a2)
  if (a1 == a2) then
    return false
  end
  local dx = a1.x - a2.x
  local dy = a1.y - a2.y
  if (math.abs(dx) < a1.image:getWidth() + a2.image:getWidth()) then
    if (math.abs(dy) < a1.image:getHeight() + a2.image:getHeight()) then
      return true
    end
  end
  return false
end

function CreateTir(pType, pNameImage, pX, pY, pVitesseX, pVitesseY)
  local tir = CreateSprite(pNameImage, pX, pY)
  tir.type = pType
  tir.vx = pVitesseX
  tir.vy = pVitesseY
  SonShoot:play()
  table.insert(liste_tirs, tir)
end

function CreateAliens(pType, pX, pY)
  local nomImage = ""

  if pType == 1 then
    nomImage = "enemy1"
  elseif pType == 2 then
    nomImage = "enemy2"
  elseif pType == 3 then
    nomImage = "tourelle"
  elseif pType == 10 then
    nomImage = "enemy3"
  end

  local alien = CreateSprite(nomImage, pX, pY)

  alien.type = pType
  alien.endormi = true
  alien.chronotir = 0

  if pType == 1 then
    alien.vx = 0
    alien.vy = 2
    alien.energie = 1
    alien.score = 1
  elseif pType == 2 then
    alien.vy = 2
    alien.energie = 3
    alien.score = 2
    local direction = math.random(1, 2)
    if direction == 1 then
      alien.vx = 1
    else
      alien.vx = -1
    end
  elseif pType == 3 then
    alien.vx = 0
    alien.vy = camera.v
    alien.energie = 3
    alien.score = 3
  elseif pType == 10 then
    alien.vx = 0
    alien.vy = 4
    alien.energie = 20
    alien.angle = 0
    alien.score = 10
  end

  table.insert(liste_aliens, alien)
end

function CreateSprite(pNameImage, pX, pY)
  sprite = {}
  sprite.x = pX
  sprite.y = pY
  sprite.image = love.graphics.newImage("Image/" .. pNameImage .. ".png")
  sprite.l = sprite.image:getWidth()
  sprite.h = sprite.image:getHeight()
  sprite.supprime = false
  sprite.angle = 0
  sprite.vx = 0
  sprite.vy = 0
  sprite.speed = 3

  sprite.frame = 1
  sprite.listeFrames = {}
  sprite.maxFrame = 1

  -- lander.img = love.graphics.newImage("ship.png")
  -- lander.img2 = love.graphics.newImage("engine.png")
  -- imgEngine = True
  table.insert(liste_sprites, sprite)

  return sprite
end

function CreateExplode(pX, pY)
  local newExplode = CreateSprite("explode_1", pX, pY)
  newExplode.listeFrames = imgExplosions
  newExplode.maxFrame = 5
end

function love.load()
  love.window.setMode(800, 600)
  love.window.setTitle("Atelier Shouter")

  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()

  heros = CreateSprite("heros", largeur / 2, hauteur / 2)
  heros.energie = 10

  DemarreJeu()
end

function DemarreJeu()
  heros.x = largeur / 2
  heros.y = hauteur - (heros.h * 2)

  -- Créations des Aliens
  local line = 4
  CreateAliens(1, largeur / 2, -(32 / 2) - (32 * (line - 1)))
  line = 7
  CreateAliens(2, largeur / 2, -(32 / 2) - (32 * (line - 1)))
  line = 10
  CreateAliens(3, largeur / 3, -(32 / 2) - (32 * (line - 1)))
  line = 13
  CreateAliens(2, largeur / 2, -(32 / 2) - (32 * (line - 1)))
  line = 17
  CreateAliens(3, largeur / 3, -(32 / 2) - (32 * (line - 1)))
  line = 20
  CreateAliens(1, largeur / 2, -(32 / 2) - (32 * (line - 1)))
  line = 23
  CreateAliens(1, largeur / 4, -(32 / 2) - (32 * (line - 1)))
  line = 25
  CreateAliens(1, largeur / 3, -(32 / 2) - (32 * (line - 1)))
  line = 27
  CreateAliens(1, largeur / 2, -(32 / 2) - (32 * (line - 1)))
  line = 30
  CreateAliens(1, largeur / 4, -(32 / 2) - (32 * (line - 1)))
  line = 30
  CreateAliens(1, largeur / 3, -(32 / 2) - (32 * (line - 1)))
  line = 30
  CreateAliens(2, largeur - 50, -(32 / 2) - (32 * (line - 1)))
  line = 33
  CreateAliens(2, largeur / 1.5, -(32 / 2) - (32 * (line - 1)))
  line = 35
  CreateAliens(2, largeur / 3, -(32 / 2) - (32 * (line - 1)))
  line = 38
  CreateAliens(1, largeur - 150, -(32 / 2) - (32 * (line - 1)))
  line = 40
  CreateAliens(2, largeur - 50, -(32 / 2) - (32 * (line - 1)))
  line = 41
  CreateAliens(1, largeur - 100, -(32 / 2) - (32 * (line - 1)))
  line = 42
  CreateAliens(2, largeur / 2, -(32 / 2) - (32 * (line - 1)))
  line = 45
  CreateAliens(2, largeur / 1.5, -(32 / 2) - (32 * (line - 1)))
  line = 46
  CreateAliens(1, largeur - 100, -(32 / 2) - (32 * (line - 1)))
  line = 48
  CreateAliens(3, largeur / 2, -(32 / 2) - (32 * (line - 1)))
  line = 50
  CreateAliens(3, largeur / 1.5, -(32 / 2) - (32 * (line - 1)))
  line = 57
  CreateAliens(2, largeur / 3, -(32 / 2) - (32 * (line - 1)))
  line = 59
  CreateAliens(1, largeur / 1.5, -(32 / 2) - (32 * (line - 1)))
  line = 60
  CreateAliens(2, largeur / 2, -(32 / 2) - (32 * (line - 1)))
  line = 61
  CreateAliens(1, largeur / 3, -(32 / 2) - (32 * (line - 1)))
  line = 62
  CreateAliens(3, largeur / 1.5, -(32 / 2) - (32 * (line - 1)))
  line = 64
  CreateAliens(2, largeur / 7, -(32 / 2) - (32 * (line - 1)))
  line = 65
  CreateAliens(1, largeur / 5, -(32 / 2) - (32 * (line - 1)))
  line = 65
  CreateAliens(1, largeur / 1.2, -(32 / 2) - (32 * (line - 1)))
  line = 67
  CreateAliens(3, largeur / 2, -(32 / 2) - (32 * (line - 1)))
  line = 68
  CreateAliens(2, largeur / 3, -(32 / 2) - (32 * (line - 1)))
  line = 70
  CreateAliens(1, largeur / 1.5, -(32 / 2) - (32 * (line - 1)))
  line = 71
  CreateAliens(1, largeur - 100, -(32 / 2) - (32 * (line - 1)))
  line = 72
  CreateAliens(2, largeur / 7, -(32 / 2) - (32 * (line - 1)))
  line = 72
  CreateAliens(3, largeur / 6, -(32 / 2) - (32 * (line - 1)))
  line = 74
  CreateAliens(2, largeur / 3, -(32 / 2) - (32 * (line - 1)))
  line = 75
  CreateAliens(1, largeur / 2, -(32 / 2) - (32 * (line - 1)))
  line = 77
  CreateAliens(1, largeur / 1.2, -(32 / 2) - (32 * (line - 1)))
  line = 77
  CreateAliens(3, largeur / 1.5, -(32 / 2) - (32 * (line - 1)))
  line = 80
  CreateAliens(1, largeur - 100, -(32 / 2) - (32 * (line - 1)))
  line = 81
  CreateAliens(2, largeur / 7, -(32 / 2) - (32 * (line - 1)))
  line = 81
  CreateAliens(3, largeur / 6, -(32 / 2) - (32 * (line - 1)))
  line = 82
  CreateAliens(1, largeur / 3, -(32 / 2) - (32 * (line - 1)))
  line = 84
  CreateAliens(1, largeur / 2, -(32 / 2) - (32 * (line - 1)))
  line = 84
  CreateAliens(2, largeur / 1.2, -(32 / 2) - (32 * (line - 1)))
  line = 85
  CreateAliens(3, largeur / 2, -(32 / 2) - (32 * (line - 1)))
  line = 87
  CreateAliens(2, largeur / 3, -(32 / 2) - (32 * (line - 1)))
  line = 87
  CreateAliens(1, largeur / 1.5, -(32 / 2) - (32 * (line - 1)))
  -- Boss
  line = #Niveau
  CreateAliens(10, largeur / 2, -(32 / 2) - (32 * (line - 1)))

  -- RAZ de la camera
  camera.y = 0
end

function updateJeu()
  -- Avance la camera
  camera.y = camera.y + camera.v

  local n

  -- Traitement des tirs
  for n = #liste_tirs, 1, -1 do -- Bien penser à parcourir la liste à l'envers pour pouvoir supprimer des éléments !
    local tir = liste_tirs[n]
    tir.x = tir.x + tir.vx
    tir.y = tir.y + tir.vy

    -- Vérification qu'on touche le héro
    if tir.type == "alien" then
      if collide(tir, heros) then
        heros.energie = heros.energie - 1
        tir.supprime = true
        table.remove(liste_tirs, n)
        if heros.energie == 0 then
          ecran_courant = "gameover"
        end
      end
    end

    -- Vérification qu'on touche les ennemis et gestion des explosions
    if tir.type == "hero" then
      local nAlien
      for nAlien = #liste_aliens, 1, -1 do
        local alien = liste_aliens[nAlien]
        if alien.endormi == false then
          if collide(tir, alien) then
            CreateExplode(tir.x, tir.y)
            alien.energie = alien.energie - 1
            SonExplode:play()
            tir.supprime = true
            table.remove(liste_tirs, n)
            if alien.energie <= 0 then
              score = score + alien.score
              local nExplode
              for nExplode = 1, 5 do
                CreateExplode(alien.x + math.random(10, -10), alien.y + math.random(10, -10))
              end
              if alien.type == 10 then
                victory = true
                timerVictory = 120
                for nExplode = 1, 20 do
                  CreateExplode(alien.x + math.random(25, -25), alien.y + math.random(25, -25))
                end
              -- On peut ajouter un Son beaucoup plus puissant lors de la destruction du boss
              end
              alien.supprime = true
              table.remove(liste_aliens, nAlien)
            end
          end
        end
      end
    end
    -- Attention ! Il est très important de supprimer le nombre de tir inséré dans la liste "tirs" pour des questions de bon fonctionnement dans le temps du programme lié à la mémoire.
    -- Pour se faire on va vérifier si le tir n'est pas sorti de l'écran
    if tir.y < 0 or tir.y > hauteur and tir.supprime == false then
      -- On crée un booléen sprite.supprime à l'intérieur de la fonction CreateSprite à réutiliser ici pour pointer le tir à delete
      tir.supprime = true
      table.remove(liste_tirs, n)
    end
  end

  -- Traitement des aliens
  for n = #liste_aliens, 1, -1 do
    local alien = liste_aliens[n]

    if alien.y > 0 then
      alien.endormi = false
    end

    if alien.endormi == false then
      alien.x = alien.x + alien.vx
      alien.y = alien.y + alien.vy

      if alien.type == 1 or alien.type == 2 then
        -- Deuxième façon de faire
        -- alien.chronotir = alien.chronotir + 1
        alien.chronotir = alien.chronotir - 1
        -- if alien.chronotir >= 60 then
        if alien.chronotir <= 0 then
          -- alien.chronotir = 0
          alien.chronotir = math.random(60, 100)
          CreateTir("alien", "laser2", alien.x, alien.y, 0, 5)
        end
      elseif alien.type == 3 then
        alien.chronotir = alien.chronotir - 1
        if alien.chronotir <= 0 then
          alien.chronotir = math.random(35, 50)
          local vx, vy
          angle = math.angle(alien.x, alien.y, heros.x, heros.y)
          vx = 5 * math.cos(angle)
          vy = 5 * math.sin(angle)
          CreateTir("alien", "laser2", alien.x, alien.y, vx, vy)
        end
      elseif alien.type == 10 then
        alien.chronotir = alien.chronotir - 1
        if alien.chronotir <= 0 then
          alien.chronotir = math.random(15, 25)
          local vx, vy
          alien.angle = alien.angle + 0.5
          vx = 10 * math.cos(alien.angle)
          vy = 10 * math.sin(alien.angle)
          CreateTir("alien", "laser2", alien.x, alien.y, vx, vy)
        end
        if alien.y >= hauteur / 3 then
          alien.vy = alien.vy * (-1)
          local direction = math.random(1, 2)
          if direction == 1 then
            alien.vx = 1
          else
            alien.vx = -1
          end
          if alien.x <= 0 then
            alien.vx = alien.vx * (-1)
          elseif alien.x >= largeur then
            alien.vx = alien.vx * (-1)
          end
        elseif alien.y <= 0 then
          alien.vy = alien.vy * (-1)
        end
      end
    else
      alien.y = alien.y + camera.v
    end
    if alien.y > hauteur then
      alien.supprime = true
      table.remove(liste_aliens, n) -- On l'enlève de la liste des aliens / La purge des sprites se fait plus tard
    end
  end

  -- Traitement et Purge des Sprites
  -- Dernière étape, maintenant il faut supprimer les Sprites enregistrés dans la #sprites ! Même procédés !

  for n = #liste_sprites, 1, -1 do
    local sprite = liste_sprites[n]
    -- Le sprite est-il animé ?
    if sprite.maxFrame > 1 then
      sprite.frame = sprite.frame + 0.1
      if math.floor(sprite.frame) > sprite.maxFrame then
        sprite.supprime = true
      else
        sprite.image = sprite.listeFrames[math.floor(sprite.frame)]
      end
    end
    if sprite.supprime == true then
      table.remove(liste_sprites, n)
    end
  end

  -- Déplacement du vaisseau hero
  if love.keyboard.isDown("right") and heros.x < largeur - heros.l then
    heros.x = heros.x + 4
  end
  if love.keyboard.isDown("left") and heros.x > 0 + heros.l then
    heros.x = heros.x - 4
  end
  if love.keyboard.isDown("up") and heros.y > 0 + heros.h then
    heros.y = heros.y - 4
  end
  if love.keyboard.isDown("down") and heros.y < hauteur - heros.h then
    heros.y = heros.y + 4
  end

  -- Passage en mode victoire lorsque le boss est vaincu
  if victory == true then
    timerVictory = timerVictory - 1
    if timerVictory == 0 then
      ecran_courant = "victory"
    end
  end
end

function updateMenu()
end

function love.update(dt)
  if ecran_courant == "jeu" then
    updateJeu()
  elseif ecran_courant == "menu" then
    updateMenu()
  end
end

function drawJeu()
  -- Dessin du niveau
  local nbLignes = #Niveau
  local ligne, colonne
  local x, y

  x = 0
  y = (0 - 64) + camera.y

  for ligne = 1, nbLignes do
    for colonne = 1, 25 do
      -- Dessine la Tuile
      local tuile = Niveau[ligne][colonne]
      if tuile > 0 then
        love.graphics.draw(imgTuiles[tuile], x, y, 0, 1, 1)
      end
      x = x + 32
    end
    x = 0
    y = y - 32
  end

  local n
  for n = 1, #liste_sprites do
    local s = liste_sprites[n]
    love.graphics.draw(s.image, s.x, s.y, math.rad(heros.angle), 1, 1, s.l / 2, s.h / 2)
  end

  -- love.graphics.print("Nombre de tirs : "..#liste_tirs.." Nombre de sprites : "..#liste_sprites.." Nombre d'aliens : "..#liste_aliens, 0, 0)
  love.graphics.print("SCORE : " .. score, 0, 0)
  love.graphics.print("VIE : " .. heros.energie, 0, 20)
end

function drawMenu()
  love.graphics.draw(imgMenu, 0, 0)
end

function drawGameOver()
  love.graphics.draw(imgGameOver, 0, 0)
end

function drawVictory()
  love.graphics.draw(imgVictory, 0, 0)
end

function love.draw()
  if ecran_courant == "jeu" then
    drawJeu()
  elseif ecran_courant == "menu" then
    drawMenu()
  elseif ecran_courant == "gameover" then
    drawGameOver()
  elseif ecran_courant == "victory" then
    drawVictory()
  end
end

function love.keypressed(key)
  if ecran_courant == "jeu" then
    if key == "space" then
      CreateTir("hero", "laser1", heros.x, heros.y - heros.h, 0, -10)
    end
  elseif ecran_courant == "menu" then
    if key == "space" then
      ecran_courant = "jeu"
    end
  elseif ecran_courant == "gameover" then
    love.event.quit()
    if key == "space" then
      ecran_courant = "menu"
    end
  end
end

-- Autre code pour amélioration de la gravité du vaisseau hero et de sa rotation

-- local heros = {}
-- heros.x = 0
-- heros.y = 0
-- heros.angle = 270
-- heros.vx = 0
-- heros.vy = 0
-- heros.speed = 3
-- heros.img = love.graphics.newImage("ship.png")
-- heros.img2 = love.graphics.newImage("engine.png")
