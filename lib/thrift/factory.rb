require 'thrift/factory/version'
require 'thrift'

module Thrift
  class IntegerFactory
    def build(type)
      format =
        case type
        when Types::BYTE then 'c'
        when Types::I16  then 's'
        when Types::I32  then 'l'
        when Types::I64  then 'q'
        end

      SecureRandom.random_bytes.unpack(format).first
    end
  end

  class FloatFactory
    def build
      SecureRandom.random_bytes.unpack('d').first
    end
  end

  class StringFactory
    def build
      ('a'..'z').to_a.shuffle[0, 8].join
    end
  end

  class Factory
    def build(source)
      source.struct_fields.each_pair do |_, field|
        type, name = field.fetch(:type), field.fetch(:name)

        value =
          case type
          when Types::BOOL
            [ true, false ].sample
          when Types::BYTE, Types::I16, Types::I32, Types::I64
            IntegerFactory.new.build(type)
          when Types::DOUBLE
            FloatFactory.new.build
          when Types::STRING
            StringFactory.new.build
          when Types::STRUCT
            klass = field.fetch(:class)
            build(klass.new)
          when Types::LIST
            [ ]
          when Types::SET
            Set.new
          when Types::MAP
            { }
          end

        source.send :"#{name}=", value
      end

      source
    end
  end
end
