module UsersHelper
  def show_nickname(user)
    "@#{user.nickname}"
  end
end
