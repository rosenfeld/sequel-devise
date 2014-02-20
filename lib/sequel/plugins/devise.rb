module Sequel
  module Plugins
    module Devise
      def self.apply(model, options = {})
        model.extend ::Devise::Models
        model.plugin :hook_class_methods # Devise requires a before_validation
        model.plugin :dirty # email_changed?
        model.plugin :validation_class_methods # for using validatable module
      end

      module InstanceMethods
        def changed? # For rememberable
          !changed_columns.empty?
        end

        def email_changed? # For validatable
          column_changed? :email
        end
      end

      module ClassMethods
        Model::HOOKS.each do |hook|
          define_method(hook) do |method = nil, options = {}, &block|
            if Symbol === (if_method = options[:if])
              orig_block = block
              block = proc { instance_eval &orig_block if send(if_method) }
            end
            super method, &block
          end
        end
      end
    end
  end
end
