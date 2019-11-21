# frozen_string_literal: true

module RuboCop
  module Cop
    module Academia
      class OnReplica < RuboCop::Cop::Cop
        MSG = "Please use `Octopus.on_replica(:shard)` where :shard is the name of the database"

        def on_send(node)
          receiver, method_name, *args = *node

          return unless method_name == :on_replica
          return if match_octopus(receiver) && args.any?

          add_offense(node)
        end

        private

        def match_octopus(node)
          node && node.const_name == "Octopus"
        end
      end
    end
  end
end
