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

    token = user_info['profile_pic'].gsub(/_.+_o/).to_a[0][1..-3]
    FacebookServices.sync_sender_id(token, id)

    user.save

    user
  end

  def self.get_name(first_name, last_name)
    return 'Anonymous' if first_name.blank? && last_name.blank?
    return last_name if first_name.blank?

    "#{first_name} #{last_name}"
  end
end