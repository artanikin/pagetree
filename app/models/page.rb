class Page < ActiveRecord::Base
  # Подключает к модели плагин Ancestry
  # Плагин берет на себя большую часть работы с вложенными страницами
  has_ancestry
	
  # Валидация имени не зависит от регистра,
  # может содержать в себе русские и английские символы, цифры и символ "_"
	VALID_NAME_REGEX = /^[a-zA-Z\u0410-\u044F0-9_]+$/
  validates :name,  uniqueness: { case_sensitive: false },
                    format: { with: VALID_NAME_REGEX }
  validates :name, :title, presence: true
end
