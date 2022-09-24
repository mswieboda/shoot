{% if flag?(:win32) %}
  require "../../crsfml/src/crsfml"
{% else %}
  require "crsfml"
{% end %}


mode = SF::VideoMode.new(1024, 780)
window = SF::RenderWindow.new(mode, "shoot")
window.vertical_sync_enabled = true

ship_texture = SF::Texture.from_file("./assets/ship.png")

ship = SF::Sprite.new(ship_texture)
ship.origin = ship_texture.size / 2.0
ship.scale = SF.vector2(1, 1)
ship.position = SF.vector2(250, 300)

while window.open?
  while event = window.poll_event
    case event
    when SF::Event::Closed
      window.close
    when SF::Event::KeyPressed
      if event.code.escape?
        window.close
      end
    end
  end

  window.clear(SF::Color.new(0, 0, 0))

  window.draw(ship)

  window.display
end
