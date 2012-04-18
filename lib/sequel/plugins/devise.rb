module Sequel
  module Plugins
    module Devise
      def self.apply(model, options = {})
        model.extend ::Devise::Models
        model.plugin :hook_class_methods # Devise requires a before_validation
      end
    end
  end
end
