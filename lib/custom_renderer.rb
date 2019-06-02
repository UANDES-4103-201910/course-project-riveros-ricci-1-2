module CustomRenderer
  class SafeMentionsRenderer < Redcarpet::Render::Safe
    include ActionView::Helpers::UrlHelper

    def postprocess(document)
      # Find mentions and put links to user
      document.gsub(/(@[a-zA-Z0-9]+)/) { link_to_user($1) }
    end

    def link_to_user(user)
      user_model = User.find_by_username(user.delete('@'))
      if user_model
        link_to(user,
                Rails.application.routes.url_helpers.user_path(user_model))
      else
        user
      end
    end
  end
end