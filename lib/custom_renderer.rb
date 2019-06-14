module CustomRenderer
  class SafeMentionsRenderer < Redcarpet::Render::Safe
    include ActionView::Helpers::UrlHelper

    def postprocess(document)
      # Find mentions and put links to user
      doc = document.gsub(/(@[a-zA-Z0-9]+)/) { link_to_user($1) }
      doc.gsub(/#[a-z]([0-9]+)/) { link_to_post($1) }
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

    def link_to_post(post_id)
      post_model = Post.find_by_id(post_id)
      if post_model
        link_to("\#p#{post_id}",
                Rails.application.routes.url_helpers.post_path(post_model))
      else
        "\#p#{post_id}"
      end

    end
  end
end