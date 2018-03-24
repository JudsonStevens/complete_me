require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/node.rb'
require_relative '../lib/complete_me'

class NodeTest < MiniTest::Test

  def setup
    @n = Node.new
  end

  def test_it_exists
    assert_instance_of Node, @n
  end

  def test_word_flag_attribute_can_be_changed
  skip
  end

  def test_it_holds_a_reference_to_another_node
  skip
  end

  def test_it_holds_the_correct_letter
  skip
  end

  def test_it_has_weight
  skip
  end


end
