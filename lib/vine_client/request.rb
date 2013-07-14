module Vine
  module Request

    [:get,:put,:post,:delete].each{|verb|define_method(verb){|*arg| call(verb, arg[0],arg[1])}}

    def call(http_verb, path, params)
      result = connection.send(http_verb, path, params){|req| req[:vine_session_id]=@key if @key}
      result.body['data']
    end

    def connection
      options = {
        :url => 'https://api.vineapp.com/',
        :headers => {
          :accept => 'application/json',
          :user_agent => "com.vine.iphone/1.0.3 (unknown, iPhone OS 6.1.0, iPhone, Scale/2.000000)",
        },
        :request => {
          :open_timeout => 5,
          :timeout => 10,
        },
        :ssl => {
          :verify => true
        },
      }
 
      Faraday.new(options) do |builder|
        builder.response :raise_error
        builder.response :mashify
        builder.response :json
        builder.request :url_encoded
        builder.adapter :net_http
    end
  end
  end
end