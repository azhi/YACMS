class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new(role: :guest)
    send(user.role)
  end

  def guest
    can :read, Page
    can :read, Post
    can :read, Comment
  end

  def user
    guest
    can :create_comment, Post, {allow_commentaries: true}
    can :create, Comment
  end

  def admin
    user
    can :manage, Page
    can :manage, Post
    can :manage, Setting
  end
end
