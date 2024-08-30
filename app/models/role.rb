# == Schema Information
#
# Table name: roles
#
#  id          :bigint           not null, primary key
#  active      :boolean
#  code        :string(255)
#  description :text(65535)
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Role < ApplicationRecord
    has_many :role_permissions
    has_many :permissions, :through => :role_permissions

    def set_permissions(permissions)
        permissions.each do |id|
		    permission = Permission.find(id)
		    self.permissions << permission
        end
    end
end
