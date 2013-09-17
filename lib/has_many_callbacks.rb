
module HasManyCallbacks
  extend ActiveSupport::Concern

  class HasManyWithChildCallbacksBuilder < ActiveRecord::Associations::Builder::HasMany
    def valid_options
      super + [ :after_save, :after_destroy ]
    end

    def build
      association = super

      hook_callback = lambda do |callback_name|
        code = %{
          #{callback_name} do |obj|
            association = obj.class.reflect_on_association(:#{association.inverse_of.name})
            callback_option = association.inverse_of.options[:#{callback_name}]
            callback = callback_option.is_a?(Symbol) ?
              lambda { |r, o| r.send(callback_option, o) } : callback_option
            associated_obj = obj.send(association.name)
            if associated_obj.present?
              association.macro == :has_many ?
                associated_obj.each { |r| callback[r, self] } : callback[associated_obj, self]
            end
          end
        }
        association.klass.instance_eval code
      end

      [:after_save, :after_destroy].each do |callback|
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
