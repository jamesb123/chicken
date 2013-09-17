class Organism < ActiveRecord::Base
  class Organism < ActiveRecord::Base
    has_many_dynamic_attributes :scoped_by => 'Project'
    has_many :samples
  end
end