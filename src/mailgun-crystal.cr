require "http/client"
require "http/params"
require "base64"
require "uri"
require "json"

module MailgunCrystal
  VERSION = "0.1.0"

  struct Response
    property status_code, body, id

    def initialize(@status_code : Int32, @body : String | Nil)
    end
  end

  class Client
    @api_key : String
    @domain : String

    def initialize(@api_key, @domain)
    end

    def auth
      Base64.strict_encode @api_key
    end

    def request_with(params : String)
      HTTP::Client.post(
        "https://api.mailgun.net/v3/#{@domain}/messages",
        headers: HTTP::Headers{"Authorization" => "Basic #{self.auth}"},
        form: params
      )
    rescue ex
      Response.new status_code: 1, body: ex.message
    end

    def handle(response : HTTP::Client::Response | Response)
      if response.status_code == 200 && response.is_a? HTTP::Client::Response
        body = JSON.parse response.body
        {
          "status_code" => 200,
          "id" => body["id"],
          "message" => body["message"]
        }
      else
        {
          "status_code" => response.status_code,
          "message" => response.body
        }
      end
    end

    def send_text(
      from : String,
      to : String | Array(String),
      subject : String,
      content : String
    )
      params = HTTP::Params.encode({
        "from" => from,
        "to" => to,
        "subject" => subject,
        "text" => content
      })
      response = self.request_with params
      self.handle response
    end

    def send_html(
      from : String,
      to : String | Array(String),
      subject : String,
      content : String
    )
      params = HTTP::Params.encode({
        "from" => from,
        "to" => to,
        "subject" => subject,
        "html" => content
      })
      response = self.request_with params
      self.handle response
    end
  end
end
