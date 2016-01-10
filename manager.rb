require 'eventmachine'

START_YEAR, START_MONTH, START_DAY, START_HOUR = ARGV

class SDTD < EventMachine::Connection
  LOG_REGEX = /^(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}) (\d+\.\d+) (\w+) (.*)$/
  TIME_REGEX = /^Day (\d+), (\d+):(\d+)$/

  def initialize *args
    super

    @started = Time.new(START_YEAR, START_MONTH, START_DAY, START_HOUR, 0, 0, "+00:00").to_i

    EventMachine.add_periodic_timer(10) {
      check_time
    }
  end

  def receive_data data 
    split_data = data.split("\n")

    split_data.each do |line|
      line.strip!

      unless line.empty?
        handle_line(line)
      end
    end
  end

  def handle_line(line)
    timeMatch = TIME_REGEX.match(line)

    if (timeMatch != nil)
      handle_time timeMatch[1].to_i, timeMatch[2].to_i, timeMatch[3].to_i
    end
  end

  def check_time
    send_data "gettime\n\r"
  end

  def handle_time days, hours, minutes
    wanted_day = ((Time.now.to_i - @started) / (86400 * 7)) + 1

    unless days == wanted_day
      send_data "settime #{wanted_day} #{hours} #{minutes}\n\r"
    end
  end
end

EventMachine.run {
  EventMachine::connect '127.0.0.1', 8081, SDTD
}
