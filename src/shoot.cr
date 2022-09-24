{% if flag?(:win32) %}
  require "../../crsfml/src/crsfml"
  require "../../crsfml/src/audio"
{% else %}
  require "crsfml"
  require "crsfml/audio"
{% end %}

require "./shoot/game"

Shoot::Game.new.run
