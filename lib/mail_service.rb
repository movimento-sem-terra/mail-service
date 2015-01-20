require 'mandrill'

class MailService
  API_KEY = ENV["MANDRILL_APIKEY"]
  SENDER_NAME = ENV["SENDER_NAME"]
  SENDER_EMAIL = ENV["SENDER_EMAIL"]
  CONTACT_INFO = {
    :name => ENV["CONTACT_NAME"],
    :email => ENV["CONTACT_EMAIL"]
  }

  def self.deliver!(from, content)
    message = create_message(from, content)
    @mandrill = Mandrill::API.new(API_KEY)
    result = @mandrill.messages.send(message)
    result.first
  end

  private
  def self.create_message(from, content)
    message = {
      :subject => "[www.mst.org.br] Pergunta enviada pelo site",
      :headers => { "Reply-To"=> from},
      :html => "<html><h3>Mensagem enviada pelo site:</h3> <br/> <p>#{message}</p></html>",
      :text =>  content,
      :from_name => SENDER_NAME,
      :to => [CONTACT_INFO],
      :from_email=> SENDER_EMAIL
    }
  end
end

