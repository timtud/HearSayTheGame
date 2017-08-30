module ApplicationHelper
  def user_avatar(user)
    if user.photo.present?
      return user.photo.path
    elsif user.picture_url.present?
      return user.picture_url
    else
      return "http://res.cloudinary.com/dgtihmi68/image/upload/v1504087694/ty2LLr9m_zvi9e5.jpg"
    end
  end
end
