module Persistable

  module ClassMethods

    def destroy_all
      self.all.clear
    end

    def create(name)
      item = self.new(name)
      item.save
      item
    end
  end

  module InstanceMethods
    def save
      self.class.all << self
      self
    end
  end

end
