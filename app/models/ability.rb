# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action  :update, :destroy, to: :ud
    alias_action :create, :read, :update, :destroy, to: :crud
    alias_action :read, :create, to: :cr
    can :read, Post, public: true
    if user.present? and !user.blacklisted?


      if user.is_admin?

        if user.is_superadmin?
          can :manage, :all

        else

          can [:dump, :ud], Post do |post|
            inside_geofences?(post, user)
          end
          can [:create, :read], Post
          can :manage, Blacklist
          can :manage, Dumpster


          can :ud, UserProfile do |user_profile|
             user_profile.user.admin?
          end
        end


      elsif user.is_superadmin?
        can :manage, :all


      #normal user
      else
        can :ud, Post do |post|
          post.user == user
        end

        can :read, User

        can :crud, Vote, user_id: user.id

        can :comment, Post, &:is_open

        can :crud, Comment, user_id: user.id

        can :crud, PostFlag, user_id: user.id

        can :crud, FollowPost, user_id: user.id

        can :read, Post

        can [:create, :update], Post do
          Blacklist.find_by(user_id: user.id)
        end

        can :ud, UserProfile do |user_profile|
          user_profile.user == user
        end

        can :ud, User do |u|
          u == user
        end

      end
    end


    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end

  def inside_geofences?(post, user)
    user.geofences.each do |gf|
      return gf.contains_location?(post.location_latitude, post.location_longitude)
    end
    false
  end
end

