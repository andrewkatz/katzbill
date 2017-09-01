class SMSNotifier < Notifier
  def notify(user, bill)
    client.messages.create(
      from: ENV['TWILIO_PHONE'],
      to: user.phone,
      body: title(bill)
    )
  rescue Twilio::REST::TwilioError => e
    puts "Failed to send SMS notification for bill:#{bill.id} user:#{user.id} error:#{e.message}"
  end

  private

  def client
    @client ||= Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end

  def body(bill)
    is_or_are = bill.days_left == 1 ? 'is' : 'are'
    "Hi there! There #{is_or_are} only #{title(bill)}. It's #{message(bill)}."
  end
end
