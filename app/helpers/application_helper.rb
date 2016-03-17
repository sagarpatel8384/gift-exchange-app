module ApplicationHelper
  def gravatar_url(user, size)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    url = "http://gravatar.com/avatar/#{gravatar_id}.jpg?s=#{size}"
  end
end
