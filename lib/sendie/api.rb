class Sendie::Api
  require 'uri'
  require 'net/https'

  attr_reader :data

  def initialize
    @data = {}
    @data[:sections] = {}
    @data[:from] = { email: Sendie.config.from_email, name: Sendie.config.from_name }
    @data[:categories] = []
    reset
  end

  def reset
    @data[:personalizations] = []
    @tmp_substitutes = {}
    @tmp_subject = nil
  end

  def section(variable, value)
    @data[:sections]["#{variable}"] = value
  end

  def substitute(variable, value)
    @tmp_substitutes["#{variable}"] = value
  end

  def send_to(email)
    @data[:personalizations] << {
      to: [{ email: email }],
      substitutions: @tmp_substitutes,
      subject: @tmp_subject
    }
    @tmp_substitutes = {}
    @tmp_subject = nil
  end

  def substitute_subject(value)
    @tmp_subject = value
  end

  def subject(value)
    @data[:subject] = value
  end

  def uniq_args(value)
    @data[:unique_args] = value if value.is_a?(Hash)
  end

  def categories(*list)
    @data[:categories].concat(list.flatten)
  end

  def deliver_at(timestamp)
    @data[:send_at] = timestamp
  end

  def template_id(id)
    @data[:template_id] = id
  end

  def to_json
    JSON.generate(@data)
  end

  def send_mail
    uri = URI('https://api.sendgrid.com/v3/mail/send')
    @http = Net::HTTP.start(uri.host, uri.port, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_PEER)
    begin
      req = Net::HTTP::Post.new(uri.path, initheader = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' })
      req['Authorization'] = "Bearer #{Sendie.config.api_key}"
      req.body = to_json
      response = @http.request(req)
      response.body
    ensure
      @http.finish
    end
  end
end
