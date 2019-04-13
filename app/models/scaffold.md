# User
rails g scaffold User username:string email:string password:string is_admin:boolean is_superadmin:boolean user_status:references last_access:datetime karma:integer
# Post
rails g scaffold Post user:references description:text is_resolved:boolean content:text location_latitude:decimal{'8,6'} location_longitude:decimal{'9,6'} city:string country:string is_open:boolean
# Comment
rails g scaffold Comment user:references post:references content:text
# FollowPost
rails g scaffold FollowPost user:references post:references
# UserStatus
rails g scaffold UserStatus name:string comment:text
# UserShared
rails g scaffold UserShared user:references post:references
# FileType
rails g scaffold FileType name:string image_path:string
# SharedFile
rails g scaffold SharedFile user:references post:references file_type:references path:string
# Vote
rails g scaffold Vote user:references post:references value:integer
# Blacklist
rails g scaffold Blacklist user:references start_date:datetime end_date:datetime
# Dumpster
rails g scaffold Dumpster post:references creator:references
# FollowUser
rails g scaffold FollowUser user:references followed_user:references
# UserProfile
rails g scaffold UserProfile user:references name:string bio:text
# AdminGeofence
rails g scaffold AdminGeofence user:references latitude:decimal{'8,6'} longitude:decimal{'9,6'}
# PostFlag
rails g scaffold PostFlag post:references flagged_by:references comment:text


