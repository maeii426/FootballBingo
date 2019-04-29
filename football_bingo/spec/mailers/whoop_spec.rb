require "rails_helper"

RSpec.describe WhoopMailer, type: :mailer do

  describe 'send email to given user' do

    it 'renders the subject' do
      user = build(:user, name: 'Lucas', email: 'whoop606super@gmail.com')
      mail= described_class.send_email(user).deliver_now
      expect(mail.subject).to eq('Collect Your Whoop Prize!')
    end

    it 'renders the receiver email' do
      user = build(:user, name: 'Lucas', email: 'whoop606super@gmail.com')
      mail= described_class.send_email(user).deliver_now
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      user = build(:user, name: 'Lucas', email: 'whoop606super@gmail.com')
      mail= described_class.send_email(user).deliver_now
      expect(mail.from).to eq(['admin@whoop.com'])
    end
  end
end
