module ApplicationHelper
  def user_avatar(user)
    if user.photo.present?
      return user.photo.path
    elsif user.picture_url.present?
      return user.picture_url
    else
      return "http://alexpoucher.com/wp-content/uploads/2017/04/C8QsNInXUAAyjZQ.jpg"
    end
  end
end
