# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role_id                :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role_id               (role_id)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
class User < ApplicationRecord

  # define revocation strategies
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # include default devise modules
  devise :database_authenticatable,
    # :confirmable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable,
    :jwt_authenticatable, jwt_revocation_strategy: self

end
