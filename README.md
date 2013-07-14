#vine_client
===========

`vine_client` - This is the simple Ruby wrapper for the Vine API.

## Installation

``` ruby
# Gemfile
gem vine_client
```

or

``` sh
$ gem install vine_client
```

## Usage

###Authentication
``` ruby
user=Vine::Client.new('username','password')
```
### Method calls

```ruby
#user info
user.user_info('user_id')#default current user id

#return list 
user.get_popular

#user timeline
user.timelines('user_id')

#tags
user.tag(tag)

#notfifications

user.notifications('user_id')

#logout

user.logout
```



