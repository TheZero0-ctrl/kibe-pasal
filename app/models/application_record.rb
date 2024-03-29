# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include MessageVerifier
  include HumanEnum

  primary_abstract_class
end
