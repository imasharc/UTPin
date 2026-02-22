class Document < ApplicationRecord
  has_many :pins, dependent: :destroy
end
