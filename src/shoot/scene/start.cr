require "../menu/items"
require "../keys"

module Shoot::Scene
  class Start < Base
    property? start
    getter items

    def initialize(screen_width, screen_height)
      super(screen_width, screen_height, :start)

      @start = false
      @items = Menu::Items.new(screen_width, screen_height, ["start", "exit"])
    end

    def reset
      super

      @start = false
    end

    def update(frame_time, keys : Keys)
      items.update(frame_time)

      if keys.just_pressed?([Keys::Space, Keys::Enter])
        if selected = items.selected
          case selected
          when "start"
            @start = true
          when "exit"
            @exit = true
          end
        end
      elsif keys.just_pressed?(Keys::Escape)
        @exit = true
      end
    end

    def draw(window : SF::RenderWindow)
      items.draw(window)
    end
  end
end
