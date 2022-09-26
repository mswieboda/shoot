require "game_sf"

require "./shoot/game"

module Shoot
  alias Keys = GSF::Keys
  alias Mouse = GSF::Mouse

  Game.new.run
end
