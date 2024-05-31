# frozen_string_literal: true

module UsersControlHelper
  def time_format(total_minutes)
    hours = total_minutes.floor / 60
    minutes = total_minutes.floor % 60
    seconds = ((total_minutes - total_minutes.floor) * 60).round

    format('%<hours>02d:%<minutes>02d:%<seconds>02d', hours:, minutes:, seconds:)
  end
end
