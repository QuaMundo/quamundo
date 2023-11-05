# frozen_string_literal: true

module ActiveRecord
  module ConnectionAdapters
    # Extend column types - uuid for uniquely identify QuaMundo objects
    class TableDefinition
      def qm_uuid
        column :qm_uuid, :uuid,
               default: 'gen_random_uuid()',
               null: false,
               index: true
      end
    end
  end
end
