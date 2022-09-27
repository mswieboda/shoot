require "game_sf"

require "./shoot/game"

module Shoot
  alias Keys = GSF::Keys
  alias Mouse = GSF::Mouse
  alias Joysticks = GSF::Joysticks

  Game.new.run
end
