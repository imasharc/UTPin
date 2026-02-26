class Document < ApplicationRecord
  has_many :pages, dependent: :destroy

  has_many :pins, through: :pages
end
