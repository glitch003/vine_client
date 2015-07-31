require 'hashie'

module Vine
  class Client
    include Request
    def initialize(name, pass)
      result = login(name,pass)
      @key = result['key']
      @userId = result['userId']
    end

    def login(name, pass)
      post('/users/authenticate',{:username =>name, :password=>pass})
    end

    def logout
      delete('/users/authenticate')
    end

    def get_popular
      get('/timelines/popular')
    end

    def user_info(user_id=@userId)
      get("/users/profiles/#{user_id}")
    end

    def channel(channel_code, page = nil, popular_or_recent = "popular")
      result = get("/timelines/channels/#{channel_code}/#{popular_or_recent}?page=#{page}")
      method = lambda{|keyword, page| get("/timelines/channels/#{channel_code}/#{popular_or_recent}?page=#{page}")}
      ResultSet.new(result, channel_code, method)
    end

    def search(keyword, page = nil)
      result = get("/users/search/#{keyword}?page=#{page}")
      method = lambda{|keyword, page| get("/users/search/#{keyword}?page=#{page}")}
      ResultSet.new(result, keyword, method)
    end


    def timelines(page = nil, user_id=@userId)
      result = get("/timelines/users/#{user_id}?page=#{page}")
      method = lambda{|user_id, page| get("/timelines/users/#{user_id}?page=#{page}")}
      ResultSet.new(result, user_id, method)
    end

    def tag(tag=nil, page=nil)
        result = get("/timelines/tags/#{tag}?page=#{page}")
        method = lambda{|tag, page| get("/timelines/tags/#{tag}?page=#{page}")}
        ResultSet.new(result, tag, method)
    end

    def notifications(user_id=@userId)
      get("/users/#{user_id}/pendingNotificationsCount")
    end

    def like(post_id=nil)
      post("/posts/#{post_id}/likes") if post_id
    end

    def get_post(post_id=nil)
      get("/timelines/posts/#{post_id}") if post_id
    end
  end

  class ResultSet
    include Request
    attr_reader :records, :current_page

    def call_method(method, optional_param, page)
      result = method.call(optional_param, page)
      ResultSet.new(result, optional_param, method)
    end

    def initialize(result, optional_param,method)
      @current_page = result.nextPage.nil? ? 1 : result.nextPage - 1
      @records = result.records.map{|vine| Video.new(vine.to_hash)}
      define_singleton_method(:next_page){ call_method(method, optional_param, @current_page + 1)}  unless result.nextPage.nil?
      define_singleton_method(:previous_page){ call_method(method ,optional_param, @current_page - 1)}  unless result.previousPage.nil?
    end
  end

  class Video < Hashie::Mash
    include Request
    def like()
      post("/posts/#{self.postId}/likes") if self.postId
    end
  end
end
