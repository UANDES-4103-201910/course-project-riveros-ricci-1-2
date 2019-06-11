# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action  :update, :destroy, to: :ud
    alias_action :create, :read, :update, :destroy, to: :crud
    can :read, Post, public: true
    if user.present?


      if user.is_admin?

        if user.is_superadmin?
          can :manage, :all

        else

          can :manage, Post
          can :manage, Blacklist
          can :manage, Dumpster


          can :ud, UserProfile do |user_profile|
             user_profile.user.admin?
          end
        end


      elsif user.is_superadmin?
        can :manage, :all
        cannot :ud, UserProfile do |user_profile|
          user_profile.user != user
        end

      #normal user
      else
        can :ud, Post do |post|
          post.user == user
        end

        can :read, User

        can :crud, Vote, user_id: user.id

        can :crud, Comment, user_id: user.id

        can [:create, :read], Post

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
end

