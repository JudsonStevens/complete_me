require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/node'
require_relative '../lib/complete_me'
require_relative 'complete_me_test'

class NodeTest < MiniTest::Test

  def setup
    @node = Node.new
    @cm = CompleteMe.new
  end

  def test_it_exists
    assert_instance_of Node, @node
  end

  def test_nothing
    skip
  end

  def test_it_initializes_with_the_correct_weight
    expected = {}
    assert_equal expected, @node.weight
  end

  def test_it_holds_a_reference_to_another_node
    expected = {}
    assert_equal expected, @node.child_nodes
  end

  def test_it_holds_the_correct_letter
    @cm.insert('pizza')
    assert @cm.include?('pizza')
  end

  def test_it_has_weight
    expected = {}
    assert_equal expected, @node.weight
  end
end