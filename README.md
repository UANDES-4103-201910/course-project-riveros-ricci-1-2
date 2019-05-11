# Web assignment

## How to build
> Pre-requirements:
> - [yarn](https://yarnpkg.com/en/)
> - Ruby 2.5.1
> - Rails 5.2.3
> - Bundler

1. Clone repo
2. `bundler install`
3. `yarn install`
4. `rails db:migrate db:seed`
...

## How to run
### In development
1. `foreman start`
2. Visit [localhost:5000](http://localhost:5000)

## Views
- [Landing page](http://localhost:5000/)
- [Post and comments](http://localhost:5000/post)
- [User profile](http://localhost:5000/users/1)
- [User signup](http://localhost:5000/signup)
- [Admin's blacklist](http://localhost:5000/admin/blacklist)