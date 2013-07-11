# == Schema Information
#
# Table name: pages
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  ancestry    :string(255)
#

class Page < ActiveRecord::Base
  attr_accessible :name, :title, :description, :parent_id
  # Подключает к модели плагин Ancestry
  # Плагин берет на себя большую часть работы с вложенными страницами
  has_ancestry

  before_save { name.downcase! }
	
  # Валидация имени не зависит от регистра,
  # может содержать в себе русские и английские символы, цифры и символ "_"
	VALID_NAME_REGEX = /^[a-zA-Z\u0410-\u044F0-9_]+$/
  validates :name,  uniqueness: { case_sensitive: false },
                    format: { with: VALID_NAME_REGEX },
                    length: { maximum: 30 }
  validates :name, :title, :description, presence: true
end
