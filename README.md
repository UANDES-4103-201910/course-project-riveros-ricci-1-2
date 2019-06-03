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
5. Optional: Seed with dummys: `rails db:seed:dummy`
...

## How to run
### In development
1. `foreman start`
2. Visit [localhost:5000](http://localhost:5000)

## Views
You can navigate through the site to all views.

Here are some:
- [Landing page](http://localhost:5000/)
- [Post and comments](http://localhost:5000/post)
- [User profile](http://localhost:5000/users/1)
- [User signup](http://localhost:5000/users/sign_in)
- [User login](http://localhost:5000/users/sign_out)
- [Admin's blacklist](http://localhost:5000/admin/blacklists)
- [Admin's dumpster](http://localhost:5000/admin/dumpsters)

## APIs
- [Postman collection](https://www.getpostman.com/collections/3a88a40eeb2030b53cd8)

## Assigment 3 TODOs

1. System Access
   - [x] Log in with email
   - [ ] Google auth
   - [x] Log out
2. Registration
   - [x] User registration
   - [x] Change password
   - [ ] Password recovery
3. User Administration
   - [x] New user
   - [x] View User details
     - [x] Last access
     - [X] User role
   - [x] Edit user
     - [ ] Change password
   - [ ] Delete user
4. System Administration
   - [x] New admin
   - [x] View admin details
   - [ ] Edit admin
     - [ ] Change password
   - [ ] Delete admin
5. User Profile
   - [x] View
   - [x] Edit
   - [x] View posts
   - [ ] View logged in user's following posts
6. Posts
   - [x] View
     - [ ] Attachments
   - [ ] Delete
   - [x] Edit
   - [ ] Upvote / Downvote
   - [ ] Follow
   - [x] View publisher profile
   - [ ] Flag
7. Comments
   - [x] Add
   - [x] Edit
   - [x] Tag user in comment
   - [x] View author profile
8. User Search
   - [ ] By nickname
   - [ ] By location

## Known bugs / issues

- Users
   - Creating a user via admin is not allowed by Devise
   - Log out is done in a hacky way
- Posts
   - Can't delete post probably because missing CASCADE
