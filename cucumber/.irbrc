require "irb/completion"
require "irb/ext/save-history"
require "benchmark"
require "run_loop"

AwesomePrint.irb!

ARGV.concat [ "--readline",
              "--prompt-mode",
              "simple"]

IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = ".irb-history"

IRB.conf[:AUTO_INDENT] = true

IRB.conf[:PROMPT][:DEVICE_AGENT] = {
  :PROMPT_I => "device-agent #{RunLoop::VERSION}> ",
  :PROMPT_N => "device-agent #{RunLoop::VERSION}> ",
  :PROMPT_S => nil,
  :PROMPT_C => "> ",
  :AUTO_INDENT => false,
  :RETURN => "%s\n"
}

IRB.conf[:PROMPT_MODE] = :DEVICE_AGENT

begin
  require "pry"
  Pry.config.history.should_save = false
  Pry.config.history.should_load = false
  require "pry-nav"
rescue LoadError => _

end

def World(*args)

end

["automator.rb"].each do |file|
  path = File.join(".", "features", "support", file)
  print "Loading #{path}..."
  load path
  puts "done!"
end

puts ""
puts "#       =>  Useful Methods  <=          #"
puts "> xcode        => Xcode instance"
puts "> simctl       => Simctl instance"
puts "> default_sim  => Default simulator"
puts "> device_agent => RunLoop::XCUITest instance"
puts "> holmes       => Launch an app with DeviceAgent"
puts "> verbose      => turn on DEBUG logging"
puts "> quiet        => turn off DEBUG logging"
puts ""

def xcode
  @xcode ||= RunLoop::Xcode.new
end

def instruments
  @instruments ||= RunLoop::Instruments.new
end

def simctl
  @simctl ||= RunLoop::Simctl.new
end

def default_sim
  @default_sim ||= lambda do
    name = RunLoop::Core.default_simulator(xcode)
    simctl.simulators.find do |sim|
      sim.instruments_identifier(xcode) == name
    end
  end.call
end

def verbose
  ENV["DEBUG"] = "1"
end

def quiet
  ENV["DEBUG"] = "1"
end

if !ENV["CBXWS"]
  path = File.expand_path(File.join("..", "DeviceAgent.xcworkspace"))

  if File.directory?(path)
    ENV["CBXWS"] = path
  else
    puts "CBXWS is not defined and could not find xcworkspace at:"
    puts ""
    puts "  #{path}"
    puts ""
    puts "Exiting...Goodbye."
    exit 1
  end
end

if ENV["APP"].nil? || ENV["APP"] == ""
  path = File.expand_path(File.join("..", "Products", "app", "TestApp", "TestApp.app"))

  if File.exist?(path)
    ENV["APP"] = path
  else
    puts "APP is not defined and could not find app at:"
    puts ""
    puts "  #{path}"
    puts ""
    puts "You have some options:"
    puts ""
    puts " 1. Run against the TestApp"
    puts "   $ (cd .. && make test-app)"
    puts "   $ be irb"
    puts "   > holmes"
    puts ""
    puts "2. Run against another app on the simulator."
    puts "   $ APP=/path/to/My.app be irb"
    puts ""
    puts "3. Run against an app installed on the simulator."
    puts "   $ APP=com.example.MyApp be irb"
    puts ""
    puts "4. Run against an app install on a device. The device target can be"
    puts "   a UDID or the name of the device."
    puts "   $ APP=com.example.MyApp DEVICE_TARGET=< udid or name> be irb"
    puts ""
    puts "Exiting...Goodbye."
    exit 1
  end
end

puts "DeviceAgent workspace = #{ENV["CBXWS"]}"
puts "APP = #{ENV["APP"]}"
puts "DEVICE_TARGET = #{RunLoop::Device.detect_device({}, xcode, simctl, instruments)}"

def device_agent(bundle_id="sh.calaba.TestApp")
  device = RunLoop::Device.detect_device({}, xcode, simctl, instruments)
  RunLoop::XCUITest.new(bundle_id, device)
end

def holmes()
  device = RunLoop::Device.detect_device({}, xcode, simctl, instruments)

  options = {
    :device => device.udid,
    :xcode => xcode,
    :simctl => simctl,
    :instruments => instruments,
    :app => ENV["APP"],
    :cbx_launcher => :xcodebuild,
    :gesture_performer => :device_agent
  }

  @xcuitest = @holmes = @device_agent = RunLoop.run(options)
  @waiter = DeviceAgent::Wait.new(@device_agent)
  @gestures = DeviceAgent::Gestures.new(@waiter)
end

def booted_simulator
  simctl.simulators.detect(nil) do |sim|
    sim.state == "Booted"
  end
end

def attach
  if !@device_agent
    device = booted_simulator
    app = RunLoop::App.new(ENV["APP"])
    bundle_id = app.bundle_identifier
    launcher = RunLoop::DeviceAgent::Xcodebuild.new(device)
    @device_agent = RunLoop::XCUITest.new(bundle_id, device, launcher)
  end

  @waiter = DeviceAgent::Wait.new(@device_agent)
  @gestures = DeviceAgent::Gestures.new(@waiter)
  @holmes = @xcuitest = @device_agent
end

def device_agent
  attach
end

verbose

motd=["Let's get this done!", "Ready to rumble.", "Enjoy.", "Remember to breathe.",
      "Take a deep breath.", "Isn't it time for a break?", "Can I get you a coffee?",
      "What is a calabash anyway?", "Smile! You are on camera!", "Let op! Wild Rooster!",
      "Don't touch that button!", "I'm gonna take this to 11.", "Console. Engaged.",
      "Your wish is my command.", "This console session was created just for you."]
puts "#{motd.sample()}"

RunLoop.log_error(%Q{

The .irbrc file is out of date and probably does not work as expected.

Feel free to update the .irbrc so it works for your needs.

})
