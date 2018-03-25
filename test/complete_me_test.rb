require "minitest"
require "minitest/emoji"
require "minitest/autorun"
require "./lib/complete_me"
require "pry"

class CompleteMeTest < Minitest::Test

  def setup
    @cm = CompleteMe.new
  end


  # def insert_words(words)
  #   cm.populate(words.join("\n"))
  # end

  def medium_word_list
    File.read('../complete_me/complete_me_spec_harness/test/medium.txt')
  end

  def large_word_list
    File.read('/usr/share/dict/words')
  end

  def test_count_starts_at_zero
    expected = 0
    assert_equal expected, @cm.count
  end

  def test_it_inserts_a_word
    @cm.insert('hedgehog')
    expected = 1
    assert_equal expected, @cm.count
  end

#Populate is not doing what we expect in insert_words method
#(complete_me.rb line 143)
  def test_it_inserts_multiple_words
    @cm.insert_words(['porcupine', 'hedgehog', 'capybara', 'ferret'])
    expected = 4
    assert_equal expected, @cm.count
  end


  def test_populate_returns_an_array_of_strings
    strings = File.read('./lib/word_list.txt')
    expected_1 = 'cascade'
    expected_2 = 'monday'
    expected_3 = 1000
    assert_equal expected_1, @cm.populate(strings).first
    assert_equal expected_2, @cm.populate(strings).last
    assert_equal expected_3, @cm.populate(strings).count
  end

  def test_populate_inserts_strings_into_trie
    strings = File.read('./lib/word_list.txt')
    @cm.populate(strings)
    assert @cm.search('bullfinch')
  end

  #Populate is not doing what we expect in insert_words method
  #(complete_me.rb line 143)
  def test_suggest_returns_final_word_suggestions
    prefix = "a"
    @cm.insert_words(['am', 'at', 'banana'])
    expected = ['am', 'at']
    assert_equal expected, @cm.suggest(prefix)
  end

#Search is not taking arguments and returning has_key? false for
#"lcjkadsd" as expected
  def test_search_returns_false_if_word_not_in_trie
    refute @cm.search('lcjkadsd')
  end

  def test_unknown_prefix_is_not_a_word
    @cm.insert('hello')
    refute @cm.search('hel')
  end

  def test_word_flag_starts_false
    refute @cm.search('')
  end

  def test_word_flag_can_be_set_to_true
    @cm.insert('hello')
    assert @cm.search('hello')
  end

end
