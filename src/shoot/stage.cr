require "./scene/start"
require "./scene/horizontal"
require "./scene/freedom"

module Shoot
  class Stage < GSF::Stage
    property start
    property horizontal
    property freedom

    def initialize(window : SF::Window)
      super(window)

      @start = Scene::Start.new
      @horizontal = Scene::Horizontal.new
      @freedom = Scene::Freedom.new(window)

      @scene = start
    end

    def check_scenes
      case scene.name
      when :start
        if scene.exit?
          @exit = true
        elsif start_scene = start.start_scene
          switch(horizontal) if start_scene == :horizontal
          switch(freedom) if start_scene == :freedom
        end
      when :horizontal, :freedom
        switch(start) if scene.exit?
      end
    end
  end
end
