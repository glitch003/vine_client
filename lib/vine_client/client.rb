module Vine
  class Client
    include Request
    def initialize(name, pass)
      result=login(name,pass)
      @key=result['key']
      @userId=result['userId']
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

    def search(keyword)
      get("/users/search/#{keyword}")
    end

    def timelines(user_id=@userId)
      get("/timelines/users/#{user_id}")
    end

    def tag(tag=nil)
      get('/timelines/tags/#{tag}') if tag
    end

    def notifications(user_id=@userId)
      get("/users/#{user_id}/pendingNotificationsCount")
    end
  end
end