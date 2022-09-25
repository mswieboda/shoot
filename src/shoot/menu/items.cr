require "./item"

module Shoot::Menu
  class Items
    getter items

    def initialize(screen_width, screen_height, labels = [] of String)
      @items = [] of Item

      labels.each_with_index do |label, index|
        x = screen_width / 2
        y = screen_height / 2 + index * Item::Size * 2 - Item::Size * 3
        @items << Item.new(x, y, label, selected: index == 0)
      end
    end

    def selected
      if item = items.find(&.selected?)
        return item.label
      end
    end

    def update(frame_time)
      items.each(&.update(frame_time))
    end

    def draw(window : SF::RenderWindow)
      items.each(&.draw(window))
    end
  end
end
