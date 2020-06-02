module Concerns
  module Findable

    def find_by_name(name)
      item = self.all.find { |item| item.name == name }
    end

    def find_or_create_by_name(name)
      item = self.find_by_name(name)
      if !item
        item = self.create(name)
      end
      item
    end

  end
end
