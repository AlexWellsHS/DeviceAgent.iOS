
module UnitTestApp
  module Orientation

    def upside_down_supported?
      hash = @gestures.device_info
      if hash["iphone6"] || hash["iphone6+"]
        false
      else
        true
      end
    end

    def rotate_and_expect(position)
      symbol = position.to_sym
      json = @device_agent.rotate_home_button_to(symbol)
      sleep(0.5)
      orientation = json["orientation"]

      if [:top, :up].include?(symbol) && !upside_down_supported?
        message = "Upside down orientation is not supported iPhone 6*"
        colored = RunLoop::Color.blue(message)
        $stdout.puts("    #{colored}")
      else
        expected = expected_position(position)
        expect(orientation).to be == expected
      end
    end

    def expected_position(position)
      symbol = position.to_sym
      case symbol
      when :top, :up
        2
      when :bottom, :down
        1
      when :right
        3
      when :left
        4
      else
        raise ArgumentError, %Q[
Expected '#{position}' to be [:top, :up, :bottom, :down, :left, :right]
]
      end
    end
  end
end

World(UnitTestApp::Orientation)

Then(/^I rotate the device so the home button is on the (top|bottom|left|right)$/) do |position|
  rotate_and_expect(position)
end
