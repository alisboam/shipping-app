# Project

https://www.notion.so/be251a29f2f140c7a135cdf422dccb5d?v=9ad19de8d60742fa8805497672dc4563

## Install

### Clone the repository

```shell
git clone git@github.com:alisboam/shipping-app.git
cd shipping-app
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 3.0.0`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler) and [Yarn](https://github.com/yarnpkg/yarn):

```shell
bundle && yarn
```

### Install dependencies
Run the following commands to create and setup the database.

```ruby
rails db:create
rails db:setup
rails db:seed 
```

##### Start Rails server

You can start the rails server using the command given below.

```ruby
rails s
```

And now you can visit the site with the URL http://localhost:3000