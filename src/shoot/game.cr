require "./stage"

module Shoot
  class Game < GSF::Game
    getter manager

    def initialize
      super(title: "shoot")

      @stage = Stage.new(window)
    end
  end
end
