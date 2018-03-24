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

  def test_it_initializes_with_the_correct_weight
    expected = {}
    assert_equal expected, @n.weight
  end

  def test_it_holds_a_reference_to_another_node
    expected = {}
    assert_equal expected, @n.child_nodes
  end

  def test_it_holds_the_correct_letter
  skip
  end

  def test_it_has_weight
    expected = {}
    assert_equal expected, @n.weight
  end
end
