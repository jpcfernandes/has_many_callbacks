
module HasManyCallbacks
  extend ActiveSupport::Concern

  class HasManyWithChildCallbacksBuilder < ActiveRecord::Associations::Builder::HasMany
    HAS_MANY_CALLBACKS = [ :after_create, :after_save, :after_destroy ]
    def valid_options
      super + HAS_MANY_CALLBACKS
    end

    def build
      association = super

      hook_callback = lambda do |callback_name|
        callback_option = association.options[callback_name]

        if callback_option.is_a?(Symbol)
          callback_code = "target.send(:#{callback_option}, obj)"
        else
          callback_code = "callback_option[target, obj]"
        end

        if association.inverse_of.macro == :has_many
          target_callback_iteration_code = "associated_obj.each { |target| #{callback_code} }"
        else
          target_callback_iteration_code = "target = associated_obj; #{callback_code}"
        end

        code = %{
          #{callback_name} do |obj|
            association = obj.class.reflect_on_association(:#{association.inverse_of.name})
            inverse_association = association.klass.reflect_on_association(:#{association.name})
            callback_option = inverse_association.options[:#{callback_name}]
            associated_obj = obj.send(association.name)

            if associated_obj.present?
              #{target_callback_iteration_code}
            end
          end
        }
        association.klass.instance_eval code
      end

      HAS_MANY_CALLBACKS.each do |callback|
        if options[callback].present?
          hook_callback[callback]
          #puts "#{model.to_s}: hooking #{callback} on #{association.try(:name)}"
        end
      end


      #hook_callback.call(:after_create, after_create_callback) if after_create_callback.present?
      association
    end
  end

  module ClassMethods
    def has_many(name, scope = nil, options = {}, &extension)
      HasManyWithChildCallbacksBuilder.build(self, name, scope, options, &extension)
    end
  end

end

ActiveRecord::Base.send(:include, HasManyCallbacks)
ActiveRecord::Base.send(:include, HasManyCallbacks::ClassMethods)
