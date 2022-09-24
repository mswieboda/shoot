{% if flag?(:win32) %}
  require "../../crsfml/src/crsfml"
{% else %}
  require "crsfml"
{% end %}

require "./shoot/game"

Shoot::Game.new.run
