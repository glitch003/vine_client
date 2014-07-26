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

    def search(keyword, page)
      get("/users/search/#{keyword}?page=#{page}")
    end

    def timelines(user_id=@userId)
      get("/timelines/users/#{user_id}")
    end

    def tag(tag=nil, page=nil)
      if tag
        if page
          get("/timelines/tags/#{tag}?page=#{page}")
        else
          get("/timelines/tags/#{tag}")
        end

      end
    end

    def notifications(user_id=@userId)
      get("/users/#{user_id}/pendingNotificationsCount")
    end

    def like(post_id=nil)
      post("/posts/#{post_id}/likes") if post_id
    end
  end
end
