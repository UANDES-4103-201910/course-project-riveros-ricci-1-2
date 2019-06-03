module UsersHelper
  def title_filter(filter)
    case filter
    when 'admins'
      'Administrators'
    when 'non_admin'
      'Users'
    else
      'All Users'
    end
  end

  def user_role_text(user)
    case user.admin?
    when true
      user.is_superadmin? ? 'SAdmin' : 'Admin'
    else
      'Normal'
    end
  end

  def avatar_or_placeholder(user)
    if user.profile.avatar.attached?
      url_for user.profile.avatar
    else
      'profile-placeholder.gif'
    end
  end

  def last_login(user)
    if user.last_access
      render partial: 'shared/date_ago', locals: {html_class: 'text-muted', date: user.last_access} if user.last_access
    else
      "Never"
    end

  end
end
