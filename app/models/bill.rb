class Bill < Payment
  REMINDER_INTERVALS = [0, 3, 7].freeze

  def should_send_reminder?
    REMINDER_INTERVALS.include? days_left
  end
end
