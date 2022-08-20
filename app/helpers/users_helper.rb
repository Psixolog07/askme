module UsersHelper
  def show_nickname(user)
    "@#{user.nickname}"
  end

  def show_header_color_for_html_style(user)
    "background-color:#{user.header_color}"
  end
end
