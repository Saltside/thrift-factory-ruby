require_relative 'test_helper'

class AcceptanceTest < MiniTest::Unit::TestCase
  def test_building_simple_struct
    assert_valid build(SimpleStruct.new)
  end

  def test_building_nested_struct
    assert_valid build(NestedExample.new)
  end

  def test_building_set_of_structs
    assert_valid build(SetExample.new)
  end

  def test_building_list_of_structs
    assert_valid build(ListExample.new)
  end

  def test_building_set_of_strings
    assert_valid build(StringSetExample.new)
  end

  def test_building_list_of_strings
    assert_valid build(StringListExample.new)
  end

  def test_building_map_with_struct_keys
    assert_valid build(MapKeyExample.new)
  end

  def test_building_map_with_struct_values
    assert_valid build(MapValueExample.new)
  end

  def test_building_union
    assert_valid build(UnionExample.new)
  end

  private

  def build(klass)
    Thrift::Factory.new.build(klass)
  end

  def refute_valid(struct)
    assert_raises Thrift::ProtocolException, 'Incorrect validation' do
      Thrift::Validator.new.validate struct
    end
  end

  def assert_valid(struct)
    Thrift::Validator.new.validate struct
  rescue Thrift::ProtocolException => ex
    flunk ex
  end
end
