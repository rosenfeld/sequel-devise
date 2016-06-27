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

        def encrypted_password_changed? # For recoverable and database_authenticatable
          new? || column_changed?(:encrypted_password)
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
            update(hash) != false
          rescue Sequel::ValidationFailed
            return false
          end
        end

        def update_attribute(key, value)
          update_attributes key => value
        end
      end

      module ClassMethods

        def human_attribute_name(key)
          key.to_s
        end

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
