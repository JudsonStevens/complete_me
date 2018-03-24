require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/complete_me'
require_relative '../lib/node'

class CompleteMeTest < MiniTest::Test

  def setup
    @c = CompleteMe.new
  end

  def test_it_exists
    assert_instance_of CompleteMe, @c
  end

  def test_it_instantiates_root_node_correctly
    assert_equal @c.root_node.weight, Node.new.weight
  end
  
  def test_it_can_find_a_letter_node
  skip
  end

  def test_it_can_find_a_word_flagged_node
  skip
  end

  def test_it_can_count_all_words_in_tree
  skip
  end

  def test_it_can_offer_suggestions
  skip
  end

  def test_it_can_find_weight_of_suggestions
  skip
  end

  def test_it_can_insert_words
    @c.insert_new_word("example")
    assert @root_node.child_nodes.has_key?("e")
    assert @root_node.child_nodes.has_key?, "x"
  end

  def test_it_can_remove_a_node_with_no_children
  skip
  end

  def test_it_can_remove_a_node_with_one_child
  skip
  end
    
end
