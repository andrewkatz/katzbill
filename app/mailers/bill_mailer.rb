class BillMailer < ActionMailer::Base
  default from: 'no-reply@katzbill.com'

  def reminder_email(bill)
    @bill = bill

    mail(
      to: bill.user.email,
      subject: "#{bill.days_left} until \"#{bill.name}\" is due"
    )
  end
end
