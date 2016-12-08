class UserServices

  def self.initialize_user(id)
    user = User.where(id: id).first

    if user.blank?
      user = User.create(id: id)
    end

    user_info = FacebookServices.user_info(id)
    if user_info
      user.first_name = user_info['first_name']
      user.last_name = user_info['last_name']
    end

    user.save

    user
  end

  def self.get_name(first_name, last_name)
    return 'Anonymous' if first_name.blank? && last_name.blank?
    return last_name if first_name.blank?

    "#{first_name} #{last_name}"
  end
end