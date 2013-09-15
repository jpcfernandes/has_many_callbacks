
module HasManyCallbacks
  extend ActiveSupport::Concern

  class HasManyWithChildCallbacksBuilder < ActiveRecord::Associations::Builder::HasMany
    def valid_options
      super + [ :after_save ]
    end

    def build
      association = super

      hook_callback = lambda do |callback_name|
        association.klass.instance_eval %{
          #{callback_name} do |obj|
            association = obj.class.reflect_on_association(:#{association.inverse_of.name})
            callback = association.inverse_of.options[:#{callback_name}]
            callback = lambda { |r| r.send(callback) } if callback.is_a?(Symbol)
            associated_obj = obj.send(association.name).reload

            if associated_obj.present?
              association.macro == :has_many ? associated_obj.each { |r| callback[r, self] } : callback[associated_obj, self]
            end
          end
        }
      end

      hook_callback[:after_save] if options[:after_save].present?
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
