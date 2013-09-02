module Etat
  module ActiveRecord
    extend ActiveSupport::Concern

    def state
      if attributes['state']
        attributes['state'].to_sym
      else
        attributes['state']
      end
    end

    module ClassMethods
      def has_states *states
        @states = []
        states.each do |state|
          if state.is_a?(Symbol)
            create_state_with state
            create_scopes state
            @states << state
          else
            raise 'States should be symbol'
          end
        end
      end

      def event event_name, &block
        define_method(event_name) do
          instance_eval &block
        end
      end

      def states
        @states
      end

      private
      def create_scopes state
        self.class_eval <<-RUBY, __FILE__, __LINE__ + 1
          scope "all_#{state}", -> { where(state: state) }
          scope "all_but_#{state}", -> { where("state != ?", state) }
        RUBY
      end

      private
      def create_state_with state
        define_method("#{state}?") do
          self.state == state.to_sym
        end
      end
    end
  end
end