# == Schema Information
#
# Table name: permissions
#
#  id            :bigint           not null, primary key
#  action        :string(255)
#  description   :text(65535)
#  name          :string(255)
#  subject_class :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Permission < ApplicationRecord
    has_many :role_permissions
    has_many :roles, :through => :role_permissions
end
