module PostsHelper
  def add_posts_markers(posts, icon = 'myIcon', map = 'mymap')
    output = []

    posts.each do |p|
      output << "var marker = L.marker([#{p.location_latitude}, #{p.location_longitude}], {icon: #{icon}}).addTo(#{map});"
      output << "marker.bindPopup('#{link_to p.description, post_path(p)}<br>#{p.user.username}');"
    end
    output.join("\n").html_safe
  end
end
