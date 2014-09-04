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
          new? || column_changed?(:email)
        end

        def email_was # For confirmable
          column_changes[:email].first
        end

        # for database_authenticatable:
        def assign_attributes(hash)
          set hash
        end

        def update_attributes(hash, *ignored)
          begin
            update hash
          rescue Sequel::ValidationFailed
            return false
          end
        end
      end

      module ClassMethods
        Model::HOOKS.each do |hook|
          define_method(hook) do |method = nil, options = {}, &block|
            if Symbol === (if_method = options[:if])
              orig_block = block
              block = nil
              method_without_if = method
              method = :"_sequel_hook_with_if_#{method}"
              define_method(method) do
                return unless send if_method
                send method_without_if
                instance_eval &orig_block if orig_block
              end
              private method
            end
            super method, &block
          end
        end
      end
    end
  end
end
